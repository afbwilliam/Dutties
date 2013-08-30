$ontext

GAMS as Slave

This Transportation Model text is implemented in conjuction with a Delphi program
rungams.exe as contained in  gamsrun.zip

The worksheet writes the files included below named:
            supplyset.csv
            demandset.csv
            supplydat.csv
            demanddat.csv
            distancedat.csv
This code sends back solution in output.csv
$offtext
SETS
       Supply     Locations of supply points
/
$INCLUDE supplyset.csv
/
       Demand     Location of Demand markets
/
$INCLUDE demandset.csv
/;

PARAMETERS
      Available(supply)  Supply available in cases
/
$ONDELIM
$INCLUDE supplytbl.csv
$OFFDELIM
/

       Needed(demand)  demand requirement in cases
/
$ONDELIM
$INCLUDE demandtbl.csv
$OFFDELIM
/ ;

TABLE Distance(supply,demand)  distance in thousands of miles
$ONDELIM
$INCLUDE distancetbl.csv
$OFFDELIM
        ;


PARAMETER Cost(supply,demand)  transport cost in thousands of dollars per case ;
        Cost(supply,demand) = 100
                            + 100* Distance(supply,demand) / 1000 ;

positive VARIABLES
               ship(supply,demand)  shipment quantities in cases
variable
               Z       total transportation costs in thousands of dollars ;

EQUATIONS
               COSTacct            define objective function
               SUPPLYbal(supply)   observe supply limits at sources
               DEMANDbal(demand)   satisfy demand requirements at markets ;

COSTacct ..        Z  =E=  SUM((supply,demand), Cost(supply,demand)*ship(supply,demand)) ;

SUPPLYbal(supply) ..   SUM(demand, ship(supply,demand))  =L=  Available(supply) ;

DEMANDbal(demand) ..   SUM(supply, ship(supply,demand))  =G=  needed(demand) ;

MODEL TRANSPORT /ALL/ ;


SOLVE TRANSPORT USING LP MINIMIZING Z ;

*       Output data to ascii csv file
FILE csv Report File /output.csv        /;
csv.pc = 5;
PUT csv;
PUT 'PLANT','MARKET','CASES' /;
LOOP((supply,demand),
      PUT supply.tl, demand.tl, ship.l(supply,demand):10:0 /;
);
LOOP(supply,
     PUT supply.tl, supplybal.m(supply):10:4 /;
);
LOOP(demand,
     PUT demand.tl, demandbal.m(demand):10:4 /;
);
put "cost",z.l /;
put "modelstat" transport.modelstat:5:0;
PUTCLOSE csv;

$ontext
#user model library stuff
Main topic Compiled program in charge
Featured item 1  Delphi
Featured item 2  Compiled program
Featured item 3
Featured item 4
include (gamsrun.exe,gamsrun.zip)
Description
GAMS as Slave

This Transportation Model text is implemented in conjuction with a Delphi program
rungams.exe
The worksheet writes the files included below named:
            supplyset.csv
            demandset.csv
            supplydat.csv
            demanddat.csv
            distancedat.csv
This code sends back solution in output.csv

$offtext
