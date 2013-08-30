Imports GAMS
Imports System.IO

Module Transport11

    Sub Main()
        ' Create a save/restart file usually supplied by an application provider
        ' We create it for demonstration purpose
        Dim wDir As String = Path.Combine(".", "tmp")
        CreateSaveRestart(Path.Combine(wDir, "tbase"))

        ' define some data by using C# data structures
        Dim plants As New List(Of String)
        plants.Add("Seattle")
        plants.Add("San-Diego")

        Dim markets As New List(Of String)
        markets.Add("New-York")
        markets.Add("Chicago")
        markets.Add("Topeka")

        Dim capacity As New Dictionary(Of String, Double)
        capacity.Add("Seattle", 350.0)
        capacity.Add("San-Diego", 600.0)

        Dim demand As New Dictionary(Of String, Double)
        demand.Add("New-York", 325.0)
        demand.Add("Chicago", 300.0)
        demand.Add("Topeka", 275.0)

        Dim distance As New Dictionary(Of Tuple(Of String, String), Double)
        distance.Add(New Tuple(Of String, String)("Seattle", "New-York"), 2.5)
        distance.Add(New Tuple(Of String, String)("Seattle", "Chicago"), 1.7)
        distance.Add(New Tuple(Of String, String)("Seattle", "Topeka"), 1.8)
        distance.Add(New Tuple(Of String, String)("San-Diego", "New-York"), 2.5)
        distance.Add(New Tuple(Of String, String)("San-Diego", "Chicago"), 1.8)
        distance.Add(New Tuple(Of String, String)("San-Diego", "Topeka"), 1.4)

        Dim ws As GAMSWorkspace
        If (Environment.GetCommandLineArgs().Length > 1) Then
            '                        systemDirectory
            ws = New GAMSWorkspace(wDir, Environment.GetCommandLineArgs()(1), )
        Else
            ws = New GAMSWorkspace(wDir, , )
        End If

        ' prepare a GAMSDatabase with data from the C# data structures
        Dim db As GAMSDatabase = ws.AddDatabase()

        Dim i As GAMSSet = db.AddSet("i", 1, "canning plants")
        For Each p As String In plants
            i.AddRecord(p)
        Next
        Dim j As GAMSSet = db.AddSet("j", 1, "markets")
        For Each m As String In markets
            j.AddRecord(m)
        Next
        Dim a As GAMSParameter = db.AddParameter("a", 1, "capacity of plant i in cases")
        For Each p As String In plants
            a.AddRecord(p).Value = capacity(p)
        Next
        Dim b As GAMSParameter = db.AddParameter("b", 1, "demand at market j in cases")
        For Each m As String In markets
            b.AddRecord(m).Value = demand(m)
        Next
        Dim d As GAMSParameter = db.AddParameter("d", 2, "distance in thousands of miles")
        For Each t As Tuple(Of String, String) In distance.Keys
            d.AddRecord(t.Item1, t.Item2).Value = distance(t)
        Next
        Dim f As GAMSParameter = db.AddParameter("f", 0, "freight in dollars per case per thousand miles")
        f.AddRecord().Value = 90

        ' run a job using data from the created GAMSDatabase
        Dim cpBase As GAMSCheckpoint = ws.AddCheckpoint("tbase")
        Using opt As GAMSOptions = ws.AddOptions()

            Dim t4 As GAMSJob = ws.AddJobFromString(GetModelText(), cpBase)
            opt.Defines.Add("gdxincname", db.Name)
            opt.AllModelTypes = "xpress"
            t4.Run(opt, db)
            For Each rec As GAMSVariableRecord In t4.OutDB.GetVariable("x")
                Console.WriteLine("x(" + rec.Keys(0) + "," + rec.Keys(1) + "): level=" + rec.Level.ToString + " marginal=" + rec.Marginal.ToString)
            Next

        End Using
    End Sub


    Sub CreateSaveRestart(ByVal cpFileName As String)
        Dim ws As GAMSWorkspace

        If (Environment.GetCommandLineArgs().Length > 1) Then
            ws = New GAMSWorkspace(Path.GetDirectoryName(cpFileName), Environment.GetCommandLineArgs()(1), )
        Else
            ws = New GAMSWorkspace(Path.GetDirectoryName(cpFileName), , )
        End If

        Dim j1 As GAMSJob = ws.AddJobFromString(GetBaseModelText())
        Dim opt As GAMSOptions = ws.AddOptions()

        opt.Action = GAMSOptions.EAction.CompileOnly

        Dim cp As GAMSCheckpoint = ws.AddCheckpoint(Path.GetFileName(cpFileName))
        j1.Run(opt, cp)

        opt.Dispose()
    End Sub

    Public Function GetBaseModelText()
        Dim model As String = "" & _
            vbCrLf & "$onempty" & _
            vbCrLf & "  Sets" & _
            vbCrLf & "       i(*)   canning plants / /" & _
            vbCrLf & "       j(*)   markets        / /" & _
            vbCrLf & "" & _
            vbCrLf & "  Parameters" & _
            vbCrLf & "       a(i)   capacity of plant i in cases / /" & _
            vbCrLf & "       b(j)   demand at market j in cases  / /" & _
            vbCrLf & "       d(i,j) distance in thousands of miles / /" & _
            vbCrLf & "  Scalar f  freight in dollars per case per thousand miles /0/;" & _
            vbCrLf & "" & _
            vbCrLf & "  Parameter c(i,j)  transport cost in thousands of dollars per case ;" & _
            vbCrLf & "" & _
            vbCrLf & "            c(i,j) = f * d(i,j) / 1000 ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Variables" & _
            vbCrLf & "       x(i,j)  shipment quantities in cases" & _
            vbCrLf & "       z       total transportation costs in thousands of dollars ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Positive Variable x ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Equations" & _
            vbCrLf & "       cost        define objective function" & _
            vbCrLf & "       supply(i)   observe supply limit at plant i" & _
            vbCrLf & "       demand(j)   satisfy demand at market j ;" & _
            vbCrLf & "" & _
            vbCrLf & "  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;" & _
            vbCrLf & "" & _
            vbCrLf & "  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;" & _
            vbCrLf & "" & _
            vbCrLf & "  demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Model transport /all/ ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Solve transport using lp minimizing z ;"

        Return model
    End Function


    Public Function GetModelText()
        Dim model As String = "" & _
            vbCrLf & "$if not set gdxincname $abort 'no include file name for data file provided'" & _
            vbCrLf & "$gdxin %gdxincname%" & _
            vbCrLf & "$onMulti" & _
            vbCrLf & "$load i j a b d f" & _
            vbCrLf & "$gdxin" & _
            vbCrLf & "" & _
            vbCrLf & "  Display x.l, x.m ;"
        Return model
    End Function

End Module
