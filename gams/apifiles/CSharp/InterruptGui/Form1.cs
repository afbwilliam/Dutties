using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Threading.Tasks;
using GAMS;
using System.IO;

namespace InterruptGui
{
    public partial class Form1 : Form
    {
        GAMSJob currentJob = null;
        public Form1()
        {
            InitializeComponent();
            this.ControlBox = false;
        }

        private void RunGams()
        {
            MethodInvoker action = delegate
            {
                bu_run.Enabled = false;
                bu_close.Enabled = false;
                bu_cancel.Enabled = true;
            };
            this.BeginInvoke(action);

            TextBoxBaseWriter tbw = new TextBoxBaseWriter(this.richTextBox1, this);

            GAMSWorkspace ws = new GAMSWorkspace();
            ws.GamsLib("lop");
            currentJob = ws.AddJobFromFile("lop.gms");
            GAMSOptions opt = ws.AddOptions();
            opt.AllModelTypes = "bdmlp";
            opt.SolveLink = GAMSOptions.ESolveLink.CallModule;

            try
            {
                currentJob.Run(opt, tbw);
            }
            catch (GAMSException e)
            {
                action = delegate
                {
                    richTextBox1.AppendText(e.Message);
                };
            }

            action = delegate
            {
                bu_run.Enabled = true;
                bu_close.Enabled = true;
                bu_cancel.Enabled = false;
            };
            this.BeginInvoke(action);
        }

        private void bu_run_Click(object sender, EventArgs e)
        {
            Task.Factory.StartNew(() => RunGams());
        }

        private void bu_cancel_Click(object sender, EventArgs e)
        {
            currentJob.Interrupt();
        }

        private void bu_close_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
