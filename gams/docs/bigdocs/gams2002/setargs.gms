*illustrate use of setargs

scalar a /2/, b /4/, c ,d  ;
$batinclude batincsag c a b
$batinclude batincsag d a c
$batinclude batincsag d "a+b-d*a" "c*sqrt(abs(a+1))"

$ontext
#user model library stuff
Main topic Include
Featured item 1 Batinclude
Featured item 2 Argument use
Featured item 3
Description
Bat include argument example


$offtext
