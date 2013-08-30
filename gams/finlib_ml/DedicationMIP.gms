$TITLE Dedication model with tradeability constraints

* DedicationMIP.gms:  Dedication model with tradeability constraints.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.3.2
* Last modified: Apr 2008.

* First model - Simple dedication.

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


ALIAS(Bonds, i);

SCALAR
         spread         Borrowing spread over the reinvestment rate;

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
        v0              Upfront investment;

EQUATION
        CashFlowCon(t)  Equations defining the cashflow balance;


CashFlowCon(t)..  SUM(i, F(t,i) * x(i) ) +
                 ( v0 - SUM(i, Price(i) * x(i)) )         $(tau(t) = 0) +
                  borrow(t)                               $(tau(t) < Horizon) +
                 ( ( 1 + rf(t-1) ) * surplus(t-1) )       $(tau(t) > 0) =E=
                 surplus(t) + Liability(t)                $(tau(t) > 0) +
                 ( 1 + rf(t-1) + spread ) * borrow(t-1)   $(tau(t) > 0);


OPTION SOLVEOPT = REPLACE;

MODEL Dedication /CashFlowCon/;

SOLVE Dedication minimizing v0 USING LP;

DISPLAY "First Model Results";
DISPLAY v0.l, borrow.l, surplus.l, x.l;

FILE DedicationHandle /"DedicationMIPPortfolios.csv"/;

DedicationHandle.pc = 5;

PUT DedicationHandle;

PUT "No trading constraints"/;

LOOP ( i,

        PUT v0.l:10:3,i.tl,BondData(i,"Maturity"),Coupon(i),(x.l(i)*Price(i)):10:3/;

);

LOOP ( t,

        PUT t.tl,borrow.l(t):10:3,surplus.l(t):10:3/;
);




* Second model - Dedication plus even-lot constraints.

SCALARS
        LotSize      Even-Lot requirement  /1000/
        FixedCost    Fixed cost per trade  /20/
        VarblCost    Variable cost         /0.01/;


INTEGER VARIABLES
        Y(i)         Variable counting the number of lot purchased;

EQUATION
        EvenLot(i)   Equation defining the even-lot requirements;

EvenLot(i)..   x(i) =E= LotSize*Y(i);

* Some reasonable upper bounds on Y(i)

Y.UP(i) = ceil( SUM(t, Liability(t) ) / Price(i) / LotSize );

MODEL DedicationMIPEvenLot /CashFlowCon, EvenLot/;

OPTIONS
        OPTCR = 0
        ITERLIM = 999999
        RESLIM = 100;


SOLVE  DedicationMIPEvenLot MINIMIZING v0 USING MIP;

DISPLAY "Second Model Results";
DISPLAY x.l,Y.l,v0.l;

PUT "Even-lot constraints"/;

LOOP ( i,

        PUT v0.l:10:3,i.tl,BondData(i,"Maturity"),Coupon(i),(x.l(i)*Price(i)):10:3/;

);

LOOP ( t,

        PUT t.tl,borrow.l(t):10:3,surplus.l(t):10:3/;
);



* Third model - Dedication plus fixed and variable transaction costs

VARIABLES
        TotalCost   Total cost to minimize
        TransCosts  Total transaction costs (fixed + variable)

BINARY VARIABLES
        Z(i) Indicator variable for assets included in the portfolio

EQUATIONS
         CostDef       Equation definining the total cost including transaction costs
         TransDef      Equation the transaction costs (fixed + variable)
         UpBounds(i)   Upper bounds for each variable;

CostDef..      TotalCost  =E= v0 + TransCosts;

TransDef..     TransCosts =E= SUM(i, FixedCost * Z(i) + VarblCost * x(i));

UpBounds(i)..  x(i)       =L= x.UP(i) * Z(i);

MODEL DedicationMIPTrnCosts /CashFlowCon, CostDef, TransDef, UpBounds/;

* Some conservative bounds on investments

x.UP(i) = LotSize * Y.UP(i);

SOLVE DedicationMIPTrnCosts MINIMIZING TotalCost USING MIP;

DISPLAY "Third Model Results";
DISPLAY x.l, v0.l,TotalCost.l, TransCosts.l;

PUT "Fixed and variable costs"/;

LOOP ( i,

        PUT v0.l:10:3,i.tl,BondData(i,"Maturity"),Coupon(i),(x.l(i)*Price(i)):10:3/;

);

LOOP ( t,

        PUT t.tl,borrow.l(t):10:3,surplus.l(t):10:3/;
);



* Fourth model - Dedication including even-lot restrictions and
* transaction costs.


MODEL DedicationMIPAll /CashFlowCon, EvenLot, CostDef, TransDef, UpBounds/;

SOLVE DedicationMIPAll MINIMIZING TotalCost USING MIP;

DISPLAY "Fourth Model Results";
DISPLAY x.l, v0.l,TotalCost.l, TransCosts.l;

PUT "Even-lot constraints and transaction costs"/;

LOOP ( i,

        PUT v0.l:10:3,i.tl,BondData(i,"Maturity"),Coupon(i),(x.l(i)*Price(i)):10:3/;

);

LOOP ( t,

        PUT t.tl,borrow.l(t):10:3,surplus.l(t):10:3/;
);