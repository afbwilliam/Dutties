$TITLE Elasto-hydrodynamic lubrication

$ontext

   Reference: Michael M. Kostreva,
   "Elasto-hydrodynamic lubrication: a non-linear
   complementarity problem", Int. Journal for Num. Methods
   in Fluids (4), 377-397 (1984).

   The lubricant film gap and pressure between two lubricated
   elastic cylinders in line contact is calculated.  When the pressure
   is positive, Reynolds' equation applies and must be satisfied;
   when the pressure is 0, the surfaces must diverge.

   The load (in pounds) is represented by alpha.
   The speed (in rpm) of the cylinders is represented by lambda.
   (alpha, lambda) pairs are given in the tables alph and lam, respectively.

$offtext

$set matout "'matsol.gdx', p.l, gap, k.l, xa, delx ";
$if not set m $set m 100

sets
load    / 100lbs, 175lbs, 250lbs /,
speed   / 500rpm, 2500rpm, 5000rpm /,
J       / 1 * %m% /;
alias (I,J);

scalars
pi,
N,
delx,
w0,
xa      / -3 /,
xf      / 2 /,
pscale  / 0.75 /,
alpha,
lambda;

N = card(J);
delx = (xf - xa) / N;
pi = 4 * arctan(1);

parameters
klevel,
plevel(J),
gap(I),
alph(load) /
100lbs  2.832
175lbs  3.746
250lbs  4.477 /,
w(I);

w0 = 0.5;
w(I) = 1$(ord(I) lt N) + 0.5$(ord(I) eq N);

table lam(load, speed)
        500rpm  2500rpm 5000rpm
100lbs  6.057   30.29   60.57
175lbs  1.978   9.889   19.78
250lbs  .9692   4.846   9.692   ;

variable  k        'represents contant term in pressure equation';

positive variables  p(J)        'pressure';
* p(0) is assumed to be 0

equations
  psum   'pressures are scaled so that the integral of the pressure over X = pi/2'
  reynolds(I);

psum .. 1 =e= 2/pi * sum(J, w(J) * p(J)) * delx;

reynolds(I) ..
lambda/delx * (
( power(xa + (ord(I)+.5)*delx, 2) + k + 1
  + 2/pi * (sum (J, w(J) * ((ord(J)-0.5-ord(I))*delx) *
        log(abs(ord(J)-.5-ord(I))*delx) * (p(J+1)-p(J-1)) / 2)
        + w0 * (-0.5-ord(I)) * delx * log((ord(I)+.5)*delx) * p("1") / 2) )
- ( power(xa + (ord(I)-.5)*delx, 2) + k + 1
  + 2/pi * (sum (J, w(J) * ((ord(J)+0.5-ord(I))*delx) *
        log(abs(ord(J)+.5-ord(I))*delx) * (p(J+1)-p(J-1)) / 2)
        + w0 * (+0.5-ord(I)) * delx * log((ord(I)-.5)*delx) * p("1") / 2) )
)

        =g=

(1/power(delx,2)) * (
(p(I+1)-p(I)) / exp(alpha*(p(I+1)+p(I))*.5) * power(
( power(xa + (ord(I)+.5)*delx, 2) + k + 1
  + 2/pi * (sum (J, w(J) * ((ord(J)-0.5-ord(I))*delx) *
        log(abs(ord(J)-.5-ord(I))*delx) * (p(J+1)-p(J-1)) / 2)
        + w0 * (-0.5-ord(I)) * delx * log((ord(I)+.5)*delx) * p("1") / 2)
), 3)
-
(p(I)-p(I-1)) / exp(alpha*(p(I)+p(I-1))*.5) * power(
( power(xa + (ord(I)-.5)*delx, 2) + k + 1
  + 2/pi * (sum (J, w(J) * ((ord(J)+0.5-ord(I))*delx) *
        log(abs(ord(J)+.5-ord(I))*delx) * (p(J+1)-p(J-1)) / 2)
        + w0 * (+0.5-ord(I)) * delx * log((ord(I)-.5)*delx) * p("1") / 2)
), 3)
);

model ehl       / psum.k, reynolds.p /;

option limrow = 0;
option limcol = 0;
option iterlim = 10000;
option reslim = 2400;

* set problem parameters
alpha = alph("100lbs");
lambda = lam("100lbs","500rpm");
klevel = 1.6;

* calculate "modified Hertzian solution" using gap as x values
* use gap as temporary var
gap(J) = xa + delx*ord(J);
plevel(J) = (-0.02*xa + gap(J)*.02)$(gap(J) lt -1)
        + (sqrt(1-gap(J)*gap(J)))$(abs(gap(J)) lt 1);

k.l = klevel;
p.l(J) = plevel(J);

$if exist matdata.gms $include matdata.gms

solve ehl using mcp;

gap(I) = ( power(xa + (ord(I)-.5)*delx, 2) + k.l + 1
  + 2/pi * (sum (J, w(J) * ((ord(J)+0.5-ord(I))*delx) *
        log(abs(ord(J)+.5-ord(I))*delx) * (p.l(J+1)-p.l(J-1)) / 2)
        + w0 * (+0.5-ord(I)) * delx * log((ord(I)-.5)*delx) * p.l("1") / 2) );

execute_unload %matout%;
