*this example illustrates execution time data loading from GDX files

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

  Sets
       i   canning plants   / seattle, san-diego /
       j   markets          / new-york, chicago, topeka /
       k(j) a subset ;
  Parameters
       a(i)  capacity of plant i in cases
       b(j)  demand at market j in cases;

  Parameter d(i,j)  distance in thousands of miles;
  Scalar f  freight in dollars per case per thousand miles   ;
  Variables
       x(i,j)  shipment quantities in cases
       z       total transportation costs in thousands of dollars ;

  Positive Variable x ;

  Equations
       cost        define objective function
       supply(i)   observe supply limit at plant i
       demand(j)   satisfy demand at market j ;
  execute_load 'tran2',k=j,d,f,a=sup,b=dem,x,supply;
  display k,a,b,d,f;

  Parameter c(i,j)  transport cost in thousands of dollars per case ;
            c(i,j) = f * d(i,j) / 1000 ;
  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;

  supply(i) ..   sum(j, x(i,j))  =l=  a(i) ;

  demand(j) ..   sum(i, x(i,j))  =g=  b(j) ;

  Model transport /all/ ;

  Solve transport using lp minimizing z ;

  Display x.l, x.m ;

d(i,j)=d(i,j)*10;


$ontext
#user model library stuff
Main topic GDX
Featured item 1 Load
Featured item 2 Execute_Load
Featured item 3
Featured item 4
include tran2.gdx
Description
Illustrates execution time data loading into GDX files

$offtext
