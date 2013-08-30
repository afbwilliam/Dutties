*Illustrate calculation of set membership

option limrow=0;option limcol=0;
alias(sources,places,*)
table trandata (sources,places) transport data from spreadsheet
*$import tran.prn
                     newyork      chicago      topeka     totalsupply
      seattle          2.5           1.7          1.8          350
      Sandiego         2.5           1.8          1.4          300
      totalneed        325            75          250
set source(sources)  sources in spreadsheet data
    destinaton(places) destinations in spreadsheet data;
source(sources)$(trandata(sources,"totalsupply"))=yes;
destinaton(places)$(trandata("totalneed",places))=yes;
display source,destinaton;
Parameters
    Supply(Sources)   Supply at each source plant in cases
    Need(places)      Amount neeeded at each market destination in cases
    distance(sources,places) distance matrix;
    supply(source) = trandata(source,"totalsupply");
    Need(destinaton) = trandata("totalneed",destinaton);
    distance(source,destinaton)=trandata(source,destinaton);
Scalar
   prmilecst   freight cost in $ per case per 1000 miles /90/
   loadcost    freight loading cost in $ per case /25/        ;
Parameter trancost(Sources,places)  transport cost in dollars per case ;
   trancost(Source,Destinaton) =
         loadcost + prmilecst * distance(Source,Destinaton) ;
Positive Variable
    transport(Sources,places) shipment quantities in cases;
Variable
    totalcost total transportation costs in dollars ;
Equations
       Costsum                 total transport cost -- objective function
       Supplybal(Sources)      supply limit at source plants
       Demandbal(places)       demand at destinations ;

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

$ontext
#user model library stuff
Main topic Set
Featured item 1 Unknown elements
Featured item 2 Calculate elements
Featured item 3
Featured item 4
Description
Illustrate use of a While statement

$offtext
