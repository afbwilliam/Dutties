$ontext

  Example database access with SQL2GMS (ODBC Driver)

  Multiple queries in one call, store in GDX file

Alternatively, following connection strings might also be used
C=DSN=MS Access Database;dbq=Sample.mdb
C=Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Sample.mdb
C=DSN=Sample
Note that for the last connection string to work, Sample.mdb must be entered as
'User DSN' in 'Control Panel | Administrative Tools | Data Sources (ODBC)'.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > cmd.txt
C=DRIVER=Microsoft Access Driver (*.mdb);dbq=Sample.mdb
X=sample.gdx

Q1=select distinct(year) from data
s1=year

Q2=select distinct(loc) from data
s2=loc

Q3=select distinct(prod) from data
s3=prd

Q4=select prod,loc,year,sales from data
A4=sales

Q5=select prod,loc,year,profit from data
A5=profit
$offecho

$call sql2gms @cmd.txt > %system.nullfile%

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
