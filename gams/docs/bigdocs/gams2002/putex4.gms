*illustrate use of &, / and # in a put context

file my1;
put my1;
Put 'Hello' @3 'Goodbye';
put /;
Put 'Hello' @20 'Goodbye';
put //
put 'Hello '
put ' Goodbye'/;
scalar width /15/;
Put 'Hello' @(width+3) 'Goodbye';
put //;

set i /i1*i6/;
loop(I, put i.tl );
put //;
loop(I, put i.tl /);

putpage;
Put #3 'Hello' #2 'Goodbye' #1 'Hey these are reversed';
scalar lineonpage /15/;
Put 'Hello' #(lineonpage+3) 'Goodbye';
scalar scalar1,scalar2,scalar3;
put /;
put @91
for (scalar1 = 1 to 2,
for (scalar2 = 1 to 10,
put scalar1:10:0));
put /;
for (scalar2 = 1 to 3 ,
for (scalar1 = 1 to 10,
scalar3=scalar1;
if(scalar3=10,scalar3=0);
put scalar3:10:0));
put /;
for (scalar1 = 1 to 30,
for (scalar2 = 1 to 10,
scalar3=scalar2;
if(scalar3=10,scalar3=0);
put scalar3:1:0));

put /;

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 &
Featured item 3 /
Featured item 4 #
Description
Illustrate use of &, / and # in a put context
$offtext
