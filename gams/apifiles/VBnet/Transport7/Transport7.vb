Imports GAMS
Imports System.IO

Module Transport7

    Sub Main()
        Dim ws As GAMSWorkspace
        If (Environment.GetCommandLineArgs().Length > 1) Then
            '                        systemDirectory
            ws = New GAMSWorkspace(, Environment.GetCommandLineArgs()(1), )
        Else
            ws = New GAMSWorkspace()
        End If

        Dim cp As GAMSCheckpoint = ws.AddCheckpoint()

        ' initialize a GAMSCheckpoint by running a GAMSJob
        Dim t7 As GAMSJob = ws.AddJobFromString(GetModelText())
        t7.Run(cp)

        ' create a GAMSModelInstance and solve it multiple times with different scalar bmult
        Dim mi As GAMSModelInstance = cp.AddModelInstance()

        Dim bmult As GAMSParameter = mi.SyncDB.AddParameter("bmult", 0, "demand multiplier")
        Dim opt As GAMSOptions = ws.AddOptions()
        opt.AllModelTypes = "gurobi"

        ' instantiate the GAMSModelInstance and pass a model definition and GAMSModifier to declare bmult mutable
        mi.Instantiate("transport us lp min z", opt, New GAMSModifier(bmult))

        bmult.AddRecord().Value = 1.0
        Dim bmultlist() As Double = {0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3}

        For Each b As Double In bmultlist
            '{
            bmult.FirstRecord().Value = b
            mi.Solve()
            Console.WriteLine("Scenario bmult={0}", b, ":")
            Console.WriteLine("  Modelstatus: {0}", mi.ModelStatus)
            Console.WriteLine("  Solvestatus: {0}", mi.SolveStatus)
            Console.WriteLine("  Obj: {0}", mi.SyncDB.GetVariable("z").FindRecord().Level)
            '}
        Next
        ' create a GAMSModelInstance and solve it with single links in the network blocked
        mi = cp.AddModelInstance()

        Dim x As GAMSVariable = mi.SyncDB.AddVariable("x", 2, VarType.Positive, "")
        Dim xup As GAMSParameter = mi.SyncDB.AddParameter("xup", 2, "upper bound on x")
        Dim modifiers As GAMSModifier = New GAMSModifier(x, UpdateAction.Upper, xup)

        ' instantiate the GAMSModelInstance and pass a model definition and GAMSModifier to declare upper bound of X mutable
        mi.Instantiate("transport us lp min z", modifiers)

        For Each i As GAMSSetRecord In t7.OutDB.GetSet("i")
            For Each j As GAMSSetRecord In t7.OutDB.GetSet("j")
                xup.Clear()
                xup.AddRecord(i.Keys(0), j.Keys(0)).Value = 0
                mi.Solve()
                Console.WriteLine("Scenario link blocked: " + i.Keys(0) + " - " + j.Keys(0))
                Console.WriteLine("  Modelstatus: {0}", mi.ModelStatus)
                Console.WriteLine("  Solvestatus: {0}", mi.SolveStatus)
                Console.WriteLine("  Obj: {0}", mi.SyncDB.GetVariable("z").FindRecord().Level)
            Next
        Next
    End Sub

    Public Function GetModelText()
        Dim model As String = "  Sets" & _
            vbCrLf & "       i   canning plants   / seattle, san-diego /" & _
            vbCrLf & "       j   markets          / new-york, chicago, topeka / ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Parameters" & _
            vbCrLf & "" & _
            vbCrLf & "       a(i)  capacity of plant i in cases" & _
            vbCrLf & "         /    seattle     350" & _
            vbCrLf & "              san-diego   600  /" & _
            vbCrLf & "" & _
            vbCrLf & "       b(j)  demand at market j in cases" & _
            vbCrLf & "         /    new-york    325" & _
            vbCrLf & "              chicago     300" & _
            vbCrLf & "              topeka      275  / ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Table d(i,j)  distance in thousands of miles" & _
            vbCrLf & "                    new-york       chicago      topeka" & _
            vbCrLf & "      seattle          2.5           1.7          1.8" & _
            vbCrLf & "      san-diego        2.5           1.8          1.4  ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Scalar f      freight in dollars per case per thousand miles  /90/ ;" & _
            vbCrLf & "  Scalar bmult  demand multiplier /1/;" & _
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
            vbCrLf & "  demand(j) ..   sum(i, x(i,j))  =g=  bmult*b(j) ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Model transport /all/ ;"
        Return model
    End Function

End Module
