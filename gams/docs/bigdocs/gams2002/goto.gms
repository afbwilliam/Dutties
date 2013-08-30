*illustrate $goto and $label

scalar y /1/;
$setglobal gg
$if setglobal gg $goto yesgg
y=y+3;
display yy;
$label yesgg
*after yesgg
$if not setglobal gg $goto nogg
y=y/14;
display y;
$label nogg


$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1  $Goto
Featured item 2  $Label
Featured item 3  Goto
Featured item 4  Label
Description
illustrate $goto and $label
$offtext
