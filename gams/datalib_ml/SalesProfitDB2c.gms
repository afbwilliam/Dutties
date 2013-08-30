$ontext

  Example database access with MDB2GMS
  The programs selects sales and profit information from database "Sample.mdb"
  using 'UNION' and writes results to "salesprofit.inc". It also illustrates
  how to break a line in a query statement.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set y   'years'      /1997*1998/;
set loc 'locations'  /nyc,was,la,sfo/;
set prd 'products'   /hardware, software/;
set q   'quantities' /sales, profit/;

$onecho > cmd.txt
I=Sample.mdb
Q=select prod,loc,year,'sales',sales from data \
  union \
  select prod,loc,year,'profit',profit from data
O=salesprofit.inc
$offecho

$call mdb2gms @cmd.txt > %system.nullfile%

parameter data(prd,loc,y,q) /
$include salesprofit.inc
/;
display data;
