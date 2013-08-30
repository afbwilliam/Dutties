
$ontext

Illustrate speed consequence of considering unnecessary cases

$offtext

Option profile=1;
option limrow=0;
option limcol=0;
$offsymlist offsymxref
option solprint=off;
Set state /1*50/
set county /1*3000/
set landtype /1*10/
parameter landarea(state,county,landtype);

set matchup(state,county) list of what states counties are in;
*arbitrary assignment of counties to states for example only
    Matchup(state,county)$((ord(county) ge (ord(state)-1)*60+1)
                      And (ord(county) le ord(state)*60+1))=yes;
landarea(state,county,landtype)$matchup(state,county)=1;
parameter totalland(state);
totalland(state)=
      sum(matchup(state,county),sum(landtype,landarea(state,county,landtype)));
display totalland;



$ontext
#user model library stuff
Main topic Speed
Featured item 1  Conditionals
Featured item 2  Profile
Featured item 3  Unnecessary cases
Description
Illustrate speed consequence of considering unnecessary cases

$offtext
