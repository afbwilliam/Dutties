$TITLE  Oil Pipeline Design Problem - Heuristic

$ontext

We implement three different heuristics. The first heuristic runs just once, it
works with a simplified cost structure. The other two heuristics alternate. We
try a simple rounding heuristic and local branching.

$offtext

$include oilbase.inc
$gdxin net
$load  n k kk port regnode arc p cap dist pipecost cap1 pipecost1


Scalar heurcnt /0/;
$if exist pwl.ind $include pwl.ind

* PWL Heuristic parameters
Scalar    alpha           slope for big pipes     / 0.8 /
          beta            slope for small pipes   / 0.1 /
          h1              separation point between single and big pipe  / 20 /

Variables s(n,n)          segment variable

Equations pwlobj          the cost objective for piece-wise linear cost approximation
          pwlbigM(n,n)    max flow constraints
          pwlsegment(n,n) segment fixing constraints;

pwlobj.. sum(arc, dist(arc)*(alpha*f(arc)+(alpha-beta)*s(arc))) =e= cost;

pwlbigM(arc)..
      smax(kk, cap(kk))*b(arc) =g= f(arc);

pwlsegment(arc)..
      h1*b(arc)-f(arc) =l= s(arc);

model pwl /pwlobj, bal, oneout, oneoutp, pwlbigM, pwlsegment/;
scalar pwlopt optimum of pwl heuristic;

file fx /pwl.ind/;
option limrow=0, limcol=0, solprint=off;

Parameter blb(n,n);
Equation deflb;
deflb.. sum(arc$blb(arc), 1-b(arc)) + sum(arc$(not blb(arc)), b(arc)) =l= 4;

model oillocalbranch /obj, oneout, oneoutp, bal, bigM, defb, deflb/;

option mip=%mipsolver%;

nw(n) = yes;
if (heurcnt>0,
  if (mod(heurcnt,5)=0,
    execute_load 'bchout_i' b.l, bk.l;
    blb(arc) = round(b.l(arc));
    oillocalbranch.reslim  = 60;
    oillocalbranch.optcr   = 0;
$ifi not %mipsolver% == cplex $goto cont
    oillocalbranch.optfile = 99;
$echo mipstart 1     > cplex.o99
$echo mipemphasis 1 >> cplex.o99
$label cont
    solve oillocalbranch minimizing cost using mip;
    oilbase.modelstat$(oillocalbranch.modelstat = %modelstat.Optimal% or
                       oillocalbranch.modelstat = %modelstat.IntegerSolution%) = 1;
  else
* Load LP solution from solver
     execute_load 'bchout' f.l;
     b.fx(arc)$(f.l(arc) = 0) = 0;
     b.up(arc)$(b.up(arc) = 0) = 1$(uniform(0,1)<0.25);
* We have already a solution
     execute_load 'bchout_i.gdx', cost;
     oilbase.cutoff = cost.l;
     solve oilbase minimizing cost using mip;
   )
else
   solve pwl using mip minimizing cost;
   b.fx(arc) = round(b.l(arc));
   solve oilbase minimizing cost using mip;
);
putclose fx 'heurcnt=' (heurcnt+1) ';'
abort$(oilbase.modelstat <> %modelstat.Optimal% and
       oilbase.modelstat <> %modelstat.IntegerSolution%) 'No integer solution';

