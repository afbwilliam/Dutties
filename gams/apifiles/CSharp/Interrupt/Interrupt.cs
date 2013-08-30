using System;
using GAMS;

namespace Interrupt
{
    class Interrupt
    {
        static void Main(string[] args)
        {
            GAMSWorkspace ws = new GAMSWorkspace();

            // Use a MIP that needs some time to solve
            ws.GamsLib("lop");
            GAMSJob job = ws.AddJobFromFile("lop.gms");

            // Change the default behaviour of pressing Ctrl+C to send that signal to a running job
            Console.CancelKeyPress += delegate(object sender, ConsoleCancelEventArgs a) { job.Interrupt(); a.Cancel = true; };

            // Run the job, Pressing Ctrl+C will interrupt the GAMS job, but not this whole application
            job.Run(output: Console.Out);
        }
    }
}
