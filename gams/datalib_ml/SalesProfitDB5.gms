$ontext

  Example database access with SQL2GMS. The programs selects sales and
  profit information from database "sample.mdb" using 'UNION' and writes
  results to "salesprofitm.inc". Alternative connection strings are also
  provided as comment.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set y   'years'      /1997*1998/;
set loc 'locations'  /nyc,was,la,sfo/;
set prd 'products'   /hardware, software/;
set q   'quantities' /sales, profit/;

$ontext
The query statement can be divided into multiple lines if required as follows :
Q=select prod,loc,year,'sales',sales from data \
  union \
  select prod,loc,year,'profit',sales from data

Alternatively, following connection strings might also be used
C=DSN=MS Access Database;dbq=Sample.mdb
C=Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Sample.mdb
C=DSN=Sample
Note that for the last connection string to work, Sample.mdb must be entered as
'User DSN' in 'Control Panel | Administrative Tools | Data Sources (ODBC)'.
$offtext

$onecho > cmd.txt
C=DRIVER={Microsoft Access Driver (*.mdb)};dbq=Sample.mdb
Q=select prod,loc,year,'sales',sales from data union select prod,loc,year,'profit',sales from data
O=salesprofit.inc
$offecho

$call sql2gms @cmd.txt > %system.nullfile%

parameter data(prd,loc,y,q) /
$include salesprofit.inc
/;
display data;
