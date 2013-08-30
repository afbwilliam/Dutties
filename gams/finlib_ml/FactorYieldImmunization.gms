$TITLE Factor immunization models, maximizing the non-linear portfolio yield

* FactorYieldImmunization.gms: Factor immunization models, maximizing the non-linear portfolio yield
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.5.1
* Last modified: Apr 2008.

* Note that this program should be called with a restart.
* First line below checks whether the program is called
* with a restart whereas the second line checks with an equation
* identifier from the expected restart file whether the right
* file is supplied.

$if '%gams.r%' == '' $abort Restart is missing
$if not declared PresentValueMatch $abort Wrong restart file

* Alternatively, the program can be run without a restart
* by commenting the two lines above and decommenting the
* line below.
*$include FactorImmunization

VARIABLE
         PortfolioYield           Portfolio Yield;

EQUATIONS
         YieldDef                 Equation defining the portfolio yield;

YieldDef .. SUM((i,t), x(i) * F(t,i) * EXP( -PortfolioYield * tau(t)) ) =E= SUM(i, PV(i) * x(i));

PortfolioYield.UP = 0.20; PortfolioYield.LO = 0.01;

* No convexity model

MODEL FactorYieldImmunizationOne /PresentValueMatch, DurationMatch, YieldDef/;

SOLVE FactorYieldImmunizationOne MAXIMIZING PortfolioYield USING NLP;

DISPLAY   PortfolioYield.L,x.L;

MODEL FactorYieldImmunizationTwo /PresentValueMatch, DurationMatch, ConvexityMatch, YieldDef/;

SOLVE FactorYieldImmunizationTwo MAXIMIZING PortfolioYield USING NLP;

DISPLAY   PortfolioYield.L,x.L;
