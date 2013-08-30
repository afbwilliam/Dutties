$ontext

  Example database access with MDB2GMS
  The programs selects sales and profit information from database "Sample.mdb"
  using 'UNION' and writes results to "salesprofitm.inc". It also illustrates
  use 'M' (mute) to remove messages to stdout and advertisement in generated include file.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set y   'years'      /1997*1998/;
set loc 'locations'  /nyc,was,la,sfo/;
set prd 'products'   /hardware, software/;
set q   'quantities' /sales, profit/;

$onecho > cmd.txt
I=Sample.mdb
Q=select prod,loc,year,'sales',sales from data union select prod,loc,year,'profit',profit from data
O=salesprofitm.inc
M
$offecho

$call mdb2gms @cmd.txt > %system.nullfile%

parameter data(prd,loc,y,q) /
$include salesprofitm.inc
/;
display data;
