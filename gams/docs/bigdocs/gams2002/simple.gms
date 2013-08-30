$offsymxref offsymlist
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
model mymodel /all/;
mymodel.optfile=1;
option limrow=0; option limcol=0;
option lp=gamsbas;
mymodel.optfile=1;
solve mymodel using lp maximizing objfun;

$Ontext

Name SIMPLE.GMS
Main topic Advanced basis
Featured item 1 savepoint
Featured item 2 gdx point file
Featured item 3 Optfile
Featured item 4
Extension .GMS
Description
Illustrate gdx point basis generation and use of option file

$Offtext
