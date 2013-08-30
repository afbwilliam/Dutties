Imports GAMS
Imports System.IO

Module Transport1

    Sub Main()

        Dim ws As GAMSWorkspace
        If (Environment.GetCommandLineArgs().Length > 1) Then
            '                        systemDirectory
            ws = New GAMSWorkspace(, Environment.GetCommandLineArgs()(1), )
        Else
            ws = New GAMSWorkspace()
        End If

        ws.GamsLib("trnsport")

        ' create a GAMSJob from file and run it with default settings
        Dim t1 As GAMSJob = ws.AddJobFromFile("trnsport.gms")

        t1.Run()
        Console.WriteLine("Ran with Default:")
        For Each rec As GAMSVariableRecord In t1.OutDB.GetVariable("x")
            Console.WriteLine("x(" + rec.Keys(0) + "," + rec.Keys(1) + "): level=" + rec.Level.ToString + " marginal=" + rec.Marginal.ToString)
        Next


        ' run the job again with another solver
        Using opt As GAMSOptions = ws.AddOptions()
            opt.AllModelTypes = "xpress"
            t1.Run(opt)
        End Using

        Console.WriteLine("Ran with XPRESS:")
        For Each rec As GAMSVariableRecord In t1.OutDB.GetVariable("x")
            Console.WriteLine("x(" + rec.Keys(0) + "," + rec.Keys(1) + "): level=" + rec.Level.ToString + " marginal=" + rec.Marginal.ToString)
        Next
        ' run the job with a solver option file
        Using optFile As StreamWriter = New StreamWriter(Path.Combine(ws.WorkingDirectory, "xpress.opt"))
            Using opt As GAMSOptions = ws.AddOptions()
                optFile.WriteLine("algorithm=barrier")
                optFile.Close()
                opt.AllModelTypes = "xpress"
                opt.OptFile = 1
                t1.Run(opt)
            End Using
        End Using

        Console.WriteLine("Ran with XPRESS with non-default option:")
        For Each rec As GAMSVariableRecord In t1.OutDB.GetVariable("x")
            Console.WriteLine("x(" + rec.Keys(0) + "," + rec.Keys(1) + "): level=" + rec.Level.ToString + " marginal=" + rec.Marginal.ToString)
        Next
    End Sub

End Module
