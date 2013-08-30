$ontext

Display part of transport model

Used in save restart as follows

GAMS trandata                  s=s1
GAMS tranmodl        r=s1      s=s2
GAMS tranrept        r=s2      s=s1
GAMS trandisp        r=s1  (note reuse of name)

$offtext
OPTION DECIMALS=0;
DISPLAY MOVEMENT,COSTS;
OPTION DECIMALS=2;
DISPLAY DEMANDREP, CMOVEMENT, shipments.l;

$ontext
#user model library stuff
Main topic Output
Featured item 1  Save restart
Featured item 2  Display
Featured item 3
Featured item 4
Description
Display part of transport model

Used in save restart as follows

GAMS trandata                  s=s1
GAMS tranmodl        r=s1      s=s2
GAMS tranrept        r=s2      s=s1
GAMS trandisp        r=s1  (note reuse of name)

$offtext
