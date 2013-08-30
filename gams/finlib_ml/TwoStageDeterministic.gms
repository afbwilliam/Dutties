$TITLE Deterministic Two-stage program

* TwoStageDetermistic.gms: Deterministic Two-stage program.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 6.3.1
* Last modified: Apr 2008.



SET Assets Available assets
   /Stock, Put_1, Call_1, Put_2, Call_2/;

SET Assets_1(Assets) Assets available up to the end of the first period
   /Stock, Put_1, Call_1/;

SET Assets_2(Assets) Assets available up to the end of the second period
   /Stock, Put_2, Call_2/;

ALIAS (Assets, i );
ALIAS (Assets_1, j);
ALIAS (Assets_2, k);

PARAMETER P_1(j) Asset prices at the beginning of the first time period
   /Stock = 43,
    Put_1  = 0.81,
    Call_1 = 4.76/;

PARAMETER P_2(i) Asset prices (values) at the beginning of the second time period
   /Stock  = 44,
    Put_1  = 4,
    Call_1 = 0,
    Put_2  = 0.92,
    Call_2 = 4.43/;

PARAMETER F(k) Asset prices (values) at the end of the second time period
   /Stock  = 48,
    Put_2  = 8,
    Call_2 = 0/;

POSITIVE VARIABLES
   x(j)     First-stage (or first-period) holdings
   y(k)     Second-stage (or second-period) holdings;

VARIABLE
   z        Objective function value;

EQUATIONS
   BudgetCon         Equation defining the budget contraint
   ObjDef            Objective function definition
   MinReturnCon      Equation defining the minimum return contraint
   RebalanceCon      Equation defining the rebalance contraint;

ObjDef ..         z =E= SUM(k, F(k) * y(k));

BudgetCon ..      SUM(j, P_1(j) * x(j))   =L= 10000;

MinReturnCon ..   SUM(k, F(k) * y(k))     =G= 11500;

RebalanceCon ..   SUM(j, P_2(j) * x(j))   =G= SUM(k, P_2(k) * y(k));

MODEL DeterministicTwoStage /ALL/;

SOLVE DeterministicTwoStage MAXIMIZING z USING LP;

DISPLAY x.l,z.l;