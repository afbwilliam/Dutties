*Illustrate conditional copile switch from lp to nlp model

$setglobal nonlin yes
*$setglobal nonlin no
variables            z   objective
positive variables   x   decision variables;
equations            obj
                     xlim;
$if "%nonlin%" == "yes" $goto nonlin
        obj..   z=e=3*x;
$goto around
$label nonlin
        obj..   z=e=3*x-3*x**2;
$label around
        xlim..   x=l=4;
model cond /all/;
$if "%nonlin%" == "yes" solve cond using nlp maximizing z;
$if not "%nonlin%" == "yes" solve cond using lp maximizing z;

$ontext
#user model library stuff
Main topic  Conditional compile
Featured item 1 $If
Featured item 2 $Set
Featured item 3 $Goto
Featured item 4 $Label
Description
Illustrate conditional copile switch from lp to nlp model
Note abort is like display
$offtext
