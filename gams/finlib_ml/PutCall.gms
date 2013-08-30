$TITLE Put/Call efficient frontier model

* MAD.gms: Put/Call efficient frontier model.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 5.7
* Last modified: Apr 2008.

$IF NOT set out
$SET out PutCallModel
$CALL rm -f  %out%.gdx
$IF NOT %system.errorlevel% == 0
$ABORT %out%.gdx cannot be removed - close

$INCLUDE "WorldIndices.inc"

OPTION LIMROW=0,LIMCOL=0,SOLVELINK=2;

SCALARS
   Budget       Nominal investment budget
   Omega        Bound on the expected shortfalls;

Budget = 100.0;


PARAMETERS
   pr(l)       Scenario probability
   P(i,l)      Final values
   EP(i)       Expected final values;


pr(l) = 1.0 / CARD(l);

P(i,l) = 1 + AssetReturns ( i, l );

EP(i) = SUM(l, pr(l) * P(i,l));


PARAMETER
   TargetIndex(l)   Target index returns;

* To test the model with a market index, uncomment the following line two lines.
* Note that, this index is consistent only when using WorldIndexes.inc.

$INCLUDE "Index.inc"

TargetIndex(l) = Index(l);

* Primal of the UnConstrained Put/Call model

PARAMETERS
   LowerBounds(i)
   UpperBounds(i);


POSITIVE VARIABLES
   yPos(l)     Positive deviations
   yNeg(l)     Negative deviations;

VARIABLES
   x(i)            Holdings of assets in monetary units (not proportions)
   z               Objective function value;

EQUATIONS
   BudgetCon         Equation defining the budget contraint
   ObjDef            Objective function definition for MAD
   TargetDevDef(l)   Equations defining the positive and negative deviations
   PutCon            Constraint to bound the expected value of the negative deviations ;

BudgetCon ..        SUM(i, x(i)) =E= Budget;

PutCon ..           SUM(l, pr(l) * yNeg(l) ) =L= Omega;

TargetDevDef(l)..   SUM(i, ( P(i,l) - TargetIndex(l) ) * x(i) ) =E= yPos(l) -  yNeg(l);

ObjDef    ..        z =E= SUM(l, pr(l) * yPos(l));


MODEL UnConPutCallModel 'Model PFO 5.7.1' / PutCon, TargetDevDef, ObjDef /;

* Set the average level of downside (risk) allowed

Omega = 0.1;

SOLVE UnConPutCallModel MAXIMIZING z USING LP;

* Dual of the UnConstrained Put/Call model

POSITIVE VARIABLES
   Pi(l)
   PiOmega;

EQUATIONS
   DualObjDef
   DualTrackingDef(i)
   MeasureDef(l);

DualObjDef ..           z =E= Omega * PiOmega;

DualTrackingDef(i)..    SUM(l, (P(i,l) - TargetIndex(l)) * Pi(l)) =E= 0.0;

MeasureDef(l)..         pr(l) * PiOmega - Pi(l) =G= 0;

Pi.LO(l) = pr(l);

MODEL UnConDualPutCallModel 'Model PFO 5.7.2' / DualObjDef, DualTrackingDef, MeasureDef /;

SOLVE UnConDualPutCallModel MINIMIZING z USING LP;

* Display PiOmega.l and Pi.l and check that they are, respectively, equal
* to TargetDevDef.m and PutCon.m
* GAMS provides the dual prices directly, so it is not
* really necessary to build explicitly the dual model.

PARAMETER PrimalDual(l,*) Compare primal and dual soultions;

PrimalDual(l,'pi.l')           = - pi.l(l);
PrimalDual(l,'TargetDevDef.m') = TargetDevDef.m(l);
PrimalDual(l,'Difference') =     TargetDevDef.m(l)+pi.l(l);

DISPLAY z.l,PiOmega.l,PutCon.m,PrimalDual;

* We propose an alternative way to build a frontier using
* the loop statement. Such a structure is suitable for the
* GDX utility (for details, see gdxutility.pdf included in the doc folder )

OPTION SOLPRINT = OFF;

SET
   FrontierPoints /P_1 * P_50/;

* Number of points in the frontier

ALIAS ( FrontierPoints, j );

PARAMETER
   FrontierPortfolios(j,i) Frontier portfolios
   CallValues(j,*)         Call values
   DualPrices(j,*)         Dual prices
   PutCall(j,*)            Put and Call values
   OmegaLevels(j)          Risk levels (Omega);

FILE temp file handel / temp.txt /;

* We assign to each point a risk level Omega

OmegaLevels('P_1') = 0.01;

LOOP (j$(ORD(j) > 1),

    OmegaLevels(j) = OmegaLevels(j-1) + (0.01)$(ORD(j) <= 10) + (0.025)$(ORD(j) > 10)
);

Dualprices(j,'Omega') = OmegaLevels(j);

CallValues(j,'Omega') = OmegaLevels(j);

* Set some liquidity constraints

x.LO(i) = -100.0;
x.UP(i) =  100.0;

LOOP (j,

   Omega = OmegaLevels(j);

   SOLVE UnConPutCallModel MAXIMIZING z USING LP;

   FrontierPortfolios(j,i) = x.L(i);

   CallValues(j,'Mild Constraint') = z.L;

   Dualprices(j,'Mild Constraint') = PutCon.M

);

EXECUTE_UNLOAD "%out%.gdx";

EXECUTE 'gdxxrw %out%.gdx o=%out%.xls par=FrontierPortfolios rng=MildPortfolios!a1 Rdim=1';

IF(errorlevel,
   PUT_UTILITY temp 'log' / '' /
                    'log' / 'Cannot write to %out%.xls' /
                    'log' / 'Close this file - will sleep for 15 seconds' /
                    'log' / 'and then try again.' /
                    'log' / '';
   DISPLAY$sleep(15) 'expected %out%.xls file to be closed';
   EXECUTE 'gdxxrw %out%.gdx o=%out%.xls par=FrontierPortfolios rng=MildPortfolios!a1 Rdim=1';
   ABORT$errorlevel 'Failed the second time' );

* Set tight liquidity constraints

x.LO(i) = -20.0;
x.UP(i) =  20.0;

LOOP (j,

   Omega = OmegaLevels(j);

   SOLVE UnConPutCallModel MAXIMIZING z USING LP;

   FrontierPortfolios(j,i) = x.L(i);

   CallValues(j,'Tight Constraint') = z.L;

   Dualprices(j,'Tight Constraint') = PutCon.M

);

EXECUTE_UNLOAD "%out%.gdx";
PUTCLOSE temp
$ONPUT
Trace=2
par=dualprices  rng=DualPrices!a1  Rdim=1
par=CallValues  rng=CallValues!a1  Rdim=1
par=FrontierPortfolios rng=TightPortfolios!a1 Rdim=1
$OFFPUT

EXECUTE 'gdxxrw %out%.gdx o=%out%.xls @temp.txt';

* Determine the liquidity and discount premium
* for one put/call efficient portfolio.

SCALAR
   Df;

PARAMETER
   Price(i)
   Discount(i)
   Premium(i)
   BenchMarkNeutralPrice(i)
   Psi(l);


Omega = 0.475;

SOLVE UnConPutCallModel MAXIMIZING z USING LP;

Discount(i) = 0.0;

Premium(i) = 0.0;

Df = SUM(l, -TargetDevDef.M(l) );

Psi(l) = -TargetDevDef.M(l) / Df;

BenchMarkNeutralPrice(i) = SUM(l, Psi(l) * P(i,l)) / SUM(l, Psi(l) * TargetIndex(l));

Discount(i)$(x.M(i) > 0) =  x.M(i) / SUM(l, (-TargetDevDef.M(l)) * TargetIndex(l));

Premium(i)$(x.M(i) < 0) =  (-x.M(i)) / SUM(l, (-TargetDevDef.M(l)) * TargetIndex(l));

Price(i) = BenchMarkNeutralPrice(i) +  Premium(i)  -  Discount(i);

PARAMETER liquidity(i,*) Liquidity report;

liquidity(i,'Premium')  = Premium(i);

liquidity(i,'Discount') = Discount(i);

EXECUTE_UNLOAD "%out%.gdx";

EXECUTE 'gdxxrw %out%.gdx o=%out%.xls trace=2 par=Liquidity rng=Liquidity!a1 Rdim=1';

DISPLAY   Df,Psi,BenchMarkNeutralPrice,Discount,Premium,Price;

* Put/call model with balance constraint

MODEL PutCallModel 'Model PFO 5.7.3' / BudgetCon, PutCon, TargetDevDef, ObjDef /;

LOOP (j,
   Omega = OmegaLevels(j);
   SOLVE PutCallModel MAXIMIZING z USING LP;
   FrontierPortfolios(j,i) = x.L(i);
   putcall(j,'Put side') = PutCon.L;
   putcall(j,'Call side')= z.L );

EXECUTE_UNLOAD "%out%.gdx";

PUTCLOSE temp 'par=putcall rng=Frontiers!a1 Rdim=1'/
              'par=FrontierPortfolios rng=Portfolios!a1 Rdim=1';

EXECUTE 'gdxxrw %out%.gdx o=%out%.xls @temp.txt';