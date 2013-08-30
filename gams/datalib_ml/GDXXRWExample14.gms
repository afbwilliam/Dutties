$ontext
This example illustrates:
. Compilation phase
. Read data from a spreadsheet and create a gdx file
. Reading sets from the gdx file
. Using the sets as a domain for additional declarations
. Reading additional data elements
. Execution phase
. Solve the model
. Write solution to a gdx file
. Use gdx file to update spreadsheet

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$onecho > Taskin.txt
dset=i rng=a3:a4 rdim=1
dset=j rng=b2:d2 cdim=1
par=d rng=A2 Cdim=1 Rdim=1
par=a rng=a8 Rdim=1
par=b rng=a13 Rdim=1
par=f rng=a19 Dim=0
$offecho
$call gdxxrw.exe TrnsportData.xls @Taskin.txt trace=0
$gdxin TrnsportData.gdx

Sets i canning plants
     j markets;

$load i j

Display i,j;

Parameters
     a(i)   capacity of plant i in cases
     b(j)   demand at market j in cases
     d(i,j) distance in thousands of miles

Scalar f freight in dollars per case per thousand miles

$load d a b f
$gdxin

Parameter c(i,j) transport cost in thousands of dollars per case ;
c(i,j) = f * d(i,j) / 1000 ;

Variables
     x(i,j) shipment quantities in cases
     z      total transportation costs in thousands of dollars ;
Positive Variable x;

Equations
     cost      define objective function
     supply(i) observe supply limit at plant i
     demand(j) satisfy demand at market j ;

cost .. z =e= sum((i,j),c(i,j)*x(i,j));

supply(i).. sum(j,x(i,j)) =l= a(i);

demand(j).. sum(i,x(i,j)) =g= b(j);

Model transport /all/ ;

Solve transport using lp minimizing z ;

Display x.l, x.m ;

execute_unload 'TrnsportData.gdx', x;
execute 'gdxxrw.exe TrnsportData.gdx o=TrnsportData.xls var=x.l rng=sheet2!a1 trace=0' ;
