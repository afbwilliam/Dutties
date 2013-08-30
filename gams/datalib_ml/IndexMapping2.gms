$ontext

   This example shows how to map index names if the names in the
   database are different from the ones in the GAMS model.
   In this case all mapping is handled inside the database.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set i /NY,DC,LA,SF/;

$onecho > cmd.txt
i=Sample.mdb
q=SELECT [GAMS City], [value] FROM [example table],CityMapper WHERE [Access City]=city
o=city2.inc
$offecho

$call mdb2gms @cmd.txt > %system.nullfile%

parameter data(i)/
$include city2.inc
/;
display data;
