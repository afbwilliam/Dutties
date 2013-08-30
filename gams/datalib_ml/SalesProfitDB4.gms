$ontext

  Example database access with MDB2GMS
  Multiple queries in one call, store in GDX file

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > cmd.txt
I=Sample.mdb
X=sample.gdx

Q1=select distinct(year) from data
s1=year

Q2=select distinct(loc) from data
s2=loc

Q3=select distinct(prod) from data
s3=prd

Q4=select prod,loc,year,sales from data
p4=sales

Q5=select prod,loc,year,profit from data
p5=profit
$offecho

$call mdb2gms @cmd.txt > %system.nullfile%

$call =shellExecute gdxviewer sample.gdx

set y 'years';
set loc 'locations';
set prd 'products';
parameter sales(prd,loc,y);
parameter profit(prd,loc,y);

$gdxin 'sample.gdx'
$load y=year loc prd sales profit


display sales;
display profit;
