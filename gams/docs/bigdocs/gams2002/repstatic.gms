$ontext

Model illustrating repeated static calculations features

$offtext

SCALAR LAND /100/;
PARAMETER SAVELAND;
SAVELAND = LAND;
SET LANDCHANGE  SCENARIOS FOR CHANGES IN LAND/R1,R2,R3/
PARAMETER VALUE(LANDCHANGE) PERCENT CHANGE IN LAND
        /R1 +10 , R2 + 20 , R3 +30/
LOOP ( LANDCHANGE,
       LAND = LAND * (1 + VALUE ( LANDCHANGE ) / 100. )
       display "without reset" ,land);
LOOP ( LANDCHANGE,
      LAND=saveLAND*(1+VALUE ( LANDCHANGE ) / 100. )
      display "based on saveland" ,land);
LOOP ( LANDCHANGE,
      LAND=saveLAND;
      LAND=LAND*(1+VALUE ( LANDCHANGE ) / 100. )
      display "based on saveland" ,land);

$ontext
#user model library stuff
Main topic Calculations
Featured item 1 Repeated static
Description
Illustrate repeated static calculations features

$offtext
