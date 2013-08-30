$title Trim Loss Minimization (Heuristic)

SET i product roll
    j pattern number

SCALAR Bmax width of entire roll
       delta maximum loss in pattern
       Nkmax maximum number of knives

PARAMETER n(i)  number of orders of each product roll
          b(i)  width of each roll
          mupp(j)

* Load data from the instance
$gdxin trimloss
$load i j Bmax delta Nkmax n b mupp

VARIABLES
         r(i,j)    number of products of type i in pattern j
         y(j)      existence of pattern j
         m(j)      repeats of pattern j
         objval    objective function variable;

FREE VARIABLES    objval;
BINARY VARIABLE   y;
INTEGER VARIABLE  r;

Parameter rx(i,j) number of products of type i in pattern j;
* Load the LP solution from the node
$gdxin bchout
$load r

rx(i,j) = r.l(i,j);

* Undo the bound change from branching
r.lo(i,j) = 0; r.up(i,j) = Nkmax;

EQUATIONS
         f           objective function
         numroll(i)  order constraints ensuring sufficient production
         widthL(j)   width lower bound constraint
         widthU(j)   width upper bound constraint
         rL(j)       logical constraint on r
         sumr(j)     logical constraint on r
         mL(j)       logical constraint on m
         mU(j)       logical constraint on m
         sumbil      lower bound on total number of patterns made
         yy(j)       ordering of y variables to reduce degeneracy
         lmm(j)      ordering of m variables to reduce degeneracy
;

f.. objval =e= SUM(j, m(j) + ord(j)/10 * y(j));

numroll(i).. SUM(j, m(j) * rx(i,j)) =g= n(i);

widthL(j).. SUM(i,b(i) * r(i,j)) =g= (Bmax - delta) * y(j);
widthU(j).. SUM(i,b(i) * r(i,j)) =l= Bmax * y(j);

rL(j).. y(j) =l= SUM(i,r(i,j));

sumr(j).. SUM(i,r(i,j)) =l=  Nkmax * y(j);

mL(j).. y(j) =l= m(j);
mU(j).. m(j) - mupp(j) * y(j) =l= 0;

sumbil  .. SUM(j, m(j)) =g=
              max(ceil(sum(i,n(i))/Nkmax), ceil(sum(i,b(i)*n(i))/Bmax))+1;

yy(j+1).. y(j+1) =l= y(j);

lmm(j+1).. m(j+1) =l= m(j);

* Bounds
r.UP(i,j) = Nkmax;
m.UP(j) = mupp(j);

MODEL trimlossx /ALL/;

Positive variables dp(i,j), dm(i,j) deviations
Equations
         defdev(i,j)
         defcovered(i)
         defobj
;

defdev(i,j).. r(i,j) =e= rx(i,j) + dp(i,j) - dm(i,j);
defcovered(i).. sum(j, r(i,j)) =g= 1;
defobj.. objval =e= sum((i,j), dp(i,j) + dm(i,j));

MODEL findr /defobj, defcovered, defdev, widthL, widthU, rL, sumr, yy/;

findr.optcr=0;
SOLVE findr USING MIP MINIMIZING objval;

r.fx(i,j) = round(r.l(i,j));
rx(i,j) = r.l(i,j);

trimlossx.optcr = 0;
SOLVE trimlossx USING MIP MINIMIZING objval;
