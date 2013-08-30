$ontext
To export to a file or a database in batch mode, one can use the following statement:

   execute 'gdxviewer.exe i=inputfile.gdx type=outputfile id=x';

where "type" can be xls, pivot, csv, txt, inc, html, xml, mdb and "id"
parameter indicates a symbol to be exported from the GDX file.
(Thus, x is a symbol in the GDX file.) Note that for type "sql", no
output file is used. The database is rather given as part of the
connection string. If a path or filename contains blanks, the name
must be surrounded by double quotes as in "file name". Only one symbol
can be exported at a time. An option file (.ini file) can be given
using ini=Options.ini in the statement. If no .ini file is given,
the .ini file of the interactive mode will be used.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

Sets i   canning plants
     j   markets;
Variables
       x(i,j)  shipment quantities in cases ;

$GDXIN Trnsport.gdx
$LOAD i,j,x
$GDXIN

* Note that the program will continue after GDXViewer is closed.
execute 'Gdxviewer.exe Trnsport.gdx';

execute_unload 'Result.gdx', i,x;

* XLS writing
execute 'gdxviewer.exe i=Result.gdx xls=Result.xls id=x';

* Excel Pivot Table writing
execute 'gdxviewer.exe i=Result.gdx pivot=ResultPivot.xls id=x';

* CSV file writing
execute 'gdxviewer.exe i=Result.gdx csv=Result.csv id=x';

* Text file writing
execute 'gdxviewer.exe i=Result.gdx txt=Result.txt id=x';

* GAMS include file writing
execute 'gdxviewer.exe i=Result.gdx inc=Result.inc id=x';

* HTML file writing
*set HTML options
$onecho > HTMLOptions.ini
[HTMLexport]
tableborder=1
tablepadding=3
tablespacing=0
$offecho
execute 'gdxviewer.exe i=Result.gdx html=Result.html id=x ini=HTMLOptions.ini';

* XML file writing
execute 'gdxviewer.exe i=Result.gdx xml=Result.xml id=x';

* MS Access MDB file writing
* In this particular case, x contains the special character INF and
* must be substituted with numbers before it can be written to a database.
$onecho > MDBOptions.ini
[specialvaluemapping]
inf=1.0e8

[MDBfileexport]
indexlength=31
importmethod=0
$offecho

execute 'gdxviewer.exe i=Result.gdx mdb=Result.mdb id=x ini=MDBOptions.ini';

* SQL Database Table writing
* As already mentioned in the beginning, database is given as part of the
* connection string. This part writes to the database Result.mdb which
* should be generated by the above statement.
* For the connection string, alternatively, 'connectionstring=DSN=Result' can be used,
* however, Result.mdb must be entered as 'User DSN' in
* 'Control Panel | Administrative Tools | Data Sources (ODBC)'.

$onecho > SQLOptions.ini
[SQL]
connectionstring=Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Result.mdb
userid=
password=
indexlength=31
doubletype=double
$offecho

execute 'gdxviewer.exe i=Result.gdx sql id=i ini=SQLOptions.ini';