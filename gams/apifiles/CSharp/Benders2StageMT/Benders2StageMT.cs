using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Threading.Tasks;
using GAMS;

namespace BendersDecomposition2StageSP
{
    class Benders2StageMT
    {
        private static void ScenSolve(GAMSModelInstance subi, ref double cutconst, ref Dictionary<string, double> cutcoeff, Queue<Tuple<string, double, Dictionary<string, double>>> demQueue, ref double objsub, Object queueMutex, Object ioMutex)
        {
            while (true)
            {
                Tuple<string, double, Dictionary<string, double>> demDict;
                lock (queueMutex)
                {
                    if (0 == demQueue.Count)
                        return;
                    demDict = demQueue.Dequeue();
                }

                subi.SyncDB.GetParameter("demand").Clear();

                foreach (KeyValuePair<string, double> kv in demDict.Item3)
                    subi.SyncDB.GetParameter("demand").AddRecord(kv.Key).Value = kv.Value;

                subi.Solve(GAMSModelInstance.SymbolUpdateType.BaseCase);
                
                lock (ioMutex)
                    Console.WriteLine(" Sub " + subi.ModelStatus + " : obj=" + subi.SyncDB.GetVariable("zsub").FirstRecord().Level);

                double probability = demDict.Item2;
                objsub += probability * subi.SyncDB.GetVariable("zsub").FirstRecord().Level;
                
                foreach (KeyValuePair<string, double> kv in demDict.Item3)
                {
                    cutconst += probability * subi.SyncDB.GetEquation("market").FindRecord(kv.Key).Marginal * kv.Value;
                    cutcoeff[kv.Key] += probability * subi.SyncDB.GetEquation("selling").FindRecord(kv.Key).Marginal;
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
            GAMSJob data = ws.AddJobFromString(GetDataText());
            
            GAMSOptions optData = ws.AddOptions();
            optData.Defines.Add("useBig", "1");
            optData.Defines.Add("nrScen", "100");

            data.Run(optData);

            optData.Dispose();
            GAMSParameter scenarioData = data.OutDB.GetParameter("ScenarioData");

            GAMSOptions opt = ws.AddOptions();
            opt.Defines.Add("datain", data.OutDB.Name);
            int maxiter = 40;
            opt.Defines.Add("maxiter", maxiter.ToString());
            opt.AllModelTypes = "cplexd";

            GAMSCheckpoint cpMaster = ws.AddCheckpoint();
            GAMSCheckpoint cpSub = ws.AddCheckpoint();

            ws.AddJobFromString(GetMasterText()).Run(opt, cpMaster, data.OutDB);
            
            GAMSModelInstance masteri = cpMaster.AddModelInstance();
            GAMSParameter cutconst = masteri.SyncDB.AddParameter("cutconst", 1, "Benders optimality cut constant");
            GAMSParameter cutcoeff = masteri.SyncDB.AddParameter("cutcoeff", 2, "Benders optimality coefficients");
            GAMSVariable theta = masteri.SyncDB.AddVariable("theta", 0, VarType.Free, "Future profit function variable");
            GAMSParameter thetaFix = masteri.SyncDB.AddParameter("thetaFix", 0, "");
            masteri.Instantiate("masterproblem max zmaster using lp", opt, new GAMSModifier(cutconst), new GAMSModifier(cutcoeff), new GAMSModifier(theta, UpdateAction.Fixed, thetaFix));

            ws.AddJobFromString(GetSubText()).Run(opt, cpSub, data.OutDB);

            int numThreads = 2;
            GAMSModelInstance[] subi = new GAMSModelInstance[numThreads];
            Queue<Tuple<string, double, Dictionary<string, double>>> demQueue = new Queue<Tuple<string, double, Dictionary<string, double>>>();

            for (int i = 0; i < numThreads; i++)
            {
                subi[i] = cpSub.AddModelInstance();
                GAMSParameter received = subi[i].SyncDB.AddParameter("received", 1, "units received from first stage solution");
                GAMSParameter demand = subi[i].SyncDB.AddParameter("demand", 1, "stochastic demand");
                
                subi[i].Instantiate("subproblem max zsub using lp", opt, new GAMSModifier(received), new GAMSModifier(demand));
            }
            opt.Dispose();
            
            double lowerbound = double.NegativeInfinity, upperbound = double.PositiveInfinity, objmaster = double.PositiveInfinity;
            int iter = 1;
            do
            {
                Console.WriteLine("Iteration: " + iter);
                // Solve master
                if (1 == iter) // fix theta for first iteration
                    thetaFix.AddRecord().Value = 0;
                else
                    thetaFix.Clear();

                masteri.Solve(GAMSModelInstance.SymbolUpdateType.BaseCase);
                Console.WriteLine(" Master " + masteri.ModelStatus + " : obj=" + masteri.SyncDB.GetVariable("zmaster").FirstRecord().Level);
                if (1 < iter)
                    upperbound = masteri.SyncDB.GetVariable("zmaster").FirstRecord().Level;
                objmaster = masteri.SyncDB.GetVariable("zmaster").FirstRecord().Level - theta.FirstRecord().Level;

                foreach (GAMSSetRecord s in data.OutDB.GetSet("s"))
                {
                    Dictionary<string, double> demDict = new Dictionary<string, double>();
                    foreach (GAMSSetRecord j in data.OutDB.GetSet("j"))
                        demDict[j.Keys[0]] = scenarioData.FindRecord(s.Keys[0], j.Keys[0]).Value;
                    demQueue.Enqueue(new Tuple<string, double, Dictionary<string, double>>(s.Keys[0], scenarioData.FindRecord(s.Keys[0], "prob").Value, demDict));
                }

                for (int i = 0; i < numThreads; i++)
                    subi[i].SyncDB.GetParameter("received").Clear();
                foreach (GAMSVariableRecord r in masteri.SyncDB.GetVariable("received"))
                {
                    cutcoeff.AddRecord(iter.ToString(), r.Keys[0]);
                    for (int i = 0; i < numThreads; i++)
                        subi[i].SyncDB.GetParameter("received").AddRecord(r.Keys).Value = r.Level;
                }

                cutconst.AddRecord(iter.ToString());
                double objsubsum = 0.0;

                // solve multiple model instances in parallel
                Object queueMutex = new Object();
                Object ioMutex = new Object();
                double[] objsub = new double[numThreads];
                Dictionary<string, double>[] coef = new Dictionary<string, double>[numThreads];
                double[] cons = new double[numThreads];

                for (int i = 0; i < numThreads; i++)
                {
                    coef[i] = new Dictionary<string, double>();
                    foreach (GAMSSetRecord j in data.OutDB.GetSet("j"))
                        coef[i].Add(j.Keys[0], 0.0);
                }

                Parallel.For(0, numThreads, delegate(int i) { ScenSolve(subi[i], ref cons[i], ref coef[i], demQueue, ref objsub[i], queueMutex, ioMutex); });

                for (int i = 0; i < numThreads; i++)
                {
                    objsubsum += objsub[i];
                    cutconst.FindRecord(iter.ToString()).Value += cons[i];
                    foreach (GAMSSetRecord j in data.OutDB.GetSet("j"))
                        cutcoeff.FindRecord(iter.ToString(), j.Keys[0]).Value += coef[i][j.Keys[0]];
                }
                lowerbound = Math.Max(lowerbound, objmaster + objsubsum);
                    
                iter++;
                if (iter == maxiter + 1)
                    throw new Exception("Benders out of iterations");

                Console.WriteLine(" lowerbound: " + lowerbound + " upperbound: " + upperbound + " objmaster: " + objmaster);
            } while ((upperbound - lowerbound) >= 0.001 * (1 + Math.Abs(upperbound)));

            masteri.Dispose();
            foreach (GAMSModelInstance inst in subi)
                inst.Dispose();
        }

        static String GetDataText()
        {
            String model = @"
Sets
   i factories                                   /f1*f3/
   j distribution centers                        /d1*d5/

Parameter
   capacity(i) unit capacity at factories
                 /f1 500, f2 450, f3 650/
   demand(j)   unit demand at distribution centers
                 /d1 160, d2 120, d3 270, d4 325, d5 700 /
   prodcost    unit production cost                   /14/
   price       sales price                            /24/
   wastecost   cost of removal of overstocked products /4/

Table transcost(i,j) unit transportation cost
       d1    d2    d3    d4    d5
  f1   2.49  5.21  3.76  4.85  2.07
  f2   1.46  2.54  1.83  1.86  4.76
  f3   3.26  3.08  2.60  3.76  4.45;

$ifthen not set useBig
Set
  s scenarios /lo,mid,hi/

table ScenarioData(s,*) possible outcomes for demand plus probabilities
     d1  d2  d3  d4  d5 prob
lo  150 100 250 300 600 0.25
mid 160 120 270 325 700 0.50
hi  170 135 300 350 800 0.25;
$else
$if not set nrScen $set nrScen 10
Set       s                 scenarios                        /s1*s%nrScen%/;
parameter ScenarioData(s,*) possible outcomes for demand plus probabilities;
option seed=1234;
ScenarioData(s,'prob') = 1/card(s);
ScenarioData(s,j)      = demand(j)*uniform(0.6,1.4);
$endif
";

            return model;
        }

        static String GetMasterText()
        {
            String model = @"
Sets
   i factories
   j distribution centers

Parameter
   capacity(i)    unit capacity at factories
   prodcost       unit production cost
   transcost(i,j) unit transportation cost

$if not set datain $abort 'datain not set'
$gdxin %datain%
$load i j capacity prodcost transcost

* Benders master problem
$if not set maxiter $set maxiter 25
Set
   iter             max Benders iterations /1*%maxiter%/

Parameter
   cutconst(iter)   constants in optimality cuts
   cutcoeff(iter,j) coefficients in optimality cuts

Variables
   ship(i,j)        shipments
   product(i)       production
   received(j)      quantity sent to market
   zmaster          objective variable of master problem
   theta            future profit
Positive Variables ship;

Equations
   masterobj        master objective function
   production(i)    calculate production in each factory
   receive(j)       calculate quantity to be send to markets
   optcut(iter)     Benders optimality cuts;

masterobj..
    zmaster =e=  theta -sum((i,j), transcost(i,j)*ship(i,j))
                       - sum(i,prodcost*product(i));

receive(j)..       received(j) =e= sum(i, ship(i,j));

production(i)..    product(i) =e= sum(j, ship(i,j));
product.up(i) = capacity(i);

optcut(iter)..  theta =l= cutconst(iter) +
                           sum(j, cutcoeff(iter,j)*received(j));

model masterproblem /all/;

* Initialize cut to be non-binding
cutconst(iter) = 1e15;
cutcoeff(iter,j) = eps;
";

            return model;
        }

        static String GetSubText()
        {
            String model = @"
Sets
   i factories
   j distribution centers

Parameter
   demand(j)   unit demand at distribution centers
   price       sales price
   wastecost   cost of removal of overstocked products
   received(j) first stage decision units received

$if not set datain $abort 'datain not set'
$gdxin %datain%
$load i j demand price wastecost

* Benders' subproblem

Variables
   sales(j)         sales (actually sold)
   waste(j)         overstocked products
   zsub             objective variable of sub problem
Positive variables sales, waste

Equations
   subobj           subproblem objective function
   selling(j)       part of received is sold
   market(j)        upperbound on sales
;

subobj..
   zsub =e= sum(j, price*sales(j)) - sum(j, wastecost*waste(j));

selling(j)..  sales(j) + waste(j) =e= received(j);

market(j)..   sales(j) =l= demand(j);

model subproblem /subobj,selling,market/;

* Initialize received
received(j) = demand(j);
";

            return model;
        }

    }
}
