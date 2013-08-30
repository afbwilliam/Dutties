*Illustrate tuple use

SETS  PLANT    PLANT LOCATIONS
                /NEWYORK, CHICAGO, LOSANGLS/
      MARKET   DEMAND MARKETS
                /MIAMI,   HOUSTON, MINEPLIS, PORTLAND/

PARAMETERS   SUPPLY(PLANT)  QUANTITY AVAILABLE AT EACH PLANT
                /NEWYORK     0, CHICAGO    75, LOSANGLS   90/
             DEMAND(MARKET)   QUANTITY REQUIRED BY DEMAND MARKET
                /MIAMI      30, HOUSTON    75,
                 MINEPLIS   60, PORTLAND    0/;

 TABLE   DISTANCE(PLANT,MARKET)   DISTANCE FROM EACH PLANT TO EACH MARKET

                     MIAMI      HOUSTON     MINEPLIS     PORTLAND
         NEWYORK       3           7           6
         CHICAGO       9          11           3            13
         LOSANGLS     17           6          13             7;


 PARAMETER COST(PLANT,MARKET)    CALCULATED COST OF MOVING GOODS;
           COST(PLANT,MARKET) = 5 + 5 * DISTANCE(PLANT,MARKET);

 POSITIVE VARIABLES
         SHIPMENTS(PLANT,MARKET) AMOUNT SHIPPED OVER A TRANSPORT ROUTE;
 VARIABLES
         TCOST                   TOTAL COST OF SHIPPING OVER ALL ROUTES;
 EQUATIONS
         TCOSTEQ                 TOTAL COST ACCOUNTING EQUATION
         SUPPLYEQ(PLANT)         LIMIT ON SUPPLY AVAILABLE AT A PLANT
         DEMANDEQ(MARKET)        MINIMUM REQUIREMENT AT A DEMAND MARKET;

 TCOSTEQ..         TCOST =E= SUM((PLANT,MARKET)
                                $(    supply(plant)
                                  and demand(market)
                                  and distance(plant,market))
                                 , SHIPMENTS(PLANT,MARKET)*
                                   COST(PLANT,MARKET));

 SUPPLYEQ(PLANT).. SUM(MARKET$(    supply(plant)
                                  and demand(market)
                                  and distance(plant,market))
                                ,SHIPMENTS(PLANT, MARKET))
                                 =L= SUPPLY(PLANT);

 DEMANDEQ(MARKET)..  SUM(PLANT$(    supply(plant)
                                  and demand(market)
                                  and distance(plant,market))
                                ,  SHIPMENTS(PLANT, MARKET))
                                  =G= DEMAND(MARKET);

 MODEL TRANSPORT /tcosteq,supplyeq,demandeq/;
 SOLVE TRANSPORT USING LP MINIMIZING TCOST;

*define the tuple
  set thistuple(plant,market) tuple expressing conditional;
         thistuple(plant,market)$(    supply(plant)
                              and demand(market)
                              and distance(plant,market))
                  =yes;

 EQUATIONS
         TCOSTEQ2                 TOTAL COST ACCOUNTING EQUATION
         SUPPLYEQ2(PLANT)         LIMIT ON SUPPLY AVAILABLE AT A PLANT
         DEMANDEQ2(MARKET)        MINIMUM REQUIREMENT AT A DEMAND MARKET;

*use the uple instead of the $ conditions

*here note both plant and market are varied
 TCOSTEQ2..         TCOST =E= SUM(thistuple(PLANT,MARKET)
                                 , SHIPMENTS(PLANT,MARKET)*
                                   COST(PLANT,MARKET));

*here note just market is varied in the sum but plant is controlled in the
*equation definition

 SUPPLYEQ2(PLANT).. SUM(thistuple(plant,MARKET)
                                ,SHIPMENTS(PLANT, MARKET))
                                 =L= SUPPLY(PLANT);

*here note just plant is varied in the sum but market is controlled in the
*equation definition
 DEMANDEQ2(MARKET)..  SUM(thistuple(plant,MARKET)
                                ,  SHIPMENTS(PLANT, MARKET))
                                  =G= DEMAND(MARKET);
 MODEL TRANSPORT2 /tcosteq2,supplyeq2,demandeq2/;
 SOLVE TRANSPORT2 USING LP MINIMIZING TCOST;

$ontext
#user model library stuff
Main topic Set
Featured item 1 Tuples
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate tuple use

$offtext
