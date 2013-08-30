*illustrate execution errors during model generation

sets elems /s1*s25/
parameter data1(elems)   data to be exponentiated
          datadiv(elems) divisors
          datamult(elems)     x limits;
data1(elems)=1;
data1("s20")=-1;
datadiv(elems)=1;
datadiv("s21")=0;
datamult(elems)=1;
datamult("s22")=0;
positive variables x(elems) variables
variables  obj;
equations  objr        objective with bad exponentiation
           xlim(elems) constraints with bad divisor
;
objr.. obj=e=sum(elems,data1(elems)**2.1*x(elems));
xlim(elems).. datamult(elems)/datadiv(elems)*x(elems)=e=1;
model executerr /all/
option limrow=30; option limcol=30;
solve executerr using lp maximizing obj;

$ontext
#user model library stuff
Main topic Execution errors
Featured item 1 Errors
Featured item 2 Numerical problems
Featured item 3
Featured item 4
Description
illustrate execution errors during model generation
$offtext
