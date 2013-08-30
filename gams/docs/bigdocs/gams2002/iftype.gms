*illustrate conditional compile based on item type

set itemname;
$if acrtype itemname  display "itemname is an acronym";
$if equtype itemname  display "itemname is an equation";
$if funtype itemname  display "itemname is a GAMS function";
$if modtype itemname  display "itemname is an model";
$if filtype itemname  display "itemname is a local name for a put file";
$if partype itemname  display "itemname is a parameter";
$if settype itemname  display "itemname is a set";
$if vartype itemname  display "itemname is a variable";

$if xxxtype itemname  display "itemname is a xxx";
$if pretype itemname  display "itemname is a pre";
$if protype itemname  display "itemname is a pro";

set aset;
acronym acro;
$batinclude iftypeinc aset
$batinclude iftypeinc acro
$batinclude iftypeinc sqrt


*$dispnr;
*$dmpcmpl
*$dmpmap
*$dmplim
*$dmpunits
*$tabteston
*$tabtestoff
*$domteston
*$domtestoff


$ontext
#user model library stuff
Main topic  Conditional compile
Featured item 1  $If
Featured item 2  Item type
Featured item 3  Settype
Featured item 4  Partype
Description
Illustrate conditional compile based on item type
$offtext
