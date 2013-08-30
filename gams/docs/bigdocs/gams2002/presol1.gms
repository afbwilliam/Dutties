*Illustrates presolve when problem is simplified out of existance

variables z;
positive variables y1,y2;
equations r1,r2,r3,r4;
  r1..  z=e=y1+y2;
  r2..  y1=l=10;
  r3..  y2=l=10;
  r4..  y1+y2=e=10;
model badpresol /all/
option lp=osl;
option subsystems

solve badpresol using lp maximizing z;

$ontext
#user model library stuff
Main topic Solves
Featured item 1 Presolve
Featured item 2 Problems
Featured item 3
Featured item 4
Description
Illustrates presolve when problem is simplified out of existance

$offtext
