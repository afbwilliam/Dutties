Module xp_example1
    '///////////////////////////////////////////////////////////////
    '// This program generates demand data for a modified version //
    '// of the trnsport model or reads the solution back from a   //
    '// gdx file.                                                 //
    '//                                                           //
    '// Calling convention:                                       //
    '// Case 1:                                                   //
    '//    Parameter 1: GAMS system directory                     //
    '// The program creates a GDX file with demand data           //
    '// Case 2:                                                   //
    '//    Parameter 1: GAMS system directory                     //
    '//    Parameter 2: gdxfile                                   //
    '// The program reads the solution from the GDX file          //
    '// Paul van der Eijk Jun-12, 2002                            //
    '///////////////////////////////////////////////////////////////

    Dim PGX As IntPtr

    Sub ReportGDXError(ByVal PGX As IntPtr)
        Dim S As String
        Console.WriteLine("**** Fatal GDX Error")
        gdxerrorstr(0, gdxgetlasterror(PGX), S)
        Console.WriteLine("**** " & S)
        End
    End Sub

    Sub ReportIOError(ByVal N As Integer)
        Console.WriteLine("**** Fatal I/O Error = " & N)
        End
    End Sub

    Sub WriteData(ByVal s As String, ByVal V As Double)
        Dim Indx(maxdim) As String 'TgdxStrIndex
        Dim Values(val_max) As Double 'TgdxValues
        Indx(0) = s
        Values(val_level) = V
        gdxdatawritestr(PGX, Indx, Values)
    End Sub


    Dim Msg As String
    Dim Sysdir As String
    Dim Producer As String
    Dim ErrNr, rc As Integer
    Dim Indx(maxdim) As String 'TgdxStrIndex
    Dim Values(val_max) As Double 'TgdxValues
    Dim VarNr As Integer
    Dim NrRecs As Integer
    Dim N As Integer
    Dim Dimen As Integer
    Dim VarName As String
    Dim VarTyp As Integer
    Dim D As Integer

    Sub Main()
        If Environment.GetCommandLineArgs().Length <> 2 And Environment.GetCommandLineArgs().Length <> 3 Then
            Console.WriteLine("**** XP_Example1: incorrect number of parameters")
            End
        End If

        Sysdir = Environment.GetCommandLineArgs(1)
        Console.WriteLine("XP_Example1 using GAMS system directory: " & Sysdir)

        If Not gdxcreatex(PGX, Msg) Then
            Console.WriteLine("**** Could not load GDX library")
            Console.WriteLine("**** " & Msg)
            Exit Sub
        End If

        gdxgetdllversion(PGX, Msg)
        Console.WriteLine("Using GDX DLL version: " & Msg)

        If Environment.GetCommandLineArgs().Length = 2 Then
            'write demand data
            gdxopenwrite(PGX, "demanddata.gdx", "xp_example1", ErrNr)
            If ErrNr <> 0 Then
                ReportIOError(ErrNr)
            End If
            If gdxdatawritestrstart(PGX, "Demand", "Demand data", 1, dt_par, 0) = 0 Then
                ReportGDXError(PGX)
            End If
            WriteData("New-York", 324.0)
            WriteData("Chicago", 299.0)
            WriteData("Topeka", 274.0)
            If gdxdatawritedone(PGX) = 0 Then
                ReportGDXError(PGX)
            End If
            Console.WriteLine("Demand data written by xp_example1")
        Else
            rc = gdxopenread(PGX, Environment.GetCommandLineArgs(2), ErrNr) 'Environment.GetCommandLineArgs(1) "trnsport.gdx"
            If ErrNr <> 0 Then
                ReportIOError(ErrNr)
            End If

            'read x variable back (non-default level values only)
            gdxfileversion(PGX, Msg, Producer)
            Console.WriteLine("GDX file written using version: " & Msg)
            Console.WriteLine("GDX file written by: " & Producer)

            If gdxfindsymbol(PGX, "x", VarNr) = 0 Then
                Console.WriteLine("**** Could not find variable X")
                Exit Sub
            End If

            gdxsymbolinfo(PGX, VarNr, VarName, Dimen, VarTyp)
            If (Dimen <> 2) Or (VarTyp <> dt_var) Then
                Console.WriteLine("**** X is not a two dimensional variable")
                Exit Sub
            End If

            If gdxdatareadstrstart(PGX, VarNr, NrRecs) = 0 Then
                ReportGDXError(PGX)
            End If

            Console.WriteLine("Variable X has " & NrRecs & " records")
            While gdxdatareadstr(PGX, Indx, Values, N) <> 0
                If Values(val_level) = 0.0 Then      'skip level = 0.0 is default
                    Continue While
                End If
                For D = 1 To Dimen
                    Console.Write(Indx(D - 1))
                    If D < Dimen Then
                        Console.Write(".")
                    End If
                Next
                Console.WriteLine(" = " & Values(val_level))
            End While
            Console.WriteLine("All solution values shown")
            gdxdatareaddone(PGX)
        End If

        ErrNr = gdxclose(PGX)
        If ErrNr <> 0 Then
            ReportIOError(ErrNr)
        End If

    End Sub

End Module
