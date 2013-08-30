*main program for batinclude example
scalar a /2/, b /4/, c ,d  ;
$batinclude batincadd c a b
$batinclude batincadd d a c
$batinclude batincadd d "a+b-d*a" "c*sqrt(abs(a+1))"
$batinclude batincadd2 d a c "text for the display"
$ontext
#user model library stuff
Main topic Include
Featured item 1 Batinclude
Featured item 2
Featured item 3
Description
Illustrates use of batinclude and how functions inclluded can be dramatically
changed
$offtext
