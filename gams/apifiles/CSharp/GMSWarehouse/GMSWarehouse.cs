using System;
using System.IO;
using GAMS;

namespace Warehouse
{
    class Warehouse
    {
        private static void SolveWarehouse(GAMSWorkspace gmsWS, int NumberOfWarehouses, GAMSDatabase result, Object dbMutex)
        {
            // instantiate GAMSOptions and define some scalars
            GAMSOptions gmsOpt = gmsWS.AddOptions();
            gmsOpt.AllModelTypes = "Gurobi";
            gmsOpt.Defines.Add("Warehouse", NumberOfWarehouses.ToString());
            gmsOpt.Defines.Add("Store", "65");
            gmsOpt.Defines.Add("fixed", "22");
            gmsOpt.Defines.Add("disaggregate", "0");
            gmsOpt.OptCR = 0.0; // Solve to optimality

            // create a GAMSJob from string and write results to the result database
            GAMSJob gmsJ = gmsWS.AddJobFromString(GetModelText());
            gmsJ.Run(gmsOpt);

            // need to lock database write operations
            lock (dbMutex)
                result.GetParameter("objrep").AddRecord(NumberOfWarehouses.ToString()).Value = gmsJ.OutDB.GetVariable("obj").FindRecord().Level;

            foreach (GAMSVariableRecord supplyRec in gmsJ.OutDB.GetVariable("supply"))
                if (supplyRec.Level > 0.5)
                    lock(dbMutex)
                        result.GetSet("supplyMap").AddRecord(NumberOfWarehouses.ToString(), supplyRec.Keys[0], supplyRec.Keys[1]);
            
        }

        static void Main(string[] args)
        {
            GAMSWorkspace gmsWS;
            if (Environment.GetCommandLineArgs().Length > 1)
                gmsWS = new GAMSWorkspace(systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                gmsWS = new GAMSWorkspace();

            // create a GAMSDatabase for the results
            GAMSDatabase resultDB = gmsWS.AddDatabase();
            resultDB.AddParameter("objrep",1,"Objective value");
            resultDB.AddSet("supplyMap",3,"Supply connection with level");

            int status = 1;
            try
            {
                // run multiple parallel jobs
                Object dbLock = new Object();
                System.Threading.Tasks.Parallel.For(10, 22, delegate(int i) { SolveWarehouse(gmsWS, i, resultDB, dbLock); });
                // export the result database to a GDX file
                resultDB.Export("\\tmp\\result.gdx");
                status = 0;
            }
            catch (GAMSException ex)
            {
                Console.WriteLine("GAMSException occured: " + ex.Message);
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                resultDB.Dispose();
            }

            Environment.ExitCode = status;
        }

        static String GetModelText()
        {
            String model = @"
$title Warehouse.gms

$eolcom //
$SetDDList warehouse store fixed disaggregate // acceptable defines
$if not set warehouse    $set warehouse   10
$if not set store        $set store       50
$if not set fixed        $set fixed       20
$if not set disaggregate $set disaggregate 1 // indicator for tighter bigM constraint
$ife %store%<=%warehouse% $abort Increase number of stores (>%warehouse)

Sets Warehouse  /w1*w%warehouse% /
     Store      /s1*s%store%     /
Alias (Warehouse,w), (Store,s);
Scalar
     fixed        fixed cost for opening a warehouse / %fixed% /
Parameter
     capacity(WareHouse)
     supplyCost(Store,Warehouse);

$eval storeDIVwarehouse trunc(card(store)/card(warehouse))
capacity(w)     =   %storeDIVwarehouse% + mod(ord(w),%storeDIVwarehouse%);
supplyCost(s,w) = 1+mod(ord(s)+10*ord(w), 100);

Variables
    open(Warehouse)
    supply(Store,Warehouse)
    obj;
Binary variables open, supply;

Equations
    defobj
    oneWarehouse(s)
    defopen(w);

defobj..  obj =e= sum(w, fixed*open(w)) + sum((w,s), supplyCost(s,w)*supply(s,w));

oneWarehouse(s).. sum(w, supply(s,w)) =e= 1;

defopen(w)..      sum(s, supply(s,w)) =l= open(w)*capacity(w);

$ifthen %disaggregate%==1
Equations
     defopen2(s,w);
defopen2(s,w).. supply(s,w) =l= open(w);
$endif

model distrib /all/;
solve distrib min obj using mip;
abort$(distrib.solvestat<>%SolveStat.NormalCompletion% or
       distrib.modelstat<>%ModelStat.Optimal% and
       distrib.modelstat<>%ModelStat.IntegerSolution%) 'No solution!';";

            return model;
        }
    }
}
