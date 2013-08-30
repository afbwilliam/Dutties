$ontext
   This program reads transportation data using xls2gms.exe and a command file.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > cmdxls.txt
i=Test3.xls
r1=Sheet2!a3:a4
o1=seti.inc
r2=Sheet2!b2:d2
o2=setj.inc
s2=","
r3=Sheet2!a2:d4
o3=pard.inc
$offecho

$call =xls2gms @cmdxls.txt

set i /
$include seti.inc
/;
set j /
$include setj.inc
/;
table d(i,j)
$include pard.inc
;
display i,j,d;
