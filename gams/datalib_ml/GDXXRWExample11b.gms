$ontext

This program illustrates writing to an MS Excel file
using Execute_Unload and Execute statements

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

set i /i1*i4/
j /j1*j4/
k /k1*k4/;
parameter v(i,j,k);
v(i,j,k)$(uniform(0,1) < 0.30) = uniform(0,1);
Execute_Unload "test2.gdx",I,J,K,V;
Execute 'GDXXRW.EXE test2.gdx par=V rng=a1 trace=0';
