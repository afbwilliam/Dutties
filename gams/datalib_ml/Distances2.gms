$ontext

  Example of database access with SQL2GMS
  The programs selects distances from database "sample.mdb"
  and writes them to "distances.inc" or "distances.gdx" or both.
  Note that at least one output file name has to be provided.
  If no output file name is provided, the program starts to run
  in interactive mode.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$call sql2gms C="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Sample.mdb"  Q="select city1,city2,distance from distances" O=distances.inc X=distances.gdx a=distances > %system.nullfile%

* the following options can be used
* B: Quote blanks
* M: Mute
* L: No listing
*$call =sql2gms C="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Sample.mdb" Q="select city1,city2,distance from distances" O=distances.inc X=distances.gdx a=distances B M L

* output could be produced seperately as follows:
*$call =sql2gms C="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Sample.mdb" Q="select city1,city2,distance from distances" O=distances.inc
*$call =sql2gms C="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Sample.mdb" Q="select city1,city2,distance from distances" X=distances.gdx a=distances

set i /seattle, san-diego/;
set j /new-york, chicago, topeka/;

parameter dist1(i,j) 'distances' /
$include distances.inc
/;

parameter dist2(i,j) 'distances';

$gdxin 'distances.gdx'
$load dist2=distances
$gdxin

display dist1, dist2;
