*Illustrate timing of a $include

scalar a /1/;
file toinc /toinclude.gms/;
put toinc,'a=5;' /;
$include toinclude
display a;

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate timing of a $include
$offtext
