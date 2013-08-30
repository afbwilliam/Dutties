File dosbox / titlemaker.cmd/
putclose dosbox '@title this is a new DOS box title';
execute 'titlemaker.cmd';

set i /1*100000/
scalar j/0/
loop(i,
putclose dosbox '@title On loop ' i.tl;
execute 'titlemaker.cmd' ;
j=j+1);

$ontext
#user model library stuff
Main topic WHere am I
Featured item 1 Putclose
Featured item 2 Execute
Featured item 3
Description
Illustrates use of putclose to change title of the DOS Box

To use this in the IDE you must make the DOS box visible.
$offtext
