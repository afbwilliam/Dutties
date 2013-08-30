*Illustrate solslack
$OFFSYMLIST OFFSYMXREF
OPTION LIMROW=0;
OPTION LIMCOL=0;
OPTION SOLSLACK=1;

 SET    PROCESS       TYPES OF PRODUCTION PROCESSES
                          /FUNCTNORM , FUNCTMXSML , FUNCTMXLRG
                          ,FANCYNORM , FANCYMXSML , FANCYMXLRG/
        RESOURCE      TYPES OF RESOURCES
                          /SMLLATHE,LRGLATHE,CARVER,LABOR/ ;

 PARAMETER PRICE(PROCESS)     PRODUCT PRICES BY PROCESS
                   /FUNCTNORM  82, FUNCTMXSML  82, FUNCTMXLRG  82
                   ,FANCYNORM 105, FANCYMXSML 105, FANCYMXLRG 105/
           PRODCOST(PROCESS)     COST BY PROCESS
                   /FUNCTNORM  15, FUNCTMXSML  16  , FUNCTMXLRG  15.7,
                    FANCYNORM  25, FANCYMXSML  26.5, FANCYMXLRG  26.6/
           RESORAVAIL(RESOURCE) RESOURCE AVAILABLITY
                   /SMLLATHE 140, LRGLATHE  90,
                    CARVER   120, LABOR    125/;

 TABLE RESOURUSE(RESOURCE,PROCESS) RESOURCE USAGE

               FUNCTNORM   FUNCTMXSML  FUNCTMXLRG
SMLLATHE          0.80       1.30        0.20
LRGLATHE          0.50       0.20        1.30
CARVER            0.40       0.40        0.40
LABOR             1.00       1.05        1.10
 +             FANCYNORM   FANCYMXSML  FANCYMXLRG
SMLLATHE          1.20       1.70        0.50
LRGLATHE          0.70       0.30        1.50
CARVER            1.00       1.00        1.00
LABOR             0.80       0.82        0.84;

 POSITIVE VARIABLES
          PRODUCTION(PROCESS) ITEMS PRODUCED BY PROCESS;
 VARIABLES
          PROFIT              TOTALPROFIT;
 EQUATIONS
          OBJT                  OBJECTIVE FUNCTION ( PROFIT )
          AVAILABLE(RESOURCE)   RESOURCES AVAILABLE ;

  OBJT..  PROFIT =E=
             SUM(PROCESS,(PRICE(PROCESS)-PRODCOST(PROCESS))
                 * PRODUCTION(PROCESS));

  AVAILABLE(RESOURCE)..
             SUM(PROCESS,RESOURUSE(RESOURCE,PROCESS)*PRODUCTION(PROCESS))
                 =L= RESORAVAIL(RESOURCE);

 MODEL RESALLOC /ALL/;
 SOLVE RESALLOC USING LP MAXIMIZING PROFIT;

$ontext
#user model library stuff
Main topic Output
Featured item 1 Solslack
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate solslack
$offtext
