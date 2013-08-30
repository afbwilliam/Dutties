$ontext
   This program reads multidimensional parameter using xls2gms.exe.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

Sets l 'livestock types'       /sheep,goat,angora,cattle,buffalo,mule,poultry/
     cl 'livestk comm'         /meat,milk,wool,hide,egg/
     ty 'time periods - years' / 1974*1979 /;

$onecho > yield.txt
I=Yield.xls
R=data!B2:J23
O=Yield.inc
$offecho

$call =xls2gms @yield.txt

Table yieldtl(l,cl,ty) livestock "yield" time series (kg per head)
$include Yield.inc
;

display yieldtl;
