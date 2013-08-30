*illustrate nonlinear scaling by solver and gams

$onsymlist offsymxref
 OPTION LIMROW = 0
 OPTION LIMCOL = 0  ;
Set alli   allitems
           /Corn,Soybeans,Beef  ,cattle
            Water,Cropland,Pastureland
            Fertilizer,Seed,Othercost, Veternary, Supplement
           "Aprillabor","Maylabor"
           "Summerlabor","Septlabor","Octlabor",
            Cattlefeed
            Total,totalcost,labor/
    Crop(alli)       CROPS               /CORN ,SOYBEANS /
    Animals(alli)    types of animals    /cattle/
    Primary(alli)    primary commodities /corn,soybeans,beef/
    Purchinput(alli) purchased inputs    / veternary, supplement,totalcost/
    Feedalt          ways of mixing cattle diets /alt1,alt2/
    Landtype(alli)   land types          /cropland,pastureland/
    labor(alli)     labor inputs    /
                     "Aprillabor","Maylabor"
                     "Summerlabor","Septlabor","Octlabor"/
    irrigation       irrigation alternatives /Dryland,Irrigate/
    feedtype(alli)   feeds that are mixed /cattlefeed/
    cropmanage     ways crops can be managed
                       /April-Sept,April-Oct,May-Sept,May-Oct/
    livemanage     ways crops animals can be managed
                        /extensive,intensive/
    farms          farm types in region /farm1,farm2,farm3,farm4,livestock/
    usefeed(farms)  farms which use feed /livestock/
 parameter number(farms) number of farms;
     number(farms)=1;
set mixes /1*125/
set item /amount,acres/
table MIXDAT(farms,item,alli,mixes)        mixdata  on a per acre basis

                                       1           2           3           4

farm1    .amount.Corn              56.57       14.67                   63.71
farm1    .amount.Soybeans          39.24       50.67       54.59       36.67
farm1    .amount.Water              0.86        0.22                    0.86
farm1    .amount.Cropland           1.00        1.00        1.00        1.00
farm1    .amount.totalcost        116.71      103.59       98.78      118.48
farm1    .acres .Corn               0.29        0.07                    0.33
farm1    .acres .Soybeans           0.71        0.93        1.00        0.67
farm2    .amount.Corn             109.67                  161.75
farm2    .amount.Soybeans          22.92       55.00
farm2    .amount.Water              1.75                    1.75
farm2    .amount.Cropland           1.00        1.00        1.00
farm2    .amount.totalcost        135.92       98.00      153.83
farm2    .acres .Corn               0.58                    1.00
farm2    .acres .Soybeans           0.42        1.00
farm3    .amount.Corn              11.56      107.56      159.22
farm3    .amount.Soybeans          51.94       18.94
farm3    .amount.Water              0.17        0.17        0.17
farm3    .amount.Cropland           1.00        1.00        1.00
farm3    .amount.totalcost        101.61      125.61      139.39
farm3    .acres .Corn               0.06        0.66        1.00
farm3    .acres .Soybeans           0.94        0.34
farm4    .amount.Corn              59.43       29.71       75.43      145.88
farm4    .amount.Soybeans          39.29       47.14       33.79        7.62
farm4    .amount.Water              0.86        0.43        0.86        0.86
farm4    .amount.Cropland           1.00        1.00        1.00        1.00
farm4    .amount.totalcost        116.57      107.29      120.57      140.27
farm4    .acres .Corn               0.29        0.14        0.39        0.86
farm4    .acres .Soybeans           0.71        0.86        0.61        0.14

                           +           5           6           7           8

farm1    .amount.Corn             122.07      122.07       85.61      130.51
farm1    .amount.Soybeans          14.52       14.52       28.55       10.45
farm1    .amount.Water              0.86        0.86        0.86        0.86
farm1    .amount.Cropland           1.00        1.00        1.00        1.00
farm1    .amount.totalcost        135.00      135.00      124.38      138.26
farm1    .acres .Corn               0.73        0.73        0.48        0.81
farm1    .acres .Soybeans           0.27        0.27        0.52        0.19
farm4    .amount.Corn             133.29
farm4    .amount.Soybeans          12.57
farm4    .amount.Water              0.86
farm4    .amount.Cropland           1.00
farm4    .amount.totalcost        136.00
farm4    .acres .Corn               0.77
farm4    .acres .Soybeans           0.23;

set activeMIX(farms,mixes) active mixes by farm;
    activeMIX(farms,mixes)$sum(alli$MIXDAT(farms,"acres",alli,mixes),1)=yes;
table available (alli,farms) resources available
                                        farm1   farm2   farm3    farm4
                 cropland              700      400     600       700
                 pastureland           130      300     200       300
;
parameter regavail (alli) Livestock resources available  /

                 pastureland         800
                 "AprilLabor"       1800
                "MayLabor"         2200
                "summerLabor"      3300
                "SeptLabor"        2600
                "OctLabor"         2500 /;

Set curvepar curve parameters /price, quantity, elasticity ,intercept,slope/

table demand(primary,curvepar) demand data
             price  quantity  elasticity
    corn     2.30    75563       -1.2
    soybeans 5.20    14752       -1.5
    Beef     55     66666.66       -.5;
demand(primary,"slope")=demand(primary,"elasticity")*
                 demand(primary,"quantity")/demand(primary,"price");
demand(primary,"intercept")=demand(primary,"price")-
                 demand(primary,"quantity")*demand(primary,"slope");
display demand;
table supply(landtype,curvepar) demand data
                  price  quantity  elasticity
    pastureland    3808    800       0.3
    ;
supply(landtype,"slope")$supply(landtype,"quantity")=supply(landtype,"elasticity")*
                 supply(landtype,"quantity")/supply(landtype,"price");
supply(landtype,"intercept")=supply(landtype,"price")-
                 supply(landtype,"quantity")*supply(landtype,"slope");
display supply;
table mktcost(primary,farms) farm transactions cost in marketing
                             farm1 farm2 farm3  farm4
            corn              0.10         .02    .05
            soybeans          0.20         .04
            beef              5            14        ;
table feedmixrec( alli,feedalt,feedtype) feed mix recipies
                              alt1.cattlefeed   alt2.cattlefeed
              corn                 1.2               1.3
              soybeans              .2               .15
              supplement            1.5               1.1  ;
table livebud(alli,animals,livemanage)  livestock budgets
                             cattle.extensive  cattle.intensive
               corn                 -2                   -3
               beef               11                  12.50
               pastureland         0.7                 0.15
               othercost           380                  440
              "Aprillabor"        0.3                  0.2
              "Maylabor"          0.3                  0.2
              "summerlabor"       0.6                  0.4
              "Septlabor"         0.3                  0.2
              "Octlabor"          0.3                  0.2
               cattlefeed           16                   29
               veternary            10                   15;


parameter cost(purchinput)  purchased input costs;
    cost(purchinput)=1;
parameter regwataval   regional water availability;
regwataval=sum(farms,available("water",farms));
scalar regmodel equals one if running regional model /1/ ;
parameter regfarmlab(labor)  refional farmlabor availability;
regfarmlab(labor)=sum(farms,available(labor,farms));
positive variables
     farmmix(farms,mixes)                         total farm crop mix use
     liveprod(animals,livemanage)                 livestock production
     sales(primary)                               primary product sales
     mixfeeds(feedalt,feedtype)                   feed mixing
     market(farms,primary)                        primary product sales
     buyinput(purchinput)                         purchased input acquisition
     facsupply(landtype)                             landtype supply curve
;

VARIABLES
  CSPS                       consumer and producer surplus

EQUATIONS
  OBJT                       OBJECTIVE FUNCTION (NET REVENUE)
  LAND(farms,landtype)       LAND AVAILABLE
  primarybal(primary)        Primary product balance
  farmpribal(farms,primary)  Farm level primary product balance
  livelabor(labor)           livestock Regional labor available
  liveland(landtype)         livestock Regional land available
  feedbal(feedtype)          Feed Balance
  convex(farms)              mix limit
  inputbal(purchinput)       purchased input balance
;

  OBJT..        CSPS=E=  (
    sum(primary,demand(primary,"intercept")*sales(primary)+
               0.5* demand(primary,"slope")*sales(primary)*sales(primary) )
    - sum((farms,primary),mktcost(primary,farms)*
                     market(farms,primary))
   -sum(purchinput,cost(purchinput)*buyinput(purchinput))
   -sum(landtype,supply(landtype,"intercept")*facsupply(landtype)
               +0.5* supply(landtype,"slope")*facsupply(landtype)
                                             *facsupply(landtype) ))
   ;
  LAND(farms,landtype)..
     sum(activemix(farms,mixes),
               mixdat(farms,"amount",landtype,mixes)
              *farmmix(farms,mixes))
    =l= available (landtype,farms)*number(farms);

   Liveland(landtype)..
       +sum((animals,livemanage),livebud(landtype,animals,livemanage)
                              *liveprod(animals,livemanage))
      =l= regavail(landtype)$(supply(landtype,"slope") eq 0)
         +facsupply(landtype)$supply(landtype,"slope");

livelabor(labor)..
   +sum((animals,livemanage),livebud(labor,animals,livemanage)
                              *liveprod(animals,livemanage))
     =l=regavail(labor);

convex(farms).. sum(activemix(farms,mixes), farmmix(farms,mixes)) =l=
       available("cropland",farms)*number(farms);

  Primarybal(primary)..
     sales(primary)
      +sum((feedalt,feedtype),mixfeeds(feedalt,feedtype)*
       feedmixrec(primary,feedalt,feedtype))

     =l= sum(farms,market(farms,primary))
       +sum((animals,livemanage),livebud(primary,animals,livemanage)
                              *liveprod(animals,livemanage))
         ;

feedbal(feedtype)..
     +sum((animals,livemanage),livebud(feedtype,animals,livemanage)
                 *liveprod(animals,livemanage))
      =l= sum(feedalt$sum(primary,feedmixrec( primary,feedalt,feedtype))
                     ,mixfeeds(feedalt,feedtype));



  farmPribal(farms,primary)..
     market(farms,primary)
     =l=
      sum(activemix(farms,mixes),
               mixdat(farms,"amount",primary,mixes)
              *farmmix(farms,mixes));

  inputbal(purchinput)..
      sum(activemix(farms,mixes),
               mixdat(farms,"amount",purchinput,mixes)
              *farmmix(farms,mixes))
     =l= buyinput(purchinput);

MODEL nation /ALL/;
option nlp=minos;
file opt /minos.opt/
put opt
put ' superbasics  100' /;
put 'scale nonlinear variables' /;
put 'optimality tolerance 0.0000000001' /;
putclose;

nation.optfile=1;
SOLVE nation USING NLP MAXIMIZING csps;
sales.l(primary)=demand(primary,"quantity");
facsupply.l(landtype)=supply(landtype,"quantity");

sales.scale(primary)=1000;
sales.scale("beef")=1000000;
Primarybal.scale(primary)=sales.scale(primary);
farmPribal.scale(farms,primary) =sales.scale(primary);

csps.scale=1000000;
objt.scale=csps.scale;
*nation.optfile=1;
*  option solprint=off;
nation.scaleopt=1;
nation.optfile=1;
parameter report(*,*,*);
report("csps","level","noscale")=csps.l;
report("sales",primary,"noscale")=sales.l(primary);
*option nlp=gamschk;
SOLVE nation USING NLP MAXIMIZING csps;
report("csps","level","scale")=csps.l;
report("sales",primary,"scale")=sales.l(primary);
display report;

$ontext
#user model library stuff
Main topic Scaling
Featured item 1 Scale
Featured item 2 Scaleopt
Featured item 3 Options file
Featured item 4 Solver scale
include minos.opt
Description
illustrate nonlinear scaling by solver and GAMS
$offtext
