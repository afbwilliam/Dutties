*illustrate put to another program with fixed format
set run /r1*r12/;
set decwant /1990,2000,2010/
set welfite /Agconswelf,Agprodwelf,AGtotwelf,AGGOVTCOST,
         AGnetwelf,agtradbal,domforcon,domforpro,allfor,bothnetwel/
set otheritem/cropland,pasture,irrigland,dryland,water,nitrogen
             ,Potassium,phosporous,chemicalco/
;
scalar s;
parameter fawelsum(welfite,decwant,run);
fawelsum(welfite,decwant,run)=10000*(ord(welfite)+ord(decwant)+ord(run));
parameter agtable(decwant,*,run);
agtable(decwant,welfite,run)=7555*ord(decwant);
file tosass;
put tosass;
loop(run,
  put run.tl;
  put @12;
put /;
loop(decwant,s=  fawelsum( "Agconswelf",decwant,run)/1000;put s:13:0;);
put /;
loop(decwant,s=  fawelsum( "AGGOVTCOST",decwant,run)/1000;put s:13:2;);
put /;
loop(decwant,s= agtable(decwant,"agtradbal",run)/1000;put s:13:2;);
  put / ;
 ) put / ;

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate put to another program with fixed format
$offtext
