Imports GAMS
Imports System.IO

Module Transport8

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
        ws.AddJobFromString(GetModelText()).Run(cp)

        Dim barray() As Double = {0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3}
        Dim bmultQueue As New Queue(Of Double)
        For Each b As Double In barray
            bmultQueue.Enqueue(b)
        Next
        ' solve multiple model instances in parallel
        Dim queueMutex As Object = New Object()
        Dim ioMutex As Object = New Object()
        System.Threading.Tasks.Parallel.For(0, 2, Sub(CurrentItem) ScenSolve(ws, cp, bmultQueue, queueMutex, ioMutex))
    End Sub

    Sub ScenSolve(ByVal ws As GAMSWorkspace, ByVal cp As GAMSCheckpoint, ByVal bmultQueue As Queue(Of Double), ByVal queueMutex As Object, ByVal ioMutex As Object)

        Dim mi As GAMSModelInstance = cp.AddModelInstance()
        Dim bmult As GAMSParameter = mi.SyncDB.AddParameter("bmult", 0, "demand multiplier")
        Dim opt As GAMSOptions = ws.AddOptions()
        opt.AllModelTypes = "cplexd"
        ' instantiate the GAMSModelInstance and pass a model definition and GAMSModifier to declare bmult mutable
        mi.Instantiate("transport us lp min z", opt, New GAMSModifier(bmult))
        bmult.AddRecord().Value = 1.0

        While (True)

            Dim b As Double
            ' dynamically get a bmult value from the queue instead of passing it to the different threads at creation time
            SyncLock (queueMutex)
                If (0 = bmultQueue.Count) Then
                    Return
                Else
                    b = bmultQueue.Dequeue()
                End If
            End SyncLock
            bmult.FirstRecord().Value = b
            mi.Solve()
            ' we need to make the ouput a critical section to avoid messed up report informations
            SyncLock (ioMutex)
                Console.WriteLine("Scenario bmult={0}", b, ":")
                Console.WriteLine("  Modelstatus: {0}", mi.ModelStatus)
                Console.WriteLine("  Solvestatus: {0}", mi.SolveStatus)
                Console.WriteLine("  Obj: {0}", mi.SyncDB.GetVariable("z").FindRecord().Level)
            End SyncLock
        End While
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
