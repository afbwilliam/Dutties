$call gamslib trnsport
$call gams trnsport lp=bdmlp gdx=bdmlp
$call gams trnsport lp=cplex gdx=cplex
$call gams trnsport lp=xpress gdx=xpress
$call gams trnsport lp=conopt gdx=conopt
$call gams trnsport lp=minos gdx=minos
$call gams trnsport lp=snopt gdx=snopt
$call gdxmerge bdmlp.gdx cplex.gdx xpress.gdx conopt.gdx minos.gdx snopt.gdx
set i supply set
    j demand set
    merged_set_1 names of gdx files
variable AllX(merged_set_1,i,j);
*load i and j from one of the solver gdx files
$gdxin bdmlp.gdx
$load i
$load j

*load merged file
$gdxin merged.gdx
$load merged_set_1
$load AllX=X
$gdxin
option AllX:5:1:2;
display i,j,merged_set_1,AllX.L;

$ontext
#user model library stuff
Main topic Abort
Featured item 1 GDXMERGE
Featured item 2
Featured item 3
Description
Illustrates use of GDXMERGE
$offtext
