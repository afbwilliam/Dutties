$ontext
This program compares the data of symbols with the same name,
type and dimension in two GDX files and writes the differences
to a third GDX file. A summary report will be written to standard
output.

$offtext

$include trnsport.gms

solve transport using lp minimizing z ;
execute_unload 'case1.gdx',a,x;
a('seattle') = 1.2 * a('seattle');
solve transport using lp minimizing z ;
execute_unload 'case2.gdx',a,x;
execute 'gdxdiff case1 case2 diffile > %system.nullfile%';
set difftags /dif1,dif2,ins1,ins2/;
variable xdif(i,j,difftags);
execute_load 'diffile' xdif=x;
display xdif.L;
