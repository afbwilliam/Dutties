$hidden batinclude file that tests item type for conditional compile

$if acrtype %1  display "%1 is an acronym";
$if equtype %1  display "%1 is an equation";
$if funtype %1  display "%1 is a GAMS function";
$if modtype %1  display "%1 is an model";
$if filtype %1  display "%1 is a local name for a put file";
$if partype %1  display "%1 is a parameter";
$if settype %1  display "%1 is a set";
$if vartype %1  display "%1 is a variable";

$if xxxtype %1  display "%1 is a xxx";
$if pretype %1  display "%1 is a pre";
$if protype %1  display "%1 is a pro";

$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 $If settype
Featured item 2 Batinclude
Featured item 3 $If settype
Featured item 4 $If type
Description
Uses $IF to figure out whether item is set, parameter etc
include calliftypeinc.gms
$offtext
