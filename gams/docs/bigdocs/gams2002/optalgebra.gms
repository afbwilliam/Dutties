*Illustrates use of sets by making algebraic version of model optimize.gms

SET     j               /Corn,Wheat,Cotton/
        i               /Land ,Labor/;
PARAMETER
  c(j)      / corn     109    ,wheat   90 ,cotton    115/
  b(i)     /land 100 ,labor 500/;
TABLE a(i,j)
              corn    wheat  cotton
  land          1       1       1
  labor         6       4       8      ;
POSITIVE VARIABLES   x(j);
VARIABLES            PROFIT             ;
EQUATIONS            OBJective          ,  constraint(i) ;
 OBJective.. PROFIT=E=   SUM(J,(c(J))*x(J)) ;
 constraint(i).. SUM(J,a(i,J) *x(J))  =L= b(i);
MODEL RESALLOC /ALL/;
SOLVE RESALLOC USING LP MAXIMIZING PROFIT;

$ontext
#user model library stuff
Main topic  Basic GAMS
Featured item 1 Set
Featured item 2 Algebraic modeling
Featured item 3
Featured item 4
include optimize.gms
Description
Illustrates use of sets by making algebraic version of model optimize.gms
$offtext
