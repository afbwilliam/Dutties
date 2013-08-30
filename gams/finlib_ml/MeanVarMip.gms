$TITLE Mean-variance model with diversification constraints

* MeanVarMip.gms:  Mean-variance model with diversification constraints.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 3.4
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

* Risk attitude: 0 is risk-neutral, 1 is very risk-averse.;

SCALAR
     StockMax  Maximum number of stocks /3/
     lambda    Risk attitude;

VARIABLES
    x(i)       Holdings of assets;

PARAMETER
    xlow(i)    lower bound for active variables ;

* In case short sales are allowed these bounds must be set properly.
xlow(i) = 0.0;
x.UP(i) = 1.0;

BINARY VARIABLE
    Y(i)          Indicator variable for assets included in the portfolio;


VARIABLES
   PortVariance   Portfolio variance
   PortReturn     Portfolio return
   z              Objective function value;

EQUATIONS
    ReturnDef     Equation defining the portfolio return
    VarDef        Equation defining the portfolio variance
    NormalCon     Equation defining the normalization contraint
    LimitCon      Constraint defining the maximum number of assets allowed
    UpBounds(i)   Upper bounds for each variable
    LoBounds(i)   Lower bounds for each variable
    ObjDef        Objective function definition;


ReturnDef ..   PortReturn    =E= SUM(i, ExpectedReturns(i)*x(i));

VarDef    ..   PortVariance  =E= SUM((i,j), x(i)*VarCov(i,j)*x(j));

LimitCon  ..   SUM(i, Y(i))  =L= StockMax;

UpBounds(i)..          x(i)  =L= x.UP(i)* Y(i);

LoBounds(i)..          x(i)  =G= xlow(i)* Y(i);

NormalCon ..   SUM(i, x(i))  =E= 1;

ObjDef    ..   z             =E= (1-lambda) * PortReturn - lambda * PortVariance;

MODEL MeanVarMip /ReturnDef, VarDef, LimitCon, UpBounds, LoBounds, NormalCon, ObjDef/;

OPTION  MINLP = SBB, optcr = 0;

FILE FrontierHandle /"MeanVarianceMIP.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Lambda","z","Variance","ExpReturn";

LOOP (i, PUT i.tl);

PUT /;

FOR  (lambda = 0 TO 1 BY 0.1,

   SOLVE MeanVarMip MAXIMIZING z USING MINLP;

   PUT lambda:6:5, z.l:6:5, PortVariance.l:6:5, PortReturn.l:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
)

PUTCLOSE;

***** Transaction Cost *****
* In this section the MeanVar.gms model is modified by imposing transaction
* costs. We consider a more realistic setting with fixed and proportional costs.

SCALARS
  FlatCost Flat transaction cost / 0.001 /
  PropCost Proportional transaction cost / 0.005 /;

POSITIVE VARIABLES
    x_0(i) Holdings for the flat cost regime
    x_1(i) Holdings for the linear cost regime;

* Amount at which is possible to make transactions at the flat fee.

x_0.UP(i) = 0.1;

EQUATIONS
    HoldingCon(i)        Constraint defining the holdings
    ReturnDefWithCost    Equation defining the portfolio return with cost
    FlatCostBounds(i)    Upper bounds for flat transaction fee
    LinCostBounds(i)     Upper bonds for linear transaction fee;

HoldingCon(i)..           x(i) =e= x_0(i) + x_1(i);

ReturnDefWithCost..       PortReturn =e= SUM(i, ( ExpectedReturns(i)*x_0(i) - FlatCost*Y(i) ) ) +
                          SUM(i, (ExpectedReturns(i) - PropCost)*x_1(i));

FlatCostBounds(i)..       x_0(i) =l= x_0.UP(i) * Y(i);

LinCostBounds(i)..        x_1(i) =l= Y(i);

MODEL MeanVarWithCost /ReturnDefWithCost, VarDef,HoldingCon, NormalCon, FlatCostBounds, LinCostBounds, ObjDef/;

OPTION  MINLP = SBB, optcr = 0;

FILE FrontierHandleTwo /"MeanVarianceWithCost.csv"/;

FrontierHandleTwo.pc = 5;
FrontierHandleTwo.pw = 1048;

PUT FrontierHandleTwo;

PUT "Lambda","z","Variance","ExpReturn";

LOOP (i, PUT i.tl);
LOOP (i, PUT i.tl);

PUT /;

FOR  (lambda = 0 TO 1 BY 0.1,

   SOLVE MeanVarWithCost MAXIMIZING z USING MINLP;

   PUT lambda:6:5, z.l:6:5, PortVariance.l:6:5, PortReturn.l:6:5;

   LOOP (i, PUT x_0.l(i):6:5 );
   LOOP (i, PUT x_1.l(i):6:5 );

   PUT /;
)

PUTCLOSE;

***** Portfolio Revision *****
* In this section the MeanVar.gms model is modified by imposing zero-or-range
* variable to cope with portfolio revision.

SET Bound /Lower, Upper/;

PARAMETER
   BuyLimits(Bound,i)
   SellLimits(Bound,i)
   InitHold(i)          Current holdings;

* We set the curret holding to the optimal unconstrained mean-variance portfolio
* with lambda = 0.5

InitHold('Cash_EU') = 0.3686;
InitHold('YRS_1_3') = 0.3597;
InitHold('EMU') = 0.0;
InitHold('EU_EX')= 0.0;
InitHold('PACIFIC')= 0.0;
InitHold('EMERGT') = 0.0591;
InitHold('NOR_AM') = 0.2126;
InitHold('ITMHIST') = 0.0;


BuyLimits('Lower',i) = InitHold(i) * 0.9;
BuyLimits('Upper',i) = InitHold(i) * 1.10;

SellLimits('Lower',i) = InitHold(i) * 0.75;
SellLimits('Upper',i) = InitHold(i) * 1.25;

POSITIVE VARIABLES
    buy(i)   Amount to be purchased
    sell(i)  Amount to be sold;

BINARY VARIABLE
    Yb(i) Indicator variable for assets to be purchased
    Ys(i) Indicator variable for assets to be sold;

EQUATIONS
    BuyTurnover
    LoBuyLimits(i)
    UpBuyLimits(i)
    UpSellLimits(i)
    LoSellLimits(i)
    BinBuyLimits(i)
    BinSellLimits(i)
    InventoryCon(i)      Inventory constraints;


InventoryCon(i)..    x(i) - buy(i) + sell(i) =e=  InitHold(i);

UpBuyLimits(i)..     InitHold(i) + buy(i)     =l=  BuyLimits('Upper',i);

LoBuyLimits(i)..     InitHold(i) + buy(i)     =g=  BuyLimits('Lower',i);

UpSellLimits(i)..    InitHold(i) - sell(i)    =l=  SellLimits('Upper',i);

LoSellLimits(i)..    InitHold(i) - sell(i)    =g=  SellLimits('Lower',i);

BinBuyLimits(i)..    buy(i)                  =l=  Yb(i);

BinSellLimits(i)..   sell(i)                 =l=  Ys(i);

BuyTurnover..        SUM(i, buy(i) )         =l=  0.05;

MODEL MeanVarRevision /NormalCon, HoldingCon, InventoryCon, ReturnDef,
                       UpBuyLimits, LoBuyLimits, UpSellLimits, LoSellLimits,
                       BinBuyLimits, BinSellLimits, BuyTurnover,
                       VarDef, ObjDef/;

OPTION  MINLP = SBB, optcr = 0;

FILE FrontierHandleThree /"MeanVarianceRevision.csv"/;

FrontierHandleThree.pc = 5;
FrontierHandleThree.pw = 1048;

PUT FrontierHandleThree;

PUT "Model status","Lambda","z","Variance","ExpReturn";

LOOP (i, PUT i.tl);
LOOP (i, PUT i.tl);
LOOP (i, PUT i.tl);

PUT /;

FOR  (lambda = 0 TO 1 BY 0.1,

   SOLVE MeanVarRevision MAXIMIZING z USING MINLP;

   PUT MeanVarRevision.modelstat:0:0,lambda:6:5, z.l:6:5, PortVariance.l:6:5, PortReturn.l:6:5;

   LOOP (i, PUT x.l(i):6:5 );
   LOOP (i, PUT buy.l(i):6:5 );
   LOOP (i, PUT sell.l(i):6:5 );

   PUT /;
)

PUTCLOSE;
