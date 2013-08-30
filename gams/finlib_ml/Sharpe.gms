$TITLE Sharpe model

* Sharpe.gms: Sharpe model.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 3.3
* Last modified: Apr 2008.


SET Assets;

ALIAS(Assets,i,j);

PARAMETERS
         RiskFreeRate
         ExExpectedReturns(i)  Excess Expected returns
         ExVarCov(i,j)         Variance-Covariance matrix of the excess returns;

$GDXIN Estimate
$LOAD Assets=subset RiskFreeRate=MeanRiskFreeReturn ExVarCov=ExcessCov
$LOAD ExExpectedReturns=MeanExcessRet
$GDXIN


POSITIVE VARIABLES
    x(i)           Holdings of assets;

VARIABLES
   PortVariance    Portfolio variance
   d_bar           Portfolio expected excess return
   z               Objective function value;

EQUATIONS
    ReturnDef    Equation defining the portfolio excess return
    VarDef       Equation defining the portfolio excess variance
    NormalCon    Equation defining the normalization contraint
    ObjDef       Objective function definition;


ReturnDef ..   d_bar        =E= SUM(i, ExExpectedReturns(i) * x(i));

VarDef    ..   PortVariance =E= SUM((i,j), x(i) * ExVarCov(i,j) * x(j));

NormalCon ..   SUM(i, x(i)) =E= 1;

ObjDef    ..   z            =E= d_bar / SQRT( PortVariance );

* Put strictly positive bound on Variance to keep the model out of trouble:

PortVariance.LO = 0.001;

MODEL Sharpe  /ReturnDef, VarDef, NormalCon, ObjDef/;

SOLVE Sharpe MAXIMIZING z USING nlp;

* Use the optimal sharpe ratio to build an efficient frontier.
* In this case the frontier is described by a line
* whose slope is the sharpe ratio, and the intercept equal to the benchmark return.
* The scalar "theta" determines the
* amount invested in the tangency portfolio. When theta is less than
* 1, part of the capital is invested at the benchmark rate. When theta is greater
* than 1, the investor is borrowing at the benchmark rate and invest the
* proceeds in the tangency portfolio. (We are assuming that the benchmark
* is the risk free, therefore  its variance is zero.

SCALARS
   theta                 Fraction of the wealth invested in the market portfolio
   CurrentPortVariance   Variance of the current portfolio
   CurrentPortReturn     Return of the current portfolio;

FILE SharpeHandle /"SharpeFrontier.csv"/;

SharpeHandle.pc = 5;

PUT  SharpeHandle;

PUT "Standard Deviations","Expected Return","Theta"/;

FOR ( CurrentPortVariance = 0 TO 1 BY 0.1,

     theta = SQRT ( CurrentPortVariance / PortVariance.L );
     CurrentPortReturn = RiskFreeRate + theta * d_bar.L;
     PUT  SQRT(CurrentPortVariance):6:5, CurrentPortReturn:6:5, theta:6:5/;
);

* Also plot the tangent portfolio

theta = 1;

PUT SQRT(PortVariance.L):6:5,(RiskFreeRate + theta * d_bar.L):6:5,theta:6:5/;

PUTCLOSE;