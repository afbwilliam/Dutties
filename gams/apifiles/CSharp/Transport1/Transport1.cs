using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using GAMS;

namespace TransportSeq
{
    class Transport1
    {
        static void Main(string[] args)
        {
            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace();
            ws.GamsLib("trnsport");

            // create a GAMSJob from file and run it with default settings
            GAMSJob t1 = ws.AddJobFromFile("trnsport.gms");
            
            t1.Run();
            Console.WriteLine("Ran with Default:");
            foreach (GAMSVariableRecord rec in t1.OutDB.GetVariable("x"))
                Console.WriteLine("x(" + rec.Keys[0] + "," + rec.Keys[1] + "): level=" + rec.Level + " marginal=" + rec.Marginal);

            // run the job again with another solver
            using (GAMSOptions opt = ws.AddOptions())
            {
                opt.AllModelTypes = "xpress";
                t1.Run(opt);
            }
            Console.WriteLine("Ran with XPRESS:");
            foreach (GAMSVariableRecord rec in t1.OutDB.GetVariable("x"))
                Console.WriteLine("x(" + rec.Keys[0] + "," + rec.Keys[1] + "): level=" + rec.Level + " marginal=" + rec.Marginal);

            // run the job with a solver option file
            using (StreamWriter optFile = new StreamWriter(Path.Combine(ws.WorkingDirectory, "xpress.opt")))
            using (GAMSOptions opt = ws.AddOptions())
            {
                optFile.WriteLine("algorithm=barrier");
                optFile.Close();
                opt.AllModelTypes = "xpress";
                opt.OptFile = 1;
                t1.Run(opt);
            }
            Console.WriteLine("Ran with XPRESS with non-default option:");
            foreach (GAMSVariableRecord rec in t1.OutDB.GetVariable("x"))
                Console.WriteLine("x(" + rec.Keys[0] + "," + rec.Keys[1] + "): level=" + rec.Level + " marginal=" + rec.Marginal);
        }
    }
}
