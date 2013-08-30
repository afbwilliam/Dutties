// --------------------------------------------------------------- -*- C# -*-
// File: Cutstock.cs
// --------------------------------------------------------------------------
using System;
using System.IO;
using GAMS;
using System.Collections.Generic;

namespace Cutstock
{
    class Cutstock
    {
        static void Main(string[] args)
        {
            GAMSWorkspace ws;
            if (Environment.GetCommandLineArgs().Length > 1)
                ws = new GAMSWorkspace(systemDirectory: Environment.GetCommandLineArgs()[1]);
            else
                ws = new GAMSWorkspace();
            // instantiate GAMSOptions and define parameters
            GAMSOptions opt = ws.AddOptions();
            GAMSDatabase cutstockData = ws.AddDatabase("csdata"); 
            opt.AllModelTypes = "Cplex";
            opt.OptCR = 0.0; // Solve to optimality
            int maxpattern = 35;
            opt.Defines.Add("pmax", maxpattern.ToString());
            opt.Defines.Add("solveMasterAs", "RMIP");

            // define input data
            Dictionary<string, double> d = new Dictionary<string, double>() { { "i1", 97 }, { "i2", 610 }, { "i3", 395 }, { "i4", 211 } };
            Dictionary<string, double> w = new Dictionary<string, double>() { { "i1", 47 }, { "i2", 36 }, { "i3", 31 }, { "i4", 14 } };
            int r = 100; // raw width

            // cutstockData.AddSet("i", 1, "widths").AddRecords(d.Keys);
            // cutstockData.AddParameter("d", 1, "demand").AddRecords(d);
            // cutstockData.AddParameter("w", 1, "width").AddRecords(w);
            // cutstockData.AddParameter("r", 0, "raw width").AddRecord().Value = r;

            GAMSSet widths = cutstockData.AddSet("i", 1, "widths");
            GAMSParameter rawWidth = cutstockData.AddParameter("r", 0, "raw width");
            GAMSParameter demand = cutstockData.AddParameter("d", 1, "demand");
            GAMSParameter width = cutstockData.AddParameter("w", 1, "width");

            rawWidth.AddRecord().Value = r;
            foreach (string i in d.Keys)
                widths.AddRecord(i);
            foreach (KeyValuePair<string, double> t in d)
                demand.AddRecord(t.Key).Value = t.Value;
            foreach (KeyValuePair<string, double> t in w)
                width.AddRecord(t.Key).Value = t.Value;
            
            // create initial checkpoint
            GAMSCheckpoint masterCP = ws.AddCheckpoint();
            GAMSJob masterInitJob = ws.AddJobFromString(GetMasterModel());
            masterInitJob.Run(opt, masterCP, cutstockData);
            
            GAMSJob masterJob = ws.AddJobFromString("execute_load 'csdata', aip, pp; solve master min z using %solveMasterAs%;", masterCP);

            GAMSSet pattern = cutstockData.AddSet("pp", 1, "pattern index");
            GAMSParameter patternData = cutstockData.AddParameter("aip", 2, "pattern data");

            // Initial pattern: pattern i hold width i
            int patternCount = 0;
            foreach(KeyValuePair<string,double> t in w)
            {
                patternData.AddRecord(t.Key, pattern.AddRecord((++patternCount).ToString()).Keys[0]).Value = (int)(r / t.Value);
            }

            // create model instance for sub job
            GAMSCheckpoint subCP = ws.AddCheckpoint();
            ws.AddJobFromString(GetSubModel()).Run(opt, subCP, cutstockData);
            GAMSModelInstance subMI = subCP.AddModelInstance();
            
            // define modifier demdual
            GAMSParameter demandDual = subMI.SyncDB.AddParameter("demdual", 1, "dual of demand from master");
            subMI.Instantiate("pricing min z using mip", opt, new GAMSModifier(demandDual));

            // find new pattern
            bool patternAdded = true;
            do
            {
                masterJob.Run(opt, masterCP, cutstockData);
                // Copy duals into gmssubMI.SyncDB DB
                demandDual.Clear();
                foreach (GAMSEquationRecord dem in masterJob.OutDB.GetEquation("demand"))
                    demandDual.AddRecord(dem.Keys[0]).Value = dem.Marginal;

                subMI.Solve();
                if (subMI.SyncDB.GetVariable("z").FindRecord().Level < -0.00001)
                {
                    if (patternCount == maxpattern)
                    {
                        Console.Out.WriteLine("Out of pattern. Increase maxpattern (currently {0}).", maxpattern);
                        patternAdded = false;
                    }
                    else
                    {
                        Console.WriteLine("New patter! Value: " + subMI.SyncDB.GetVariable("z").FindRecord().Level);
                        GAMSSetRecord s = pattern.AddRecord((++patternCount).ToString());
                        foreach (GAMSVariableRecord y in subMI.SyncDB.GetVariable("y"))
                        {
                            if (y.Level > 0.5)
                            {
                                patternData.AddRecord(y.Keys[0], s.Keys[0]).Value = Math.Round(y.Level);
                            }
                        }
                    }
                }
                else patternAdded = false;
            } while (patternAdded);

            // solve final MIP
            opt.Defines["solveMasterAs"] = "MIP";
            masterJob.Run(opt, cutstockData);
            Console.WriteLine("Optimal Solution: {0}", masterJob.OutDB.GetVariable("z").FindRecord().Level);
            foreach (GAMSVariableRecord xp in masterJob.OutDB.GetVariable("xp"))
            {
                if (xp.Level > 0.5)
                {
                    Console.Out.Write("  pattern {0} {1} times: ", xp.Keys[0], xp.Level);
                    GAMSParameterRecord aip = masterJob.OutDB.GetParameter("aip").FirstRecord(" ", xp.Keys[0]);
                    do
                    {
                        Console.Out.Write(" {0}: {1}", aip.Keys[0], aip.Value);
                    } while (aip.MoveNext());
                    Console.Out.WriteLine();
                }
            }
            // clean up of unmanaged ressources
            cutstockData.Dispose();
            subMI.Dispose();
            opt.Dispose();
        }

        static String GetMasterModel()
        {
            String model = @"
$Title Cutting Stock - Master problem

Set  i    widths
Parameter
     w(i) width
     d(i) demand
Scalar
     r    raw width;
$gdxin csdata
$load i w d r

$if not set pmax $set pmax 1000
Set  p        possible patterns  /1*%pmax%/
     pp(p)    dynamic subset of p
Parameter
     aip(i,p) number of width i in pattern growing in p;

* Master model
Variable xp(p)     patterns used
         z         objective variable
Integer variable xp; xp.up(p) = sum(i, d(i));

Equation numpat    number of patterns used
         demand(i) meet demand;

numpat..     z =e= sum(pp, xp(pp));
demand(i)..  sum(pp, aip(i,pp)*xp(pp)) =g= d(i);

model master /numpat, demand/;";

            return model;
        }
        static String GetSubModel()
        {
            String submodel = @"
$Title Cutting Stock - Pricing problem is a knapsack model

Set  i    widths
Parameter
     w(i) width;
Scalar
     r    raw width;

$gdxin csdata
$load i w r

Parameter
     demdual(i) duals of master demand constraint /#i eps/;

Variable  z, y(i) new pattern;
Integer variable y; y.up(i) = ceil(r/w(i));

Equation defobj
         knapsack knapsack constraint;

defobj..     z =e= 1 - sum(i, demdual(i)*y(i));
knapsack..   sum(i, w(i)*y(i)) =l= r;
option optcr=0;
model pricing /defobj, knapsack/; pricing.optfile=1";

            return submodel;
        }
    }
}
