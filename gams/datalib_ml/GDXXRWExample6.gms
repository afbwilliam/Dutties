$ontext

This program illustrates reading a table from an Excel
spreadsheet. It contains the same data as in GDXXRWExample5.gms
which is organized differently. Unlike GDXXRWExample5.gms,
this example also reads set data. Additionally, this program
offers writing and reading GDXXRW command options from a file.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

 sets i row entries
      a column entries ;

 parameter data2(i,a);

$CALL GDXXRW Test1.xls par=Data2 rng=EX2!A1 Rdim=2 Dset=I rng=EX2!A1 Rdim=1 Dset=A rng=EX2!B1 Rdim=1 trace=0

*Alternatively the above statement can be commented and below part can be uncommented
*to write to and read from a file.
*$onecho > example6.txt
*par =Data2 rng=EX2!A1 RDim=2
*Dset=I rng=EX2!A1 Rdim=1
*Dset=A rng=EX2!B1 Rdim=1
*$offecho
*$call GDXXRW test1.xls @example6.txt

$GDXIN Test1.gdx
$LOAD i a data2
$GDXIN

display i,a,data2;


