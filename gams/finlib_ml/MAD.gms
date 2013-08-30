$TITLE Mean absolute deviation model

* MAD.gms: Mean absolute deviation model.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 5.3
* Last modified: Apr 2008.


* Uncomment one of the following lines to include a data file

* $INCLUDE "Corporate.inc"
$INCLUDE "WorldIndices.inc"

SCALARS
        Budget       Nominal investment budget
        MU_TARGET    Target portfolio return
        MU_STEP      Target return step
        MIN_MU       Minimum return in universe
        MAX_MU       Maximum return in universe;

Budget = 100.0;

PARAMETERS
        pr(l)       Scenario probability
        P(i,l)      Final values
        EP(i)       Expected final values;


pr(l) = 1.0 / CARD(l);

P(i,l) = 1 + AssetReturns ( i, l );

EP(i) = SUM(l, pr(l) * P(i,l));

MIN_MU = SMIN(i, EP(i));
MAX_MU = SMAX(i, EP(i));

* Assume we want 20 portfolios in the frontier

MU_STEP = (MAX_MU - MIN_MU) / 20;


DISPLAY MAX_MU;


POSITIVE VARIABLES
        x(i)            Holdings of assets in monetary units (not proportions)
        y(l)            Measures of the absolute deviation;

VARIABLES
        z           Objective function value;

EQUATIONS
        BudgetCon       Equation defining the budget contraint
        ReturnCon       Equation defining the portfolio return constraint
        ObjDef          Objective function definition for MAD
        yPosDef(l)      Equations defining the positive deviations
        yNegDef(l)      Equations defining the negative deviations;

BudgetCon ..     SUM(i, x(i)) =E= Budget;

ReturnCon ..     SUM(i, EP(i) * x(i)) =G= MU_TARGET * Budget;

yPosDef(l) ..    y(l) =G= SUM(i, P(i,l) * x(i)) - SUM(i, EP(i) * x(i));

yNegDef(l) ..    y(l) =G= SUM(i, EP(i) * x(i)) - SUM(i, P(i,l) * x(i));

ObjDef    ..     z =E= SUM(l, pr(l) * y(l));


MODEL MeanAbsoluteDeviation 'PFO Model 5.3.1' /BudgetCon, ReturnCon, yPosDef, yNegDef, ObjDef/;

OPTION SOLVEOPT = REPLACE;

FILE FrontierHandle /"MADvsMV.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "MAD","Mean"/;


FOR (MU_TARGET = MIN_MU TO MAX_MU BY MU_STEP,

        SOLVE MeanAbsoluteDeviation MINIMIZING z USING LP;

        PUT z.l:6:5,(MU_TARGET * Budget):8:3;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;

);


* Compute variances and covariances
* for comparison between Mean Variance and Mean Absolute Deviation

ALIAS (i,i1,i2);

PARAMETERS
        VP(i,i);

VP(i,i) = SUM(l, SQR(P(i,l) - EP(i))) / (CARD(l)- 1);

VP(i1,i2)$(ORD(i1) > ORD(i2)) = SUM(l, (P(i1,l) - EP(i1))*(P(i2,l) - EP(i2))) / (CARD(l) - 1);

DISPLAY VP;

EQUATION
        ObjDefMV        Objective function definition for Mean-Variance;

ObjDefMV ..      z =E= SUM((i1,i2), x(i1)* VP(i1,i2) * x(i2));

MODEL MeanVariance /BudgetCon, ReturnCon, ObjDefMV/;

PUT "SD","Mean"/;

FOR  (MU_TARGET = MIN_MU TO MAX_MU BY MU_STEP,

        SOLVE MeanVariance MINIMIZING z USING NLP;

        z.l = SQRT(z.l);

        PUT z.l:6:5,(MU_TARGET * Budget):8:3;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;

);

SCALARS
        lambdaPos      Weight attached to positive deviations
        lambdaNeg      Weight attached to negative deviations;

lambdaPos = 0.5;
lambdaNeg = 0.5;

EQUATIONS
        yPosWeightDef(l)   Equations defining the positive deviations with weight attached
        yNegWeightDef(l)   Equations defining the positive deviations with weight attached;


yPosWeightDef(l) ..    y(l) =G= lambdaPos * (SUM(i, P(i,l) * x(i)) - SUM(i, EP(i) * x(i)));

yNegWeightDef(l) ..    y(l) =G= lambdaNeg * (SUM(i, EP(i) * x(i)) - SUM(i, P(i,l) * x(i)));


MODEL MeanAbsoluteDeviationWeighted /BudgetCon, ReturnCon, yPosWeightDef, yNegWeightDef, ObjDef/;

PUT "MADWeighted","Mean"/;

FOR  (MU_TARGET = MIN_MU TO MAX_MU BY MU_STEP,

        SOLVE MeanAbsoluteDeviationWeighted MINIMIZING z USING LP;

        PUT z.l:6:5,(MU_TARGET * Budget):8:3;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;

);

lambdaPos = 0.2;
lambdaNeg = 0.8;


PUT "MADWeighted","Mean"/;

FOR  (MU_TARGET = MIN_MU TO MAX_MU BY MU_STEP,

        SOLVE MeanAbsoluteDeviationWeighted MINIMIZING z USING LP;

        PUT z.l:6:5,(MU_TARGET * Budget):8:3;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;

);

* Note that, the last two models will yield the same portfolios! See PFO Section 5.2.2 .