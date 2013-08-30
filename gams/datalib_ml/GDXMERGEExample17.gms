$ontext
This program solves the trnsport model using different LP solvers.
After each run, all symbols are written to a GDX file and then
all GDX files are merged into one file. The variable X is read
from the merged file and displayed.

$offtext

$call gamslib -q trnsport
$call gams trnsport lp=bdmlp gdx=bdmlp lo=%GAMS.lo%
$call gams trnsport lp=cplex gdx=cplex lo=%GAMS.lo%
$call gams trnsport lp=xpress gdx=xpress lo=%GAMS.lo%
$call gams trnsport lp=conopt gdx=conopt lo=%GAMS.lo%
$call gams trnsport lp=minos gdx=minos lo=%GAMS.lo%
$call gams trnsport lp=snopt gdx=snopt lo=%GAMS.lo%
$call gdxmerge *.gdx > %system.nullfile%
variable AllX(*,*,*);
$gdxin merged.gdx
$load AllX=X
$gdxin
option AllX:5:1:2;
display AllX.L;
