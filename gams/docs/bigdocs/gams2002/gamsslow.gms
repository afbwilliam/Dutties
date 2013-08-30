*Illustrate program timing problems and discovery

option limrow=0; option limcol=0;
option solprint=off;
option profile=1;
*option profiletol=1.1;
$offsymxref offsymlist
Set     a /1*12/
        B /1*12/
        C /1*10/
        D /1*10/
        e /1*12/;
parameter x(e,d,c,b,a);
                 X(e,d,c,b,a)=10;
parameter z(a,b,c,d,e);
z(a,b,c,d,e)=x(e,d,c,b,a);
parameter y;
                 Y=sum ((a,b,c,d,e),z(a,b,c,d,e)*x(e,d,c,b,a));
variables obj
Positive variables var(e,b,a);
equations objeq
          R( b,c,d)
          q(a,b,c);

objeq.. obj=e=sum((a,b,c,d,e),z(a,b,c,d,e)*x(e,d,c,b,a)*var(e,b,a));
r(b,c,d).. sum((a,e),Var(e,b,a))=l=sum((a,e),x(e,d,c,b,a)*z(a,b,c,d,e));
q(a,b,c).. sum((d,e),var(e,b,a)/x(e,d,c,b,a)*z(a,b,c,d,e))=l=20;
model slow /all/;
*option lp=bdmlp;
slow.workspace=10;
solve slow maximizing obj using lp;
parameter sumofvar;
sumofvar=sum((a,b,c,d,e),z(a,b,c,d,e)*x(e,d,c,b,a)*var.l(e,b,a));


$ontext
#user model library stuff
Main topic Speed
Featured item 1 Profile
Featured item 2 Set ordering
Featured item 3 Profiletol
Featured item 4
Description
Illustrate program timing problems and discovery

$offtext
