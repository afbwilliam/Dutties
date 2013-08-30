using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using GAMS;

namespace TransportSeq
{
    class Transport12
    {
        // Needs to be called with an uninstantiated GAMSModelInstance
        static void GUSSCall(GAMSSet dict, GAMSModelInstance mi, string solveStatement, GAMSOptions opt = null, GAMSModelInstanceOpt miOpt = null, TextWriter output=null)
        {
            List<Tuple<GAMSModifier, GAMSParameter>> modifierList = new List<Tuple<GAMSModifier, GAMSParameter>>();

            if (dict.Dim != 3)
                throw new GAMSException("Dict needs to be 3-dimensional");

            string scenName = dict.FirstRecord(new string[] { " ", "scenario", " " }).Keys[0];
            GAMSSet scenSymbol = dict.GAMSDatabase.GetSet(scenName);


            foreach (GAMSSetRecord rec in dict)
            {
                if (rec.Keys[1].ToLower() == "scenario")
                    continue;
                if (rec.Keys[1].ToLower() == "param")
                {
                    int modifierDim = dict.GAMSDatabase.GetParameter(rec.Keys[2]).Dim - scenSymbol.Dim;
                    if (modifierDim < 0)
                        throw new GAMSException("Dimension of " + rec.Keys[2] + " too small");
                    modifierList.Add(new Tuple<GAMSModifier, GAMSParameter>
                                         (new GAMSModifier(mi.SyncDB.AddParameter(rec.Keys[0], modifierDim, "")), 
                                          dict.GAMSDatabase.GetParameter(rec.Keys[2])));
                }
                else if ((rec.Keys[1].ToLower() == "lower") || (rec.Keys[1].ToLower() == "upper") || (rec.Keys[1].ToLower() == "fixed"))
                {
                    int modifierDim = dict.GAMSDatabase.GetParameter(rec.Keys[2]).Dim - scenSymbol.Dim;
                    if (modifierDim < 0)
                        throw new GAMSException("Dimension of " + rec.Keys[2] + " too small");
                    GAMSVariable modifierVar;
                    try 
                    {
                        modifierVar = dict.GAMSDatabase.GetVariable(rec.Keys[0]);
                    }
                    catch (Exception)
                    {
                        modifierVar = mi.SyncDB.AddVariable(rec.Keys[0],modifierDim, VarType.Free, "");
                    }
                    if (rec.Keys[1].ToLower() == "lower")
                        modifierList.Add(new Tuple<GAMSModifier, GAMSParameter>
                                             (new GAMSModifier(modifierVar, UpdateAction.Lower, mi.SyncDB.AddParameter(rec.Keys[2], modifierDim, "")),
                                              dict.GAMSDatabase.GetParameter(rec.Keys[2])));
                    else if (rec.Keys[1].ToLower() == "upper")
                        modifierList.Add(new Tuple<GAMSModifier, GAMSParameter>
                                             (new GAMSModifier(modifierVar, UpdateAction.Upper, mi.SyncDB.AddParameter(rec.Keys[2], modifierDim, "")),
                                              dict.GAMSDatabase.GetParameter(rec.Keys[2])));
                    else  // fixed 
                        modifierList.Add(new Tuple<GAMSModifier, GAMSParameter>
                                             (new GAMSModifier(modifierVar, UpdateAction.Fixed, mi.SyncDB.AddParameter(rec.Keys[2], modifierDim, "")),
                                              dict.GAMSDatabase.GetParameter(rec.Keys[2])));
                }
                else if ((rec.Keys[1].ToLower() == "level") || (rec.Keys[1].ToLower() == "marginal"))
                {
                    // Check that parameter exists in GAMSDatabase, will throw an exception if not
                    GAMSParameter x = dict.GAMSDatabase.GetParameter(rec.Keys[2]);
                }
                else
                    throw new GAMSException("Cannot handle UpdateAction " + rec.Keys[1]);
            }
            List<GAMSModifier> mL = new List<GAMSModifier>();
            foreach (Tuple<GAMSModifier,GAMSParameter> tup in modifierList)
                mL.Add(tup.Item1);
            mi.Instantiate(solveStatement, opt, mL.ToArray());

            List<Tuple<GAMSSymbol, GAMSParameter, string>> outList = new List<Tuple<GAMSSymbol, GAMSParameter, string>>();

            foreach (GAMSSetRecord s in scenSymbol)
            {
                foreach (Tuple<GAMSModifier, GAMSParameter> tup in modifierList)
                {
                    GAMSParameter p;
                    GAMSParameter pscen = tup.Item2;

                    if (tup.Item1.DataSym == null)
                        p = (GAMSParameter)tup.Item1.GamsSym;
                    else
                        p = tup.Item1.DataSym;

                    // Implemented SymbolUpdateType=BaseCase
                    p.Clear();

                    GAMSParameterRecord rec;
                    string[] filter = new string[pscen.Dim];
                    for (int i = 0; i < scenSymbol.Dim; i++)
                        filter[i] = s.Keys[i];
                    for (int i = scenSymbol.Dim; i < pscen.Dim; i++)
                        filter[i] = " ";
                    try
                    {
                        rec = pscen.FirstRecord(filter);
                    }
                    catch (GAMSException)
                    {
                        continue;
                    }
                    do
                    {
                        string[] myKeys = new string[p.Dim];
                        for (int i = 0; i < p.Dim; i++)
                            myKeys[i] = rec.Keys[scenSymbol.Dim+i];
                        p.AddRecord(myKeys).Value = rec.Value;
                    } while (rec.MoveNext());
                }

                mi.Solve(GAMSModelInstance.SymbolUpdateType.BaseCase, output, miOpt);
                if (outList.Count == 0)
                    foreach (GAMSSetRecord rec in dict)
                        if ((rec.Keys[1].ToLower() == "level") || (rec.Keys[1].ToLower() == "marginal"))
                            outList.Add(new Tuple<GAMSSymbol, GAMSParameter, string>(mi.SyncDB.GetSymbol(rec.Keys[0]), dict.GAMSDatabase.GetParameter(rec.Keys[2]), rec.Keys[1].ToLower()));

                foreach (Tuple<GAMSSymbol, GAMSParameter, string> tup in outList)
                {
                    string[] myKeys = new string[scenSymbol.Dim + tup.Item1.FirstRecord().Keys.Length];
                    for (int i = 0; i < scenSymbol.Dim; i++)
                        myKeys[i] = s.Keys[i];

                    if ((tup.Item3 == "level") && (tup.Item1 is GAMSVariable))
                        foreach (GAMSVariableRecord rec in tup.Item1)
                        {
                            for (int i = 0; i < rec.Keys.Length; i++)
                                myKeys[scenSymbol.Dim + i] = s.Keys[i];
                            tup.Item2.AddRecord(myKeys).Value = rec.Level;
                        }
                    else if ((tup.Item3 == "level") && (tup.Item1 is GAMSEquation))
                        foreach (GAMSEquationRecord rec in tup.Item1)
                        {
                            for (int i = 0; i < rec.Keys.Length; i++)
                                myKeys[scenSymbol.Dim + i] = s.Keys[i];
                            tup.Item2.AddRecord(myKeys).Value = rec.Level;
                        }
                    else if ((tup.Item3 == "marginal") && (tup.Item1 is GAMSVariable))
                        foreach (GAMSVariableRecord rec in tup.Item1)
                        {
                            for (int i = 0; i < rec.Keys.Length; i++)
                                myKeys[scenSymbol.Dim + i] = s.Keys[i];
                            tup.Item2.AddRecord(myKeys).Value = rec.Marginal;
                        }
                    else if ((tup.Item3 == "marginal") && (tup.Item1 is GAMSEquation))
                        foreach (GAMSEquationRecord rec in tup.Item1)
                        {
                            for (int i = 0; i < rec.Keys.Length; i++)
                                myKeys[scenSymbol.Dim + i] = s.Keys[i];
                            tup.Item2.AddRecord(myKeys).Value = rec.Marginal;
                        }
                }
            }
        }

        static void Main(string[] args)
        {
            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace();
            GAMSCheckpoint cp = ws.AddCheckpoint();

            // initialize a GAMSCheckpoint by running a GAMSJob
            GAMSJob t12 = ws.AddJobFromString(GetModelText());
            t12.Run(cp);

            // create a GAMSModelInstance and solve it multiple times with different scalar bmult
            GAMSModelInstance mi = cp.AddModelInstance();

            double[] bmultlist = new double[] { 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3 };

            GAMSDatabase db = ws.AddDatabase();

            GAMSSet scen = db.AddSet("scen", 1, "");
            GAMSParameter bmult = db.AddParameter("bmultlist", 1, "");
            GAMSParameter zscen = db.AddParameter("zscen", 1, "");

            int i = 0;
            foreach (double b in bmultlist)
            {
                bmult.AddRecord("s" + i).Value = b;
                scen.AddRecord("s" + i++);
            }

            GAMSSet dict = db.AddSet("dict",3,"");
            dict.AddRecord(scen.Name, "scenario", "");
            dict.AddRecord("bmult", "param", bmult.Name);
            dict.AddRecord("z", "level", zscen.Name);


            GUSSCall(dict, mi, "transport us lp min z");

            foreach (GAMSParameterRecord rec in db.GetParameter(zscen.Name))
                Console.WriteLine(rec.Keys[0] + " obj: " + rec.Value);
            
            //*******************

            GAMSModelInstance mi2 = cp.AddModelInstance();
            GAMSDatabase db2 = ws.AddDatabase();

            GAMSSet scen2 = db2.AddSet("scen", 1, "");
            GAMSParameter zscen2 = db2.AddParameter("zscen", 1, "");
            GAMSParameter xup = db2.AddParameter("xup", 3, "");

            for (int j = 0; j < 4; j++)
            {
                foreach (GAMSSetRecord irec in t12.OutDB.GetSet("i"))
                    foreach (GAMSSetRecord jrec in t12.OutDB.GetSet("j"))
                        xup.AddRecord("s" + j, irec.Keys[0], jrec.Keys[0]).Value = j+1;                    
                scen2.AddRecord("s" + j);
            }
            

            GAMSSet dict2 = db2.AddSet("dict", 3, "");
            dict2.AddRecord(scen2.Name, "scenario", "");
            dict2.AddRecord("x", "lower", xup.Name);
            dict2.AddRecord("z", "level", zscen2.Name);

            GUSSCall(dict2, mi2, "transport us lp min z", output: Console.Out);

            foreach (GAMSParameterRecord rec in db2.GetParameter(zscen2.Name))
                Console.WriteLine(rec.Keys[0] + " obj: " + rec.Value);
        }

        static String GetModelText()
        {
            String model = @"
  Sets
       i   canning plants   / seattle, san-diego /
       j   markets          / new-york, chicago, topeka / ;

  Parameters

       a(i)  capacity of plant i in cases
         /    seattle     350
              san-diego   600  /

       b(j)  demand at market j in cases
         /    new-york    325
              chicago     300
              topeka      275  / ;

  Table d(i,j)  distance in thousands of miles
                    new-york       chicago      topeka
      seattle          2.5           1.7          1.8
      san-diego        2.5           1.8          1.4  ;

  Scalar f      freight in dollars per case per thousand miles  /90/ ;
  Scalar bmult  demand multiplier /1/;

  Parameter c(i,j)  transport cost in thousands of dollars per case ;

            c(i,j) = f * d(i,j) / 1000 ;

  Variables
       x(i,j)  shipment quantities in cases
       z       total transportation costs in thousands of dollars ;

  Positive Variable x ;

  Equations
       cost        define objective function
       supply(i)   observe supply limit at plant i
       demand(j)   satisfy demand at market j ;

  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;

  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;

  demand(j) ..   sum(i, x(i,j))  =g=  bmult*b(j) ;

  Model transport /all/ ;
";

            return model;
        }

    }
}
