///////////////////////////////////////////////////////////////
// This program generates demand data for a modified version //
// of the trnsport model or reads the solution back from a   //
// gdx file.                                                 //
//                                                           //
// Calling convention:                                       //
// Case 1:                                                   //
//    Parameter 1: GAMS system directory                     //
// The program creates a GDX file with demand data           //
// Case 2:                                                   //
//    Parameter 1: GAMS system directory                     //
//    Parameter 2: gdxfile                                   //
// The program reads the solution from the GDX file          //
// Paul van der Eijk Jun-12, 2002                            //
///////////////////////////////////////////////////////////////

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xp_example1
{
    class xp_example1
    {
        static gdxcs gdx;
        static void ReportGDXError()
        {
            string S = string.Empty;
            Console.WriteLine("**** Fatal GDX Error");
            gdx.gdxErrorStr(gdx.gdxGetLastError(), ref S);
            Console.WriteLine("**** " + S);
            Environment.Exit(1);
        }

        static void ReportIOError(int N)
        {
            Console.WriteLine("**** Fatal I/O Error = " + N);
            Environment.Exit(1);
        }

        static void WriteData(string s, double V)
        {
            string[] Indx = new string[gamsglobals.maxdim];
            double[] Values = new double[gamsglobals.val_max];
            Indx[0] = s;
            Values[gamsglobals.val_level] = V;
            gdx.gdxDataWriteStr(Indx, Values);
        }

        static int Main(string[] args)
        {
            string Msg = string.Empty;
            string Sysdir;
            string Producer = string.Empty;
            int ErrNr = 0;
            int rc;
            string[] Indx = new string[gamsglobals.maxdim];
            double[] Values = new double[gamsglobals.val_max];
            int VarNr = 0;
            int NrRecs = 0;
            int N = 0;
            int Dimen = 0;
            string VarName = string.Empty;
            int VarTyp = 0;
            int D;

            if (Environment.GetCommandLineArgs().Length != 2 && Environment.GetCommandLineArgs().Length != 3)
            {
                Console.WriteLine("**** XP_Example1: incorrect number of parameters");
                return 1;
            }

            String[] arguments = Environment.GetCommandLineArgs();
            Sysdir = arguments[1];
            Console.WriteLine("XP_Example1 using GAMS system directory: " + Sysdir);

            gdx = new gdxcs(Sysdir, ref Msg);
            if (Msg != string.Empty)
            {
                Console.WriteLine("**** Could not load GDX library");
                Console.WriteLine("**** " + Msg);
                return 1;
            }

            gdx.gdxGetDLLVersion(ref Msg);
            Console.WriteLine("Using GDX DLL version: " + Msg);

            if (Environment.GetCommandLineArgs().Length == 2)
            {
                //write demand data
                gdx.gdxOpenWrite("demanddata.gdx", "xp_example1", ref ErrNr);
                if (ErrNr != 0) xp_example1.ReportIOError(ErrNr);
                if (gdx.gdxDataWriteStrStart("Demand", "Demand data", 1, gamsglobals.dt_par, 0) == 0) ReportGDXError();
                WriteData("New-York", 324.0);
                WriteData("Chicago", 299.0);
                WriteData("Topeka", 274.0);
                if (gdx.gdxDataWriteDone() == 0) ReportGDXError();
                Console.WriteLine("Demand data written by xp_example1");
            }
            else
            {
                rc = gdx.gdxOpenRead(arguments[2], ref ErrNr);
                if (ErrNr != 0) ReportIOError(ErrNr);

                //read x variable back (non-default level values only)
                gdx.gdxFileVersion(ref Msg, ref Producer);
                Console.WriteLine("GDX file written using version: " + Msg);
                Console.WriteLine("GDX file written by: " + Producer);

                if (gdx.gdxFindSymbol("x", ref VarNr) == 0)
                {
                    Console.WriteLine("**** Could not find variable X");
                    return 1;
                }

                gdx.gdxSymbolInfo(VarNr, ref VarName, ref Dimen, ref VarTyp);
                if (Dimen != 2 || VarTyp != gamsglobals.dt_var)
                {
                    Console.WriteLine("**** X is not a two dimensional variable");
                    return 1;
                }

                if (gdx.gdxDataReadStrStart(VarNr, ref NrRecs) == 0) ReportGDXError();

                Console.WriteLine("Variable X has " + NrRecs + " records");
                while (gdx.gdxDataReadStr(ref Indx, ref Values, ref N) != 0)
                {
                    if(Values[gamsglobals.val_level] == 0.0) //skip level = 0.0 is default
                        continue;
                    for (D=0; D<Dimen; D++)
                    {
                        Console.Write(Indx[D]);
                        if (D < Dimen-1) Console.Write(".");
                    }
                    Console.WriteLine(" = " + Values[gamsglobals.val_level]);
                }
                Console.WriteLine("All solution values shown");
                gdx.gdxDataReadDone();
            }
            ErrNr = gdx.gdxClose();
            if (ErrNr != 0) ReportIOError(ErrNr);
            return 0;
        }
    }
}
