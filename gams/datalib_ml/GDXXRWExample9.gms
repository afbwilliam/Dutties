$ontext

This program illustrates reading a set from an Excel
spreadsheet with using 'values' option.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

 set set1;

$CALL GDXXRW Test1.xls set=SET1 values=yn rng=EX5!A2:B6 Rdim=1 trace=0
$GDXIN Test1.gdx
$LOAD set1
$GDXIN

display set1;
