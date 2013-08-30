*this example illustrates compile time data loading from GDX files

$Title  A Transportation Problem (TRNSPORT,SEQ=1)
$Ontext

This problem finds a least cost shipping schedule that meets
requirements at markets and supplies at factories.


Dantzig, G B, Chapter 3.3. In Linear Programming and Extensions.
Princeton University Press, Princeton, New Jersey, 1963.

This formulation is described in detail in:
Rosenthal, R E, Chapter 2: A GAMS Tutorial. In GAMS: A User's Guide.
The Scientific Press, Redwood City, California, 1988.

The line numbers will not match those in the book because of these
comments.

$Offtext

$gdxin tran2
$LOAD
 
  Sets
       i   canning plants
       j   markets          ;
$load i j
  Parameters
       a(i)  capacity of plant i in cases
       b(j)  demand at market j in cases;
$load a=sup
$loaddc b=dem
  Parameter d(i,j)  distance in thousands of miles;
$load d
  Scalar f  freight in dollars per case per thousand miles   ;
$load f
$gdxin
display i,j,a,b,d,f;

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
$gdxin tran2
$load x
$gdxin
  Solve transport using lp minimizing z ;

  Display x.l, x.m ;

d(i,j)=d(i,j)*10;



$ontext
#user model library stuff
Main topic GDX
Featured item 1  Load
Featured item 2 Compile time
include tran2.gdx
Description
Ilustrates compile time data loading from GDX files
Model is originally from GAMS model library
$offtext

