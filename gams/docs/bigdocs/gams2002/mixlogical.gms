*this illustrates mixing numbers, sets and logical expressions

scalar x,z;
X=1;
z = 100*(x < 4) + ( 3 < 3);
display z;
z = (x < 4) or ( 3 < 3);
display z;
set i /i1,i2/
set j(i);
j(i)=x+1;
display j     ;
j(i)=yes;
parameter zz(i);
zz(i)=j(i)*100;
display zz;


$ontext
#user model library stuff
Main topic Computations
Featured item 1 =
Featured item 2 Logical expression
Featured item 3 Mixed mode
Featured item 4
Description
Illustrates mixing numbers, sets and logical expressions
$offtext
