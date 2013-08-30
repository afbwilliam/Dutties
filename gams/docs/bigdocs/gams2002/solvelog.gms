*Illustrate solver execution error taking log of zero

variables x,z   ;
equations r1,r2;
r1.. z=e=log(x);
r2.. x=l=10;
x.lo=-0.0001;
x.l=5;
model badexp /all/
solve badexp using nlp minimizing z;

$ontext
#user model library stuff
Main topic Execution errors
Featured item 1 Solver
Featured item 2 Logarithm problems
Featured item 3
Featured item 4
Description
Illustrate solver execution error taking log of zero
$offtext
