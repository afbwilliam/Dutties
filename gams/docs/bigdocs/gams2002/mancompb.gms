$ontext

Manual Comparative Analysis using repeated solves with
cross scenario report writing

$offtext
option limrow=0;
option solprint=off;
option limcol=0;
$offsymlist offsymxref
$include farmcomp.gms
$include farmrep.gms
set ordr /"Scenario setup","Scenario Results"/
set scenarios /base,beefp,beefcorn/
Parameter savsumm(ordr,*,alli,scenarios) Comparative Farm Summary;
savsumm("Scenario setup","price",primary,"base")=price(primary);
savsumm("Scenario Results",measures,alli,"base")=summary(alli,measures);
price("beef")=0.70;
SOLVE FARM USING LP MAXIMIZING NETINCOME;
display price ;
$include farmrep.gms
savsumm("Scenario setup","price",primary,"beefp")=price(primary);
savsumm("Scenario Results",measures,alli,"beefp")=summary(alli,measures);
price("corn")=2.70;
display price ;
SOLVE FARM USING LP MAXIMIZING NETINCOME;
$include farmrep.gms
savsumm("Scenario setup","price",primary,"beefcorn")=price(primary);
savsumm("Scenario Results",measures,alli,"beefcorn")=summary(alli,measures);
option savsumm:2:3:1;display savsumm;

Parameter savsummp(ordr,*,alli,scenarios) Comparative Farm Summary (percent chg);
savsummp(ordr,measures,alli,scenarios)$savsumm(ordr,measures,alli,"base")=
        round(  (savsumm(ordr,measures,alli,scenarios)
          -savsumm(ordr,measures,alli,"base"))*100
          /savsumm(ordr,measures,alli,"base"),1);
savsummp(ordr,measures,alli,scenarios)
          $(savsumm(ordr,measures,alli,"base") eq 0
        and savsumm(ordr,measures,alli,scenarios) ne 0)=na;
savsummp(ordr,"price",alli,scenarios)$savsumm(ordr,"price",alli,"base")=
        round(  (savsumm(ordr,"price",alli,scenarios)
          -savsumm(ordr,"price",alli,"base"))*100
          /savsumm(ordr,"price",alli,"base"),1);
savsummp(ordr,"price",alli,scenarios)
          $(savsumm(ordr,"price",alli,"base") eq 0
        and savsumm(ordr,"price",alli,scenarios) ne 0)=na;
option savsummp:1:3:1;display savsummp;

$ontext
#user model library stuff
Main topic  Comparative analysis
Featured item 1 Comparative analysis
Featured item 2 Manual
Featured item 3 Report writing
Featured item 4 Cross scenario
Description
Manual Comparative Analysis using repeated solves with
cross scenario report writing

$offtext
