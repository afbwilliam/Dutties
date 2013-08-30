$ontext
Store data from Access database into a GDX file.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > cmd.txt
I=Transportation.mdb
X=Transportation.gdx
Q1=select name from suppliers
S1=i
Q2=select name from demandcenters
S2=j
Q3=select name,demand from demandcenters
P3=demand
Q4=select name,supply from suppliers
P4=supply
Q5=select supplier,demandcenter,distance from distances
P5=dist
$offecho
$call mdb2gms.exe @cmd.txt > %system.nullfile%
