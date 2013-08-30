$ontext

This program illustrates reading a table from an Excel
spreadsheet with row and column dimension of magnitude
1.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

 sets i row entries    /i1,i2/
      a column entries /a1, a2,a3/ ;

 parameter data1(i,a);

$CALL GDXXRW Test1.xls par=data1 rng=a1:d3 Cdim=1 Rdim=1 trace=0
$GDXIN Test1.gdx
$LOAD data1
$GDXIN

display data1;
