*illustrate $ run time conditionals

set i / i1*i3/
    j / truck,train/;
parameter q(i) / i1 1, i2 -1, i3 11/;
parameter a(i) / i1 0, i2  1, i3 4/;
parameter cost(i,j) / i1.truck 0, i2.train  1, i3.truck 4/;
scalar x;
scalar qq /0/;
equations eq1,eq2,eq3(i);
equation eq4,eq5(i),eq6(i);
variables xvar,yvar,ivar(i),tran(i,j);
variables ijvar(I,j);
equation eq7;
x=7;

*dollar conditionals suppressing whether a replacement occurs
    X$(qq gt 0)=3;
    qq $ (sum(i,abs(a(i))) gt 0)=1/sum(i,a(i));
    qq $(sum(I,q(i)) gt 0)=4;
    a(i)$(qq gt 0) = q(i)+a(i);
    a(i)$a(i) = q(i)/a(i);

*dollar conditionals suppressing whether terms are included
    qq=qq+1$(x gt 0);
    q(i)=a(i)+1$(a(i) gt 0);
    X=sum(I,q(i))$(qq gt 0)+4;
    Eq4..    xvar+yvar$(qq gt 0)=e=3;
    Eq5(i)..  ivar(i)$(a(i) gt 0)+yvar$(qq gt 0)=e=3;

*dollar conditionals suppressing whether indexed terms are included
    X=sum(I$(q(i) gt 0),a(i));
    Loop((I,j)$(cost(I,j) gt 0),X=x+cost(I,j));
    X=smin(I$(q(i) gt 0),q(i));
    eq6(i)..  sum(j$(cost(i,j) gt 1),cost(i,j)*tran(i,j))=e=1;
    X=sum(I,a(i)) $qq;

*dollar conditionals suppressing whether an equation is generated into the model
    Eq1$(qq gt 0)..    xvar=e=3;
    Eq2$(sum(I,q(i)) gt 0)..  yvar=l=4;
    Eq3(i)$(a(i) gt 0)..   ivar(i)=g= -a(i);
    Eq7(i)$qq..   sum(j,ijvar(I,j))=g= -a(i);

$ontext
#user model library stuff
Main topic Conditionals
Featured item 1 $ conditionals
Featured item 2
Featured item 3
Description
illustrate $ run time conditionals

$offtext
