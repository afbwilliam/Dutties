$ontext
   This program reads transportation data using xls2gms.exe.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set i /
$call =xls2gms r=Sheet2!a3:a4 i=Test3.xls o=seti.inc
$include seti.inc
/;

set j /
$call =xls2gms r=Sheet2!b2:d2 s="," i=Test3.xls o=setj.inc
$include setj.inc
/;

table d(i,j)
$call =xls2gms r=Sheet2!a2:d4 i=Test3.xls o=pard.inc
$include pard.inc
;

display i,j,d;
