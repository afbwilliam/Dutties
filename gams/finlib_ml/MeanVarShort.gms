$TITLE Mean-variance model allowing short sales

* MeanVarShort.gms:  Mean-variance model allowing short sales.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 3.2.2
* Last modified: Apr 2008.


SET Assets;

ALIAS(Assets,i,j);

PARAMETERS
         RiskFreeRate
         ExpectedReturns(i)  Expected returns
         VarCov(i,j)         Variance-Covariance matrix ;

* Read from Estimate.gdx the data needed to run the mean-variance model

$GDXIN Estimate
$LOAD Assets=subset RiskFreeRate=MeanRiskFreeReturn VarCov ExpectedReturns
$GDXIN


SCALAR
   lambda      Risk attitude;

* Allow short sales:

VARIABLES
   x(i)        Holdings of assets;

* Each individual asset can be sold short up to 20\% .

x.LO(i) = -0.2;

POSITIVE VARIABLES
   Short(i)       Amount shorted;

VARIABLES
   PortVariance   Portfolio variance
   PortReturn     Portfolio return
   z              Objective function value;

EQUATIONS
    ReturnDef     Equation defining the portfolio return
    VarDef        Equation defining the portfolio variance
    NormalCon     Equation defining the normalization contraint
    ShortDef(i)   Equation defining the amount to be shorted
    ShortLimit    Equation defining the total amount to short
    ObjDef        Objective function definition;

ReturnDef ..   PortReturn       =E= SUM(i, ExpectedReturns(i)*x(i));

VarDef    ..   PortVariance     =E= SUM((i,j), x(i)*VarCov(i,j)*x(j));

NormalCon ..   SUM(i, x(i))     =E= 1;

ShortDef(i)..  Short(i)         =G= -x(i);

* Total of up to 50% short sales are allowed.

ShortLimit..   SUM(i, Short(i)) =L= 0.5;

ObjDef    ..   z                =E= (1-lambda) * PortReturn - lambda * PortVariance;


MODEL MeanVarShort /ReturnDef, VarDef,  NormalCon, ShortDef, ShortLimit, ObjDef/;

FILE FrontierHandle /"MeanVarianceShortFrontier.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Lambda","z","Variance","ExpReturn";

LOOP (i, PUT i.tl);

PUT /;


FOR  (lambda = 0 TO 1 BY 0.1,

   SOLVE MeanVarShort MAXIMIZING z USING nlp;

   PUT lambda:6:5, z.l:6:5, PortVariance.l:6:5, PortReturn.l:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
)

PUTCLOSE;

* Output directly to an Excel file through the GDX utility

SET FrontierPoints / PP_0 * PP_10 /

ALIAS (FrontierPoints,p);

PARAMETERS
         RiskWeight(p)           Investor's risk attitude parameter
         MinimumVariance(p)      Optimal level of portfolio variance
         PortfolioReturn(p)      Portfolio return
         OptimalAllocation(p,i)  Optimal asset allocation
         SolverStatus(p,*)       Status of the solver
         SummaryReport(*,*)      Summary report;

* The risk weight, lambda,  has to range in the interval [0,1]

RiskWeight(p) = (ORD(p)-1)/(CARD(p)-1);

DISPLAY RiskWeight;

LOOP(p,
   lambda = RiskWeight(p);
   SOLVE MeanVarShort MAXIMIZING z USING NLP;
   MeanVarShort.SOLPRINT = 2;
   MinimumVariance(p)= PortVariance.l;
   PortfolioReturn(p)  = PortReturn.l;
   OptimalAllocation(p,i)     = x.l(i);
   SolverStatus(p,'solvestat') = MeanVarShort.solvestat;
   SolverStatus(p,'modelstat') = MeanVarShort.modelstat;
   SolverStatus(p,'objective') = MeanVarShort.objval
);

* Store results by rows

SummaryReport(i,p) = OptimalAllocation(p,i);
SummaryReport('Variance',p) = MinimumVariance(p);
SummaryReport('Return',p) = PortfolioReturn(p);
SummaryReport('Lambda',p)   = RiskWeight(p);

DISPLAY SummaryReport,SolverStatus;

* Write SummaryReport into an Excel file

EXECUTE_UNLOAD 'SummaryShort.gdx', SummaryReport;
EXECUTE 'gdxxrw.exe SummaryShort.gdx O=MeanVarianceShortFrontier.xls par=SummaryReport rng=sheet1!a1' ;