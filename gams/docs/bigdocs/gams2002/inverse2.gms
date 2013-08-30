$gdxin mygdx.gdx
set i;
$load i
$gdxin
alias(i,j);
table ainv(i,j)
$include myinverse.put
display ainv;
execute_unload 'mygdx.gdx', ainv;


$ontext
#user model library stuff
Main topic Linking to other programs
Featured item 1 GDX
Featured item 2 GAMS to GAMS
Featured item 3 Execute_unload
Featured item 4
include (invert.gms,mygdx.gdx,myinverse.put)
Description
Matrix inversion through passed put and loaded GDX file
Illustrates GAMS call to GAMS
$offtext
