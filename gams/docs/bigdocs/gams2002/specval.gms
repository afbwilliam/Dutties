*Illustrate use of special values in GAMS

scalar x /1/,y /0/,z;
z$y=x/y;
if(y =0,z=inf);
display z;

z$y=-x/y;
if(y =0,z=-inf);
display z;

z$y=x/y;
if(y =0,z=NA);
display z;

z$y=x/10000000000000;
if(y < 0.00001,z=EPS);
display z;

z=x/0000000000000;
display z;

$ontext
#user model library stuff
Main topic Calculations
Featured item 1 Special values
Featured item 2 Na
Featured item 3 Inf
Featured item 4 Eps
Description
Illustrate use of special values in GAMS
$offtext
