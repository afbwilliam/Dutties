*Illustrate use of sameas function

Set         cityI         / "new york", Chicago, boston/;
Set         cityj         /boston/;
Scalar ciz,cir,cirr;
ciZ=sum(sameas(cityI,cityj),1);
ciR=sum((cityI,cityj)$ sameas(cityI,cityj),1);
ciRR=sum(sameas(cityI,"new york"),1);

$ontext
#user model library stuff
Main topic  Set
Featured item 1 Sameas
Featured item 2 Conditionals
Featured item 3 Element equivalence
Featured item 4
Description
Illustrate use of sameas function
$offtext
