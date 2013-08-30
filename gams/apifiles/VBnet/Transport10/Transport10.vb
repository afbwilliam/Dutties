Imports GAMS
Imports System.IO
Imports Excel = Microsoft.Office.Interop.Excel

Module Transport10

    Sub Main()
        ' Reading input data from workbook
        excelApp = New Excel.Application()

        Dim wb As Excel.Workbook = excelApp.Workbooks.Open(Directory.GetCurrentDirectory() + "\..\..\..\..\Data\transport.xls")

        Dim range As Excel.Range

        Dim capacity As Excel.Worksheet = wb.Worksheets("capacity")
        range = capacity.UsedRange
        Dim capacityData As Array = range.Cells.Value
        Dim iCount As Integer = capacity.UsedRange.Columns.Count

        Dim demand As Excel.Worksheet = wb.Worksheets("demand")
        range = demand.UsedRange
        Dim demandData As Array = range.Cells.Value
        Dim jCount As Integer = range.Columns.Count

        Dim distance As Excel.Worksheet = wb.Worksheets("distance")
        range = distance.UsedRange
        Dim distanceData As Array = range.Cells.Value

        ' number of markets/plants have to be the same in all spreadsheets
        Debug.Assert((range.Columns.Count - 1) = jCount And (range.Rows.Count - 1) = iCount, _
                         "Size of the spreadsheets doesn't match")
        wb.Close()

        ' Creating the GAMSDatabase and fill with the workbook data
        Dim ws As GAMSWorkspace
        If (Environment.GetCommandLineArgs().Length > 1) Then
            '                        systemDirectory
            ws = New GAMSWorkspace(, Environment.GetCommandLineArgs()(1), )
        Else
            ws = New GAMSWorkspace()
        End If

        Dim db As GAMSDatabase = ws.AddDatabase()

        Dim i As GAMSSet = db.AddSet("i", 1, "Plants")
        Dim j As GAMSSet = db.AddSet("j", 1, "Markets")
        Dim capacityParam As GAMSParameter = db.AddParameter("a", 1, "Capacity")
        Dim demandParam As GAMSParameter = db.AddParameter("b", 1, "Demand")
        Dim distanceParam As GAMSParameter = db.AddParameter("d", 2, "Distance")

        For ic As Integer = 1 To iCount
            i.AddRecord(capacityData.GetValue(1, ic))
            capacityParam.AddRecord(capacityData.GetValue(1, ic)).Value = capacityData.GetValue(2, ic)
        Next

        For jc As Integer = 1 To jCount
            j.AddRecord(demandData.GetValue(1, jc))
            demandParam.AddRecord(demandData.GetValue(1, jc)).Value = demandData.GetValue(2, jc)

            For ic As Integer = 1 To iCount
                distanceParam.AddRecord(distanceData.GetValue(ic + 1, 1), distanceData.GetValue(1, jc + 1)).Value = distanceData.GetValue(ic + 1, jc + 1)
            Next

        Next

        ' Create and run the GAMSJob
        Using opt As GAMSOptions = ws.AddOptions()

            Dim t10 As GAMSJob = ws.AddJobFromString(GetModelText())
            opt.Defines.Add("gdxincname", db.Name)
            opt.AllModelTypes = "xpress"
            t10.Run(opt, db)

            For Each rec As GAMSVariableRecord In t10.OutDB.GetVariable("x")
                Console.WriteLine("x(" + rec.Keys(0) + "," + rec.Keys(1) + "): level=" + rec.Level.ToString + " marginal=" + rec.Marginal.ToString)
            Next

        End Using

    End Sub

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
