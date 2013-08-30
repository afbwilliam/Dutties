import wx
import threading
from gams import *

class TextCtrlWriter(object):
    def __init__(self, textCtrl):
        self.textCtrl = textCtrl

    def write(self, text):
        self.textCtrl.AppendText(text)

    def flush(self):
        self.textCtrl.Update()
        self.textCtrl.Refresh()

class InterruptGui(wx.Frame):

    def close(self, event):
        self.Close()

    def cancel(self, event):
        self.t1.interrupt()

    def run_gams(self):
        writer = TextCtrlWriter(self.log)
        ws = GamsWorkspace()
        ws.gamslib("lop")
        opt = ws.add_options()
        opt.all_model_types = "bdmlp"
        self.t1 = ws.add_job_from_file("lop.gms")
        self.t1.run(opt, output=writer)
        self.bu_run.Enable()
        self.bu_cancel.Disable()
        self.bu_close.Enable()

    def run(self, event):
        self.log.Clear()
        self.bu_run.Disable()
        self.bu_close.Disable()
        self.bu_cancel.Enable()
        threading.Thread(target=self.run_gams).start()

    def __init__(self, parent, id, title, size):
        wx.Frame.__init__(self, parent, id, title, size=size)
        self.SetBackgroundColour('lightgrey')

        wx.StaticText(self, -1, "GAMS Log:", (10, 10))
        self.log = wx.TextCtrl(self, pos=(10, 30), size=(565, 485),  style=wx.TE_MULTILINE)

        self.bu_run = wx.Button(self, -1, "Run", (10,520), (137, 33))
        self.bu_run.Bind(wx.EVT_BUTTON, self.run)

        self.bu_cancel = wx.Button(self, -1, "Cancel", (10,520), (137, 33))
        self.bu_cancel.Bind(wx.EVT_BUTTON, self.cancel)
        self.bu_cancel.Disable()

        self.bu_cancel = wx.Button(self, -1, "Cancel", (360,520), (105, 33))
        self.bu_cancel.Bind(wx.EVT_BUTTON, self.cancel)
        self.bu_cancel.Disable()

        self.bu_close = wx.Button(self, -1, "Close", (470,520), (105, 33))
        self.bu_close.Bind(wx.EVT_BUTTON, self.close)

if __name__ == '__main__':
    app = wx.PySimpleApp()
    frame = InterruptGui(None, -1, 'Interrupt Example', (600, 600))
    frame.Show()
    app.MainLoop();
