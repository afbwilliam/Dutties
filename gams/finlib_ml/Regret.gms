$TITLE Regret models

* Regret.gms: Regret models.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 5.4
* Last modified: Apr 2008.




* Uncomment one of the following lines to include a data file

*$INCLUDE "Corporate.inc"
$INCLUDE "WorldIndices.inc"

SCALARS
        Budget        Nominal investment budget
        EpsRegret     Tolerance allowed for epsilon regret models
        MU_TARGET     Target portfolio return
        MU_STEP       Target return step
        MIN_MU        Minimum return in universe
        MAX_MU        Maximum return in universe
        RISK_TARGET   Bound on expected regret (risk);


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

PARAMETER
        TargetIndex(l)   Target index returns;

* To test the model with a market index, uncomment the following two lines.
* Note that, this index can be used only with WorldIndexes.inc.

*$INCLUDE "Index.inc";

*TargetIndex(l) = Index(l);

POSITIVE VARIABLES
        x(i)            Holdings of assets in monetary units (not proportions)
        Regrets(l)      Measures of the negative deviations or regrets;

VARIABLES
        z               Objective function value;

EQUATIONS
        BudgetCon        Equation defining the budget contraint
        ReturnCon        Equation defining the portfolio return constraint
        ExpRegretCon     Equation defining the expected regret allowed
        ObjDefRegret     Objective function definition for regret minimization
        ObjDefReturn     Objective function definition for return mazimization
        RegretCon(l)     Equations defining the regret constraints
        EpsRegretCon(l)  Equations defining the regret constraints with tolerance threshold;

BudgetCon ..         SUM(i, x(i)) =E= Budget;

ReturnCon ..         SUM(i, EP(i) * x(i)) =G= MU_TARGET * Budget;

ExpRegretCon ..      SUM(l, pr(l) * Regrets(l)) =L= RISK_TARGET;

RegretCon(l) ..      Regrets(l) =G= TargetIndex(l) * Budget - SUM(i, P(i,l) * x(i));

EpsRegretCon(l) ..   Regrets(l) =G= (TargetIndex(l) - EpsRegret) * Budget - SUM(i, P(i,l) * x(i));

ObjDefRegret ..      z =E= SUM(l, pr(l) * Regrets(l));

ObjDefReturn ..      z =E= SUM(i, EP(i) * x(i));

MODEL MinRegret 'PFO Model 5.4.1' /BudgetCon, ReturnCon, RegretCon, ObjDefRegret/;
MODEL MaxReturn /BudgetCon, ExpRegretCon, EpsRegretCon, ObjDefReturn/;

FILE FrontierHandle /"RegretFrontiers.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Status","Regret","Mean";
LOOP (i, PUT i.tl);
PUT "","Status","Regret","Mean"/;

* Comment the following line if you want to
* track the market index.

TargetIndex(l) = 1.01;
EpsRegret = 0.0;

* The two models are equivalent. Indeed, they yield the
* same efficient frontier.

FOR (MU_TARGET = MIN_MU TO MAX_MU BY MU_STEP,

        SOLVE MinRegret MINIMIZING z USING LP;

        PUT MinRegret.MODELSTAT:0:0,z.L:6:5,(MU_TARGET * Budget):8:3;

        LOOP (i, PUT x.L(i):6:2);

        RISK_TARGET = z.L;

        PUT "";

        SOLVE MaxReturn MAXIMIZING z USING LP;

        PUT MaxReturn.MODELSTAT:0:0,RISK_TARGET:6:5,z.L:8:3;

        LOOP (i, PUT x.L(i):6:2);

        PUT /;
);