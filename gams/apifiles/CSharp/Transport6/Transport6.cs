using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using GAMS;

namespace TransportSeq
{
    class Transport6
    {
        static void RunScenario(GAMSWorkspace ws, GAMSCheckpoint cp, object ioMutex, double b)
        {
            GAMSJob t6 = ws.AddJobFromString("bmult=" + b + "; solve transport min z us lp; ms=transport.modelstat; ss=transport.solvestat;", cp);
            t6.Run();
            // we need to make the ouput a critical section to avoid messed up report information
            lock (ioMutex)
            {
                Console.WriteLine("Scenario bmult=" + b + ":");
                Console.WriteLine("  Modelstatus: " + t6.OutDB.GetParameter("ms").FindRecord().Value);
                Console.WriteLine("  Solvestatus: " + t6.OutDB.GetParameter("ss").FindRecord().Value);
                Console.WriteLine("  Obj: " + t6.OutDB.GetVariable("z").FindRecord().Level);
            }
        }
        static void Main(string[] args)
        {
            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace();
            GAMSCheckpoint cp = ws.AddCheckpoint();

            // initialize a GAMSCheckpoint by running a GAMSJob
            ws.AddJobFromString(GetModelText()).Run(cp);

            double[] bmultlist = new double[] { 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3 };

            // run multiple parallel jobs using the created GAMSCheckpoint
            Object ioMutex = new Object();
            System.Threading.Tasks.Parallel.ForEach(bmultlist, delegate(double b) { RunScenario(ws, cp, ioMutex, b); });
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
  Scalar ms 'model status', ss 'solve status';
";

            return model;
        }

    }
}
