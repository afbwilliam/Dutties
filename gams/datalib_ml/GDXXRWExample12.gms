$ontext

This program illustrates the use of merge and clear option.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

* merges data
$call GDXXRW i=test2.gdx o=test2.xls par=V rng=sheet2!a1 merge trace=0

* to clear, comment above line and uncomment below line
*$call GDXXRW i=test2.gdx o=test2.xls par=V rng=sheet2!a1 clear
