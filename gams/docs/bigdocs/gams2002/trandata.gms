$ontext

Small data set for transport model
illustrate include procedure along with tranint.gms
also used to illustrate save restart


$offtext
SETS  PLANT    PLANT LOCATIONS  /NEWYORK  , CHICAGO , LOSANGLS /
      MARKET   DEMAND MARKETS   /MIAMI,   HOUSTON, MINEPLIS, PORTLAND/
PARAMETERS   SUPPLY(PLANT)  QUANTITY AVAILABLE AT EACH PLANT
                /NEWYORK   100, CHICAGO   275, LOSANGLS   90/
             DEMAND(MARKET)   QUANTITY REQUIRED BY DEMAND MARKET
                /MIAMI 100,HOUSTON 90,MINEPLIS 120,PORTLAND 90/;
 TABLE   DISTANCE(PLANT,MARKET)   DISTANCE FROM EACH PLANT TO EACH MARKET
                     MIAMI   HOUSTON   MINEPLIS   PORTLAND
         NEWYORK      1300     1800       1100       3600
         CHICAGO      2200     1300        700       2900
         LOSANGLS     3700     2400       2500       1100      ;

$ontext
#user model library stuff
Main topic Report writing
Featured item 1 Include
Featured item 2 Save restart
include (tranint.gms,tranrept.gms,tranmodl.gms)
Description
Data part of transport model
illustrate include procedure along with tranint.gms
Also used to illustrate save restart

$offtext
