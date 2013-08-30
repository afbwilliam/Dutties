*Illustrate use of diag function
Set         cityI         / "new york", Chicago, boston/;
Set         cityj         /boston/;
Scalar ciz,cir,cirr;
ciZ=sum((cityi,cityj),diag(cityI,cityj));
ciRR=sum(cityi,diag (cityI,"new york"));

$ontext
#user model library stuff
Main topic  Set
Featured item 1 Diag
Featured item 2 Conditionals
Featured item 3 Element equivalence
Featured item 4
Description
Illustrate use of diag function
$offtext
