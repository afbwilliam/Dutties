*Compilation error caused by misspelling of item name

$onsymlist onuellist onsymxref
*Example of a comment
$Ontext
Comments in $on/off text are not given line numbers
$offtext
SET PROCEsS   PRODUCTION PROCESSES /makechair,maketable,makelamp/
    RESOURCE  TYPES OF RESOURCES   /plantcap,salecontrct/;
PARAMETER PRICE(PROCES)      PRODUCT PRICES BY PROCESS
              /makechair 6.5 ,maketable 3, makelamp 0.5/
          Yield(process)  yields per unit of the process
              /Makechair 2   ,maketable 6 ,makelamp 3/
        PRODCOST(PROCESS)     COST BY PROCESS
              /Makechair 10  ,Maketable 6, Makelamp 1/
        RESORAVAIL(RESOURCE)  RESOURCE AVAILABLITY
             /platcap 10 ,salecontrct 3/;
TABLE RESOURUSE(RESOURCE,PROCESS) RESOURCE USAGE
                   Makechair   Maketable  Makelamp
     plantcap         3          2          1.1
     salecontrt       1         -1;
POSITIVE VARIABLES PRODUCTION(PROCESS) ITEMS PRODUCED BY PROCESS;
VARIABLES          PROFIT              TOTALPROFIT;
EQUATIONS          OBJT OBJECTIVE FUNCTION ( PROFIT )
                   AVAILABLE(RESOURCE) RESOURCES AVAILABLE;
OBJT.. PROFIT=E=   SUM(PROCESS,(PRICE(PROCESS)*yield(process)
                           -PRODCOST(PROCESS))*PRODUCTION(PROCESS)) ;
AVAILABLE(RESOURcE).. SUM(PROCESS,RESOURUS(RESOURCE,PROCESS)
                     *PRODUCTION(PROCESS))  =L= RESORAVAIL(RESOURCE);
MODEL RESALLOC /ALL/;
SOLVE RESALLOC USING LP MAXIMIZING PROFIT;
$offlisting
parameter solprod(process) report of production;
solprod(PROCESS)= PRODUCTION.l(PROCESS);
$onlisting
display solprod;

$ontext
#user model library stuff
Main topic Compiler error
Featured item 1 Parameter
Featured item 2
Featured item 3
Featured item 4
Description
compilation error caused by misspelling of item name
$offtext
