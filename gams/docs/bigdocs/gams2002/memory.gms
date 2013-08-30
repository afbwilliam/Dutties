*Illustrate clear and kill of memory and profile usage for memory detection

option profile=1;
option lp=bdmlp;
$OFFSYMLIST OFFSYMXREF
option limrow=0;
option limcol=0;
set i /1*5 /
set j /1*5 /
set k /1*5 /
set l /1*5 /
set m /1*5 /
set n /1*5 /
set o /1*5 /
parameter y(i,j,k,l,m,n,o);
parameter q(i,j,k);
variable  x(i,j,k,l,m,n,o)
          f(i,j,k)
          obj;
equation  z(i,j,k,l,m,n,o)
          res(i,j,k)
          ob;
 y(i,j,k,l,m,n,o)=10;
 x.up(i,j,k,l,m,n,o)=10;
 x.scale(i,j,k,l,m,n,o)=1000;
 q(i,j,k)=10;

ob..
      obj  =e= suM((i,j,k,l,m,n,o),x(i,j,k,l,m,n,o));
z(i,j,k,l,m,n,o)..
      x(i,j,k,l,m,n,o) =l= 8;
res(i,j,k)..
          f(i,j,k)=l=7;
model memory /all/
option solprint=off;
solve memory maximizing obj using lp;


$ontext
#user model library stuff
Main topic Memory
Featured item 1 Profile
Featured item 2 Memory detection
Featured item 3 Clear
Featured item 4 Kill
Description
Illustrate clear and kill of memory and profile usage for memory detection
$offtext
