$Ontext
  Simplist put file example
  Uses gams command line parameters thorugh gams.xxx

  This problem is an adaptation of the GAMS model
  library and GAMS users manual problem trnsport.gms
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
* option lp=gamschk;
  Solve tranport using lp minimizing totalcost ;

   set scenarios Four alternatives /base Base Case,
                                   scen1 No Chicago
                                   scen2 No New York
                                   scen3 No Topeka/;
    table  demandscen(destinaton,scenarios)
                    base  scen1 scen2 scen3
         "new york"  325    625     0   525
          chicago    300      0   625   375
          topeka     275    275   275     0;
parameter savtransport(Source,Destinaton,scenarios);
parameter report(*,*,scenarios);
file myputfile;
put myputfile;
put 'Run on ' system.date '  using source file  ' system.ifile //;
put 'Run over scenario set ' scenarios.ts //;
loop(scenarios,
    Need(Destinaton)=demandscen(destinaton,scenarios);
    Solve tranport using lp minimizing totalcost ;
    report("total","cost",scenarios)=totalcost.l;
    report("demand shadow price",Destinaton,scenarios)
            = demandbal.m(Destinaton);
    report("supply shadow price",Source,scenarios)
          = Supplybal.m(Source);
    savtransport(Source,Destinaton,scenarios)=transport.l(Source,Destinaton);
    put 'Scenario name   ' scenarios.te(scenarios):14
    put @30 ' Optimality status     ' tranport.modelstat:2:0 /;
    put @30 ' Optimality status text ' tranport.Tmodstat /;
    put @30 ' Solver status         ' tranport.solvestat:2:0 /;
    put @30 ' Solver status text     ' tranport.Tsolstat /;
   )      ;
put //;
loop(Destinaton,
  put 'Report for ' , Destinaton.tl:15
  put @40 '------------  Scenario  ------------' /;
  put @41;
  loop(scenarios,put scenarios.tl:10);
  put /;
  loop(source
       $sum(scenarios,abs(savtransport(Source,Destinaton,scenarios))),
     put 'Incoming From ' source.tl @35;
     loop(scenarios,
         put savtransport(Source,Destinaton,scenarios):10:0);
     put /;
      );
  put 'Quantity demanded ' @35
  loop(scenarios,put demandscen(destinaton,scenarios):10:0);
  put /;
         put 'Marginal Cost of meeting demand ' @35
         loop(scenarios,
             put  report("demand shadow price",Destinaton,scenarios):10:2);
         put /
  put /;
    );
put 'sstring ' system.sstring   //;

put "page size         = " "%gams.ps%" /;
put "gams input file   = " "%gams.input%" /;
put "gams restart file = " "%gams.restart%" /;

put / "example of .tn use" //;
loop((scenarios,Source,Destinaton)$savtransport(Source,Destinaton,scenarios),
     put savtransport.tn(Source,Destinaton,scenarios):0:0 @50
         " = "
         savtransport(Source,Destinaton,scenarios) /;
     );
$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 File
Featured item 3 gams.xxx
Featured item 4
Description
  Simplist put file example
  Uses gams command line parameters thorugh gams.xxx

  This problem is an adaptation of the GAMS model
  library and GAMS users manual problem trnsport.gms

$offtext