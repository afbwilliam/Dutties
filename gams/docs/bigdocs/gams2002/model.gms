*illustrate variable,equation and model declaration
OPTION LIMROW =2;
OPTION LIMCOL = 2;
OPTION SOLSLACK = 1;

SETS  SUPPLYL     SUPPLY LOCATIONS      /S1,S2/
      WAREHOUSE   WAREHOUSE LOCATIONS   /A,B,C/
      MARKET      DEMAND MARKETS        /D1,D2/
      CATEGORY    WAREHOUSE DATA        /COST,CAPACITY,LIFE/

PARAMETERS   SUPPLY(SUPPLYL)  QUANTITY AVAILABLE AT EACH SUPPLY POINT
              /S1 50, S2   75/
             DEMAND(MARKET)   QUANTITY REQUIRED BY DEMAND MARKET
                         / D1 75, D2 50/

 TABLE   COSTSM(SUPPLYL,MARKET)   COST FROM SUPPLY LOCATION TO MARKET
                     D1      D2
             S1      4        8
             S2      7        6   ;

 TABLE   COSTSW(SUPPLYL,WAREHOUSE)   COST FROM SUPPLY LOCATION TO WAREHOUSE
                     A       B      C
             S1      1       2      8
             S2      6       3      1  ;

 TABLE   COSTWM(WAREHOUSE,MARKET)   COST FROM WAREHOUSE TO MARKET
                     D1      D2
             A       4        6
             B       3        4
             C       5        3   ;

  TABLE DATAW(WAREHOUSE,CATEGORY)   DATA FOR WAREHOUSES
                COST   CAPACITY   LIFE
       A        500     999        10
       B        720      60        12
       C        680      70        10

 Variables
         Tcost                     Total Cost Of Shipping Over All Routes;
 Binary Variables
         Build(Warehouse)          Warehouse Construction Variables
 Positive Variables
         Shipsw(Supplyl,Warehouse) Amount Shipped To Warehouse
            /S1.a.l 5/
         Shipwm(Warehouse,Market)  Amount Shipped From Warehouse
 Nonnegative Variables
         Shipsm(Supplyl,Market)    Amount Shipped Direct To Demand
;
Semicont Variables
        X,y,z;

 EQUATIONS
         TCOSTEQ                 TOTAL COST ACCOUNTING EQUATION
         SUPPLYEQ(SUPPLYL)       LIMIT ON SUPPLY AVAILABLE AT A SUPPLY POINT
         DEMANDEQ(MARKET)        MINIMUM REQUIREMENT AT A DEMAND MARKET
         BALANCE(WAREHOUSE)      WAREHOUSE SUPPLY DEMAND BALANCE
         CAPACITY(WAREHOUSE)     WAREHOUSE CAPACITY
             /a.scale 50,a.l 10,b.m 20/
         CONFIGURE               ONLY ONE WAREHOUSE;

       Shipsw.up(Supplyl,Warehouse)=1000;
       Shipwm.scale(Warehouse,Market)=50;
       Shipsm.lo(Supplyl,Market)$(ord(supplyl) eq 1 and
                                            ord(market) eq 1)=1;


 TCOSTEQ..
  TCOST =E=
  SUM(WAREHOUSE,
        DATAW(WAREHOUSE,"COST")/DATAW(WAREHOUSE,"LIFE")*BUILD(WAREHOUSE))
 +SUM((SUPPLYL,MARKET)   ,SHIPSM(SUPPLYL,MARKET)   *COSTSM(SUPPLYL,MARKET))
 +SUM((SUPPLYL,WAREHOUSE),SHIPSW(SUPPLYL,WAREHOUSE)*COSTSW(SUPPLYL,WAREHOUSE))
 +SUM((WAREHOUSE,MARKET) ,SHIPWM(WAREHOUSE,MARKET) *COSTWM(WAREHOUSE,MARKET));

 SUPPLYEQ(SUPPLYL)..    SUM(MARKET, SHIPSM(SUPPLYL, MARKET))
                      + SUM(WAREHOUSE,SHIPSW(SUPPLYL,WAREHOUSE))
                       =L= SUPPLY(SUPPLYL);

 DEMANDEQ(MARKET)..    SUM(SUPPLYL, SHIPSM(SUPPLYL, MARKET))
                    +  SUM(WAREHOUSE, SHIPWM(WAREHOUSE, MARKET))
                       =G= DEMAND(MARKET);

 BALANCE(WAREHOUSE)..    SUM(MARKET, SHIPWM(WAREHOUSE, MARKET))
                       - SUM(SUPPLYL,SHIPSW(SUPPLYL,WAREHOUSE))
                       =L= 0;

 CAPACITY(WAREHOUSE)..  SUM(MARKET, SHIPWM(WAREHOUSE, MARKET))
                       -BUILD(WAREHOUSE)*DATAW(WAREHOUSE,"CAPACITY")
                       =L= 0 ;

 CONFIGURE..            SUM(WAREHOUSE,BUILD(WAREHOUSE)) =L= 1;


 MODEL WAREHOUSEL Warehouse location model /ALL/;
 SOLVE WAREHOUSEL USING MIP MINIMIZING TCOST;
 scalar totalship    sum of all shipments;
 totalship=
    SUM((SUPPLYL,MARKET)   ,SHIPSM.L(SUPPLYL,MARKET))
   +SUM((SUPPLYL,WAREHOUSE),SHIPSW.L(SUPPLYL,WAREHOUSE))
   +SUM((WAREHOUSE,MARKET) ,SHIPWM.L(WAREHOUSE,MARKET));
 parameter marg(supplyl) shadow prices on supply;
 SUPPLYEQ.scale(SUPPLYL)=33;
 marg(supplyl)=SUPPLYEQ.m(SUPPLYL);
 MODEL WAREHOUSEL2 Warehouse location model
      /TCOSTEQ,SUPPLYEQ,DEMANDEQ,BALANCE,CAPACITY,CONFIGURE/;
 SOLVE WAREHOUSEL2 USING MIP MINIMIZING TCOST;
 Model        one         first model                             / TCOSTEQ,SUPPLYEQ,DEMANDEQ /
              two         second model that nests first           / one, balance /
              three       third model that nests first and second / two, capacity,configure /
              four        fourth model that includes what is in model one and three / one+three /
              five        fifth model includes equations in WAREHOUSEL2 but not those in model one / WAREHOUSEL2-one /
              six          sixth model includes those in model WAREHOUSEL2 but not equation configure/ WAREHOUSEL2-configure /



$ontext
#user model library stuff
Main topic Model setup
Featured item 1 Variable
Featured item 2 Model
Featured item 3 Equation
Featured item 4 Solve
Description
Illustrate variable,equation and model declaration

$offtext
