///////////////////////////////////////////////////////////////
// This program performs the following steps:
//    1. Generate a gdx file with demand data
//    2. Calls GAMS to solve a simple transportation model
//       (The GAMS model writes the solution to a gdx file)
//    3. The solution is read from the gdx file
///////////////////////////////////////////////////////////////

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xp_example2
{
    class xp_example2
    {
        static gamsxcs gamsx;
        static gdxcs gdx;
        static optcs opt;

        static bool GDXError(int i, string s)
        {
            string msg = string.Empty;

            gdx.gdxErrorStr(i, ref msg);
            Console.WriteLine(s + "failed: " + msg);
            return false;
        }

        static bool WriteModelData(string fnGDXFile)
        {
            int status = 0;
            string msg = string.Empty;
            string[] Indx = new string[gamsglobals.maxdim];
            double[] Values = new double[gamsglobals.val_max];

            gdx.gdxOpenWrite(fnGDXFile, "XP_Example2", ref status);

            if (status != 0)
                return GDXError(status, "gdxOpenWrite");

            if (0 == gdx.gdxDataWriteStrStart("Demand", "Demand Data", 1, gamsglobals.dt_par, 0))
                return GDXError(gdx.gdxGetLastError(), "gdxDataWriteStrStart");

            Indx[0] = "New-York"; Values[gamsglobals.val_level] = 324.0; gdx.gdxDataWriteStr(Indx, Values);
            Indx[0] = "Chicago"; Values[gamsglobals.val_level] = 299.0; gdx.gdxDataWriteStr(Indx, Values);
            Indx[0] = "Topeka"; Values[gamsglobals.val_level] = 274.0; gdx.gdxDataWriteStr(Indx, Values);

            if (0 == gdx.gdxDataWriteDone())
                return GDXError(gdx.gdxGetLastError(), "gdxDataWriteDone");

            if (gdx.gdxClose() != 0)
                return GDXError(gdx.gdxGetLastError(), "gdxClose");

            return true;
        }

        static bool CallGams(string sysDir)
        {
            string msg = string.Empty;
            int saveEOLOnly;

            string defFile = sysDir + System.IO.Path.DirectorySeparatorChar + "optgams.def";

            if (opt.optReadDefinition(defFile) != 0)
            {
                int i, itype = 0;
                for (i = 1; i <= opt.optMessageCount(); i++)
                {
                    opt.optGetMessage(i, ref msg, ref itype);
                    Console.WriteLine(msg);
                }
                Console.WriteLine("*** Problem reading definition file " + defFile);
                return false;
            }

            saveEOLOnly = opt.optEOLOnlySet(0);
            //need to adjust path if executed e.g. in bin\debug            
            opt.optReadFromStr("I=..\\GAMS\\model2.gms lo=2");
            opt.optEOLOnlySet(saveEOLOnly);
            opt.optSetStrStr("sysdir", sysDir);

            if (gamsx.gamsxRunExecDLL(opt.GetoptPtr(), sysDir, 1, ref msg) != 0)
            {
                Console.WriteLine("Could not execute RunExecDLL: " + msg);
                return false;
            }
            return true;
        }

        static bool ReadSolutionData(string fnGDXFile)
        {
            int VarNr = 0, NrRecs = 0, FDim = 0, dim = 0, vartype = 0;
            int status = 0;
            string VarName;
            string msg = string.Empty;
            string[] Indx = new string[gamsglobals.maxdim];
            double[] Values = new double[gamsglobals.val_max];

            gdx.gdxOpenRead(fnGDXFile, ref status);
            if (status != 0)
                return GDXError(status, "gdxOpenRead");

            VarName = "result";
            if (0 == gdx.gdxFindSymbol(VarName, ref VarNr))
            {
                Console.WriteLine("Could not find variable >" + VarName + "<");
                return false;
            }

            gdx.gdxSymbolInfo(VarNr, ref VarName, ref dim, ref vartype);
            if (2 != dim || gamsglobals.dt_var != vartype)
            {
                Console.WriteLine(VarName + " is not a two dimensional variable");
                return false;
            }

            if (0 == gdx.gdxDataReadStrStart(VarNr, ref NrRecs))
                return GDXError(gdx.gdxGetLastError(), "gdxDataReadStrStart");

            while (gdx.gdxDataReadStr(ref Indx, ref Values, ref FDim) != 0)
            {
                int i;
                if (0.0 == Values[gamsglobals.val_level]) continue; /* skip level = 0.0 is default */
                for (i = 0; i < dim; i++)
                {
                    Console.Write(Indx[i]);
                    if (i < dim - 1)
                        Console.Write(".");
                }
                Console.WriteLine(" = " + Values[gamsglobals.val_level]);
            }
            Console.WriteLine("All solution values shown");

            gdx.gdxDataReadDone();

            status = gdx.gdxGetLastError();
            if (status != 0)
                return GDXError(status, "GDX");

            if (gdx.gdxClose() != 0)
                return GDXError(gdx.gdxGetLastError(), "gdxClose");

            return true;
        }



        static int Main(string[] args)
        {
            string sysDir, msg = string.Empty;
            string defSysDir = @"C:\GAMS\win32\24.0";

            if (Environment.GetCommandLineArgs().Length > 1)
                sysDir = Environment.GetCommandLineArgs()[1];
            else
                sysDir = defSysDir;

            Console.WriteLine("Loading objects from GAMS system directory: " + sysDir);

            gamsx = new gamsxcs(sysDir, ref msg);
            if (!string.IsNullOrEmpty(msg))
            {
                Console.WriteLine("Could not create gamsx object: " + msg);
                return 1;
            }
            gdx = new gdxcs(sysDir, ref msg);
            if (!string.IsNullOrEmpty(msg))
            {
                Console.WriteLine("Could not create gdx object: " + msg);
                return 1;
            }
            opt = new optcs(sysDir, ref msg);
            if (!string.IsNullOrEmpty(msg))
            {
                Console.WriteLine("Could not create opt object: " + msg);
                return 1;
            }

            if (!WriteModelData("demanddata.gdx"))
            {
                Console.WriteLine("Model data not written");
                return 1;
            }

            if (!CallGams(sysDir))
            {
                Console.WriteLine("Call to GAMS failed");
                return 1;
            }

            if (!ReadSolutionData("results.gdx"))
            {
                Console.WriteLine("Could not read solution back");
                return 1;
            }

            return 0;
        }
    }
}
