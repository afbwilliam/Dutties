$ontext

   This example shows how to map index names if the names in the
   database are different from the ones in the GAMS model.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set i /NY,DC,LA,SF/;

set idb 'from database' /
  'new york',
  'washington dc',
  'los angeles',
  'san francisco'
/;

parameter dbdata(idb) /
$call mdb2gms B i=Sample.mdb o="city1.inc" q="select City,[Value] from [example table]" > %system.nullfile%
$include city1.inc
/;

set mapindx(i,idb) /
   NY.'new york'
   DC.'washington dc'
   LA.'los angeles'
   SF.'san francisco'
/;

parameter data(i);
data(i) = sum(mapindx(i,idb), dbdata(idb));
display data;
