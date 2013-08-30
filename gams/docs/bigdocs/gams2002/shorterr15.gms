$Ontext
Compiler errors with numerical specification omission
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
parameter RESOURUSE(RESOURCE,PROCESS) RESOURCE USAGE;
POSITIVE VARIABLES PRODUCTION(PROCESS) ITEMS PRODUCED BY PROCESS;
VARIABLES          PROFIT              TOTALPROFIT;
EQUATIONS          OBJT OBJECTIVE FUNCTION ( PROFIT )
                   AVAILABLE(RESOURCE) RESOURCES AVAILABLE ;

OBJT.. PROFIT=E=   SUM(PROCESS,(PRICE(PROCESS)*yield(process)
                           -PRODCOST(PROCESS))*PRODUCTION(PROCESS)) ;
scalar x;
x=sum(PROCESS,Yield(process));
AVAILABLE(RESOURCE).. SUM(PROCESS,RESOURUSE(RESOURCE,PROCESS)
                     *PRODUCTION(PROCESS))  =L= RESORAVAIL(RESOURCE);

MODEL RESALLOC /ALL/;
$offlisting
parameter solprod(process) report of production;
solprod(PROCESS)= PRODUCTION.l(PROCESS);
$onlisting
display solprod;

$ontext
#user model library stuff
Main topic Compiler error
Featured item 1 Declaration
Featured item 2 Definition
Featured item 3
Featured item 4
Description
Compiler errors with numerical specification omission

$offtext
