*Illustrates presolve when problem hs no feasible MIP solution

variables z;
integer variables y1,y2;
equations r1,r2,r3,r4;
  r1..  z=e=y1+y2;
  r2..  y1=g=0.10;
  r3..  y2=g=0.10;
  r4..  y1+y2=l=1;
model badpresol /all/
option mip=cplex;
option mip=osl;
option mip=bdmlp;
option mip=xa;
option mip=xpress;
solve badpresol using mip maximizing z;

$ontext
#user model library stuff
Main topic Solves
Featured item 1 Presolve
Featured item 2 Problems
Featured item 3 MIP
Featured item 4 Infeasible
Description
Illustrates presolve when problem hs no feasible MIP solution

$offtext
