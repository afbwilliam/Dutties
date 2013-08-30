*Illustrate speed consequence of dropping unnecessary cases

Option profile=1;
option limrow=0;
option limcol=0;
$offsymlist offsymxref
option solprint=off;
Set state /1*50/
set county /1*3000/
set landtype /1*10/
parameter landarea(state,county,landtype);

landarea(state,county,landtype)=1;
parameter totalland(state);
totalland(state)=
      sum(county,sum(landtype,landarea(state,county,landtype)));
display totalland;


$ontext
#user model library stuff
Main topic Speed
Featured item 1  Conditionals
Featured item 2  $
Featured item 3  Profile
Featured item 4  Unnecessary cases
Description
Illustrate speed consequence of dropping unnecessary cases

$offtext
