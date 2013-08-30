$Title Dicut Generation (cut generator for bchfcnet)
$Ontext

  Francisco Ortega, Laurence Wolsey
  A branch-and-cut algorithm for the single-commodity, uncapacitated,
  fixed-charge network flow problem.
  Networks 41 (2003), no. 3, 143--158.

  http://www.core.ucl.ac.be/services/psfiles/dp00/dp2000-49.pdf

  Michael Bussieck, Hua Ni
  Technical Note: Solving the Steiner Tree Problem with GAMS Branch-and-Cut
  Facility.
  Technical report, GAMS Development Corp. 2003.

$Offtext
$eolcom //

set        nn              nodes
           ss              sub arcs index
           arc(nn,nn,ss)   arcs
Alias(nn,n,m),(s,ss)

Parameter  demand(nn)      node demand

Variables  y(nn,nn,ss)     usage of the arc
           orgcost

$gdxin net.gdx
$load nn ss arc demand

$gdxin bchout.gdx
$load y orgcost=cost

scalar startcut start the cutting plane generation when LP reaches /652/;

* Start cuts after CPLEX is done with cuts
$if set cplex abort$(orgcost.l < startcut) 'stop',orgcost.l,startcut;

* Is this an integer solution? Then there won't be cuts
abort$(sum(arc$(y.l(arc)>1e-6 and y.l(arc)<1-1e-6),1)=0) 'stop no frac';

Set        cc        maximum number of cuts  / 1*20 /
           gdxcc     / bchdicut1*bchdicut20 /
           c(cc)     active solution eliminating constraints
Variable   z(nn)     indicator for node membership
           cost      objective
           zall(gdxcc,nn)
Binary variables z, zall
Equations  obj       objective
           sc        positive demand over the node set;

obj..     sum(arc(m,n,s), y.l(m,n,s)*z(n)*(1-z(m))) =e= cost;

sc..      sum(n, demand(n)*z(n))                    =g= 1;

Model dicut /obj, sc/;

option limrow=0, limcol=0, solprint=off;

Parameter y_c(cc,nn,nn,ss)  coefficient of the y variables in the cut
          rhs_c(cc)         cut rhs
          sense_c(cc)       the sense of the cuts // 1 =L=, 2 =E=, 3 =G=
          numcuts           /0/
          first             /1/
Set       gdxccact(gdxcc);

c(cc)     = no;
$call rm -rf bchdicut*.gdx
z.l(nn) = uniform(0.25,0.75);
cost.up = 0.985;
solve dicut minimizing cost using minlp;

if ((dicut.modelstat = %modelstat.Optimal%           or
     dicut.modelstat = %modelstat.IntegerSolution%   or
     dicut.modelstat = %modelstat.LocallyOptimal%    and
     dicut.solvestat = %solvestat.NormalCompletion%) and  cost.l < 0.985,
  execute 'gdxmerge bchdicut*.gdx > "%gams.scrdir%merge.%gams.scrext%"';
  execute_load 'merged.gdx', gdxccact=merged_set_1, zall=z;
  zall.l(gdxccact,n) = round(zall.l(gdxccact,n));
  loop((gdxccact(gdxcc),cc)$(ord(gdxcc)=ord(cc)),
    numcuts     = numcuts + 1;
    sense_c(cc) = 3; // =G=
    rhs_c(cc)   = 1;
    y_c(cc,arc(m,n,s))$(not zall.l(gdxccact,m) and zall.l(gdxccact,n)) = 1;
    c(cc)       = yes;
  )
else
  abort 'stop, no cuts';
)
