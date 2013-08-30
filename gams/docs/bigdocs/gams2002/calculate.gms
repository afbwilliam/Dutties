*This gives examples of calculations and use of functions

set i /i1*i10/;
set j /j1*j10/;
set Q(i);
scalar x,r;
parameter Z(i);
parameter Y(i);
parameter w(j)/j2 6, j10 8/;
variables zz(i);
equations eq(i),eq1(i),eq2(i),eq3(i),eq4(i);
variables zq(j);
equations eq5(i);
variables zz(i);
equations eq(i);

x=4+6+sqrt(7);
Z(i)=12+x;
Eq1[I].. zZ(i)=e=12+x;
Y(i)=+z(i);
x=x-3-sqrt(7);
Z(i)=12-x;
Eq2[I].. zZ(i)=e=12-x;
Y(i)=-z(i);
x=x-3-sqrt(7);
Z(i)=12*x;
Eq3[I].. zZ(i)=e=12*x;
Y(i)=44*z(i);
x=x-3/sqrt(7);
Z(i)=12/x;
Eq4[I].. zZ(i)=e=12/x;
Y(i)=1/z(i);
x=3**sqrt(7);
Z(i)=12.0**x;
Y(i)$(z(i)-1 gt 0)=z(i)**0.5;
Y(i)=14*x**2/4-3+2;

Z{I}=10*[3+2]**{34/(11+12)}+{11-1};

eq[i].. zZ{I}=l=10*[3+2]**{34/(11+12)}+{11-1};

r=sum(I,y[I]);
r=sum((I,j),y(i)+w(j));
*eq5[I]..  zz[I]=e=sum[j,zz[i-1]+zq[j]];

r=smax(I,y[I]);
r=smax((I,j),y(i)+w(j));
eq5[I]..  zz[I]=e=smax[j,zz[i-1]+zq[j]];
scalar mz,z22/0/;
parameter mr(i);
variable xvar(i);
equation obj;
variable z2(j);
set zzz /z1*z10/;
parameter mx(zzz);
mx(zzz)=log(ord(zzz));
parameter ar(zzz,i);
parameter ma(i),jr(i,j);
equation resource(j);
jr(i,j)=card(i);
ma(i)=4;
ar(zzz,i)=12;
xvar.l(i)=3;
mr(i)=10;
mZ=sum(I,mr(i)*xvar.l(i));
Obj.. z22=e= sum(I,mr(i)*xvar(i));

mX(Zzz)=sum(I,ar(zzz,i)*ma(i));
Resource(j).. z2(j)=e= sum(I,jr(I,j)*xvar(i)) ;

Loop(zzz, z22=z22+sum(I,ar(zzz,i)*mr(i)));

Z22=sum(I,ar('z1',i)*mr(i));

parameter v(i,j),c(i,j);
v(i,j)=ord(i)+ord(j);
c(i,j)=log(v(i,j));
R=sum((I,J),c(I,J)*v(I,J));
R=sum(I,sum(J,c(I,J)*v(I,J)));

equation eq7(i),eq8(j);
mA(i)$xvar.l(i)=mr(i);
mA(i) =mr(i)$xvar.l(i);
r=sum(i$xvar.l(i),mr(i));
r=smin(i$xvar.l(i),mr(i));
r=prod(i$xvar.l(i),mr(i));
Eq7(i)$ma(i).. zZ{I}=l=10*[3+2]**{34/(11+12)}+{11-1};
Eq8(j)$w(j)..  z2(j)=e= sum(I$ma(i),jr(I,j)*xvar(i)) ;

set mysubset(i);
mysubset(i)$(ord(i) le 2)=yes;
set atuple(I,j);
atuple(I,j)$(ord(i) > ord(j))=yes;
equation eq11(i),eq12(i),eq13(i),eq14(i,j),eq15(i,j),eq16(j);
variable twovar(i,j);
mA(i)$mysubset(i)=mr(i);

mA(i)$mysubset(i)=mr(i);
ma(mysubset(i))=mr(i);
mA(i) =mr(i) $mysubset(i);
mA(i) =sum(atuple(I,j),v(I,j));
v(i,j)$atuple(i,j)=3;
v(atuple(i,j))=3;
v(atuple)=3;
r=sum(mysubset,mr(mysubset));
r=sum(mysubset(i),mr(i));
r=sum(mysubset(i),mr(mysubset)+mr(i));
r=sum(atuple(I,j),v(I,j));
r=smin(i$mysubset(i),mr(i));
r=smax((I,j)$atuple(I,j),v(I,j));
r=smax(atuple(I,j),v(I,j));
Eq11(i)$mysubset(i).. zZ{I}=l=10*[3+2]**{34/(11+12)}+{11-1};
Eq12(mysubset).. zZ{mysubset}=l=10*[3+2]**{34/(11+12)}+{11-1};
Eq13(mysubset(i))..  zZ{I}=l=sum(atuple(I,j),ord(i)+ord(j));
Eq14(atuple(i,j))..  1=e= twovar(i,j) ;
Eq15(I,j)$atuple(i,j)..  1=e= twovar(i,j) ;
eq16(j).. 1=e=sum(atuple(I,j),v(I,j)*twovar(i,j));

set origin      /o1,o2/
set destination /d1,d2/
set Cantravel(origin,destination);
table distance(origin,destination)
           d1    d2
o1          2     1
o2         11      ;
alias(superset,i);
mysubset(superset)=yes;
mysubset(superset)=no;
Cantravel(origin,destination)$(distance(origin,destination) gt 0)=yes;



scalar s;
r=1;
s=2*r;
Display 'one',s;
r=2;
display 'two',s;

$ontext
#user model library stuff
Main topic Computations
Featured item 1 Ord
Featured item 2 Card
Featured item 3 Sqrt
Featured item 4 Yes

Description
This gives examples of calculations and use of functions

$offtext
