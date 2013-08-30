*this example illustrates the use of assorted functions
set s11 /s1,s2/;
scalar zzz / 10 /;
scalar resultzzz;
resultzzz=poly(zzz,1,2,-1);
display resultzzz;

scalar x,t /-10/,y /5/, tt/20/;
x=system.gamsrelease;
display x;
x=gamsrelease;

display x;
variable z,yy;
equation eq1;
X=abs(t);
X=abs(y+2);
Eq1..   z=e=abs(yy);
yy.fx=10;
model rr1 /eq1/;
solve rr1 using dnlp maximizing z;

equation eq2;
X=exp(tt);
X=exp(y+2);
Eq2..   z=e=exp(yy);
model rr2 /eq2/;
solve rr2 using nlp maximizing z;

equation eq3;
X=log(tt);
X=log(y+2);
Eq3..   z=e=log(yy);
model rr3 /eq3/;
solve rr3 using nlp maximizing z;

equation eq4;
X=log10(tt);
X=log10(y+2);
Eq4..   z=e=log10(yy);
model rr4 /eq4/;
solve rr4 using nlp maximizing z;

equation eq5;
X=max(y+2,t,tt);
Eq5..   z=e=max(yy,t);
model rr5 /eq5/;
solve rr5 using dnlp maximizing z;

equation eq6;
X=min(y+2,t,tt);
Eq6..   z=e= min (yy,t);
model rr6 /eq6/;
solve rr6 using dnlp maximizing z;

equation eq7;
set i /i1*i10/;

variable va(i);
parameter a(i);
a(i)=10;
X=prod(I,a(i)*0.2-0.5);
va.fx(i)=a(i);
Eq7..   z=e= prod(I,va(i)*0.2-0.5);
model rr7 /eq7/;
solve rr7 using nlp maximizing z;

equation eq8;
X=entropy(tt);
X=entropy(y+2);
Eq8..   z=e=entropy(yy);
model rr8 /eq8/;
solve rr8 using nlp maximizing z;

equation eq8a;
X=sigmoid(tt);
X=sigmoid(y+2);
Eq8a..   z=e=sigmoid(yy);
model rr8a /eq8a/;
solve rr8a using nlp maximizing z;

equation eq8b;
X=edist(tt,y);
X=edist(tt,y+2);
Eq8b..   z=e=edist(yy);
model rr8b /eq8b/;
solve rr8b using nlp maximizing z;

X=ifthen(tt=2,3,4+y);

scalar q /12.432/;
X=round(q);
X=round(12.432);

scalar zz /0/;
X=round(q,zz);
X=round(12.432,2);

X=smin(I,a(i)*0.2-0.5);
equation eq9a;
Eq9a..   z=e= smin(I, va(i)*0.2-0.5);
model rr9a /eq9a/;
solve rr9a using dnlp maximizing z;

X=smax(I,a(i)*0.2-0.5);
equation eq9;
Eq9..   z=e= smax(I, va(i)*0.2-0.5);
model rr9 /eq9/;
solve rr9 using dnlp maximizing z;

X=sqr(a('i1'));
X=sqr (y+2);
equation eq10;
Eq10..   z=e= sqr(yy);
model rr10 /eq10/;
solve rr10 using nlp maximizing z;

X=sqrt(a('i1'));
X=sqrt (y+2);
equation eq11;
Eq11..   z=e= sqrt(yy);
model rr11 /eq11/;
solve rr11 using nlp maximizing z;

scalar cc;
x=2*3114176;
cc=Arctan (x);
cc=ceil(x);
cc=Cos (x)      ;
cc=Errorf(x)    ;
cc=Floor (x)    ;
cc=Mapval(x)    ;
y=2;
cc=Mod(x,y)     ;
cc=Normal(x,y)  ;
cc=Power(x,y)   ;
cc=Sign(x)      ;
cc=Sin(x)       ;
cc=Trunc(x)   ;
cc=Uniform(x,x+10);
*cc=Fac(5);
cc=execseed;
execseed=mod(jnow,1);
cc=heapsize;
cc=TIMESTART;
cc=TIMECOMP;
cc=TIMEEXEC;
cc=TIMECLOSE;
cc=execerror;
execerror=0;

cc=sinh(4);
display cc;
cc=sinh(0);
display cc;
cc=cosh(4);
display cc;
cc=cosh(0);
display cc;
cc=tanh(4);
display cc;
cc=tanh(0);
display cc;

cc=gmillisec(jnow);
display cc;

cc=maxexecerror;
display cc;

maxexecerror=5;
cc=maxexecerror;
display cc;

set iiu/1*12/;
cc=0;
loop(iiu,
   cc=ord(iiu);
   display 'error count' , cc;
   cc=0;
   cc=1/cc;
   );
scalar aa /1/,ab /2/, ax/ 0.3/;
      cc=  Gamma(aa);
      cc=  LogGamma(aa);
      cc=  GammaReg(ax,aa);
      cc=  Beta(aa,ab);
      cc=  LogBeta(aa,ab);
      cc=  BetaReg(ax,aa,ab);
      cc=  arccos(aa);
      cc=  arcsin(aa);
      cc=  tan(aa);
      cc=  ArcTan2(aa,ab);
      cc = binomial (4,2);
display cc;
      cc = GamsVersion;
*HandleStatus
*HandleDelete
*HandleSubmit
*HandleCollect:         Grid facility functions, see the grid facility document for details
      cc = Heapsize;
      cc= Sleep(2);

      cc = Heaplimit;
      display cc;
      Heaplimit=40;
      cc = Heaplimit;
      display cc;

      cc= Sleep(2);

$ontext
#user model library stuff
Main topic Calculations
Featured item 1 Functions
Featured item 2 Abs
Featured item 3 Sqr
Featured item 4 Exp
Description
Illustrate use of assorted functions
Abs, exp, log, log10, timeexec, ...

$offtext
