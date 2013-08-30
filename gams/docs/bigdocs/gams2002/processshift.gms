*Illustrate action of shift command
*This is batincluded by shift.gms

$label top
$if a%1==a $goto done
display "argument 1 is now" , "%1";
$log this is working on %1
$shift
$goto top
$label done

$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 $Shift
Featured item 2
Featured item 3
Featured item 4
include processshift.gms
Description
Illustrate action of shift command
This is batincluded by shift.gms

$offtext
