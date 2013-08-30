$TITLE Utility models

* Utility.gms: Utility models.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 5.6
* Last modified: Apr 2008.


* Uncomment one of the following lines to include a data file

* $INCLUDE "Corporate.inc"
$INCLUDE "WorldIndices.inc"


SCALARS
   CeROE         Certainty equivalent ROE
   Equity        Equity avaiable for investment
   gamma         Risk aversion parameter (the lower, the most risk averse);


Equity = 100.0;

PARAMETERS
   pr(l)       Scenario probability
   P(i,l)      Final values
   EP(i)       Expected final values;

pr(l) = 1.0 / CARD(l);

P(i,l) = 1 + AssetReturns ( i, l );

EP(i) = SUM(l, pr(l) * P(i,l));

POSITIVE VARIABLES
   x(i)        Holdings of assets in monetary units (not proportions)
   ROE(l)      Return on Equity ;

* Since ROE will be exponentiated, and ROE**gamma is computed
* as EXP(gamma * ln(ROE)), the default lower bound is too small
* and some solvers could report an EXEC Error. To avoid that,
* we set the lower bound this new value.

ROE.LO(l) = 0.1;


VARIABLES
   z           Objective function value;

EQUATIONS
   EquityCon         Equation defining the equity contraint
   ROEDef(l)         Equations defining the ROEs
   ObjDef            Objective function definition for Expected Utility;

EquityCon ..         SUM(i, x(i)) =E= Equity;

ROEDef(l)..          ROE(l) =E= SUM(i, P(i,l) * x(i)) / Equity;

ObjDef ..            z =E= SUM(l, pr(l) * (
                                  (1.0/gamma * ROE(l)**gamma) $(gamma <> 0) +
                                   log(ROE(l))                $(gamma = 0)
                                 )
                               );

* Start from a feasible solution for LOG utility function

MODEL ExpectedUtility 'PFO Model 5.6.1' /EquityCon, ROEDef, ObjDef/;

FILE FrontierHandle /"ExpectedUtility.csv"/;

FrontierHandle.pc = 5;
FrontierHandle.pw = 1048;

PUT FrontierHandle;

PUT "Gamma","CeROE"/;

FOR ( gamma = -10 TO 1 BY 0.5,

      SOLVE ExpectedUtility MAXIMIZING z USING NLP;

      CeROE = ((gamma * z.L)**(1.0/gamma))$(gamma <> 0) + (exp(z.L))$(gamma = 0);

      PUT gamma:6:2,(CeROE-1):8:6;

      LOOP (i, PUT x.L(i):6:2);

      PUT /;
);
