*Illustrate conditionals on sets
*examples start 50 lines below
*,ore are 70 lines below

$OFFSYMLIST OFFSYMXREF

OPTION LIMROW = 5
OPTION LIMCOL = 0
OPTION SOLSLACK=1;

 SET PERIODS TIME PERIODS ACCOUNTED FOR
          /QUARTER1, QUARTER2, QUARTER3,QUARTER4/

 ALIAS (PERIOD,PERIODS);

 PARAMETER
           PRICE(PERIOD)    PRICES BY TIME PERIOD
                             /QUARTER1 2.3, QUARTER2 2.5,
                              QUARTER3 2.7, QUARTER4 2.9/
           COSTHOLD(PERIOD) COST OF STORING FROM THIS PERIOD INTO NEXT
                             /QUARTER1 .1, QUARTER2 .2, QUARTER3 .3/
           CONSTR(PERIOD)   MAXIMUM AMOUNT THAT CAN BE SOLD BY PERIOD
                             /QUARTER1 50, QUARTER2 50,
                              QUARTER3 50, QUARTER4 50/
           MINSAL(PERIOD)   MINIMUM AMOUNT THAT CAN BE SOLD BY PERIOD
                             /QUARTER1 15, QUARTER2 5/
 SCALAR
            STORAGE         STORAGE CAPACITY AVAILABLE  /75/
            INVENTORY       INITIAL INVENTORY          /100/;

 POSITIVE VARIABLES
         SELL(PERIOD)       SALES BY PERIOD
         STORE(PERIOD)      STORAGE AT END OF PERIOD

 VARIABLES
         NETINCOME          PROFITS

 EQUATIONS
         OBJT                       OBJECTIVE FUNCTION(NETINCOME)
         FIRSTBAL(period)           STORAGE BALANCE FOR FIRST PERIOD
         INTERBAL(PERIOD)           STORAGE BALANCE FOR INTERMEDIATE PERIODS
         LASTBAL(period)            STORAGE BALANCE FOR LAST PERIOD
         CAPACITY                   STORAGE CAPACITY
         MAXSALE(PERIOD)            MAXIMUM SALES BY PERIOD
         MINSALE(PERIOD)            MINIMUM SALES BY PERIOD;

         OBJT.. NETINCOME =E=  SUM(PERIOD, SELL(PERIOD) * PRICE(PERIOD)
                              -            COSTHOLD(PERIOD) * STORE(PERIOD));
*condionals based on element positions
         FIRSTBAL(period)$(ord(period) eq 1)..
              SELL(period) + STORE(period) =L= INVENTORY;
*also use lags
         INTERBAL(PERIOD)$(ORD(PERIOD) GT 1
                           AND ORD(PERIOD) lt CARD(PERIOD))..
                 SELL(PERIOD) =L= STORE(PERIOD-1) - STORE(PERIOD);
         LASTBAL(PERIOD)$(ORD(PERIOD) eq CARD(PERIOD))..
                 SELL(PERIOD)=L= STORE(PERIOD-1);

         CAPACITY..  STORE("QUARTER1") =L= STORAGE;
         MINSALE(PERIOD).. SELL(PERIOD) =G= MINSAL(PERIOD);
         MAXSALE(PERIOD).. SELL(PERIOD)  =L= CONSTR(PERIOD);

 MODEL STOREIT /ALL/;

 SOLVE STOREIT USING LP MAXIMIZING NETINCOME;

scalar z /0/;
Scalar ciz,cir,cirr;


*************************************************


*conditionals based on set element position
    loop(period
         $(ORD(period) GT 1 and ORD(period) lt CARD(period)),
         Z=z+1;);

*conditionals based on the text for set elments names
    Set         allcity         / "new york", Chicago, boston,miami,orlando/;
    Set         cityI(allcity)  / "new york", Chicago, boston/;
    Set         cityj(allcity)  /boston/;
    ciZ=sum(sameas(cityI,cityj),1);
    ciR=sum((cityI,cityj)$ sameas(cityI,cityj),1);
    ciRR=sum(sameas(cityI,"new york"),1);
    ciZ=sum((cityi,cityj)$diag(cityI,cityj) ,1);
    ciRR=sum(cityi$diag(cityI,"new york"),1);

*conditionals based on whether elements in subsets or tuples are defined
    set         tuple(allcity,allcity)
                  /miami.("new york", Chicago),orlando.boston/;
    ciZ=sum((allcity,cityj)$cityi(allcity),1);
    ciZ$cityi("boston")=sum(allcity,1);
    loop((allcity,cityj)$tuple(allcity,cityj),
        ciz=ciz+ord(allcity)+ord(cityj)*100);
    if(cityj("boston"),ciz=1);

$ontext
#user model library stuff
Main topic Set
Featured item 1 Set
Featured item 2 Conditionals
Featured item 3 Tuple
Featured item 4 Lead lag
Description
Illustrate set based conditionals and leads and lags

$offtext
