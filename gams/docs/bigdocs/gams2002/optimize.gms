*tutorial problem on optimization

VARIABLES             Z;
NonNegative Variables    Xcorn ,    Xwheat , Xcotton;
EQUATIONS     OBJ,  land ,  labor;
OBJ..  Z =E= 109 * Xcorn + 90 * Xwheat + 115 * Xcotton;
land..             Xcorn +      Xwheat +       Xcotton =L= 100;
labor..          6*Xcorn +  4 * Xwheat +  8  * Xcotton =L= 500;
MODEL farmPROBLEM /ALL/;
SOLVE farmPROBLEM USING LP MAXIMIZING Z;

$ontext
#user model library stuff
Main topic  Basic GAMS
Featured item 1 Basic GAMS
Featured item 2
Featured item 3
Featured item 4
include optimize.gms
Description
Tutorial problem on optimization
$offtext
