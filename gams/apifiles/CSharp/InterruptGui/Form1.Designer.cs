namespace InterruptGui
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.bu_cancel = new System.Windows.Forms.Button();
            this.bu_run = new System.Windows.Forms.Button();
            this.bu_close = new System.Windows.Forms.Button();
            this.SuspendLayout();
            //
            // richTextBox1
            //
            this.richTextBox1.Location = new System.Drawing.Point(12, 25);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.Size = new System.Drawing.Size(560, 486);
            this.richTextBox1.TabIndex = 0;
            this.richTextBox1.Text = "";
            //
            // label2
            //
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(62, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "GAMS Log:";
            //
            // bu_cancel
            //
            this.bu_cancel.Enabled = false;
            this.bu_cancel.Location = new System.Drawing.Point(356, 517);
            this.bu_cancel.Name = "bu_cancel";
            this.bu_cancel.Size = new System.Drawing.Size(105, 33);
            this.bu_cancel.TabIndex = 6;
            this.bu_cancel.Text = "Cancel";
            this.bu_cancel.UseVisualStyleBackColor = true;
            this.bu_cancel.Click += new System.EventHandler(this.bu_cancel_Click);
            //
            // bu_run
            //
            this.bu_run.Location = new System.Drawing.Point(12, 517);
            this.bu_run.Name = "bu_run";
            this.bu_run.Size = new System.Drawing.Size(137, 33);
            this.bu_run.TabIndex = 7;
            this.bu_run.Text = "Run";
            this.bu_run.UseVisualStyleBackColor = true;
            this.bu_run.Click += new System.EventHandler(this.bu_run_Click);
            //
            // bu_close
            //
            this.bu_close.Location = new System.Drawing.Point(467, 517);
            this.bu_close.Name = "bu_close";
            this.bu_close.Size = new System.Drawing.Size(105, 33);
            this.bu_close.TabIndex = 8;
            this.bu_close.Text = "Close";
            this.bu_close.UseVisualStyleBackColor = true;
            this.bu_close.Click += new System.EventHandler(this.bu_close_Click);
            //
            // Form1
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(584, 562);
            this.Controls.Add(this.bu_close);
            this.Controls.Add(this.bu_run);
            this.Controls.Add(this.bu_cancel);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.richTextBox1);
            this.Name = "Form1";
            this.Text = "Interrupt Example";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.RichTextBox richTextBox1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button bu_cancel;
        private System.Windows.Forms.Button bu_run;
        private System.Windows.Forms.Button bu_close;
    }
}

