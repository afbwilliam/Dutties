$ontext

This program illustrates reading a four dimensional parameter.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

 sets a  first row entries     /a1,a2/
      b  second row entries    /b1,b2/
      q  first column entries  /q1,q2/
      r  second column entries /r1,r2/ ;

 parameter data3(a,b,q,r);

$CALL GDXXRW Test1.xls par=data3 rng=EX3!A1:F6 Rdim=2 Cdim=2 trace=0
$GDXIN Test1.gdx
$LOAD data3
$GDXIN

display data3;
