$ontext

Illustration of Bad model file format

$offtext

Sets  products  available production process / low uses a low amount of new materials,   medium uses a medium amount of new materials, high uses a high amount of new materials/
rawmateral    source of raw materials  / scrap, new /
 Quarters    long horizon   / spring, summer, fall ,winter /
quarter(Quarters) short horizon  / spring, summer, fall /
 Table  usage(rawmateral,products)  input coefficients
          low  medium  high
 scrap      5     3      1
 new        1     2      3
 Table  expectprof(products,quarters)  expected profits
         spring summer fall
 low        25    20    10
 medium     50    50    50
 high       75    80   100
set inputitem miscdata input items
    / max-stock, store-cost, endinv-value  /
Table  miscdata(inputitem,rawmateral)  miscelaneous production data
                 scrap new
 max-stock        400  275
 store-cost       .5    2
 endinv-value     15   25           ;
 Scalar mxcapacity maximum production capacity/ 40 /;
 Variables  production(products,Quarters)  production and sales
 openstock(rawmateral,Quarters)  opening stocks, profit ;
 Positive variables production, openstock;
 Equations  capacity(quarter)     capacity constarint,        stockbalan(rawmateral,Quarters) stock balance, profitacct  profit definition ;
 capacity(quarter).. sum(products, production(products,quarter)) =l= mxcapacity;
 stockbalan(rawmateral,Quarters+1)..     openstock(rawmateral,
Quarters+1) =e=   openstock(rawmateral,Quarters)- sum(products, usage(rawmateral,products)  *production(products,Quarters));
 profitacct.. profit =e= sum(quarter, sum(products, expectprof(
products,quarter) *production(products,quarter))-sum(
rawmateral,miscdata("store-cost",rawmateral)*openstock(rawmateral
,quarter)))+ sum(rawmateral, miscdata("endinv-value",rawmateral)  *openstock(rawmateral,"winter"));
 openstock.up(rawmateral,"spring")=miscdata("max-stock",rawmateral);
 Model robert / all /
 Solve robert maximizing profit using lp;
$ontext
#user model library stuff
Main topic Good Modeling
Featured item 1 Typing
Featured item 2
Featured item 3
Description
Illustration of Bad model file format

$offtext
