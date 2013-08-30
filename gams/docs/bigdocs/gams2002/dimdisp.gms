$hidden testing dimension of parameter passed in %1
$if dimension  0 %1 display '%1 is 0 dimensional',%1;
$if dimension  1 %1 display '%1 is 1 dimensional',%1;
$if dimension  2 %1 option %1:0:1:1;display '%1 is  2 dimensional',%1;
$if dimension  3 %1 option %1:0:1:2;display '%1 is  3 dimensional',%1;
$if dimension  4 %1 option %1:0:1:3;display '%1 is  4 dimensional',%1;
$if dimension  5 %1 option %1:0:1:4;display '%1 is  5 dimensional',%1;
$if dimension  6 %1 option %1:0:2:4;display '%1 is  6 dimensional',%1;
$if dimension  7 %1 option %1:0:2:5;display '%1 is  7 dimensional',%1;
$if dimension  8 %1 option %1:0:2:6;display '%1 is  8 dimensional',%1;
$if dimension  9 %1 option %1:0:2:7;display '%1 is  9 dimensional',%1;
$if dimension 10 %1 option %1:0:2:8;display '%1 is 10 dimensional',%1;

$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 $If dimension
Featured item 2 Batinclude
Featured item 3
Featured item 4
Description

testing dimension of parameter passed in %1
include (basicif.gms)
$offtext
