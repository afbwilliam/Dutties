$ontext

  Example of database access with MDB2GMS
  The programs selects sales and profit information from database "sample.mdb"
  and writes them to "sales.inc" or "profit.inc" respectively.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set y years /1997*1998/;
set loc locations /nyc,was,la,sfo/;
set prd products /hardware, software/;

parameter sales(prd,loc,y) /
$call mdb2gms I=Sample.mdb Q="select prod,loc,year,sales from data" O=sales.inc > %system.nullfile%
$include sales.inc
/;
display sales;

parameter profit(prd,loc,y) /
$call mdb2gms I=Sample.mdb Q="select prod,loc,year,profit from data" O=profit.inc > %system.nullfile%
$include profit.inc
/;
display profit;
