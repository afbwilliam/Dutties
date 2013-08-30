$ontext
  Example of wiring option.

  Instead of
     select prod,loc,year,'sales',sales from data
     union
     select prod,loc,year,'profit',profit from data

  we use
     select prod,loc,year,sales,profit from data
     or
     select * from data

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

sets
  y    'years'       /1997*1998/
  loc  'locations'   /nyc,was,la,sfo/
  prd  'products'    /hardware, software/
  q    'quantities'  /sales, profit/
;

$onecho > cmd.txt
I=Sample.mdb
Q=select * from data
O=x.inc
W=i1|i2|i3|v4='sales'|v4='profit'
$offecho

$call mdb2gms @cmd.txt > %system.nullfile%

parameter data(y,loc,prd,q) /
$include x.inc
/;
display data;
