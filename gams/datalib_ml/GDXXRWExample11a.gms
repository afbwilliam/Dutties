$ontext

This program illustrates writing to an MS Excel file.
It first generates a GDX file from makedata.gms and then
writes it to an MS Excel file.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$call GAMS Makedata gdx=test2 lo=%GAMS.lo%

$call GDXXRW Test2.gdx par=V rng=a1 trace=0

