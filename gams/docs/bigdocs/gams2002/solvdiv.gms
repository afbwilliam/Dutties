*Illustrate solver execution error when dividing by zero

variables x,z   ;
equations r1;
r1.. z=e=-1/x;

x.l=5;
x.lo=0.000;
option nlp=conopt;
*option nlp=minos;

model badexp /all/;
solve badexp using nlp minimizing z;

$ontext
#user model library stuff
Main topic Execution errors
Featured item 1 Solver
Featured item 2 Division by zero
Featured item 3
Featured item 4
Description
Illustrate solver execution error when dividing by zero
$offtext
