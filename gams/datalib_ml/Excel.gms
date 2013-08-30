$ontext
  Reads data from Excel through ODBC
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

set y 'years'   /1997,1998/;
set c 'city'    /la,nyc,sfo,was/;
set p 'product' /hardware,software/;
set k 'key'     /sales,profit/;

$onecho > excelcmd.txt
c=DRIVER=Microsoft Excel Driver (*.xls);dbq=Profit.xls;
q=SELECT year,loc,prod,'sales',sales FROM [profitdata$] UNION SELECT year,loc,prod,'profit',profit FROM [profitdata$]
o=excel.inc
$offecho
$call sql2gms @excelcmd.txt > %system.nullfile%

parameter d(y,c,p,k) /
$include excel.inc
/;
display d;
