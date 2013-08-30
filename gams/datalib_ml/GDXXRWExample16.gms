$ontext
The following example illustrates the use of the Text directive.

First we write some data to a gdx file and we use text directive to write
text to various cells; some of the cells are hyperlinks to other locations.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$onecho > task.txt
text="Link to data" rng=Index!A2 linkid=A
text="Below the data for symbol A" rng=data!c2
par=A rng=data!c4
text="Back to index" rng=data!a1 link=Index!A1
text="For more information visit GAMS" rng=data!c1 link=http://www.gams.com
$offecho

set i /i1*i9/
j /j1*j9/;
parameter A(i,j);
A(i, j) = 10 * Ord(i) + Ord(j);
execute_unload "pv.gdx";
execute 'gdxxrw pv.gdx o=pv.xls @task.txt trace=0';
