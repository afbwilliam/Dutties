$ontext

  Example database access with SQL2GMS (ODBC Driver)
  Multiple queries in one call

Alternatively, following connection strings might also be used
C=DSN=MS Access Database;dbq=Sample.mdb
C=Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Sample.mdb
C=DSN=Sample
Note that for the last connection string to work, Sample.mdb must be entered as
'User DSN' in 'Control Panel | Administrative Tools | Data Sources (ODBC)'.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > cmd.txt
C=DRIVER=Microsoft Access Driver (*.mdb);dbq=Sample.mdb

Q1=select distinct(year) from data
O1=year.inc

Q2=select distinct(loc) from data
O2=loc.inc

Q3=select distinct(prod) from data
O3=prod.inc

Q4=select prod,loc,year,sales from data
O4=sales.inc

Q5=select prod,loc,year,profit from data
O5=profit.inc
$offecho

$call sql2gms @cmd.txt > %system.nullfile%

set y years /
$include year.inc
/;
set loc locations /
$include loc.inc
/;
set prd products /
$include prod.inc
/;

parameter sales(prd,loc,y) /
$include sales.inc
/;
display sales;

parameter profit(prd,loc,y) /
$include profit.inc
/;
display profit;
