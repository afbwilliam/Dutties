$TITLE Conditional Value at Risk models for corporate bond management

* CorporateCVaR.gms: Conditional Value at Risk models for corporate bond management.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 8.3
* Last modified: May 2008.

$INCLUDE "CorporateCommonInclude.inc"

$INCLUDE "CorporateScenarios.inc"


SCALARS
   Budget        Nominal investment budget
   alpha         Confidence level
   MU_TARGET     Target portfolio return
   MU_STEP       Target return step
   MIN_MU        Minimum return in universe
   MAX_MU        Maximum return in universe;


Budget = 100.0;
alpha  = 0.997;

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


DISPLAY P,EP,MIN_MU,MAX_MU;


POSITIVE VARIABLES
   x(i)            Holdings of assets in monetary units (not proportions)
   VaRDev(l)       Measures of the deviations from the VaR;

VARIABLES
   VaR             Value-at-Risk
   ObjValue        Objective function value
   Losses(l)       Measures of the losses;

EQUATIONS
   BudgetCon        Equation defining the budget contraint
   ReturnCon        Equation defining the portfolio return constraint
   ObjDefCVaR       Objective function definition for CVaR minimization
   LossDef(l)       Equations defining the losses
   VaRDevCon(l)     Equations defining the VaR deviation constraints;

BudgetCon ..         SUM(i, x(i)) =E= Budget;

ReturnCon ..         SUM(i, EP(i) * x(i)) =G= MU_TARGET * Budget;

VaRDevCon(l) ..      VaRDev(l) =G= Losses(l) - VaR;

LossDef(l)..         Losses(l) =E= (Budget - SUM(i, P(i,l) * x(i)));

ObjDefCVaR ..        ObjValue =E= VaR + SUM(l, pr(l) * VaRDev(l)) / (1 - alpha);


MODEL MinCVaR  'PFO Model 5.5.1' /BudgetCon, ReturnCon, LossDef, VaRDevCon, ObjDefCVaR/;

FILE FrontierHandle /"CVaRFrontiers.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Status","VaR","CVaR","Mean";

LOOP(i, PUT i.tl);

PUT /;

FOR (MU_TARGET = MIN_MU TO MAX_MU BY MU_STEP,

        SOLVE MinCVaR MINIMIZING ObjValue USING LP;

        PUT MinCVaR.MODELSTAT:0:0,VaR.l:6:5,ObjValue.l:6:5,(MU_TARGET * Budget):8:3;

        LOOP (i, PUT x.l(i):6:2);

        PUT /;
);