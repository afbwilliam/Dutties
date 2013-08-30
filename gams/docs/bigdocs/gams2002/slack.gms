$ontext
Includes slacks in standard GAMS output
$offtext

option limrow=0;option limcol=0;
SET   CROP    Crops produced /Corn,Soybeans,Wheat/
      RESOURCE  TYPES OF RESOURCES   /Land,"Spring Labor","Fall Labor"/;
PARAMETER PRICE(crop)      PRODUCT PRICES BY PROCESS
           /Corn 2.10,soybeans 5.50,wheat 3.75/
        Yield(crop)  yields per unit of the crop
           /Corn 140,soybeans 45,wheat 58/
        PRODCOST(crop)     COST BY crop
           /Corn 150,soybeans 115,wheat 90/
        RESORAVAIL(RESOURCE)  RESOURCE AVAILABLITY
           /land 800 ,"Spring labor" 4800, "Fall Labor" 3300/;
TABLE RESOURUSE(RESOURCE,crop) RESOURCE USAGE
                                 Corn  Soybeans Wheat
                Land               1     1        1
                "Spring Labor"     5     2.9      0.5
                "fall Labor"       5.5   3        2;
set terms resource hiring
          /maxavailable  maximum available
           cost          cost per unit hired/
Table hireterm(resource,terms)  hired resource terms
                                maxavailable  cost
                Land               100        90
                "Spring Labor"    1500        10
                "fall Labor"       500         8   ;
POSITIVE VARIABLES PRODUCTION(crop) Acres PRODUCED BY Crop
                   sales(crop)      crop sales
                   hire(resource)   resource hiring above farm endowment
                   ;
VARIABLES          PROFIT              TOTALPROFIT;
EQUATIONS          OBJT OBJECTIVE FUNCTION ( PROFIT )
                   AVAILABLE(RESOURCE) RESOURCES AVAILABLE
                   croponhand(crop)    crop production - sales balance
                   resourmax(resource) hired resource maximum;

OBJT.. PROFIT=E=   SUM(crop,sales(crop)*price(crop)
                           -PRODCOST(crop)*PRODUCTION(crop))
              -sum(resource,hire(resource)*hireterm(resource,"cost"));
CROPONHAND(CROP).. sales(crop)=L= YIELD(CROP)*PRODUCTION(crop);
AVAILABLE(RESOURCE).. SUM(crop,RESOURUSE(RESOURCE,crop)
                     *PRODUCTION(CROP))-hire(resource)
                    =L= RESORAVAIL(RESOURCE);
resourmax(resource)..  hire(resource)
                      =L=hireterm(resource,"MAXAVAILABLE");
MODEL RESALLOC /ALL/;
SOLVE RESALLOC USING LP MAXIMIZING PROFIT;
OPTION SOLSLACK=1;
SOLVE RESALLOC USING LP MAXIMIZING PROFIT;

$ontext
Description
Includes slacks in standard GAMS output
Notebook Section Output
GAMS Points Slack Variables
other Solslack
include
$offtext
