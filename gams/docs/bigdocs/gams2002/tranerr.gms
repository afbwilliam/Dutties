*Model with compilation errors

Sets
  Source       canning plants   / Seattle, "San Diego" /
  Destinaton   markets          / "New York", Chicago, Topeka ,"San Francisco"/ ;

Parameters
  Supply(Source)   Supply at each source plant in cases
         /seattle  350, "san diego" 600  /
  Need(Destinaton) Amount neeeded at each market destination in cases
         /"new york" 325, chicago   300,  topeka 275  / ;

Table distance(Sorce,Destinaton)  distance in thousands of miles
                 "new york"      chicago      topeka "San Francisco"
   seattle          2.5           1.7          1.8        1.0
  "San diego"       2.5           1.8          1.4        1.5;

Scalar
   prmilecst   freight cost in $ per case per 1000 miles /90/
   loadcost    freight loading cost in $ per case /25/        ;

Parameter trancost(Source,Destinaton)  transport cost in dollars per case ;
   trancost(Source,Destinaton)=loadcost + prmilecst * distance(Source,Destinaton) ;

Display trancost;

Positive Variable
    Transport(Source,Destinaton) shipment quantities in cases;
Variable
    Totalcost total transportation costs in dollars ;

Equations
       Costsum                 total transport cost -- objective function
       Supplybal(Source)       supply limit at source plants
       Demandbal(Destinaton)   demand at destinations ;

Cotssum ..  totalcost  =e=  sum((Source,Destinaton),
         trancost(Source,Destinaton)*transport(Source,Destinaton));

Supplybal(Source) ..
     sum(destinaton, transport(Source,Destinaton)) =l=  supply(Source) ;

Demandbal(Destination) ..
   sum(Source, transport(Source,Destinaton))=g=  need(Destinaton) ;

Model tranport /all/ ;

Solve tranport using lp minimizing totalcost ;

$ontext
#user model library stuff
Main topic GAMSIDE
Featured item 1 Compilation errors
Featured item 2
Featured item 3
Featured item 4
Description
Model with compilation errors

$offtext
