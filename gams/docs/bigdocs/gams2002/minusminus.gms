$ontext
Illustrate -- and related command line parametersetc
Call this with
GAMS minusminus --keycity=Boston //myflag=modes /-myvalue=7.6  -/dothis="display x;"

or

IDE parameters box contents
--keycity=Boston //myflag=modes /-myvalue=7.6  -/dothis="display x;"

$offtext

parameter x (*,*);
$show

x("%keycity%","%myflag%")=%myvalue%;
%dothis%


$ontext
#user model library stuff
Main topic Command line
Featured item 1  --
Featured item 2  //
Featured item 3  /-
Featured item 4  -/
Description
Illustrate -- and related command line parametersetc
Call this with
GAMS minusminus --keycity=Boston //myflag=modes /-myvalue=7.6  -/dothis="display x;"

or

IDE parameters box contents
--keycity=Boston //myflag=modes /-myvalue=7.6  -/dothis="display x;"

$offtext
