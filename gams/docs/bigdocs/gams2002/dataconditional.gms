*illustrate conditionals dependent on numerical existance

scalar x/3/,z/0/,y/1/,doiwantconstraint /1/;
set i /i1*i10/;
alias(i,j)
parameter q(i) /i1 1, i2 2/
parameter data(i,j);
data(i,j)=ord(i)+ord(j);
variable zz;
equation eq1,eq2,eq3,eq4,eq5,eq6;

*existence of elements or calculations
    Z=z+2$x;
    If(x, z=2);
    Eq1$doiwantconstraint..  zz=e=3;
    Loop(I$(q(i)+q(i)**2),z=z+1)
    While(x*x-1, z=z+2;x=x-1);

*existance of calculations

    Z=z+2$sum(I$q(i),1);
    If(smin(I,q(i)), z=2);
    Eq2$prod(I,q(i))..  zz=e=3;
    Eq3(j)$sum(I,abs(data(I,j)))..  zz=e=3;
    Loop(I$sum(j,abs(data(I,j))),z=z+1)
    While(prod(I,q(i)), z=2;q(i)=q(i)-2);



$ontext
#user model library stuff
Main topic Conditionals
Featured item 1 $ conditionals
Featured item 2 If
Featured item 3
Featured item 4
Description
Illustrate conditionals dependent on numerical existance

$offtext
