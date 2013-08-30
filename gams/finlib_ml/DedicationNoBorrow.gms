$TITLE Dedication model without borrowing

* Dedication.gms:  Dedication model without borrowing.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 2.4
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

SET Bonds Bonds universe
    /DS-8-06, DS-8-03, DS-7-07,
     DS-7-04, DS-6-11, DS-6-09,
     DS-6-02, DS-5-05, DS-5-03, DS-4-02
/;


ALIAS(Bonds, i);

PARAMETERS
         Price(i)       Bond prices
         Coupon(i)      Coupons
         Maturity(i)    Maturities
         Liability(t)   Stream of liabilities
         rf(t)         Reinvestment rates
         F(t, i)        Cashflows;

* Bond data. Prices, coupons and maturities from the Danish market

$INCLUDE "BondData.inc"

* Copy/transform data. Note division by 100 to get unit data, and
* subtraction of "Now" from Maturity date (so consistent with tau):

Price(i)    = BondData(i,"Price")/100;
Coupon(i)   = BondData(i,"Coupon")/100;
Maturity(i) = BondData(i,"Maturity") - Now;

* Calculate the ex-coupon cashflow of Bond i in year t:

F(t,i) = 1$(tau(t) = Maturity(i))
            +  coupon(i) $ (tau(t) <= Maturity(i) AND tau(t) > 0);

* For simplicity, we set the short term rate to be 0.03 in each period

rf(t) = 0.04;

PARAMETER
         Liability(t) Liabilities
         /2002 =  80000, 2003 = 100000, 2004 = 110000, 2005 = 120000,
          2006 = 140000, 2007 = 120000, 2008 =  90000, 2009 =  50000,
          2010 =  75000, 2011 = 150000/;

OPTION Liability:0;

DISPLAY BondData,F,Liability;

POSITIVE VARIABLES
        x(i)           Face value purchased
        surplus(t)     Amount of money reinvested;

VARIABLE
        v0             Upfront investment;

EQUATION
        CashFlowCon(t) Equations defining the cashflow balance;


CashFlowCon(t)..  SUM(i, F(t,i) * x(i) ) +
                  (v0 - SUM(i, Price(i) * x(i)))       $(tau(t) = 0) +
                  (( 1 + rf(t-1) ) * surplus(t-1))     $(tau(t) > 0) =E=
                   surplus(t) + Liability(t)           $(tau(t) > 0);

MODEL Dedication 'PFO Model 4.2.3' /CashFlowCon/;

SOLVE Dedication MINIMIZING v0 USING LP;

DISPLAY v0.L,x.L,surplus.L,x.M,CashFlowCon.M;