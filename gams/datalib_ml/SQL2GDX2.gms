$ontext
Store data from Access database into a GDX file.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > cmd.txt
C=Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Transportation.mdb
X=Transportation.gdx
Q1=select name from suppliers
S1=i
Q2=select name from demandcenters
S2=j
Q3=select name,demand from demandcenters
A3=demand
Q4=select name,supply from suppliers
A4=supply
Q5=select supplier,demandcenter,distance from distances
A5=dist
$offecho

$call sql2gms.exe @cmd.txt > %system.nullfile%
