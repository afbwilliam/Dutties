*Illustrates presolve when problem hs no feasible solution

variables z;
positive variables y1,y2;
equations r1,r2,r3,r4;
  r1..  z=e=y1+y2;
  r2..  y1=g=1.10;
  r3..  y2=g=0.10;
  r4..  y1+y2=l=1;
model badpresol /all/
option lp=conopt;
*option lp=cplex;
*option lp=osl;
*option lp=bdmlp;
*option lp=xa;
*option lp=xpress;
OPTION work = 30;
solve badpresol using lp maximizing z;

$ontext
#user model library stuff
Main topic Solves
Featured item 1 Presolve
Featured item 2 Problems
Featured item 3 Infeasible
Description
Illustrates presolve when problem hs no feasible solution

$offtext
