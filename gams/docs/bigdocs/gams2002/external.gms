$title variant of GAMS External Function - Example 1

$ontext
  This is an example develped by GAMS corp illistrating how to
  use the external function (=X=) facility with GAMS.
  The model is a simple unconstrained quadratic model
  and the quadratic function is defined in an external function.
$offtext

set i / i1*i4 /
alias (i,j);

parameter Q(i,j) Covariance Matrix
          X0(i)  Targets;
Q(i,j) = power(0.5, abs(ord(i)-ord(j)) );
X0(i)  = ord(i);
display Q, X0;

variables x(i), z;
equations zdef, zdefX;

* The desired equation, implemented in GAMS, is

  zdef .. sum( (i,j), (x(i)-x0(i)) * Q(i,j) * (x(j)-x0(j) ) ) =e= z;

* It is implemented as an external equation iss:

  zdefX .. sum(i, ord(i)*x(i) ) + (card(i)+1)* z =X= 1;

$ontext
  The coefficients in the equation show that the X-variables are
  numbered from 1 to card(i) and Z has number card(i)+1 in the
  External Function code.
  There is only one external equation and it has number 1, the value
  of the right hand side.
  Note that all variables in the equations must be assigned a variable
  number and that they all must appear in the external function. You
  cannot as yet tell the solver that some of the terms are linear
  -- all terms are nonlinear from the solver's point of view.
$offtext

model ex1      'GAMS implementation'                        / zdef /;
model extern     'External functions in Delphi'               / zdefX /;

option limcol = 0;

*  Check the solution against the targets:

parameter report(*,*,*) Solution Summary;
scalar totdist /0/;

z.l = 0;
z.m = 0;
x.l(i) = 0;
x.m(i) = 0;
zdef.l = 0;
zdef.m = 0;
solve ex1 using nlp minimizing z;
report('Solve ','Stat',  'GAMS') = ex1.solvestat;
report('Model ','Stat',  'GAMS') = ex1.modelstat;
report(i,'Target',  'GAMS') = x0(i);
report(i,'Value',   'GAMS') = x.l(i);
report(i,'Distance','GAMS') = abs(x.l(i) - x0(i));
totdist = totdist + sum(i,abs(x.l(i) - x0(i)));

z.l = 0;
z.m = 0;
x.l(i) = 0;
x.m(i) = 0;
zdefX.l = 0;
zdefX.m = 0;
solve extern using nlp minimizing z;
execerror = 0;
report('Solve ','Stat',  'Delphi') = extern.solvestat;
report('Model ','Stat',  'Delphi') = extern.modelstat;
report(i,'Target',  'Delphi') = x0(i);
report(i,'Value',   'Delphi') = x.l(i);
report(i,'Distance','Delphi') = abs(x.l(i) - x0(i));
totdist = totdist + sum(i,abs(x.l(i) - x0(i)));
display report;

display report;

if ((totdist < 1.0E-6),
  display "@@@@ #Test passed.";
else
  display totdist, "@@@@ #Test not passed. Inspect ex1.lst for details.";
);

$ontext
#user model library stuff
Main topic Linking to other programs
Featured item 1 External constraint
Featured item 2 =x=
Featured item 3
Featured item 4
include extern.dll
Description
  This is an example develped by GAMS corp illistrating how to
  use the external function (=X=) facility with GAMS.
  The model is a simple unconstrained quadratic model
  and the quadratic function is defined in an external function.
$offtext
