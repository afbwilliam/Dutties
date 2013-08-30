$TITLE Stochastic Dedication model

* StochDedication.gms: Stochastic Dedication model.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 6.2.1
* Last modified: Apr 2008.


SETS
   Time       Time periods       /2001 * 2011/
   Scenarios  Set of scenarios   /SS_1 * SS_9/;

ALIAS (Scenarios, l, ll);

ALIAS (Time, t, t1, t2);

SCALARS
   Now        Current year
   Horizon    End of the Horizon;

Now = 2001;
Horizon = CARD(t)-1;

PARAMETER
   tau(t)     Time in years;

* Note: time starts from 0

tau(t)  = ORD(t)-1;

SET
   Bonds      Bonds universe
   /DS-8-06, DS-8-03, DS-7-07,
    DS-7-04, DS-6-11, DS-6-09,
    DS-6-02, DS-5-05, DS-5-03, DS-4-02/;

SET
   Factors    Term structure factors
   /FF_1, FF_2, FF_3/;

ALIAS(Factors, j);
ALIAS(Bonds, i);


PARAMETERS
   Price(i)       Bond prices
   Coupon(i)      Coupons
   Maturity(i)    Maturities
   Liability(t)   Stream of liabilities
   F(t,i)        Cashflows;

* Bond data. Prices, coupons and maturities from the Danish market

$INCLUDE "BondData.inc"
$INCLUDE "FactorData.inc"

PARAMETER
   beta(j,t) Factor loadings;

* Transpose factor loadings

beta(j,t) = betaTrans(t,j);

* Copy/transform data. Note division by 100 to get unit data, and
* subtraction of "Now" from Maturity date (so consistent with tau):

Price(i)    = BondData(i,"Price")/100;
Coupon(i)   = BondData(i,"Coupon")/100;
Maturity(i) = BondData(i,"Maturity") - Now;

* Calculate the ex-coupon cashflow of Bond i in year t:

F(t,i) = 1$(tau(t) = Maturity(i))
            +  coupon(i) $ (tau(t) <= Maturity(i) AND tau(t) > 0);

PARAMETER
   Liability(t) Liabilities
   /2002 =  80000, 2003 = 100000, 2004 = 110000, 2005 = 120000,
    2006 = 140000, 2007 = 120000, 2008 =  90000, 2009 =  50000,
    2010 =  75000, 2011 = 150000/;

* Read spot rates

PARAMETER r(t)
/
$ONDELIM
$INCLUDE "SpotRates.inc"
$OFFDELIM
/;

* Generate spot rate scenarios, Sr(t,s), using factors from FactorData.inc .

PARAMETER
   Sr(t,l)              Spot rate scenarios;

PARAMETER
   FactorWeights(j,l)   Weights of each factor under each scenario
   /FF_1.SS_1  0.01,  FF_1.SS_2 -0.02, FF_1.SS_3 0.04,
    FF_2.SS_4  0.02,  FF_2.SS_5  0.01, FF_2.SS_6 0.01,
    FF_3.SS_7 -0.01,  FF_3.SS_8 -0.01, FF_3.SS_9 -0.02/;

Sr(t,l)$(r(t) <> 0) = r(t) + SUM(j, FactorWeights(j, l) * beta(j,t));

PARAMETERS
   pr(l)       Scenario probability
   /SS_1 = 10, SS_2 = 5, SS_3 = 11,
    SS_4 = 2,  SS_5 = 7, SS_6 = 9,
    SS_7 = 15, SS_8 = 3, SS_9 = 3/;

* Scale probabilities to one.

pr(l) = pr(l) / SUM(ll, pr(ll));

DISPLAY pr, Sr;

* Calculate the scenario-dependent present values for both
* bonds and liabilities.

PARAMETERS
   P(i)    Implied market price
   PV(i,l) Bonds present value
   PVL(l)  Liabilities present value;

PV(i,l) = SUM(t, F(t,i) * exp(-Sr(t,l) * tau(t)));
PVL(l)  = SUM(t, Liability(t) * exp(-Sr(t,l) * tau(t)));
P(i)    = SUM(l, pr(l) * PV(i,l) );

DISPLAY PV, PVL;

SCALARS
   Budget Initial budget /800000/
   Omega  Bound on the expected shortfalls /1275/;

POSITIVE VARIABLES
   yPos(l)     Positive deviations
   yNeg(l)     Negative deviations
   x(i)        Holdings of assets in monetary units (not proportions);

VARIABLE
   z           Objective function value;

EQUATIONS
   BudgetCon         Equation defining the budget contraint
   ObjDef            Objective function definition
   TargetDevDef(l)   Equations defining the positive and negative deviations
   PutCon            Constraint to bound the expected value of the negative deviations ;

ObjDef ..           z =e= SUM(l, pr(l) * yPos(l));

BudgetCon ..        SUM(i, P(i) * x(i)) =E= Budget;

PutCon ..           SUM(l, pr(l) * yNeg(l)) =L= Omega;

TargetDevDef(l) ..  SUM(i, PV(i,l) * x(i)) =E= PVL(l) + yPos(l) - yNeg(l);

MODEL StochDedication 'PFO Model 6.4.1' /ALL/;

SOLVE StochDedication  MAXIMIZING z USING LP;

DISPLAY x.l;