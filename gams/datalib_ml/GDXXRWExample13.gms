$ontext
This program reads data from an MS Excel file, modifies
it, writes to an GDX file and then finally writes the
modifies data to a new sheet in the MS Excel file.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$CALL GDXXRW test1.xls Set=I rng=A2:A3 Rdim=1 Set=A rng=B1:D1 Cdim=1 Par=X rng=A1:D3 Rdim=1 Cdim=1 trace=0
$GDXIN test1.gdx
Set I,A;
$LOAD I A
Parameter X(I,A);
$LOAD X
Display I,A,X;
$GDXIN
X(I,A) = - X(I,A);
Execute_Unload 'tmp.gdx',I,A,X;
Execute 'GDXXRW.EXE tmp.gdx O=test1.xls par=X rng=EX6!A1:D3 rdim=1 cdim=1 trace=0';
