$Ontext
  Put file example illustrating $onput and $offput output


$Offtext
file myputfile;
put myputfile;
Put 'Line 1 of text' /;
Put 'Line 2 of text' / / ;
Put 'Line 3 of text' /;
Put 'Line 4 of text' /;

put / / '*************************' / /
$onput
Line 1 of text
Line 2 of text

Line 3 of text
Line 4 of text
$offput

put / / '*************************' / /

$setglobal it "from $onputv"

$onput
no substitution
Line 1 of text %it%
Line 2 of text %it%
Line 3 of text %it%
Line 4 of text %it%
$offput

put / / '*************************' / /

$onputs
substituion
Line 1 of text "%it%"
Line 2 of text %it%
Line 3 of text %it%
Line 4 of text %it%
$offput

put / / '*************************' / /

$onput
verbatum
Line 1 of text %it%
Line 2 of text %it%
Line 3 of text %it%
Line 4 of text %it%
$offput

put / / '*************************' / /



$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 $onput/$offput
Featured item 3 $onputv
Description
  Put file example illustrating $onput and $offput output
$offtext
