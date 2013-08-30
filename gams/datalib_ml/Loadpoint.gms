$ontext
This program illustrates the use of execute_loadpoint.
The execute_loadpoint allows you to merge solution points
into any GAMS database. Loading the data acts like an
assignment statement and it merges/replaces data with
current data. 

The GDX file used here was produced using Savepoint.gms. Since
the file already contains an optimal solution, no iterations
take place in this case.
$offtext

execute_loadpoint 'Transport_p1';
$include trnsport.gms
