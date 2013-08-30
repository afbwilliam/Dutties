$Title Simple cover inequalities for the multi-knapsack problem with integer data

* Declare and get selected data from base model
Set j, i;
Parameter a(i,j), rhs(i);

$gdxin mkdata
$load j i a rhs

* Declare selected variables from base MIP model
Binary   variables x(j)
Positive variable  slack(i);

* Get current values from MIP solver
$gdxin bchout
$load x slack

* Define separation model
Parameter ai(j), rhsi slice of the multi knapsack problem;

Binary variable y(j) membership in the cover
       variable obj;

Equations k, defobj;

defobj.. obj =e= sum(j, (1-x.l(j))*y(j));

* rhsi+1 only works if all ai are integer
k.. sum(j, ai(j)*y(j)) =g= rhsi+1;

model kn /all/;

* In order to communicate with the MIP solver we need certain conventions
* 1. Cut matrix interface requirement with fixed names
Set        cut           potential cuts  / 1*5 /
Parameters rhs_c(cut)    cut rhs
           sense_c(cut)  'the sense of the cuts 1 =L=, 2 =E=, 3 =G='
           numcuts       number of cuts passed back
* 2. Nonzeros in cut matrix using the original variable name plus _c
           x_c(cut,j)    coefficient of the x variables in the cut

* We solve one knapsack type MIP to solve the cover separation problem for each
* row in the original problem that is binding
* The actual cover cut is sum(cover(j), x(j)) =l= sum(cover(j),1)-1;

option optcr=0, limrow=0, limcol=0;
option solprint=off, solvelink=%solvelink.CallModule%;

Set c(cut) current cut /1/;
numcuts = 0;
loop(i$(numcuts < card(cut) and slack.l(i) < 1e-6),
  ai(j) = a(i,j);
  rhsi = rhs(i);
  solve kn min obj using mip;
  if ((kn.modelstat = %modelstat.Optimal% or
       kn.modelstat = %modelstat.IntegerSolution%) and obj.l < 0.95,
     numcuts    = numcuts + 1;
     x_c(c,j)   = round(y.l(j));
     rhs_c(c)   = sum(j,round(y.l(j))) - 1;
     sense_c(c) = 1;
     c(cut)     = c(cut-1);
  )
);

* One can debug the cut generator by solving the RMIP of the base model (change
* mip to rmip) and creating a GDX file with the name bchout.gdx:
*  gams bchmknap rmip=cplex gdx=bchout
* Start the cut generator and analyze the cuts generated
*  gams bchcover.inc mip=cplex
display numcuts, x_c, rhs_c, sense_c;
