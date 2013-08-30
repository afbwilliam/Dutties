$ontext
Retrieve data from database once each day. Day of month in 'dbtimestamp.inc'
is compared with current day and if they are different, data are selected
and 'dbtimestamp.inc' is updated with current date. Note that if 'dbtimestamp.inc'
does not exist, it is created with day of month equaling to '0' to ensure data
selection.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > getdate.txt
C=Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Transportation.mdb
Q=select day(now())
O=dbtimestamp.inc
$offecho

$if not exist dbtimestamp.inc $call "echo 0 > dbtimestamp.inc"

scalar dbtimestamp 'day of month when data was retrieved' /
$include dbtimestamp.inc
/;

scalar currentday 'day of this run';
currentday = gday(jnow);

display "compare", dbtimestamp,currentday;

if (dbtimestamp<>currentday,
   execute '=gams.exe SQLsr0 lo=%GAMS.lo% gdx=transportation.gdx';
   abort$errorlevel "step 0 (database access) failed";
   execute 'sql2gms.exe @getdate.txt > %system.nullfile%'
);
