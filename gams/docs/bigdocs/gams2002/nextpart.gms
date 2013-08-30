

TRANSCOST(PRODUCT,TYPE,PLANT,PLANTS)=TRANSCOST(PRODUCT,TYPE,PLANT,PLANTS)*2;
 SOLVE FIRM USING LP MAXIMIZING NETINCOME;

$ontext
#user model library stuff
Main topic Save restart
Featured item 1 Save
Featured item 2 Restart
Featured item 3
Featured item 4
include (seq.bat,frstpart.gms)
Description
Illustrates save and restart

Run with seq.bat or
         GAMS frstpart s=f1
         GAMS nextpart r=f1


$offtext
