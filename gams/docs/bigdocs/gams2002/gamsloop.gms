*Demonstate output effects of using profile of 2

option profile=2;
option limrow=0;
option limcol=0;
option solprint=off
$offsymxref offsymlist
Set     a /1*10/
        B /1*10/
        C /1*10/
        D /1*10/
        e /1*10/
parameter x(a,b,c,d,e);
parameter z(a,b,c,d,e);
parameter y;
variables obj
Positive variables var(a,b,e);
equations objeq
          R( b,c,d)
          q(a,b,c);

objeq.. obj=e=sum((a,b,c,d,e),z(a,b,c,d,e)*x(a,b,c,d,e)*var(a,b,e));
r(b,c,d).. sum((a,e),Var(a,b,e))=l=sum((a,e),x(a,b,c,d,e)*z(a,b,c,d,e));
q(a,b,c).. sum((d,e),var(a,b,e)/x(a,b,c,d,e)*z(a,b,c,d,e))=l=20;
model slow /all/
option lp=bdmlp;
slow.workspace=13;
set loops /1*2/
parameter sumofvar;
loop(loops,
     X(a,b,c,d,e)=10;
     z(a,b,c,d,e)=x(a,b,c,d,e);
     Y=sum ((a,b,c,d,e),z(a,b,c,d,e)*x(a,b,c,d,e));
     solve slow maximizing obj using lp;
     sumofvar=sum((a,b,c,d,e),z(a,b,c,d,e)*x(a,b,c,d,e)*var.l(a,b,e));
);


$ontext
#user model library stuff
Main topic Speed
Featured item 1 Profile
Featured item 2 Loop
Featured item 3
Featured item 4
Description
Demonstate output effects of using profile of 2

$offtext
