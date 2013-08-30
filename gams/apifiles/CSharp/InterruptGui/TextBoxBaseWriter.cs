using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Diagnostics;

namespace InterruptGui
{
    class TextBoxBaseWriter : TextWriter
    {
        private TextBoxBase _textBoxBase;
        private Form _form;

        public TextBoxBaseWriter(TextBoxBase textBoxBase, Form form)
        {
            _textBoxBase = textBoxBase;
            _form = form;
        }

        public override void Write(String text)
        {
            MethodInvoker action = delegate
            {
                _textBoxBase.AppendText(text);
                _textBoxBase.ScrollToCaret();
            };
            _form.BeginInvoke(action);
        }

        public override void Write(Char[] buffer, Int32 index, Int32 count)
        {
            String text = String.Empty;
            for (int i = index; i < index + count; i++)
            {
                text += buffer[i];
            }
            Write(text);
        }

        public override Encoding Encoding
        {
            get { return System.Text.Encoding.UTF8; }
        }
    }
}
