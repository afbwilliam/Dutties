*Illustrate GAMSBAS basis use

sets               var         /x1*x3/
                   constraint  /r1*r3/;
variables          objfun;
positive variables x(var);
equations          objective
                   resource(constraint);
parameter          objcoef(var) objective function coeffients
                   /x1 30,x2 20,x3 10 /;
parameter          rhs(constraint)    constraint rhs's
                   /r1 10,r2  2,r3  8/;
table   amatrix(constraint,var) aij matrix
                 x1      x2       x3
        r1        2       1
        r2        1       1     -1.5
        r3               -1        1;
objective..     objfun =e= sum(var, objcoef(var) * x(var));
resource(constraint)..
       sum(var, amatrix(constraint,var)* x(var)) =l= rhs(constraint) ;
model mymodel /all/
option limrow=0; option limcol=0;
option lp=bdmlp;
$include simple.bas
mymodel.optfile=1;
solve mymodel using lp maximizing objfun;

$ontext
#user model library stuff
Main topic Advanced basis
Featured item 1 GAMSBAS
Featured item 2 BAS file
Featured item 3 Include
Featured item 4
include simple.bas
Description
Illustrate GAMSBAS basis use
Basis is called simple.bas and was written by simple.gms
$offtext
