$ontext

Middle part of transport model
illustrate includes
also used to illustrate save restart

$offtext
PARAMETER COST(PLANT,MARKET)    CALCULATED COST OF MOVING GOODS;
           COST(PLANT,MARKET) = 50 + 1 * DISTANCE(PLANT,MARKET);
 POSITIVE VARIABLES
         SHIPMENTS(PLANT,MARKET) AMOUNT SHIPPED OVER A TRANSPORT ROUTE;
 VARIABLES TCOST                 TOTAL COST OF SHIPPING OVER ALL ROUTES;
 EQUATIONS TCOSTEQ               TOTAL COST ACCOUNTING EQUATION
           SUPPLYEQ(PLANT)       LIMIT ON SUPPLY AVAILABLE AT A PLANT
           DEMANDEQ(MARKET)      MINIMUM REQUIREMENT AT A DEMAND MARKET;
 TCOSTEQ.. TCOST =E=SUM((PLANT,MARKET), SHIPMENTS(PLANT,MARKET)*
                                               COST(PLANT,MARKET));
 SUPPLYEQ(PLANT).. SUM(MARKET,SHIPMENTS(PLANT,MARKET))=L=SUPPLY(PLANT);
 DEMANDEQ(MARKET)..SUM(PLANT,SHIPMENTS(PLANT,MARKET))=G=DEMAND(MARKET);
 MODEL TRANSPORT /ALL/;
 SOLVE TRANSPORT USING LP MINIMIZING TCOST;

$ontext
#user model library stuff
Main topic Model
Featured item 1 Include
Featured item 2  Save restart
include (tranint.gms,trandata.gms,tranrept.gms)
Description
Model definition part of transport model
illustrate include procedure along with tranint.gms
also used to illustrate save restart

$offtext
