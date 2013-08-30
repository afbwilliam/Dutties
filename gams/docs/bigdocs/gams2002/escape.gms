*illustrate use of $escape

$set tt DOIT
$ondollar
* remember the order in which gams processes the input file
* 1. preprocess NON comment lines only  *  $ontext
* 2. make substitutions - once only left to right
* 3. interpret line
*
* (a)this will NOT be touched  %tt%
* I can force substitution on a comment line by making a dummy $if
* $if '' == '' * now we will make substitutions %tt%
$if '' == '' * (b) now we WILL make substitutions %tt%
display "first %tt%";
display "second %&tt%&";
file it
put it
put "display one ", "%system.date%" /;
put "display two " "%&system.date%&"/;
* $escape x will convert the symbol %x into %
$escape &
display "third %tt%";
display "fourth %&tt%&";
put "display third ", "%system.date%" /;
put "display fourth " "%&system.date%&"/;
$if '' == '' * (c) now we will NOT make substitutions %&tt%&
* $escape % will reset everything
$escape %
$if '' == '' * (d) now we WILL make substitutions %tt%
display "fifth %tt%";
display "sixth %&tt%&";
put "display fifth ", "%system.date%" /;
put "display sixth " "%&system.date%&"/;

$ontext
#user model library stuff
Main topic Dollar commands
Featured item 1 $Escape
Featured item 2 $
Featured item 3 Rename $
Featured item 4
Description
illustrate use of $escape

$offtext
