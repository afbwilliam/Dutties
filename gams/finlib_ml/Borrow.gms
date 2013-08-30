$TITLE Mean-Variance model with borrowing constraints

* Borrow.gms:  Mean-Variance model with borrowing constraints.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 3.3.1
* Last modified: Apr 2008.

SET Assets;

ALIAS(Assets,i,j);

PARAMETERS
         RiskFreeRate
         ExpectedReturns(i) Expected returns
         VarCov(i,j)        Variance-Covariance matrix ;

$gdxin estimate
$LOAD Assets=subset RiskFreeRate=MeanRiskFreeReturn VarCov ExpectedReturns
$gdxin

* Risk attitude: 0 is risk-neutral, 1 is very risk-averse.;

SCALAR
     BorrowRate_1   Borrowing rate
     BorrowRate_2   Higher borrowing rate
     lambda         Risk attitude;

BorrowRate_1 = RiskFreeRate;
BorrowRate_2 = RiskFreeRate + 0.005;

POSITIVE VARIABLES
    borrow_1  Amount borrowed at the borrowing rate
    borrow_2  Amount borrowed at the higher borrowing rate
    x(i)      Holdings of assets;

borrow_1.UP = 2.0;


VARIABLES
    PortVariance  Portfolio variance
    PortReturn    Portfolio return
    z             Objective function value;

EQUATIONS
    ReturnDef    Equation defining the portfolio excess return
    VarDef       Equation defining the portfolio excess variance
    NormalCon    Equation defining the normalization contraint
    ObjDef       Objective function definition;


ReturnDef ..   PortReturn   =E= SUM(i, ExpectedReturns(i) * x(i)) - (borrow_1 * BorrowRate_1) - (borrow_2 * BorrowRate_2);

VarDef    ..   PortVariance =E= SUM((i,j), x(i) * VarCov(i,j)*x(j));

NormalCon ..   SUM(i, x(i)) =E= 1 + borrow_1 + borrow_2;

ObjDef    ..   z            =E= (1-lambda) * PortReturn - lambda * PortVariance;


MODEL Borrow /ReturnDef, VarDef, NormalCon, ObjDef/;

FILE FrontierHandle /"BorrowFrontier.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Model Status","Lambda","Borrow_1","Borrow_2","z","Variance","ExpReturn";

LOOP (i, PUT i.tl);

PUT /;


FOR  (lambda = 0 TO 0.5 BY 0.01,

   SOLVE Borrow MAXIMIZING z USING nlp;

   PUT Borrow.modelstat:0:0,lambda:6:5, borrow_1.l:6:5, borrow_2.l:6:5, z.l:6:5, PortVariance.l:6:5, PortReturn.l:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
)

PUTCLOSE;