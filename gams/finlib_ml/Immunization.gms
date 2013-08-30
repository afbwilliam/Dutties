$TITLE Immunization models

* Immunization.gms: Immunization models.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.4
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
     DS-6-02, DS-5-05, DS-5-03, DS-4-02 /;

ALIAS(Bonds, i);

PARAMETERS
         Coupon(i)      Coupons
         Maturity(i)    Maturities
         Liability(t)   Stream of liabilities
         F(t,i)        Cashflows;

* Bond data. Prices, coupons and maturities from the Danish market

$INCLUDE "BondData.inc"

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
* the bonds.

PARAMETER
         PV(i)      Present value of assets
         Dur(i)     Duration of assets
         Conv(i)    Convexity of assets;

* Present value, Fisher & Weil duration, and convexity for
* the liability.

PARAMETER
         PV_Liab    Present value of liability
         Dur_Liab   Duration of liability
         Conv_Liab  Convexity of liability;


PV(i)   = SUM(t, F(t,i) * exp(-r(t) * tau(t)));

Dur(i)  = ( 1.0 / PV(i) ) * SUM(t, tau(t) * F(t,i) * exp(-r(t) * tau(t)));

Conv(i) = ( 1.0 / PV(i) ) * SUM(t, sqr(tau(t)) * F(t,i) * exp(-r(t) * tau(t)));

DISPLAY PV, Dur, Conv;

* Calculate the corresponding amounts for Liabilities. Use its PV as its "price".

PV_Liab   = SUM(t, Liability(t) * exp(-r(t) * tau(t)));

Dur_Liab  = ( 1.0 / PV_Liab ) * SUM(t, tau(t) * Liability(t) * exp(-r(t) * tau(t)));

Conv_Liab = ( 1.0 / PV_Liab ) * SUM(t, sqr(tau(t)) * Liability(t) * exp(-r(t) * tau(t)));

DISPLAY PV_Liab, Dur_Liab, Conv_Liab;

* Build a sequence of increasingly sophisticated immunuzation models.

POSITIVE VARIABLES
         x(i)                Holdings of bonds (amount of face value);

VARIABLE
         z                   Objective function value;

EQUATIONS
         PresentValueMatch   Equation matching the present value of asset and liability
         DurationMatch       Equation matching the duration of asset and liability
         ConvexityMatch      Equation matching the convexity of asset and liability
         ObjDef              Objective function definition;

ObjDef ..              z =E= SUM(i, Dur(i) * PV(i) * y(i) * x(i)) / (PV_Liab * Dur_Liab);

PresentValueMatch ..         SUM(i, PV(i) * x(i))               =E= PV_Liab;

DurationMatch ..             SUM(i, Dur(i)  * PV(i) * x(i))  =E= PV_Liab * Dur_Liab;

ConvexityMatch ..            SUM(i, Conv(i) * PV(i) * x(i))  =G= PV_Liab * Conv_Liab;

MODEL ImmunizationOne 'PFO Model 4.3.1' /ObjDef, PresentValueMatch, DurationMatch/;

SOLVE ImmunizationOne MAXIMIZING z USING LP;

SCALAR Convexity;

Convexity =  (1.0 / PV_Liab ) * SUM(i, Conv(i) * PV(i) * x.l(i));

DISPLAY x.l,Convexity,Conv_Liab;

MODEL ImmunizationTwo /ObjDef, PresentValueMatch, DurationMatch, ConvexityMatch/;

SOLVE ImmunizationTwo MAXIMIZING z USING LP;

DurationMatch.L = DurationMatch.L / PV_Liab;

ConvexityMatch.L = ConvexityMatch.L / PV_Liab;

DISPLAY x.l,PresentValueMatch.L,DurationMatch.L,ConvexityMatch.L;

EQUATION
         ConvexityObj;

ConvexityObj ..    z =E= ( 1.0 / PV_Liab ) * SUM(i, Conv(i) * PV(i) * x(i));

MODEL ImmunizationThree /ConvexityObj, PresentValueMatch, DurationMatch/

SOLVE ImmunizationThree MINIMIZING z USING LP;

DISPLAY x.l;