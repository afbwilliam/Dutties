$ontext

This program illustrates reading a parameter with
special values such Eps, +Inf, -Inf, etc.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

 sets v  column entries    /v1,v2,v3,v4,v5,v6/ ;

 parameter data4(v);

* $onUNDF must be set in order to read #DIV/0!
$onUNDF
$CALL GDXXRW Test1.xls par=data4 rng=EX4!A1:F2 Cdim=1 trace=0
$GDXIN Test1.gdx
$LOAD data4
$GDXIN

display data4;
