*Illustrate conditional compile using goto and label to
*include very different code depending on control variables

$setglobal mode
Sets Source       plants   / Seattle, "San Diego" /
     Destinaton   markets          / "New York", Chicago, Topeka / ;
Parameters  Supply(Source)   Supply at each source
           /seattle  350, "san diego" 600  /
            Need(Destinaton) Demand at each market
           /"new york" 325, chicago   300,  topeka 275  / ;
Table distance(Source,Destinaton)  distance in thousands of miles
                    "new york"      chicago      topeka
      seattle          2.5           1.7          1.8
      "San diego"      2.5           1.8          1.4  ;
$if setglobal mode $goto mode
Scalar  prmilecst   freight cost in $ per case per 1000 miles /90/
        loadcost    freight loading cost in $ per case /25/        ;
Parameter trancost(Source,Destinaton)  transport cost in dollars per case ;
   trancost(Source,Destinaton) =
         loadcost + prmilecst * distance(Source,Destinaton) ;
$goto around
$label mode
set mode /truck,train/
parameter prmilecst(mode)  /truck 90,train 70/
          loadcost(mode)   /truck 25,train 100/        ;
Parameter trancost(Source,Destinaton,mode)  transport cost  ;
   trancost(Source,Destinaton,mode) =
         loadcost(mode) + prmilecst(mode) * distance(Source,Destinaton) ;
$label around
Positive Variable
$if setglobal mode transport(Source,Destinaton,mode) shipment quantities in cases;
$if not setglobal mode transport(Source,Destinaton) shipment quantities in cases;
Variable    totalcost total transportation costs in dollars ;
Equations   Costsum                 total transport cost -- objective function
    Supplybal(Source)       supply limit at source plants
    Demandbal(Destinaton)   demand at destinations ;
$if not setglobal mode $goto nomode
Costsum ..  totalcost  =e=  sum((Source,Destinaton),
          sum(mode,trancost(Source,Destinaton,mode)
                  *transport(Source,Destinaton,mode)));
Supplybal(Source) ..
     sum((destinaton,mode), transport(Source,Destinaton,mode))
            =l=  supply(Source) ;
demandbal(Destinaton) ..
   sum((Source,mode), transport(Source,Destinaton,mode))
           =g=  need(Destinaton) ;
$goto modset
$label nomode
Costsum ..  totalcost  =e=  sum((Source,Destinaton),
                 trancost(Source,Destinaton)
                 *transport(Source,Destinaton));
Supplybal(Source) ..
     sum((destinaton), transport(Source,Destinaton))
            =l=  supply(Source) ;
demandbal(Destinaton) ..
   sum((Source), transport(Source,Destinaton))
           =g=  need(Destinaton) ;
$label modset
  Model tranport /all/ ;
  Solve tranport using lp minimizing totalcost ;


$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 $Set
Featured item 2 $Goto
Featured item 3 $Label
Featured item 4
Description
Illustrate conditional compile using goto and label to
cause very different code to be compiled depending on control variables

$offtext
