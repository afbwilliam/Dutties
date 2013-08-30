$ontext

 GAMS as Slave  to Excel
Model as set up before using GDXXRW

$offtext
SETS   Supply     Locations of supply points
       /WASHINGTON,    COLORADO/
       Demand     Location of Demand markets
      / CALIFORNIA,    UTAH      ,    MONTANA/;

set tranparm parameters of transport rate function  /fixed, permile/
PARAMETERS   Available(supply)  Supply available in cases
                 /WASHINGTON 200.000,    COLORADO   700.000 /
             Needed(demand)  demand requirement in cases
                /CALIFORNIA 400.000, UTAH 100.000, MONTANA 400.000/
             tranrate(tranparm) transport rate data
                /fixed   1500.000,    permile 1500.000 /;
table        Distance(supply,demand)  distance in thousands of miles
                              CALIFORNIA        UTAH     MONTANA

                  WASHINGTON      20.000       1.100       0.800
                  COLORADO         1.400       0.600       0.700;
PARAMETER Cost(supply,demand)  transport cost in thousands of dollars per case ;
        Cost(supply,demand) = tranrate("Fixed")
                            + tranrate("permile") * Distance(supply,demand) / 1000 ;
positive VARIABLES    ship(supply,demand)  shipment quantities in cases
variable              Z       total transportation costs in thousands of dollars ;
EQUATIONS             COSTacct            define objective function
                      SUPPLYbal(supply)   observe supply limits at sources
                      DEMANDbal(demand)   satisfy demand requirements at markets ;
COSTacct ..        Z  =E=  SUM((supply,demand), Cost(supply,demand)*ship(supply,demand)) ;
SUPPLYbal(supply) ..   SUM(demand, ship(supply,demand))  =L=  Available(supply) ;
DEMANDbal(demand) ..   SUM(supply, ship(supply,demand))  =G=  needed(demand) ;
MODEL TRANSPORT /ALL/ ;
SOLVE TRANSPORT USING LP MINIMIZING Z ;
parameter misc(*);
misc("cost")=z.l;
misc("modelstat")=transport.modelstat;
display misc;

$ontext
#user model library stuff
Main topic Excel in charge
Featured item 1 GAMS model
Featured item 2
Featured item 3
Featured item 4
Description
 GAMS as Slave  to Excel
Model as set up before using GDXXRW

$offtext
