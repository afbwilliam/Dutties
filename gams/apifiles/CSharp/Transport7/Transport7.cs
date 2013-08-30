using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using GAMS;

namespace TransportSeq
{
    class Transport7
    {
        static void Main(string[] args)
        {
            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace();
            GAMSCheckpoint cp = ws.AddCheckpoint();

            // initialize a GAMSCheckpoint by running a GAMSJob
            GAMSJob t7 = ws.AddJobFromString(GetModelText());
            t7.Run(cp);

            // create a GAMSModelInstance and solve it multiple times with different scalar bmult
            GAMSModelInstance mi = cp.AddModelInstance();

            GAMSParameter bmult = mi.SyncDB.AddParameter("bmult", 0, "demand multiplier"); 
            GAMSOptions opt = ws.AddOptions();
            opt.AllModelTypes = "gurobi";

            // instantiate the GAMSModelInstance and pass a model definition and GAMSModifier to declare bmult mutable
            mi.Instantiate("transport us lp min z", opt, new GAMSModifier(bmult));

            bmult.AddRecord().Value = 1.0;
            double[] bmultlist = new double[] { 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3 };

            foreach (double b in bmultlist)
            {
                bmult.FirstRecord().Value = b;
                mi.Solve();
                Console.WriteLine("Scenario bmult=" + b + ":");
                Console.WriteLine("  Modelstatus: " + mi.ModelStatus);
                Console.WriteLine("  Solvestatus: " + mi.SolveStatus);
                Console.WriteLine("  Obj: " + mi.SyncDB.GetVariable("z").FindRecord().Level);
            }
            
            // create a GAMSModelInstance and solve it with single links in the network blocked
            mi = cp.AddModelInstance();
            
            GAMSVariable x = mi.SyncDB.AddVariable("x", 2, VarType.Positive, "");
            GAMSParameter xup = mi.SyncDB.AddParameter("xup", 2, "upper bound on x");

            // instantiate the GAMSModelInstance and pass a model definition and GAMSModifier to declare upper bound of X mutable
            mi.Instantiate("transport us lp min z", modifiers: new GAMSModifier(x,UpdateAction.Upper,xup));

            foreach (GAMSSetRecord i in t7.OutDB.GetSet("i"))
                foreach (GAMSSetRecord j in t7.OutDB.GetSet("j"))
                {
                    xup.Clear();
                    xup.AddRecord(i.Keys[0],j.Keys[0]).Value = 0;
                    mi.Solve();
                    Console.WriteLine("Scenario link blocked: " + i.Keys[0]  + " - " + j.Keys[0]);
                    Console.WriteLine("  Modelstatus: " + mi.ModelStatus);
                    Console.WriteLine("  Solvestatus: " + mi.SolveStatus);
                    Console.WriteLine("  Obj: " + mi.SyncDB.GetVariable("z").FindRecord().Level);
                }
        }

        static String GetModelText()
        {
            String model = @"
  Sets
       i   canning plants   / seattle, san-diego /
       j   markets          / new-york, chicago, topeka / ;

  Parameters

       a(i)  capacity of plant i in cases
         /    seattle     350
              san-diego   600  /

       b(j)  demand at market j in cases
         /    new-york    325
              chicago     300
              topeka      275  / ;

  Table d(i,j)  distance in thousands of miles
                    new-york       chicago      topeka
      seattle          2.5           1.7          1.8
      san-diego        2.5           1.8          1.4  ;

  Scalar f      freight in dollars per case per thousand miles  /90/ ;
  Scalar bmult  demand multiplier /1/;

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

  demand(j) ..   sum(i, x(i,j))  =g=  bmult*b(j) ;

  Model transport /all/ ;
";

            return model;
        }

    }
}
