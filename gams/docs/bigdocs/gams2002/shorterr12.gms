*Compiler errors with missing equation specification

$onsymlist  onsymxref    onuellist onuelxref
*Example of a comment
$Ontext
Comments in $on/off text are not given line numbers
$offtext
SET PROCESS   PRODUCTION PROCESSES /makechair,maketable,makelamp/
    RESOURCE  TYPES OF RESOURCES   /plantcap capacity ,salecontrct contract/;
PARAMETER PRICE(PROCESS)      PRODUCT PRICES BY PROCESS
              /makechair 6.5 ,maketable 3, makelamp 0.5/
          Yield(process)  yields per unit of the process
              /Makechair 2   ,maketable 6 ,makelamp 3/
        PRODCOST(PROCESS)     COST BY PROCESS
              /Makechair 10  ,Maketable 6, Makelamp 1/
        RESORAVAIL(RESOURCE)  RESOURCE AVAILABLITY
             /plantcap 10 ,salecontrct 3/;
TABLE RESOURUSE(RESOURCE,PROCESS) RESOURCE USAGE
                   Makechair   Maketable  Makelamp
     plantcap         3          2          1.1
     salecontrct      1         -1;
POSITIVE VARIABLES PRODUCTION(PROCESS) ITEMS PRODUCED BY PROCESS;
VARIABLES          PROFIT              TOTALPROFIT;
EQUATIONS          OBJT OBJECTIVE FUNCTION ( PROFIT )
                   AVAILABLE(RESOURCE) RESOURCES AVAILABLE
                   notthere one i forgot ;
OBJT.. PROFIT=E=   SUM(PROCESS,(PRICE(PROCESS)*yield(process)
                           -PRODCOST(PROCESS))*PRODUCTION(PROCESS)) ;
AVAILABLE(RESOURCE).. SUM(PROCESS,RESOURUSE(RESOURCE,PROCESS)
                     *PRODUCTION(PROCESS))  =l= RESORAVAIL(RESOURCE);
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
Featured item 1 .. statements
Featured item 2
Featured item 3
Featured item 4
Description
Compiler errors with missing equation specification

$offtext
