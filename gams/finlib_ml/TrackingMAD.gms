$TITLE Tracking models using MAD

* TrackingMAD.gms: Tracking models using MAD.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 5.3.1
* Last modified: Apr 2008.


* Uncomment one of the following lines to include a data file

* $INCLUDE "Corporate.inc"
$INCLUDE "WorldIndices.inc"

SCALARS
        Budget        Nominal investment budget
        EpsTolerance  Tolerance;

Budget = 100.0;

PARAMETERS
        pr(l)       Scenario probability
        P(i,l)      Final values
        EP(i)       Expected final values;


pr(l) = 1.0 / CARD(l);

P(i,l) = 1 + AssetReturns ( i, l );

EP(i) = SUM(l, pr(l) * P(i,l));

POSITIVE VARIABLES
        x(i)        Holdings of assets in monetary units (not proportions);

VARIABLES
        z           Objective function value;

EQUATIONS
        BudgetCon         Equation defining the budget contraint
        ObjDef            Objective function definition for MAD
        ToleranceCon(l)   Equations defining the tolerance allowed;

BudgetCon ..         SUM(i, x(i)) =E= Budget;

ToleranceCon(l) ..   SUM(i, P(i,l) * x(i)) =G= SUM(i, EP(i) * x(i)) - EpsTolerance * Budget;

ObjDef ..            z =E= SUM(i, x(i) * EP(i));


MODEL DownsideBound 'PFO Model 5.3.4' /BudgetCon, ToleranceCon, ObjDef/;

FILE FrontierHandle /"TrackingMAD.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Tolerance","Mean"/;

DownsideBound.MODELSTAT = 1;

* Start from a high tolerance and reduce it until the model is feasible

EpsTolerance = 0.2;

WHILE ( DownsideBound.MODELSTAT <= 2,

        SOLVE DownsideBound MAXIMIZING z USING LP;

        PUT (EpsTolerance * Budget):6:5,z.l:10:3,DownsideBound.MODELSTAT:0:0;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;

       EpsTolerance = EpsTolerance - 0.01;
);

PARAMETER
        TargetIndex(l)   Target index returns;

* To test the model with a market index, uncomment the following line two lines.
* Note that, this index is consistent only when using WorldIndexes.inc.

$INCLUDE "Index.inc"

TargetIndex(l) = Index(l);

EQUATION
        TrackingCon(l)     Tracking contraints;


TrackingCon(l) ..   SUM(i, P(i,l) * x(i)) =G= ( TargetIndex(l) - EpsTolerance ) * Budget;

MODEL  TrackingMAD /BudgetCon, TrackingCon, ObjDef/;

PUT "Tolerance","Mean"/;

TrackingMAD.MODELSTAT = 1;

EpsTolerance = 0.2;

WHILE ( TrackingMAD.MODELSTAT <= 2,

        SOLVE TrackingMAD MAXIMIZING z USING LP;

        PUT (EpsTolerance * Budget):6:5,z.l:10:3,TrackingMAD.MODELSTAT:0:0;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;

        EpsTolerance = EpsTolerance - 0.01;
);

* Fixed target return 2\%, final value is 1.02 under each scenario.

TargetIndex(l) = 1.02;

PUT "Tolerance","Mean"/;

TrackingMAD.MODELSTAT = 1;

EpsTolerance = 0.2;

WHILE ( TrackingMAD.MODELSTAT <= 2,

        SOLVE TrackingMAD MAXIMIZING z USING LP;

        PUT (EpsTolerance * Budget):6:5,z.l:10:3,TrackingMAD.MODELSTAT:0:0;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;

        EpsTolerance = EpsTolerance - 0.01;
);