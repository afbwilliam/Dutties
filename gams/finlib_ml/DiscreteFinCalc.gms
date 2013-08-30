$TITLE Financial Calculator for discrete time discounting

* DiscreteFinCalc.gms: Financial Calculator for discrete time discounting
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.2.2
* Last modified: Apr 2008.


* To demonstrate the formulas we set up an artificial yield curve
* over a 30-year horizon; time points indicated by tau(t) start at 0

* To demonstrate the formulas we set up an artificial yield curve
* over a 30-year horizon; time points indicated by tau(t) start at 0

SET time /1 * 30/;

ALIAS (time,t,t1,t2);

PARAMETER
   tau(t) Time Tau;

* Time points are annual

tau(t) = ORD(t) - 1;

* A toy yield curve:

PARAMETER
   r(t) Spot rates;

* Linear, increasing from 3% to 6%

r(t) = tau(t)/30*0.03 + 0.03;

* Discount factors and forward rate calculations:

PARAMETERS
  Discount(t)          Discount factors
  ForwRate(t1, t2)     Forward rates;


Discount(t) = (1 + r(t)) ** (-tau(t));

ForwRate(t1,t2) $ (tau(t1) < tau(t2)) =
       (Discount(t1) / Discount(t2)) ** (1/(tau(t2) - tau(t1))) - 1;

DISPLAY r, Discount, ForwRate;

* Now construct an artificial liability stream, and calculate its present value

PARAMETER
   L(t) Artificial liability stream;

L(t) = 1000 + normal(0, 1000);

* Present value of liabilities

PARAMETER
   PV Present value;

PV = SUM(t, L(t) * (1 + r(t)) ** (-tau(t)));

DISPLAY PV;

* Alternative, using the Discount parameter.
* Of course, we must obtain the same value

PV = SUM(t, L(t) * Discount(t));

DISPLAY PV;