$ontext

Comparative Analysis with a conditional constraint

$offtext
option limrow=0;
option solprint=off;
option limcol=0;
$offsymlist offsymxref
$include farmcomp.gms
$include farmrep.gms
scalar cowlim activates cowlimit constraint /1/;
equation cowlimit conditional equation on cow limits;
cowlimit$cowlim.. sum((animals,livemanage),liveprod(animals,livemanage))=l=100;
model farmcowlim /all/;
option solprint=on;
parameter savprice(primary) saved primary commodity prices;
savprice(primary)=price(primary);
set ordr /"Scenario setup","Scenario Results"/
set scenarios /base,cowlim/;
parameter cowlims(scenarios) cowlimit by scenario
          /base 0
           cowlim 1/;
Parameter savsumm(ordr,*,alli,scenarios) Comparative Farm Summary;
loop(scenarios,
    cowlim=cowlims(scenarios);
    SOLVE FARMcowlim USING LP MAXIMIZING NETINCOME;
$include farmrep.gms
    savsumm("Scenario setup","Limit","cattle",scenarios)$cowlim=100;
    savsumm("Scenario setup","Limit","cattle",scenarios)$(cowlim eq 0)=INF;
    savsumm("Scenario Results",measures,alli,scenarios)=summary(alli,measures);
    );
option savsumm:2:3:1;display savsumm;
Parameter savsummp(ordr,*,alli,scenarios) Comparative Farm Summary (percent chg);
savsummp(ordr,measures,alli,scenarios)$savsumm(ordr,measures,alli,"base")=
        round(  (savsumm(ordr,measures,alli,scenarios)
          -savsumm(ordr,measures,alli,"base"))*100
          /savsumm(ordr,measures,alli,"base"),1);
savsummp(ordr,measures,alli,scenarios)
          $(savsumm(ordr,measures,alli,"base") eq 0
        and savsumm(ordr,measures,alli,scenarios) ne 0)=na;
option savsummp:1:3:1;display savsummp;

$ontext
#user model library stuff
Main topic Comparative analysis
Featured item 1 Report writing
Featured item 2 Conditionals
Featured item 3 Loop
Featured item 4 Conditional constraint

Description
Comparative Analysis with a conditional constraint
$offtext
