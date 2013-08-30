$ontext

 GAMS as Slave  to Excel

$offtext
SETS   Supply     Locations of supply points
       Demand     Location of Demand markets;
$CALL 'GDXXRW EXCELincharge.XLS skipempty=0 trace=2 index=inputs!g10'
$gdxin excelincharge.gdx
$load supply demand
display supply,demand;
set tranparm parameters of transport rate function  /fixed, permile/
PARAMETERS   Available(supply)  Supply available in cases
             Needed(demand)  demand requirement in cases
             Distance(supply,demand)  distance in thousands of miles
             tranrate(tranparm) transport rate data;
$load available needed distance tranrate
$gdxin
display available, needed, distance,tranrate
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
execute_unload 'excelincharge.gdx',ship,  supplybal, demandbal, misc;
execute 'GDXXRW EXCElincharge.gdx skipempty=0 zeroout=0 trace=2 index=results!e1'

$ontext
#user model library stuff
Main topic GAMS in Charge
Featured item 1 Spreadsheet
Featured item 2 GAMS not in charge
Featured item 3
Featured item 4
include excelincharge.xls , excelincharge.gdx
Description
GAMS file for GAMS not in charge example

$offtext
