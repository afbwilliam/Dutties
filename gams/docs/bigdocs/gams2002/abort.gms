*$abort.noerror

scalar x /0/;
if(x > 0,abort "i stopped at first place",x;);
*note next command is redundant to above
abort$(x > 0) "i stopped with abort$ at first place",x;
display "i got past first place" ,x;
x=2;
abort$(x > 0) "i stopped with abort$ at second place",x;
*note will not get to next line
if(x > 0,abort "i stopped at second place",x;);

$ontext
#user model library stuff
Main topic Abort
Featured item 1 Abort
Featured item 2
Featured item 3
Description
Illustrates use of abort to shut down a job
Note abort is like display
$offtext
