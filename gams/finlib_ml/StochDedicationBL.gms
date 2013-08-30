$TITLE Stochastic Dedication model with borrowing and lending variables

* StochDedicationBL.gms: Stochastic Dedication model with borrowing and lending variables.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 6.2.2
* Last modified: Apr 2008.


SETS
   Time       Time periods       /2001 * 2011/
   Scenarios  Set of scenarios   /SS_1 * SS_150/;

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

ALIAS(Bonds, i);
ALIAS(Factors, j);

SCALAR
   spread         Borrowing spread over the reinvestment rate;


PARAMETERS
   Price(i)       Implied bond prices
   Coupon(i)      Coupons
   Maturity(i)    Maturities
   Liability(t)   Stream of liabilities
   rf(t)         Reinvestment rates
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

Coupon(i)   = BondData(i,"Coupon")/100;
Maturity(i) = BondData(i,"Maturity") - Now;

* Calculate the ex-coupon cashflow of Bond i in year t:

F(t,i) = 1$(tau(t) = Maturity(i))
            +  coupon(i) $ (tau(t) <= Maturity(i) and tau(t) > 0);

rf(t) = 0.04;
spread = 0.02;


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
   /FF_1.SS_1*SS_50  0.01,  FF_1.SS_51*SS_100 -0.02, FF_1.SS_101*SS_150 0.04,
    FF_2.SS_1*SS_50  0.02,  FF_2.SS_51*SS_100  0.01, FF_2.SS_101*SS_150 0.01,
    FF_3.SS_1*SS_50 -0.01,  FF_3.SS_51*SS_100 -0.01, FF_3.SS_101*SS_150 -0.02/;




PARAMETERS
        pr(l)       Scenario probability;

pr(l) = 1.0 / CARD(l);

* Generate stochastic cashflows and liabilities, over a scenario set.
* For this simple model they are randomly generated, but in a real-life
* model they would depend on e.g., prepayment/lapse models, models for
* options and derivatives, etc. etc.


PARAMETERS
   Srf(t,l)                Scenarios of short term rates
   SF(t,i,l)               Scenarios of cashflows
   SFactorWeights(j, l)    Scenarios of factor weights
   SLiability(t,l)         Scenarios of liabilities;

* Note: The cashflows generated may be negative, modeling complicated derivatives

SF(t,i,l) = F(t,i) * uniform(0.6, 2.0);

SFactorWeights('FF_1', l) =  FactorWeights('FF_1',l) * uniform(0.8, 1.4);

SFactorWeights('FF_2', l) =  FactorWeights('FF_2',l) * uniform(0.9, 1.1);

SFactorWeights('FF_3', l) =  FactorWeights('FF_3',l) * uniform(0.95, 1.05);

SLiability(t,l) = Liability(t) * uniform(0.8, 1.4);

Srf(t,l) = rf(t) * uniform(0.8, 1.2);

Sr(t,l)$(r(t) <> 0) = r(t) + SUM(j, SFactorWeights(j, l) * beta(j,t));

SF('2001',i,l) = SUM(t, SF(t,i,l) * exp (- Sr(t,l) * tau(t)) );

* Implied market price

Price(i) = ( 1.0 / CARD(l) ) * SUM(l, SF('2001',i,l) );

DISPLAY  SF,  SLiability, Srf;

POSITIVE VARIABLES
   x(i)             Face value purchased
   surplus(t,l)     Amount of money reinvested
   borrow(t,l)      Amount of money borrowed;

VARIABLE
        v0                Upfront investment;

EQUATION
        CashFlowCon(t,l)  Equations defining the cashflow balance;


CashFlowCon(t,l) ..  SUM(i, SF(t,i,l) * x(i))                       $ (tau(t) > 0 ) +
                     ( v0 - SUM(i, Price(i) * x(i)) )               $ (tau(t) = 0) +
                     ( (1 + Srf(t-1,l)) * surplus(t-1,l) )          $ (tau(t) > 0) +
                     borrow(t,l)                                    $ (tau(t) < Horizon) =E=
                     surplus(t,l) + SLiability(t,l)                 $ (tau(t) > 0) +
                     (( 1 + Srf(t-1,l) + spread ) * borrow(t-1,l))  $ (tau(t) > 0);

MODEL StochDedicationBL 'PFO Model 6.4.2' /CashFlowCon/;

SOLVE StochDedicationBL MINIMIZING v0 USING LP;

DISPLAY x.l;
