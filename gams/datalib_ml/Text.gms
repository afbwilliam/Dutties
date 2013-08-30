$ontext
   Example of using SQL2GMS to read text files using the ODBC Text Driver
   Note: uses schema.ini

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set i /SEATTLE,SAN-DIEGO/;
set j /NEW-YORK,CHICAGO,TOPEKA/;


$onecho > fixedtextcmd.txt
C=DRIVER={Microsoft Text Driver (*.txt; *.csv)};DBQ=%system.fp%;
Q=select city1,city2,distance from ODBCData.txt
O=fixed.inc
$offecho
$call sql2gms @fixedtextcmd.txt > %system.nullfile%

parameter p1(i,j) /
$include fixed.inc
/;
display p1;

$onecho > separatedtextcmd.txt
C=DRIVER={Microsoft Text Driver (*.txt; *.csv)};DBQ=%system.fp%;
Q=select city1,city2,distance from ODBCData2.txt
O=fixed2.inc
$offecho
$call sql2gms @separatedtextcmd.txt > %system.nullfile%

parameter p2(i,j) /
$include fixed2.inc
/;
display p2;
