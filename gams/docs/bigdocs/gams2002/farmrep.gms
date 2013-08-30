$ontext

Report writer for comarative analysis

$offtext

 inputuse(alli,crop)$(Purchinput(alli) or Landtype(alli)
                    or Labor(alli) or sameas(alli,"water"))
          =   +sum((irrigation,cropmanage),
               cropdata(crop,irrigation,alli,cropmanage)
               *cropprod.l(crop,irrigation,cropmanage));
  inputuse(alli,animals)$(Purchinput(alli) or Landtype(alli)
                    or Labor(alli) or sameas(alli,"water"))=
             +sum(livemanage,
                 livebud(alli,animals,livemanage)
                *liveprod.l(animals,livemanage))       ;
inputuse(alli,"Total")=sum(crop,inputuse(alli,crop))+
                       sum(animals,inputuse(alli,animals));
inputuse(landtype,"MVP")=LAND.m(landtype);
inputuse("water","MVP")=wateravail.m;
inputuse(labor,"MVP")=LAboravail.m(labor);
landuse(landtype,irrigation,crop)=sum(cropmanage,
               cropdata(crop,irrigation,landtype,cropmanage)
               *cropprod.l(crop,irrigation,cropmanage));
landuse(landtype,"Grazing",animals)=sum(livemanage,
                 livebud(landtype,animals,livemanage)
                *liveprod.l(animals,livemanage))       ;
cropping(crop,irrigation,cropmanage)=
    cropprod.l(crop,irrigation,cropmanage);

primarysd(primary,"Crop Prod")=     sum((crop,irrigation,cropmanage),
               cropdata(crop,irrigation,primary,cropmanage)
              *cropprod.l(crop,irrigation,cropmanage));

primarysd(primary,"Live Prod")=
    +sum((animals,livemanage)$(livebud(primary,animals,livemanage) gt 0),
               livebud(primary,animals,livemanage)
              *liveprod.l(animals,livemanage));

primarysd(primary,"Live Feed")=
    +sum((animals,livemanage)$(livebud(primary,animals,livemanage) lt 0),
               -livebud(primary,animals,livemanage)
              *liveprod.l(animals,livemanage))
    +sum((feedalt,feedtype),mixfeeds.l(feedalt,feedtype)*
       feedmixrec( primary,feedalt,feedtype));

primarysd(primary,"Sales")=sales.l(primary);
primarysd(primary,"mvpx100") =primarybal.m(primary)*100;

summary("Total","net income") = netincome.l;
summary(landtype,"land use")=
        sum((irrigation,crop),landuse(landtype,irrigation,crop))
       +sum(animals,landuse(landtype,"Grazing",animals));
summary(crop,"Dry Cropping")=sum(landtype,landuse(landtype,"dryland",crop));
summary("Total","Dry Cropping")=sum((landtype,crop),landuse(landtype,"dryland",crop));
summary(crop,"Irr Cropping")=sum(landtype,landuse(landtype,"irrigate",crop));
summary("Total","Irr Cropping")=sum((landtype,crop),landuse(landtype,"irrigate",crop));
summary(animals,"Livestock")=sum(livemanage,liveprod.l(animals,livemanage));
summary("water","Resource Value")=wateravail.m;
summary(landtype,"Resource Value")=LAND.m(landtype);
summary(labor,"Resource Value")=Laboravail.m(Labor);
summary(primary,"Product Value")=Primarybal.m(primary);
summary(feedtype,"Product Value")=feedbal.m(feedtype);

*display inputuse,landuse,cropping;
option decimals=0;
*display primarysd;
option summary:2:1:1;display summary;



$ontext
#user model library stuff
Main topic  Comparative analysis
Featured item 1 Comparative analysis
Featured item 2 Report writing
Featured item 3
Featured item 4
Description
Report writer for comparative analysis

$offtext
