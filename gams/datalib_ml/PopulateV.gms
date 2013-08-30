$ontext

    Import a table into MS Access using VBscript

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$if exist new.mdb $call del new.mdb

set i /i1*i50/;
alias (i,j,k);
set v /v1*v5/;
parameter p(i,j,k,v);
p(i,j,k,v) = uniform(0,1);
scalar s;
s = sum((i,j,k,v),p(i,j,k,v));
display s;



file f /data.csv/;
f.pc=5;
put f,'i','j','k','v1','v2','v3','v4','v5'/;
loop((i,j,k),
     put i.tl, j.tl, k.tl;
     loop(v, put p(i,j,k,v):12:8;);
     put /;
);
putclose;


execute "=cscript access.vbs";
execute "=ShellExecute new.mdb";

$onecho > access.vbs
'this is a VBscript script
WScript.Echo "Running script: access.vbs"

dbLangGeneral = ";LANGID=0x0409;CP=1252;COUNTRY=0"
strSQL = "SELECT * INTO mytable FROM [Text;HDR=Yes;Database=%system.fp%;FMT=Delimited].[data#csv]"
Wscript.Echo "Query : " & strSQL

Set oJet = CreateObject("DAO.DBEngine.36")
Wscript.Echo "Jet version : " & oJet.version

Set oDB = oJet.createDatabase("new.mdb",dbLangGeneral)
Wscript.Echo "Created : " & oDB.name

oDB.Execute strSQL
Set TableDef = oDB.TableDefs("mytable")
Wscript.Echo "Rows inserted in mytable : " & TableDef.RecordCount

oDB.Close

Wscript.Echo "Done"
$offecho
