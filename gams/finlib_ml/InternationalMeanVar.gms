$TITLE International asset allocation model

* InternationalMeanVar.gms:  International asset allocation model.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 3.5
* Last modified: Apr 2008.


* We use real data for the 10-year period 1990-01-01 to 2000-01-01,
*
*       23 Italian Stock indices
*       3 Italian Bond indices (1-3yr, 3-7yr, 5-7yr)
*       Italian risk-free rate (3-month cash)
*
*       7 international Govt. bond indices
*       5 Regions Stock Indices: (EMU, Eur-ex-emu, PACIF, EMER, NORAM)
*       3 risk-free rates (3-mth cash) for EUR, US, JP
*
*       US Corporate Bond Sector Indices (Finance, Energy, Life Ins.)
*
*       Exchange rates, ITL to: (FRF, DEM, ESP, GBP, US, YEN, EUR)
*       Also US to EUR.




SET Assets;

ALIAS(Assets,i,j);

SET
         IT_STOCK(i)   Italian stock indexes
         IT_ALL(i)     Italian stock plus bond indexes
         INT_STOCK(i)  Italian and international stock indexes
         INT_ALL(i)    Italian stock and government indexes, international stock and government indexes, plus corporate indexes

PARAMETERS
         MAX_MU              Maximum level of the expected return
         ExpectedReturns(i)  Expected returns
         VarCov(i,j)         Variance-Covariance matrix
         RiskFree            Risk free return;

$gdxin Estimate
$LOAD Assets IT_STOCK IT_ALL INT_STOCK INT_ALL
$LOAD MAX_MU ExpectedReturns=MU VarCov=Q RiskFree=RiskFreeRt
$gdxin


SET ACTIVE(ASSETS);

alias(ACTIVE, a, a1, a2);

* Target return

SCALAR
  MU_TARGET Target portfolio return
  MU_STEP   Target return step;

* Assume we want 20 portfolios in the frontier

MU_STEP = MAX_MU / 20;

POSITIVE VARIABLES
    x(i) Holdings of assets;

VARIABLES
   PortVariance Portfolio variance;

EQUATIONS
    ReturnCon    Equation defining the portfolio return constraint
    VarDef       Equation defining the portfolio variance
    NormalCon    Equation defining the normalization contraint;

ReturnCon ..   SUM(a, ExpectedReturns(a)*x(a)) =E= MU_TARGET;

VarDef    ..   PortVariance               =E= SUM((a1,a2), x(a1)*VarCov(a1,a2)*x(a2));

NormalCon ..   SUM(a, x(a))               =E= 1;

OPTION SOLVEOPT = REPLACE;

MODEL MeanVar /ReturnCon,VarDef,NormalCon/;

FILE FrontierHandle /"InternationalMeanVarFrontier.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

* Step 1: First solve only for Italian stocks:

ACTIVE(i) = IT_STOCK(i);

PUT "Step 1: Italian stock assets"/;
PUT "Variance","ExpReturn";

* Asset labels

LOOP (i, PUT i.tl);

PUT /;

FOR  (MU_TARGET = 0 TO MAX_MU BY MU_STEP,

   SOLVE MeanVar MINIMIZING PortVariance USING nlp;

   PUT  PortVariance.l:6:5, MU_TARGET:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
);

*
* Step 2: Now solve for Italian stock and government indices:
*

PUT "Step 2: Italian stock and government assets"/;

ACTIVE(i) = IT_ALL(i);

FOR  (MU_TARGET = 0 TO MAX_MU BY MU_STEP,

   SOLVE MeanVar MINIMIZING PortVariance USING nlp;

   PUT PortVariance.l:6:5, MU_TARGET:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
);

*
* Step 3: Italian stock plus international stock indices
*

PUT "Step 3: Italian and international stock indices"/;

ACTIVE(i) = INT_STOCK(i);

FOR  (MU_TARGET = 0 TO MAX_MU BY MU_STEP,

   SOLVE MeanVar MINIMIZING PortVariance USING nlp;

   PUT PortVariance.l:6:5, MU_TARGET:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
);

*
* Step 4: Italian stock and government indices, international stock and government
* indices, plus corporate indices.
*


PUT "Step 4: All indices"/;

ACTIVE(i) = INT_ALL(i);

FOR  (MU_TARGET = 0 TO MAX_MU BY MU_STEP,

   SOLVE MeanVar MINIMIZING PortVariance USING nlp;

   PUT PortVariance.l:6:5, MU_TARGET:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
);



*
* Step 5: All italian stock indices plus  risk free
*

VARIABLES
   z
   d_bar;

EQUATIONS
    RiskFreeReturnDef
    SharpeRatio;


RiskFreeReturnDef ..   d_bar =E= SUM(a, ExpectedReturns(a)*x(a)) - RiskFree;

SharpeRatio ..             z =E= d_bar / sqrt( PortVariance );

MODEL Sharpe /RiskFreeReturnDef,VarDef,NormalCon,SharpeRatio/;

SOLVE Sharpe MAXIMIZING z USING nlp;

* Write the variance and expected return for the tangent portfolio

PUT "Step 5: Tangent portfolio"/;

PUT PortVariance.l:6:5, (d_bar.l + RiskFree):6:5, z.l:6:5;

* Write the tangent portfolio.

LOOP (i, PUT x.l(i):6:5 );

PUT /;

*
* Step 6: Include the total Italian stock index as a liability
*
*
* Build a model (very similar to the previous one)
* which attempts to track (synthesize) the Italian total stock index,
* ITMHIST, using the 23 Italian stock indices and 3 Italian bond indices
* plus the Italian risk-free asset.
*
* This is done by including ITMHIST as an asset but fixing its weight
* in the portfolio at -1. The 26 other assets then must try to balance
* out the variance of ITMHIST. In addition, we pursue different levels
* of expected return (over and above the ITMHIST return).

* Create a convenient subset containing only the general Italian stock index:

SET It_general(ASSETS) / ITMHIST /;

* The only constraint which need to be redefined is the
* normalization constraint. Indeed, it must be se to 0.

EQUATIONS
    NormalConTrack  Equation defining the normalization contraint for tracking;

NormalConTrack ..   SUM(a, x(a))  =E= 0;

OPTION SOLVEOPT = REPLACE;

MODEL MeanVarTrack /ReturnCon,VarDef,NormalConTrack/;

x.FX(It_general) = -1;

PUT "Step 6: Index tracking"/;

ACTIVE(i) = IT_STOCK(i) or It_general(i);


* Re-estimate MU_STEP as MAX_MU is different for the tracking problem

MAX_MU = 0.1587;

MU_STEP = MAX_MU / 20;


FOR  (MU_TARGET = 0 TO MAX_MU BY MU_STEP,

   SOLVE MeanVarTrack MINIMIZING PortVariance USING nlp;

   PUT MeanVarTrack.MODELSTAT:0:0, PortVariance.l:6:5, MU_TARGET:6:5;

   LOOP (i, PUT x.l(i):6:5 );

   PUT /;
);

PUTCLOSE;