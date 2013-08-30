*illustrate conditionals enploying numerical comparisions

scalar x/3/,z/0/,y/1/;
set i /i1*i10/
variable zz;
equation eq1,eq2,eq3,eq4,eq5,eq6;

*numerical conditionals

*   equality cases
       If(x eq 2, z=2);
       Eq1$(x=2)..  zz=e=3;
       Loop(I$(sqrt(x)+1= y+2),z=z+1)

*   unequal cases
       If(x ne 2, z=2);
       Eq2$(x<>2)..  zz=e=3;
       Loop(I$(sqrt(x) <> y+2),z=z+1)

*   greater than cases
       If(x gt 2, z=2);
       Eq3$(x>2)..  zz=e=3;
       Loop(I$(sqrt(x)> y+2),z=z+1)

*   less than cases
       If(x lt 2, z=2);
       Eq4$(x<2)..  zz=e=3;
       Loop(I$(sqrt(x) < y+2),z=z+1)

*   greater than or equal to cases
       If(x ge 2, z=2);
       Eq5$(x>=2)..  zz=e=3;
       Loop(I$(sqrt(x)>= y+2),z=z+1)

*   less than or equal to cases
       If(x le 2, z=2);
       Eq6$(x<=2)..  zz=e=3;
       Loop(I$(sqrt(x) <= y+2),z=z+1)


$ontext
#user model library stuff
Main topic Conditionals
Featured item 1 $ conditionals
Featured item 2 If
Featured item 3
Featured item 4
Description
Illustrate alternative forms of conditionals based on numbers
$offtext
