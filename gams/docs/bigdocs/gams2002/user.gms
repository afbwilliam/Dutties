*illustrate user defined items

$setglobal nonlin no
*following allows command line control of program by running a command like
*   gams user user1=nonlinear
*  or putting user1=nonlinear in   parameter box in ide
*can use user1 through user5
$if not "%gams.user1%" == "nonlinear" $goto arond
scalar amhere;
$setglobal nonlin yes
$label arond
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
Main topic Command line
Featured item 1 User1
Featured item 2 User2
Featured item 3
Featured item 4
Description
Illustrate user defined items

$offtext
