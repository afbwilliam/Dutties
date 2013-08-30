Module xp_example2
    '///////////////////////////////////////////////////////////////
    '//This program performs the following steps:                 // 
    '//    1. Generate a gdx file with demand data                //
    '//    2. Calls GAMS to solve a simple transportation model   //
    '//       (The GAMS model writes the solution to a gdx file)  //
    '//    3. The solution is read from the gdx file              //
    '///////////////////////////////////////////////////////////////


    Dim PGX As IntPtr
    Dim PGA As IntPtr
    Dim POP As IntPtr

    Sub ReportGDXError(ByVal inp As String)
        Dim S As String
        Console.WriteLine("**** Fatal GDX Error")
        gdxerrorstr(PGX, gdxgetlasterror(PGX), S)
        If S <> "" Then Console.WriteLine("**** " & inp & ":" & S)
        End
    End Sub

    Sub WriteData(ByVal s As String, ByVal V As Double)
        Dim Indx(maxdim) As String 'TgdxStrIndex
        Dim Values(val_max) As Double 'TgdxValues
        Indx(0) = s
        Values(val_level) = V
        gdxdatawritestr(PGX, Indx, Values)
    End Sub

    Function WriteModelData(ByVal fngdxfile As String) As Boolean
        Dim Msg As String
        Dim ErrNr As Integer

        gdxopenwrite(PGX, fngdxfile, "XP_Example2", ErrNr)
        If (ErrNr <> 0) Then
            gdxerrorstr(0, ErrNr, Msg)
            If Msg <> "" Then Console.WriteLine("*** Error gdxOpenWrite: " + Msg)
            Return False
        End If

        If gdxdatawritestrstart(PGX, "Demand", "Demand data", 1, dt_par, 0) = 0 Then
            ReportGDXError("DataWriteStrStart")
            Return False
        End If

        WriteData("New-York", 324.0)
        WriteData("Chicago", 299.0)
        WriteData("Topeka", 274.0)

        If gdxdatawritedone(PGX) = 0 Then
            ReportGDXError("WriteData")
        End If

        ErrNr = gdxgetlasterror(PGX)
        If ErrNr <> 0 Then
            gdxerrorstr(PGX, ErrNr, Msg)
            If Msg <> "" Then Console.WriteLine("*** Error while writing GDX File: " + Msg)
            Return False
        End If

        ErrNr = gdxclose(PGX)
        If ErrNr <> 0 Then
            gdxerrorstr(PGX, ErrNr, Msg)
            If Msg <> "" Then Console.WriteLine("*** Error gdxClose: " + Msg)
            Return False
        End If
        Return True
    End Function

    Function CallGams(ByVal SysDir As String) As Boolean
        Dim Msg As String
        Dim ErrNr As Integer
        Dim n As Integer

        If optreaddefinition(POP, SysDir & "\optgams.def") <> 0 Then
            Console.WriteLine("*** Error ReadDefinition, cannot read def file:" & SysDir & "\optgams.def")
            Return False
        End If

        optsetstrstr(POP, "SysDir", SysDir)
        optsetstrstr(POP, "Input", "model2.gms")
        optsetintstr(POP, "LogOption", 2)        'write .log and .lst files

        ErrNr = gamsxrunexecdll(PGA, POP, SysDir, 1, Msg)
        If ErrNr <> 0 Then
            Console.WriteLine("*** Error RunExecDLL: Error in GAMS call = " & ErrNr)
            Return False
        End If
        Return True
    End Function

    Sub ReadData(ByVal Dimen As Integer)
        Dim Indx(maxdim) As String 'TgdxStrIndex
        Dim Values(val_max) As Double 'TgdxValues
        Dim n As Integer
        Dim D As Integer

        While gdxdatareadstr(PGX, Indx, Values, n) <> 0
            If Values(val_level) = 0 Then Continue While
            For D = 0 To Dimen - 1
                Console.Write(Indx(D))
                If D < Dimen - 1 Then Console.Write(".")
            Next
            Console.WriteLine(" = " + Values(val_level).ToString)
        End While
        Console.WriteLine("All solution values shown")
    End Sub


    Function ReadSolutionData(ByVal fngdxfile As String) As Boolean
        Dim Dimen As Integer
        Dim Msg As String
        Dim ErrNr As Integer
        Dim VarNr As Integer
        Dim VarName As String
        Dim VarTyp As Integer
        Dim NrRecs As Integer

        gdxopenread(PGX, fngdxfile, ErrNr)
        If ErrNr <> 0 Then
            gdxerrorstr(PGX, ErrNr, Msg)
            If Msg <> "" Then Console.WriteLine("*** Error OpenWrite: " & Msg)
            Return False
        End If

        VarName = "result"
        If gdxfindsymbol(PGX, VarName, VarNr) = 0 Then
            Console.WriteLine("*** Error FindSymbol: Could not find variable " & VarName)
            Return False
        End If

        gdxsymbolinfo(PGX, VarNr, VarName, Dimen, VarTyp)
        If (Dimen <> 2) Or (VarTyp <> dt_var) Then
            Console.WriteLine("*** Error SymbolInfo: " & VarName & " is not a two dimensional variable")
            Return False
        End If

        If gdxdatareadstrstart(PGX, VarNr, NrRecs) = 0 Then
            ReportGDXError("DataReadStrStart")
            Return False
        End If

        ReadData(Dimen)
        gdxdatareaddone(PGX)
        gdxclose(PGX)
        Return True
    End Function

    Sub Main()

        Dim Msg As String
        Dim fngdxinp As String = "demanddata.gdx"
        Dim Sysdir As String
        Dim ok As Boolean = True

        If Environment.GetCommandLineArgs().Length < 2 Then
            Console.WriteLine("**** XP_Example2: GAMS system directory needs to be specified on comand line!")
            End
        End If

        Sysdir = Environment.GetCommandLineArgs(1)
        Console.WriteLine("XP_Example2 using GAMS system directory: " & Sysdir)

        If Not gdxcreatex(PGX, Msg) Then
            Console.WriteLine("**** Could not load GDX library")
            Console.WriteLine("**** " & Msg)
            ok = False
        End If

        If ok And Not gamsxcreatex(PGA, Msg) Then
            Console.WriteLine("**** Could not load GAMSX library")
            Console.WriteLine("**** " & Msg)
            ok = False
        End If

        If ok And Not optcreatex(POP, Msg) Then
            Console.WriteLine("**** Could not load Option library")
            Console.WriteLine("**** " & Msg)
            ok = False
        End If

        If ok And Not WriteModelData(fngdxinp) Then
            Console.WriteLine("Model data not written")
            ok = False
        End If

        If ok And Not CallGams(Sysdir) Then
            Console.WriteLine("Call to GAMS failed")
            ok = False
        End If

        If ok And Not ReadSolutionData("results.gdx") Then Console.WriteLine("Could not read solution back")

    End Sub

End Module

