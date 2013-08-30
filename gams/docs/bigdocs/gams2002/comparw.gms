*illustrate basic loop comparative analysis
*illustrate conditional compile sensing of operating system type
*illustrate message to screen using put

option limrow=0;
option solprint=off;
option limcol=0;
$offsymlist offsymxref
$include farmcomp.gms
$include farmrep.gms
parameter savprice(primary) saved primary commodity prices;
savprice(primary)=price(primary);
set ordr /"Scenario setup","Scenario Results"/
set scenarios /base,beefp,beefcorn/
Parameter savsumm(ordr,*,alli,scenarios) Comparative Farm Summary;
table scenprice(primary,scenarios)  price alterations by scenario
                base    beefp   beefcorn
corn                               2.70
soybeans
beef                     0.70            ;
*illustrate conditional compile sensing of operating type
$set console
$if %system.filesys% == UNIX  $set console /dev/tty
$if %system.filesys% == DOS $set console con
$if %system.filesys% == MS95  $set console con
$if %system.filesys% == MSNT  $set console con

$if "%console%." == "." abort "filesys not recognized";

file screen / '%console%' /;
file log /''/;

loop(scenarios,
    put screen;
    put 'I am on scenario ' Scenarios.tl;
    putclose;
    put log;
    put 'I am on scenario ' Scenarios.tl;
    putclose;
    price(primary)=savprice(primary);
    price(primary)$scenprice(primary,scenarios)=scenprice(primary,scenarios);
    display price;
    SOLVE FARM USING LP MAXIMIZING NETINCOME;
$include farmrep.gms
    savsumm("Scenario setup","price",primary,scenarios)=price(primary);
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
Main topic Comparative analysis
Featured item 1 Comparative analysis
Featured item 2 Put to screen
Featured item 3 System.filesys
Featured item 4 Loop

Description
illustrate basic loop comparative analysis
illustrate conditional compile sensing of operating system type
illustrate message to screen using put


$offtext
