$TITLE Factor immunization models

* FactorImmunization.gms: Factor immunization models
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.5
* Last modified: Apr 2008.

SET Time Time periods /2001 * 2011/;

ALIAS (Time, t, t1, t2);

SCALARS
   Now      Current year
   Horizon  End of the Horizon;

Now = 2001;
Horizon = CARD(t)-1;

PARAMETER
        tau(t) Time in years;

* Note: time starts from 0

tau(t)  = ORD(t)-1;

SET
         Bonds Bonds universe
         /DS-8-06, DS-8-03, DS-7-07,
          DS-7-04, DS-6-11, DS-6-09,
          DS-6-02, DS-5-05, DS-5-03, DS-4-02/;

SET Factors Term structure factors
    /FF_1, FF_2, FF_3/;

ALIAS(Factors, j);
ALIAS(Bonds, i);

PARAMETERS
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

Coupon(i)   = BondData(i,"Coupon")/100;
Maturity(i) = BondData(i,"Maturity") - Now;

* Calculate the ex-coupon cashflow of Bond i in year t:

F(t,i) = 1$(tau(t) = Maturity(i))
            +  coupon(i) $ (tau(t) <= Maturity(i) and tau(t) > 0);

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

* Read yield rates

PARAMETER y(i)
/
$ONDELIM
$INCLUDE "YieldRates.inc"
$OFFDELIM
/;

* The following are the Present value, Fischer-Weil duration (D^FW)
* and Convexity (Q_i), for both the bonds and the liabilities:

* Present value, Fisher & Weil duration, and convexity for
* the bonds and their factor versions.

PARAMETER
         PV(i)             Present value of assets
         Dur(i)            Duration of assets
         Conv(i)           Convexity of assets
         FactorDur(i,j)    Factor duration of assets
         FactorConv(i,j)   Factor convexity of assets;

* Present value, Fisher & Weil duration, and convexity for
* the liability and their factor versions.

PARAMETER
         PV_Liab             Present value of liability
         Dur_Liab            Duration of liability
         Conv_Liab           Convexity of liability
         FactorDur_Liab(j)   Factor duration of liability
         FactorConv_Liab(j)  Factor convexity of liability;

* Calculate PV, Dur, and Conv for the assets ...

PV(i)   = SUM(t, F(t,i) * EXP(-r(t) * tau(t)));

Dur(i)  = ( 1.0 / PV(i) ) * SUM(t, tau(t) * F(t,i) * EXP(-r(t) * tau(t)));

Conv(i) = ( 1.0 / PV(i) ) * SUM(t, SQR(tau(t)) * F(t,i) * EXP(-r(t) * tau(t)));

DISPLAY PV, Dur, Conv;

PV_Liab   = SUM(t, Liability(t) * EXP(-r(t) * tau(t)));

Dur_Liab  = ( 1.0 / PV_Liab ) * SUM(t, tau(t) * Liability(t) * EXP(-r(t) * tau(t)));

Conv_Liab = ( 1.0 / PV_Liab ) * SUM(t, SQR(tau(t)) * Liability(t) * EXP(-r(t) * tau(t)));

DISPLAY PV_Liab, Dur_Liab, Conv_Liab;

* Calculate FactorDur and  FactorConv for the assets ...

FactorDur(i,j) = ( 1.0 / PV(i) ) * SUM(t, tau(t) * F(t,i) * beta(j, t) * EXP(-r(t) * tau(t)));

FactorConv(i,j) = ( 1.0 / PV(i) ) * SUM(t, SQR(tau(t)) * F(t,i) * beta(j, t) * EXP(-r(t) * tau(t)));

DISPLAY FactorDur, FactorConv;

* ... and for the liabilities.

FactorDur_Liab(j)  = ( 1.0 / PV_Liab ) * SUM(t, tau(t) * Liability(t) * beta(j,t) * EXP(-r(t) * tau(t)));

FactorConv_Liab(j) = ( 1.0 / PV_Liab ) * SUM(t, SQR(tau(t)) * Liability(t) * beta(j,t) * EXP(-r(t) * tau(t)));

DISPLAY FactorDur_Liab, FactorConv_Liab;

* Build two factor immunization models, without and with convexity constraints

POSITIVE VARIABLES
         x(i)                Holdings of bonds (amount of face value);

VARIABLE
         z                   Objective function value;

EQUATIONS
         PresentValueMatch   Equation matching the present value of asset and liability
         DurationMatch(j)    Equation matching the factor duration of asset and liability
         ConvexityMatch(j)   Equation matching the factor convexity of asset and liability
         ObjDef              Objective function definition;

ObjDef ..           z =E= SUM(i, PV(i) * Dur(i) * y(i) * x(i)) / (PV_Liab * Dur_Liab);

PresentValueMatch ..      SUM(i, PV(i) * x(i)) =E= PV_Liab;

DurationMatch(j) ..       SUM(i, FactorDur(i,j) * PV(i) * x(i)) =E= PV_Liab * FactorDur_Liab(j);

ConvexityMatch(j) ..      SUM(i, FactorConv(i,j) * PV(i) * x(i)) =G= PV_Liab * FactorConv_Liab(j);

* No convexity model

MODEL FactorImmunizationOne 'PFO Model 4.4.1' /PresentValueMatch, DurationMatch, ObjDef/;

SOLVE FactorImmunizationOne MAXIMIZING z USING LP;

DISPLAY x.l;

MODEL FactorImmunizationTwo /PresentValueMatch, DurationMatch, ConvexityMatch, ObjDef/;

SOLVE FactorImmunizationTwo MAXIMIZING z USING LP;

DISPLAY x.l;