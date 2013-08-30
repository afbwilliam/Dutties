using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using GAMS;

namespace TransportSeq
{
    class Transport11
    {

        static void Main(string[] args)
        {

            // Create a save/restart file usually supplied by an application provider
            // We create it for demonstration purpose
            string wDir = Path.Combine(".", "tmp");
            CreateSaveRestart(Path.Combine(wDir, "tbase"));

            // define some data by using C# data structures
            List<string> plants = new List<string>() 
            { 
                "Seattle", "San-Diego" 
            };
            List<string> markets = new List<string>() 
            { 
                "New-York", "Chicago", "Topeka" 
            };
            Dictionary<string, double> capacity = new Dictionary<string, double>() 
            { 
                { "Seattle", 350.0 }, { "San-Diego", 600.0 } 
            };
            Dictionary<string, double> demand = new Dictionary<string, double>() 
            { 
                { "New-York", 325.0 }, { "Chicago", 300.0 }, { "Topeka", 275.0 }
            };
            Dictionary<Tuple<string, string>, double> distance = new Dictionary<Tuple<string, string>, double>() 
            { 
                { new Tuple<string,string> ("Seattle",   "New-York"), 2.5 },
                { new Tuple<string,string> ("Seattle",   "Chicago"),  1.7 },
                { new Tuple<string,string> ("Seattle",   "Topeka"),   1.8 },
                { new Tuple<string,string> ("San-Diego", "New-York"), 2.5 },
                { new Tuple<string,string> ("San-Diego", "Chicago"),  1.8 },
                { new Tuple<string,string> ("San-Diego", "Topeka"),   1.4 }
            };

            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(workingDirectory: wDir, systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace(workingDirectory: wDir);
            // prepare a GAMSDatabase with data from the C# data structures
            GAMSDatabase db = ws.AddDatabase();

            GAMSSet i = db.AddSet("i", 1, "canning plants");
            foreach (string p in plants)
                i.AddRecord(p);

            GAMSSet j = db.AddSet("j", 1, "markets");
            foreach (string m in markets)
                j.AddRecord(m);

            GAMSParameter a = db.AddParameter("a", 1, "capacity of plant i in cases");
            foreach (string p in plants)
                a.AddRecord(p).Value = capacity[p];

            GAMSParameter b = db.AddParameter("b", 1, "demand at market j in cases");
            foreach (string m in markets)
                b.AddRecord(m).Value = demand[m];

            GAMSParameter d = db.AddParameter("d", 2, "distance in thousands of miles");
            foreach (Tuple<string, string> t in distance.Keys)
                d.AddRecord(t.Item1, t.Item2).Value = distance[t];

            GAMSParameter f = db.AddParameter("f", 0, "freight in dollars per case per thousand miles");
            f.AddRecord().Value = 90;

            // run a job using data from the created GAMSDatabase
            GAMSCheckpoint cpBase = ws.AddCheckpoint("tbase");
            using (GAMSOptions opt = ws.AddOptions())
            {
                GAMSJob t4 = ws.AddJobFromString(GetModelText(), cpBase);
                opt.Defines.Add("gdxincname", db.Name);
                opt.AllModelTypes = "xpress";
                t4.Run(opt, db);
                foreach (GAMSVariableRecord rec in t4.OutDB.GetVariable("x"))
                    Console.WriteLine("x(" + rec.Keys[0] + "," + rec.Keys[1] + "): level=" + rec.Level + " marginal=" + rec.Marginal);
            }
        }

        static void CreateSaveRestart(string cpFileName)
        {
            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(workingDirectory: Path.GetDirectoryName(cpFileName), systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace(workingDirectory: Path.GetDirectoryName(cpFileName));
            GAMSJob j1 = ws.AddJobFromString(GetBaseModelText());
            GAMSOptions opt = ws.AddOptions();

            opt.Action = GAMSOptions.EAction.CompileOnly;


            GAMSCheckpoint cp = ws.AddCheckpoint(Path.GetFileName(cpFileName));
            j1.Run(opt, cp);

            opt.Dispose();
        }

        static String GetBaseModelText()
        {
            String model = @"
$onempty
  Sets
       i(*)   canning plants / /
       j(*)   markets        / /

  Parameters
       a(i)   capacity of plant i in cases / /
       b(j)   demand at market j in cases  / /
       d(i,j) distance in thousands of miles / /
  Scalar f  freight in dollars per case per thousand miles /0/;

  Parameter c(i,j)  transport cost in thousands of dollars per case ;

            c(i,j) = f * d(i,j) / 1000 ;

  Variables
       x(i,j)  shipment quantities in cases
       z       total transportation costs in thousands of dollars ;

  Positive Variable x ;

  Equations
       cost        define objective function
       supply(i)   observe supply limit at plant i
       demand(j)   satisfy demand at market j ;

  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;

  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;

  demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;

  Model transport /all/ ;

  Solve transport using lp minimizing z ;

";

            return model;
        }

        static String GetModelText()
        {
            String model = @"
$if not set gdxincname $abort 'no include file name for data file provided'
$gdxin %gdxincname%
$onMulti
$load i j a b d f
$gdxin

  Display x.l, x.m ;";    

            return model;
        }

    }
}
