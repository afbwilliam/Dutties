*Timing of $ commands

set i /i1,i2/
$onmulti
parameter a(i) /i1 22, i2 33/;
display a;
parameter a/i1 44/;
display a;
a(i)=a(i)*2;
display a;

$ontext
#user model library stuff
Main topic Dollar commands
Featured item 1 $
Featured item 2 Time during GAMS runs
Featured item 3
Featured item 4
Description
Timing of $ commands
$offtext
