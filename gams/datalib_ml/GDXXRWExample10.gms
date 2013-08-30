$ontext

This program illustrates reading a number of parameters and
sets using the index option. Index data is primarily a list
of set and parameter ranges and their dimensions.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$CALL GDXXRW Test1.xls Index=Index!a1 trace=0

