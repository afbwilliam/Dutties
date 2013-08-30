Imports GAMS
Imports System.IO
Imports System.Data.OleDb

Module Transport9

    Sub Main()
        Dim ws As GAMSWorkspace
        If (Environment.GetCommandLineArgs().Length > 1) Then
            '                        systemDirectory
            ws = New GAMSWorkspace(, Environment.GetCommandLineArgs()(1), )
        Else
            ws = New GAMSWorkspace()
        End If

        ' fill GAMSDatabase by reading from Access
        Dim db As GAMSDatabase = ReadFromAccess(ws)

        ' run job
        Using opt As GAMSOptions = ws.AddOptions()

            Dim t9 As GAMSJob = ws.AddJobFromString(GetModelText())
            opt.Defines.Add("gdxincname", db.Name)
            opt.AllModelTypes = "xpress"
            t9.Run(opt, db)
            For Each rec As GAMSVariableRecord In t9.OutDB.GetVariable("x")
                Console.WriteLine("x(" + rec.Keys(0) + "," + rec.Keys(1) + "): level=" + rec.Level.ToString + " marginal=" + rec.Marginal.ToString)
            Next
        End Using
    End Sub


    Sub ReadSet(ByVal connect As OleDbConnection, ByVal db As GAMSDatabase, ByVal strAccessSelect As String, _
                ByVal setName As String, ByVal setDim As Integer, ByVal setExp As String)
        Try
            Dim cmd As OleDbCommand = New OleDbCommand(strAccessSelect, connect)
            connect.Open()
            Dim reader As OleDbDataReader = cmd.ExecuteReader()
            If (reader.FieldCount <> setDim) Then
                Console.WriteLine("Number of fields in select statement does not match setDim")
                Environment.Exit(1)
            End If

            Dim i As GAMSSet = db.AddSet(setName, setDim, setExp)

            Dim keys(setDim - 1) As String

            While reader.Read()
                For idx As Integer = 0 To (setDim - 1)
                    keys(idx) = reader.GetString(idx)
                Next
                i.AddRecord(keys)
            End While
        Catch ex As Exception
            Console.WriteLine("Error: Failed to retrieve the required data from the DataBase.\n{0}", ex.Message)
            Environment.Exit(1)
        Finally
            connect.Close()
        End Try
        ' Console.ReadLine()
    End Sub


    Sub ReadParameter(ByVal connect As OleDbConnection, ByVal db As GAMSDatabase, ByVal strAccessSelect As String, _
                      ByVal parName As String, ByVal parDim As Integer, ByVal parExp As String)
        Try
            Dim cmd As OleDbCommand = New OleDbCommand(strAccessSelect, connect)
            connect.Open()

            Dim reader As OleDbDataReader = cmd.ExecuteReader()

            If reader.FieldCount <> parDim + 1 Then
                Console.WriteLine("Number of fields in select statement does not match parDim+1")
                Environment.Exit(1)
            End If
            Dim a As GAMSParameter = db.AddParameter(parName, parDim, parExp)

            Dim keys(parDim - 1) As String

            While reader.Read()
                For idx = 0 To (parDim - 1)
                    keys(idx) = reader.GetString(idx)
                Next
                a.AddRecord(keys).Value = Convert.ToDouble(reader.GetValue(parDim))
            End While

        Catch ex As Exception

            Console.WriteLine("Error: Failed to retrieve the required data from the DataBase.\n{0}", ex.Message)
            Environment.Exit(1)

        Finally
            connect.Close()
        End Try
    End Sub

    Function ReadFromAccess(ByVal ws As GAMSWorkspace) As GAMSDatabase

        Dim db As GAMSDatabase = ws.AddDatabase()

        ' connect to database
        Dim strAccessConn As String = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=..\..\..\..\Data\transport.accdb"
        Dim connection As OleDbConnection = Nothing
        Try

            connection = New OleDbConnection(strAccessConn)

        Catch ex As Exception

            Console.WriteLine("Error: Failed to create a database connection. \n{0}", ex.Message)
            Environment.Exit(1)

        End Try

        ' read GAMS sets
        ReadSet(connection, db, "SELECT Plant FROM Plant", "i", 1, "canning plants")
        ReadSet(connection, db, "SELECT Market FROM Market", "j", 1, "markets")

        ' read GAMS parameters
        ReadParameter(connection, db, "SELECT Plant,Capacity FROM Plant", "a", 1, "capacity of plant i in cases")
        ReadParameter(connection, db, "SELECT Market,Demand FROM Market", "b", 1, "demand at market j in cases")
        ReadParameter(connection, db, "SELECT Plant,Market,Distance FROM Distance", "d", 2, "distance in thousands of miles")

        Return db
    End Function




    Public Function GetModelText()
        Dim model As String = "" & _
            vbCrLf & "  Sets" & _
            vbCrLf & "       i   canning plants" & _
            vbCrLf & "       j   markets" & _
            vbCrLf & "" & _
            vbCrLf & "  Parameters" & _
            vbCrLf & "       a(i)   capacity of plant i in cases" & _
            vbCrLf & "       b(j)   demand at market j in cases" & _
            vbCrLf & "       d(i,j) distance in thousands of miles" & _
            vbCrLf & "  Scalar f  freight in dollars per case per thousand miles /90/;" & _
            vbCrLf & "" & _
            vbCrLf & "$if not set gdxincname $abort 'no include file name for data file provided'" & _
            vbCrLf & "$gdxin %gdxincname%" & _
            vbCrLf & "$load i j a b d" & _
            vbCrLf & "$gdxin" & _
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
