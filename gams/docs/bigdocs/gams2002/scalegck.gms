*Illustrate GAMSCHK as aid to scaling

   sets      items            names of variables   /x1*x4/
             resources        names of constraints /r1*r4/

  parameter objcoef(items)   objective function coeficients
                      /x1 1, x2 -500, x3 -400, x4 -5000/
            rhs(resources)   resource availabilities
                      /r3 6000,r4 300/;

  Table amatrix(resources,items) aij matrix
         x1      x2     x3     x4
    r1    1    -1000  -8000
    r2            5     4     -50
    r3          1500   2000
    r4            50     45          ;

  variables          z objective      function;
  positive variables xvar(items)      variables;
  equations          objfun           objective function
                     avail(resources) resource limits;

  objfun..   z =e= sum(items,objcoef(items)*xvar(items));
  avail(resources).. sum(items,amatrix(resources,items)*xvar(items))
                             =l= rhs(resources);
  option limrow=4;
  option limcol=0;
  model scalemod /all/;
  option lp=gamschk;
  solve scalemod using lp maximizing z;

$ontext
#user model library stuff
Main topic Scaling
Featured item 1 GAMSCHK
Featured item 2
Featured item 3
Featured item 4
include scalegck.gck
Description
Illustrate GAMSCHK as aid to scaling
$offtext

