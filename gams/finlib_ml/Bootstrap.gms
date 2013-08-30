$TITLE Bootstrapping the yield curve

* Bootstrap.gms:  Bootstrapping the yield curve.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.2.3
* Last modified: Apr 2008.


SET Time Time periods /2001 * 2011/;

ALIAS (Time, t, t1, t2);

SCALARS
   Now Current year;

Now = 2001;

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

PARAMETERS
         Price(i)       Bond prices
         Coupon(i)      Coupons
         Maturity(i)    Maturities
         F(t,i)         Cashflows;

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

VARIABLES
     r(t)            Spot rates
     SumOfSquareDev  Sum of square deviations;

EQUATION
    ObjDef             Objective function definition;

ObjDef..  SumOfSquareDev =e= SUM(i, sqr(Price(i) - SUM(t, F(t,i) * exp(-r(t) * tau(t)))));

OPTION SOLVEOPT = REPLACE;

MODEL BootstrapSimple /ObjDef/;

SOLVE BootstrapSimple MINIMIZING SumOfSquareDev USING NLP;

FILE TermStructureHandle /"TermStructure.csv"/;

TermStructureHandle.pc = 5;

PUT TermStructureHandle;

* Write the heading

PUT "Simple Bootstrap"/;
PUT "Time (in years)","Spot Rates","Discount Factors","Forward Rates"/;

* Calculate and store in a file the results: spot rates and discount factors

PARAMETER
   Forward(t)    One-period forward rates
   Discount(t)   Discount factors;

Forward(t) = r.l(t) $ ( tau(t) = 0 ) + ((tau(t) * r.l(t) - tau(t-1) * r.l(t-1)) / (tau(t) - tau(t-1))) $ (tau(t) > 0 );
Discount(t) = exp(-r.l(t) * tau(t));

LOOP (t$(tau(t) > 0),

     PUT tau(t),r.l(t):6:5,Discount(t):6:5,Forward(t):6:5/;

);


* Also calculate the yield-to-maturity y(i) of each bond.
* This is done by solving a Constrained Nonlinear System, CNS:

POSITIVE VARIABLES
     y(i) Yield-to-Maturity of the bonds;

EQUATION
   YieldDef(i) Equations defining the yield-to-maturity;

YieldDef(i) .. Price(i) =E= SUM(t, F(t,i) * exp(-y(i) * tau(t)));

MODEL FindYTM /YieldDef/;

* Solve as a square system for the yields-to-maturity

SOLVE FindYTM USING CNS;

PARAMETERS
   PriceErrors(i)   Price errors;

PriceErrors(i) = Price(i) - SUM(t, F(t,i) * exp(-r.l(t) * tau(t)));

* Write the heading

PUT "Bond","Yield-To-Maturity","Price error"/;

LOOP (i,

     PUT i.tl,y.l(i):6:5,PriceErrors(i):6:5/;

);

* Model with positive forward constraints

EQUATION
    PosForwardCon(t)   Equations to constraint forward rates to be positive;

PosForwardCon(t)$(tau(t) > 0)..  tau(t) * r(t)  =g= tau(t-1) * r(t-1);

MODEL BootstrapPosForward /ObjDef,PosForwardCon/;

SOLVE BootstrapPosForward MINIMIZING SumOfSquareDev USING NLP;

Forward(t) = r.l(t) $ ( tau(t) = 0 ) + ((tau(t) * r.l(t) - tau(t-1) * r.l(t-1)) / (tau(t) - tau(t-1))) $ (tau(t) > 0 );
Discount(t) = exp(-r.l(t) * tau(t));

PUT "Positive Forwards Bootstrap"/;
PUT "Time (in years)","Spot Rates","Discount Factors","Forward Rates"/;

LOOP (t$(tau(t) > 0),

     PUT tau(t),r.l(t):6:5,Discount(t):6:5,Forward(t):6:5/;

);

* Solve as a square system for the yields-to-maturity

SOLVE FindYTM using CNS;

PriceErrors(i) = Price(i) - SUM(t, F(t,i) * exp(-r.l(t) * tau(t)));

* Write the heading

PUT "Bond","Yield-To-Maturity","Price error"/;

LOOP (i,

     PUT i.tl,y.l(i):6:5,PriceErrors(i):6:5/;

);

SCALARS
   totalError
   lambda;

VARIABLES
   WeightedSumOfSquares

POSITIVE VARIABLES
   ForwardRates(t)  One-period forward rates;

EQUATIONS
   WeightedObjFun
   ForwardDef(t)    Equations defining the forward rates;


WeightedObjFun..  WeightedSumOfSquares =e= lambda * SUM(i, sqr(Price(i) - SUM(t, F(t,i) * exp(-r(t) * tau(t))))) + (1-lambda) *
                                           SUM(t$(tau(t) > 0), sqr( ForwardRates(t) - ForwardRates(t-1)));

* Recall that the first forward rate, F(0,1), coincides with the one period spot rate

ForwardDef(t)..  ForwardRates(t) =E= r(t) $ ( tau(t) = 0 ) +
                                     ((tau(t) * r(t) - tau(t-1) * r(t-1)) / (tau(t) - tau(t-1))) $ (tau(t) > 0 );


MODEL BootstrapSmooth /WeightedObjFun,ForwardDef/;

PUT "Smooth Bootstrap"/;

FOR( lambda = 1.0 DOWNTO 0.0 BY 0.25,

  SOLVE BootstrapSmooth MINIMIZING WeightedSumOfSquares USING NLP;

  PUT "Lambda","Average Error"/;

  totalError = SUM(i, sqr(Price(i) - SUM(t, F(t,i) * exp(-r.l(t) * tau(t)))))

  PUT lambda:3:1,totalError:6:5/

  PUT "Time (in years)","Spot Rates","Discount Factors","Forward Rates"/;

* Calculate and store in a file the results: spot rates and discount factors
  Discount(t) = exp(-r.l(t) * tau(t));

  LOOP (t$(tau(t) > 0),

    PUT tau(t),r.l(t):6:5,Discount(t):6:5,ForwardRates.l(t):6:5/;

  );

);

* Write spot rates to SpotRates.inc and
* yield-to-maturity to YieldRates.inc
* These data will be used by Immunization.gms .

* A smoothing parameter equal to 0.5 guarantees a
* reasonable term structure.



lambda = 0.5

SOLVE BootstrapSmooth MINIMIZING WeightedSumOfSquares USING NLP;

FILE SpotRatesHandle /"SpotRates.inc"/;

PUT SpotRatesHandle;

LOOP (t$(tau(t) > 0),

  PUT t.tl:0:0,",",r.l(t):6:5/;

);

PUTCLOSE SpotRatesHandle;

FILE YieldRatesHandle /"YieldRates.inc"/;

PUT YieldRatesHandle;

LOOP (i,

  PUT i.tl:0:0,",",y.l(i):6:5/;

);


DISPLAY r.l,y.l;