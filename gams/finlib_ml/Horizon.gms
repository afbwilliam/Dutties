$TITLE  Portfolio horizon returns model

* Horizon.gms:  Portfolio horizon returns model.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.3.1
* Last modified: Apr 2008.


SET Time Time periods /2001 * 2011/;

ALIAS (Time, t, t1, t2);

SCALARS
   Now      Current year
   Horizon  End of the Horizon;

Now = 2001;
Horizon = CARD(t)-1;

PARAMETER tau(t) Time in years;

* Note: time starts from 0

tau(t)  = ORD(t)-1;

SET Bonds Bonds universe
    /DS-8-06, DS-8-03, DS-7-07,
     DS-7-04, DS-6-11, DS-6-09,
     DS-6-02, DS-5-05, DS-5-03, DS-4-02
/;


ALIAS(Bonds, i);

SCALAR
         spread         Borrowing spread over the reinvestment rate
         Budget         Initial budget;

PARAMETERS
         Price(i)       Bond prices
         Coupon(i)      Coupons
         Maturity(i)    Maturities
         Liability(t)   Stream of liabilities
         rf(t)         Reinvestment rates
         F(t,i)        Cashflows;

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
spread = 0.02;

* Initial available budget to buy the matching portfolio

Budget = 803021.814;
* 803021.814
*850000
PARAMETER
         Liability(t) Liabilities
         /2002 =  80000, 2003 = 100000, 2004 = 110000, 2005 = 120000,
          2006 = 140000, 2007 = 120000, 2008 =  90000, 2009 =  50000,
          2010 =  75000, 2011 = 150000/;

POSITIVE VARIABLES
        x(i)           Face value purchased
        surplus(t)     Amount of money reinvested
        borrow(t)      Amount of money borrowed;


VARIABLE
        HorizonRet     Horizon Return;

EQUATION
        CashFlowCon(t) Equations defining the cashflow balance;

CashFlowCon(t)..  SUM(i, F(t,i) * x(i)) +
                 ( Budget - SUM(i, Price(i) * x(i)) )    $ (tau(t) = 0) +
                 borrow(t)                               $ (tau(t) < Horizon) +
                 ( 1 + rf(t-1) ) * surplus(t-1)          $ (tau(t) > 0) =E=
                 Liability(t)                            $ (tau(t) > 0) +
                 surplus(t)                              $ (tau(t) < Horizon) +
                 HorizonRet                              $ (tau(t) = Horizon) +
                 ( 1 + rf(t-1) + spread ) * borrow(t-1)  $ (tau(t) > 0);

MODEL HorizonMod 'PFO Model 4.2.4' /CashFlowCon/;

SOLVE HorizonMod MAXIMIZING HorizonRet USING LP;

DISPLAY HorizonRet.l, borrow.l, surplus.l, x.l;

* Simulation for different values of the initial budget

FILE HorizonHandle /"HorizonPortfolios.csv"/;

HorizonHandle.pc = 5;

PUT HorizonHandle;

FOR ( Budget = 778985.948 TO 818985.948 BY 10000,

   SOLVE HorizonMod MAXIMIZING HorizonRet USING LP;

   LOOP ( i,

        PUT Budget,HorizonRet.l:10:3,i.tl,BondData(i,"Maturity"),Coupon(i),(x.l(i)*Price(i)):10:3/;

   );

   LOOP ( t,

        surplus.l(t) = HorizonRet.l$(ORD(t) eq CARD(t));
        PUT t.tl,borrow.l(t):10:3,surplus.l(t):10:3/;

   );

);