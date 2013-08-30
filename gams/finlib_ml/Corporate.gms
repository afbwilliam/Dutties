$TITLE  Corporate bond indexation model

* Corporate.gms: Corporate bond indexation model
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 8.3
* Last modified: May 2008.

$INCLUDE "CorporateCommonInclude.inc"

$INCLUDE "CorporateScenarios.inc"

PARAMETER
   BroadWeights(j) Weights of the broad asset classes
   AssetWeights(i) Weights of each asset in the index;

* Assign weights randomly

AssetWeights(i) = UNIFORM(1,10);

DISPLAY  AssetWeights;

* Normalize the random weights

SCALAR
   WeightsSum;

WeightsSum = SUM(i, AssetWeights(i) );

AssetWeights(i) = AssetWeights(i) / WeightsSum;

BroadWeights('BA_1') =  SUM(m1, AssetWeights(m1) );
BroadWeights('BA_2') =  SUM(m2, AssetWeights(m2) );
BroadWeights('BA_3') =  SUM(m3, AssetWeights(m3) );

PARAMETER
   IndexReturns(l)           Index return scenarios
   BroadAssetReturns(j,l)    Broad asset class return scenarios
   Benchmark(l)              Current benchmark scenario returns;

BroadAssetReturns('BA_1',l) = SUM(m1, AssetWeights(m1) * AssetReturns(m1,l));
BroadAssetReturns('BA_2',l) = SUM(m2, AssetWeights(m2) * AssetReturns(m2,l));
BroadAssetReturns('BA_3',l) = SUM(m3, AssetWeights(m3) * AssetReturns(m3,l));

IndexReturns(l) = SUM(j, BroadWeights(j) * BroadAssetReturns(j,l));

SCALAR
   CurrentWeight    Current weight for tactcal allocation
   EpsTolerance     Tolerance;

PARAMETERS
        pr(l)       Scenario probability;

pr(l) = 1.0 / CARD(l);


POSITIVE VARIABLES
   x(i)            Percentage invested in each security
   z(j)            Percentages invested in each broad asset class;

FREE VARIABLES
   PortRet(l)      Portfolio returns
   ObjValue        Objective function value;


EQUATIONS
   ObjDef                     Objective function for the strategic model (Expected return)
   BroadPortRetDef(l)         Portfolio return definition for broad asset classes
   PortRetDef(l)              Portfolio return definition
   BroadNormalCon             Equation defining the normalization contraint for broad asset classes
   NormalCon                  Equation defining the normalization contraint
   MADCon(l)                  MAD constraints;



ObjDef..                ObjValue =E= SUM(l, pr(l) * PortRet(l));

BroadPortRetDef(l)..    PortRet(l) =E= SUM(j, z(j) * BroadAssetReturns(j,l));

PortRetDef(l)..         PortRet(l) =E= SUM(a, x(a) * AssetReturns(a,l));

MADCon(l)..             PortRet(l) =G= Benchmark(l) - EpsTolerance;

BroadNormalCon..        SUM(j, z(j)) =E= 1.0;

NormalCon..             SUM(a, x(a)) =E= CurrentWeight;


OPTION SOLVEOPT = REPLACE;

MODEL StrategicModel 'PFO Model 11.5.1' /ObjDef,BroadPortRetDef,MADCon,BroadNormalCon/;

MODEL TacticalModel 'PFO Model 11.5.2' /ObjDef,PortRetDef,MADCon,NormalCon/;

* Solve strategic model

Benchmark(l) = IndexReturns(l);

EpsTolerance = 0.02;

SOLVE StrategicModel USING LP MAXIMIZING ObjValue;

DISPLAY "Strategic Asset Allocation";
DISPLAY z.l;

* Solve tactical model for Broad Asset 1 (BA_1)

CurrentWeight = z.l('BA_1');

Benchmark(l) = BroadAssetReturns('BA_1',l);

EpsTolerance = 0.02;

ACTIVE(i) = BroadAssetClassOne(i);

IF( CurrentWeight > 0.05,

   SOLVE TacticalModel USING LP MAXIMIZING ObjValue;

   DISPLAY "Model BA_1"
   DISPLAY a;

   DISPLAY x.l;
);

* Solve tactical model for Broad Asset 2 (BA_2)

CurrentWeight = z.l('BA_2');

ACTIVE(i) = BroadAssetClassTwo(i);

Benchmark(l) = BroadAssetReturns('BA_2',l);

EpsTolerance = 0.03;

IF( CurrentWeight > 0.05,

   SOLVE TacticalModel USING LP MAXIMIZING ObjValue;

   DISPLAY "Model BA_2"
   DISPLAY a;

   DISPLAY x.l;

);

* Solve tactical model for Broad Asset 3 (BA_3)

CurrentWeight = z.l('BA_3');

ACTIVE(i) = BroadAssetClassThree(i);

Benchmark(l) = BroadAssetReturns('BA_3',l);

EpsTolerance = 0.02;

IF( CurrentWeight > 0.05,

   SOLVE TacticalModel USING LP MAXIMIZING ObjValue;


   DISPLAY "Model BA_3"
   DISPLAY a;

   DISPLAY x.l;

);

* Solve integrated model

CurrentWeight = 1.0;

Benchmark(l) = IndexReturns(l);

EpsTolerance = 0.02;

ACTIVE(i) = YES;

SOLVE TacticalModel USING LP MAXIMIZING ObjValue;

DISPLAY "Model Integrated"
DISPLAY a;

DISPLAY x.l;