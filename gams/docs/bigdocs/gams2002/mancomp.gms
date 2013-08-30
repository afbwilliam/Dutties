$ontext

Manual Comparative Analysis using repeated solves with
report writing done with one piece of code which is
incorporated multiple times using include
$offtext

option limrow=0;
option solprint=off;
option limcol=0;
$offsymlist offsymxref
$include farmcomp.gms
$include farmrep.gms
price("beef")=0.70;
SOLVE FARM USING LP MAXIMIZING NETINCOME;
display price ;
$include farmrep.gms
price("corn")=2.70;
display price ;
SOLVE FARM USING LP MAXIMIZING NETINCOME;
$include farmrep.gms

$ontext
#user model library stuff
Main topic  Comparative analysis
Featured item 1 Comparative analysis
Featured item 2 Manual
Featured item 3 Repetitive
Featured item 4
Description
Manual Comparative Analysis using repeated solves with
report writing done with one piece of code which is
incorporated multiple times using include

$offtext
