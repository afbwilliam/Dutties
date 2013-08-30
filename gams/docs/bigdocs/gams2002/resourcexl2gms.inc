* -----------------------------------------------------
* XLS2GMS Version 1.5,  August 2002
* Erwin Kalvelagen, GAMS Development Corp.
* -----------------------------------------------------
* Application: Microsoft Excel
* Version:     9.0
* Workbook:    C:\gams\gamspdf\bigone\resource.xls
* Sheet:       Sheet1
* Range:       $A$1:$D$52
* -----------------------------------------------------
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

         FUNCTNORM FUNCTMXSML FUNCTMXLRG
SMLLATHE 0.8       1.3        0.2
LRGLATHE 0.5       0.2        1.3
CARVER   0.4       0.4        0.4
LABOR    1         1.05       1.1
+        FANCYNORM FANCYMXSML FANCYMXLRG
SMLLATHE 1.2       1.7        0.5
LRGLATHE 0.7       0.3        1.5
CARVER   1         1          1
LABOR    0.8       0.82       0.84

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
* -----------------------------------------------------
