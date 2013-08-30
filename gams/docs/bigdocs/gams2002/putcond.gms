*Illustrates batinclude of conditional compile routine outit
*that figures out item type then puts it

file at
put at
set a1 set to be put/item1 first,item2 second/
parameter r(a1) parameter to be put  /item1 5,item2 6/
$batinclude outit a1
$batinclude outit r

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 Batinclude
Featured item 3 File
Featured item 4
Description
Illustrates batinclude of conditional compile routine outit
that figures out item type then puts it
$offtext
