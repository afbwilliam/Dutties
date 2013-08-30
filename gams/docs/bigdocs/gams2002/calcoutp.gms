*illustrate simple report writing

$Title  A Transportation Problem (TRNSPORT,SEQ=1)
$Ontext
  This problem is an adaptation of the GAMS model
  library and GAMS users manualproblem trnsport.gms
$Offtext
  Sets
       Source       canning plants   / Seattle, "San Diego" /
       Destinaton   markets          / "New York", Chicago, Topeka / ;
Parameters
    Supply(Source)   Supply at each source plant in cases
         /seattle  350, "san diego" 600  /
    Need(Destinaton) Amount neeeded at each market destination in cases
         /"new york" 325, chicago   300,  topeka 275  / ;
Table distance(Source,Destinaton)  distance in thousands of miles
                    "new york"      chicago      topeka
      seattle          2.5           1.7          1.8
      "San diego"      2.5           1.8          1.4  ;
Scalar
   prmilecst   freight cost in $ per case per 1000 miles /90/
   loadcost    freight loading cost in $ per case /25/        ;
Parameter trancost(Source,Destinaton)  transport cost in dollars per case ;
   trancost(Source,Destinaton) =
         loadcost + prmilecst * distance(Source,Destinaton) ;
display trancost;
option decimals=0;
display trancost;

Positive Variable
    transport(Source,Destinaton) shipment quantities in cases;
Variable
    totalcost total transportation costs in dollars ;
Equations
       Costsum                 total transport cost -- objective function
       Supplybal(Source)       supply limit at source plants
       Demandbal(Destinaton)   demand at destinations ;

Costsum ..  totalcost  =e=  sum((Source,Destinaton),
         trancost(Source,Destinaton)*transport(Source,Destinaton));

Supplybal(Source) ..
     sum(destinaton, transport(Source,Destinaton))
            =l=  supply(Source) ;

  demandbal(Destinaton) ..
   sum(Source, transport(Source,Destinaton))
           =g=  need(Destinaton) ;

  Model tranport /all/ ;

  Solve tranport using lp minimizing totalcost ;
display transport.l,transport.l,demandbal.m;

parameter outgoing(*,*,*,*,*,*) out going shipment report;
outgoing("Shipments","in cases","from",source,"to",destinaton)
              =transport.l(source,destinaton);
outgoing("Shipments","in cases","from",source,"to","total") =
  sum(destinaton,
     outgoing("Shipments","in cases","from",source,"to",destinaton));
outgoing("Marg Value of","more supply","at",source," ","Total")
              =supplybal.m(source);
outgoing("Cost of","shipping","from",source," ","total")
       =sum(destinaton,
         trancost(source,destinaton)*transport.l(source,destinaton));
outgoing("Total","shipments","from all","sources","to",destinaton)
        =sum(source,
            outgoing("Shipments","in cases","from",source,"to",destinaton));
outgoing("total","Cost of","all","shipping"," ","total")=
       sum(source,outgoing("Cost of","shipping","from",source," ","total"));
 option outgoing:0:4:2;display outgoing;
parameter incoming(*,*,*,*,*) in coming shipment report;
incoming(destinaton,"shipments","in cases","from",source)
         =transport.l(source,destinaton);
incoming(destinaton,"shipments","in cases","from","total")=
  sum(source,incoming(destinaton,"shipments","in cases","from",source));
incoming(destinaton,"Marg Cost of","meeting needs"," ","Total")
         =demandbal.m(destinaton);
incoming(destinaton,"Cost of","shipping"," ","total")
      =sum(source,
       trancost(source,destinaton)*transport.l(source,destinaton));
incoming("total","shipments","in cases","from",source)=sum(destinaton,
    incoming(destinaton,"shipments","in cases","from",source));
incoming("Total","Cost of","shipping"," ","total")=sum(destinaton,
        incoming(destinaton,"Cost of","shipping"," ","total"));
option incoming:0:3:2;display incoming;
option incoming:0:0:5;display incoming;
$ontext
#user model library stuff
Main topic Report writing
Featured item 1 .L attribute
Featured item 2 .M attribute
Featured item 3 Display format
Featured item 4 Report writing
Description
Illustrate simple report writing and display formatting

$offtext
