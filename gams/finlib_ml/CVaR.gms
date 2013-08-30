$TITLE Conditional Value at Risk models

* CVaR.gms: Conditional Value at Risk models.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 5.5
* Last modified: Apr 2008.


* Uncomment one of the following lines to include a data file

* $INCLUDE "Corporate.inc"
$INCLUDE "WorldIndices.inc"

SCALARS
        Budget        Nominal investment budget
        alpha         Confidence level
        MU_TARGET     Target portfolio return
        MU_STEP       Target return step
        MIN_MU        Minimum return in universe
        MAX_MU        Maximum return in universe
        RISK_TARGET   Bound on CVaR (risk)
        LossFlag      Flag selecting the type of loss;


Budget = 100.0;
alpha  = 0.99;

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

PARAMETER
        TargetIndex(l)   Target index returns;

* To test the model with a market index, uncomment the following two lines.
* Note that, this index can be used only with WorldIndexes.inc.

*$INCLUDE "Index.inc";

*TargetIndex(l) = Index(l);


POSITIVE VARIABLES
        x(i)            Holdings of assets in monetary units (not proportions)
        VaRDev(l)       Measures of the deviations from the VaR;


VARIABLES
       VaR             Value-at-Risk
        z               Objective function value
      Losses(l)       Measures of the losses;

EQUATIONS
        BudgetCon        Equation defining the budget contraint
        ReturnCon        Equation defining the portfolio return constraint
        CVaRCon          Equation defining the CVaR allowed
        ObjDefCVaR       Objective function definition for CVaR minimization
        ObjDefReturn     Objective function definition for return mazimization
      LossDef(l)       Equations defining the losses
        VaRDevCon(l)     Equations defining the VaR deviation constraints;

BudgetCon ..         SUM(i, x(i)) =E= Budget;

ReturnCon ..         SUM(i, EP(i) * x(i)) =G= MU_TARGET * Budget;

CVaRCon ..           VaR + SUM(l, pr(l) * VaRDev(l)) / (1 - alpha) =L= RISK_TARGET;

VaRDevCon(l) ..      VaRDev(l) =G= Losses(l) - VaR;

LossDef(l)..         Losses(l) =E= (Budget - SUM(i, P(i,l) * x(i)))$(LossFlag = 1) +
                           (TargetIndex(l) * Budget - SUM(i, P(i,l) * x(i)))$(LossFlag = 2) +
                           (SUM(i, EP(i) * x(i)) - SUM(i, P(i,l) * x(i)))$(LossFlag = 3);

ObjDefCVaR ..        z =E= VaR + SUM(l, pr(l) * VaRDev(l)) / (1 - alpha);

ObjDefReturn ..      z =E= SUM(i, EP(i) * x(i));

MODEL MinCVaR  'PFO Model 5.5.1' /BudgetCon, ReturnCon, LossDef, VaRDevCon, ObjDefCVaR/;

MODEL MaxReturn 'PFO Model 5.5.2' /BudgetCon, CVaRCon, LossDef, VaRDevCon, ObjDefReturn/;

FILE FrontierHandle /"CVaRFrontiers.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Status","VaR","CVaR","Mean";

LOOP(i, PUT i.tl);

PUT /;

LossFlag = 2;

* Comment the following line if you want to
* track the market index.

TargetIndex(l) = 1.01;

FOR (MU_TARGET = MIN_MU TO MAX_MU BY MU_STEP,

        SOLVE MinCVaR MINIMIZING z USING LP;

        PUT MinCVaR.MODELSTAT:0:0,VaR.l:6:5,z.l:6:5,(MU_TARGET * Budget):8:3;

        LOOP (i, PUT x.l(i):6:2);

      PUT /;
);