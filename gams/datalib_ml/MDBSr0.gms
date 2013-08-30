$ontext
step 0: data extraction from database
execute as: > gams MDBSr0 save=s0
$offtext
set i 'suppliers';
set j 'demand centers';
parameter demand(j);
parameter supply(i);
parameter dist(i,j) 'distances';
$onecho > cmd.txt
I=Transportation.mdb
Q1=select name from suppliers
O1=i.inc
Q2=select name from demandcenters
O2=j.inc
Q3=select name,demand from demandcenters
O3=demand.inc
Q4=select name,supply from suppliers
O4=supply.inc
Q5=select supplier,demandcenter,distance from distances
O5=dist.inc
$offecho
$call mdb2gms.exe @cmd.txt > %system.nullfile%
set i /
$include i.inc
/;
set j /
$include j.inc
/;
parameter demand /
$include demand.inc
/;
parameter supply /
$include supply.inc
/;
parameter dist /
$include dist.inc
/;
display i,j,demand,supply,dist;
