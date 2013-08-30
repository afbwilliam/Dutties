*Matrix inversion through passed put and loaded GDX file
*Illustrates GAMS call to GAMS

set i /i1*i4 /;
execute_unload 'mygdx.gdx',i
alias(i,j);
table a(i,i)
       i1     i2    i3   i4
i1      2      0     2    1
i2      0      1     1    1
i3      0      0     1    3
i4      1      0     0    1
file mymatrix;
put mymatrix;
mymatrix.pc=5;
put '';loop(j,put j.tl;); put /;
loop(i,put i.tl;loop(j,put a(i,j));put /);
putclose;
execute 'invert1 i=mymatrix.put o=myinverse.put';
execute 'gams inverse2';
parameter ainv(i,j)
execute_load 'mygdx.gdx', ainv;
display ainv;


$ontext
#user model library stuff
Main topic Linking to other programs
Featured item 1 GDX
Featured item 2 GAMS to GAMS
Featured item 3 Execute_Load
Featured item 4 Compiled program
include (inverse2.gms,invert1.exe)
Description
Matrix inversion through passed put and loaded GDX file
Illustrates GAMS call to GAMS
$offtext
