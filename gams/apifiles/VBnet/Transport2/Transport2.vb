Imports GAMS
Imports System.IO

Module Transport2

    Sub Main()
        Dim ws As GAMSWorkspace
        If (Environment.GetCommandLineArgs().Length > 1) Then
            '                        systemDirectory
            ws = New GAMSWorkspace(, Environment.GetCommandLineArgs()(1), )
        Else
            ws = New GAMSWorkspace()
        End If
        Using writer As StreamWriter = New StreamWriter(ws.WorkingDirectory + Path.DirectorySeparatorChar + "tdata.gms")

            writer.Write(GetDataText())
        End Using
        ' run a job using an instance of GAMSOptions that defines the data include file
        Using opt As GAMSOptions = ws.AddOptions()

            Dim t2 As GAMSJob = ws.AddJobFromString(GetModelText())
            opt.Defines.Add("incname", "tdata")
            t2.Run(opt)
            For Each rec As GAMSVariableRecord In t2.OutDB.GetVariable("x")
                Console.WriteLine("x(" + rec.Keys(0) + "," + rec.Keys(1) + "): level=" + rec.Level.ToString + " marginal=" + rec.Marginal.ToString)
            Next
        End Using
    End Sub

    Public Function GetDataText() As String
        Dim data As String = "  Sets" & _
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
            vbCrLf & "  Scalar f  freight in dollars per case per thousand miles  /90/ "

        Return data
    End Function

    Public Function GetModelText() As String
        Dim model As String = "  Sets" & _
            vbCrLf & "       i   canning plants" & _
            vbCrLf & "       j   markets" & _
            vbCrLf & "" & _
            vbCrLf & "  Parameters" & _
            vbCrLf & "       a(i)   capacity of plant i in cases" & _
            vbCrLf & "       b(j)   demand at market j in cases" & _
            vbCrLf & "       d(i,j) distance in thousands of miles" & _
            vbCrLf & "  Scalar f  freight in dollars per case per thousand miles;" & _
            vbCrLf & "" & _
            vbCrLf & "$if not set incname $abort 'no include file name for data file provided'" & _
            vbCrLf & "$include %incname%" & _
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
            vbCrLf & "  Solve transport using lp minimizing z ;" & _
            vbCrLf & "" & _
            vbCrLf & "  Display x.l, x.m ;"
        Return model
    End Function

End Module
