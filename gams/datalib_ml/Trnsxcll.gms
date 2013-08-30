$ontext
#this text entry documents file and allows automatic
#building of mccarl advanced class model library file
Notebook Section Linkage to Programs
GAMS Points   GAMS as Slave
other  Spreadsheet
include trnsxcll.xls
description
This Transportation Model text is implemented in conjuction with an Excel workbook

The worksheet writes the files included below named:
            supply.set
            demand.set
            supply.dat
            demand.dat
            distance.dat
            tran.dat
This code sends back solution in output.csv
$offtext
SETS
       Supply     Locations of supply points
/
$INCLUDE supply.set
/
       Demand     Location of Demand markets
/
$INCLUDE demand.set
/;

PARAMETERS
      Available(supply)  Supply available in cases
/
$ONDELIM
$INCLUDE supply.tbl
$OFFDELIM
/

       Needed(demand)  demand requirement in cases
/
$ONDELIM
$INCLUDE demand.tbl
$OFFDELIM
/ ;

TABLE Distance(supply,demand)  distance in thousands of miles
$ONDELIM
$INCLUDE distance.tbl
$OFFDELIM
        ;

set tranparm parameters of transport rate function
    /fixed
     permile/

parameter tranrate(tranparm) transport rate data /
$ONDELIM
$INCLUDE tranrate.tbl
$OFFDELIM
  /      ;

PARAMETER Cost(supply,demand)  transport cost in thousands of dollars per case ;
        Cost(supply,demand) = tranrate("Fixed")
                            + tranrate("permile") * Distance(supply,demand) / 1000 ;

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
put "modelstat" transport.modelstat;
PUTCLOSE csv;
