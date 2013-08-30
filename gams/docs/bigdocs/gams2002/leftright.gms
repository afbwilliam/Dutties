*Illustrate left and right hand side conditionals

scalar y,z,x;
Y=2;
Z=2;
X=0;
Y$X=4;
Z=4$X;
display y,z;

variable yy;
equation c1,c2;
C1$x.. YY=e=4;
C2..     YY=e=4$X;
model lr /all/;
option lp=bdmlp;

solve lr using lp maximizing yy;


$ontext
#user model library stuff
Main topic Conditionals
Featured item 1 $ conditionals
Featured item 2 Left conditional
Featured item 3 Right conditional
Featured item 4
Description
Illustrate left and right hand side conditionals
$offtext
