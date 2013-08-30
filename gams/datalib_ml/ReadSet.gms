$ontext
   This program reads set data using xls2gms.exe.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set i /
$call =xls2gms r=a1:a3 i=Test3.xls o=set1.inc
$include set1.inc
/;

display i;

set j /
$call =xls2gms r=b5:d5 s="," i=Test3.xls o=set2.inc
$include set2.inc
/;

display j;
