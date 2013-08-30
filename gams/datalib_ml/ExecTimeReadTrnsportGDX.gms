$Title  A Transportation Problem (TRNSPORT,SEQ=1)
$Ontext

This program is a modified version of trnsport.gms and
illustrates use of reading data from a GDX file during
execution time

$Offtext


  Sets
       i   canning plants
       j   markets;

$gdxin Trnsport.gdx
$load i j

  Parameters
       a(i)  capacity of plant i in cases
       b(j)  demand at market j in cases
       d(i,j) distance in thousands of miles ;

  Scalar f  freight in dollars per case per thousand miles;

  execute_load 'Trnsport.gdx' a,b,d,f;

  Parameter c(i,j)  transport cost in thousands of dollars per case ;

            c(i,j) = f * d(i,j) / 1000 ;

  Variables
       x(i,j)  shipment quantities in cases
       z       total transportation costs in thousands of dollars ;

  Positive Variable x ;

  Equations
       cost        define objective function
       supply(i)   observe supply limit at plant i
       demand(j)   satisfy demand at market j ;

  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;

  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;

  demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;

  Model transport /all/ ;

  Solve transport using lp minimizing z ;

  Display x.l, x.m ;

