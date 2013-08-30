$ontext

Base model for comparative analysis

$offtext
$onsymlist offsymxref
 OPTION LIMROW = 0
 OPTION LIMCOL = 0  ;
Set alli   allitems
           /Corn,Soybeans,Beef  ,cattle
            Water,Cropland,Pastureland
            Fertilizer,Seed,Othercost, Veternary, Supplement
           "April Labor","May Labor"
           "Summer Labor","Sept Labor","Oct Labor",
            Cattlefeed
            Total/
    Crop(alli)       CROPS               /CORN ,SOYBEANS /
    Animals(alli)    types of animals    /cattle/
    Primary(alli)    primary commodities /corn,soybeans,beef/
    Purchinput(alli) purchased inputs    /fertilizer,seed,othercost
                                          veternary, supplement/
    Feedalt          ways of mixing cattle diets /alt1,alt2/
    Landtype(alli)   land types          /cropland,pastureland/
    Labor(alli)      Labor inputs    /
                     "April Labor","May Labor"
                     "Summer Labor","Sept Labor","Oct Labor"/
    irrigation       irrigation alternatives /Dryland,Irrigate/
    feedtype(alli)   feeds that are mixed /cattlefeed/
    cropmanage     ways crops can be managed
                       /April-Sept,April-Oct,May-Sept,May-Oct/
    livemanage     ways crops animals can be managed
                        /extensive,intensive/
table cropdata (crop,irrigation,alli,cropmanage)   crop budget data
                                   April-Sept  April-Oct May-Sept May-Oct
corn.dryland. corn                      140       150       135      150
corn.dryland. cropland                    1         1         1        1
corn.dryland. water                       0         0         0        0
corn.dryland. fertilizer                 60        63        58       60
corn.dryland. seed                       28        33        33       28
corn.dryland. othercost                  50        50        50       50
corn.dryland."April Labor"               1.5       1.5
corn.dryland."May Labor"                                     1.5      1.5
corn.dryland."Summer Labor"               1         1         1        1
corn.dryland."Sept Labor"                 2                 1.9
corn.dryland."Oct Labor"                           2.1                 2

corn.irrigate. corn                      195       200       185      198
corn.irrigate. cropland                    1         1        1        1
corn.irrigate. water                       3         3        3        3
corn.irrigate. fertilizer                 60        63       58       60
corn.irrigate. seed                       28        33       33       28
corn.irrigate. othercost                  75        75       75       75
corn.irrigate."April Labor"               2.7      2.7
corn.irrigate."May Labor"                                   2.7      2.7
corn.irrigate."Summer Labor"               3         3        3        3
corn.irrigate."Sept Labor"               1.8                1.4
corn.irrigate."Oct Labor"                           1.9              1.8

soybeans.dryland. soybeans                55        56       54       53
soybeans.dryland. cropland                 1         1        1        1
soybeans.dryland. water                    0         0        0        0
soybeans.dryland. fertilizer              20        23       18       20
soybeans.dryland. seed                    28        33       33       28
soybeans.dryland. othercost               50        50       50       50
soybeans.dryland."April Labor"            1.5      1.5
soybeans.dryland."May Labor"                                 1.5     1.5
soybeans.dryland."Summer Labor"            1         1        1        1
soybeans.dryland."Sept Labor"              1                0.9
soybeans.dryland."Oct Labor"                       1.1                 1

soybeans.irrigate. soybeans               57        59       57       55
soybeans.irrigate. cropland                1         1        1        1
soybeans.irrigate. water                   2         2        2        2
soybeans.irrigate. fertilizer             50        53       48       50
soybeans.irrigate. seed                   28        33       33       28
soybeans.irrigate. othercost              65        65       65       65
soybeans.irrigate."April Labor"          2.7       2.7
soybeans.irrigate."May Labor"                               2.7      2.7
soybeans.irrigate."Summer Labor"           3         3        3        3
soybeans.irrigate."Sept Labor"           1.1                1.0
soybeans.irrigate."Oct Labor"                      1.2               1.1;
table feedmixrec( alli,feedalt,feedtype) feed mix recipies
                              alt1.cattlefeed   alt2.cattlefeed
              corn                 1.2               1.3
              soybeans              .2               .15
              othercost            1.5               1.1  ;
table livebud(alli,animals,livemanage)  livestock budgets
                                cattle.extensive  cattle.intensive
              corn                 -2                   -3
              beef               1100                 1250
              pastureland         0.7                 0.15
              othercost           380                  440
              "April Labor"       0.3                   0.2
              "May Labor"         0.3                   0.2
              "summer Labor"      0.6                   0.4
              "Sept Labor"        0.3                   0.2
              "Oct Labor"         0.3                   0.2
               cattlefeed          16                    29
               veternary           10                    15;

parameter available (alli) resources available
              /  cropland              700
                 pastureland           130
                 water                 600
                "April Labor"          700
                "May Labor"            850
                "summer Labor"        4500
                "Sept Labor"           630
                "Oct Labor"            530
              /
PARAMETER price(primary)  prices for products
           /corn     2.20
            soybeans 5.00
            beef     0.50/;
parameter cost(purchinput)  purchased input costs;
    cost(purchinput)=1;
positive variables
     cropprod(crop,irrigation,cropmanage)   crop production
     liveprod(animals,livemanage)           livestock production
     sales(primary)                          primary product sales
     buyinput(purchinput)                    purchased input acquisition
     mixfeeds(feedalt,feedtype)              feed mixing;

VARIABLES
  NETINCOME     NET REVENUE (PROFIT)

EQUATIONS
  OBJT                 OBJECTIVE FUNCTION (NET REVENUE)
  LAND(landtype)       LAND AVAILABLE
  Laboravail(Labor)    Labor AVAILABLE
  Primarybal(primary)  Primary product balance
  feedbal(feedtype)    Feed Balance
  inputbal(purchinput) Purchased input balance
  wateravail           water available;

  OBJT..        NETINCOME=E=
    sum(primary,price(primary)*sales(primary))
   -sum(purchinput,cost(purchinput)*buyinput(purchinput));

  LAND(landtype)..
     sum((crop,irrigation,cropmanage),
               cropdata(crop,irrigation,landtype,cropmanage)
              *cropprod(crop,irrigation,cropmanage))
    +sum((animals,livemanage),livebud(landtype,animals,livemanage)
                              *liveprod(animals,livemanage))
    =l= available (landtype);

  Laboravail(Labor)..
     sum((crop,irrigation,cropmanage),
             cropdata(crop,irrigation,Labor,cropmanage)
            *cropprod(crop,irrigation,cropmanage))
    +sum((animals,livemanage),
          livebud(Labor,animals,livemanage)
         *liveprod(animals,livemanage))
     =l= available (Labor);

  wateravail..
     sum((crop,irrigation,cropmanage),
                  cropdata(crop,irrigation,"water",cropmanage)
                 *cropprod(crop,irrigation,cropmanage))
    +sum((animals,livemanage),
            livebud("water",animals,livemanage)
           *liveprod(animals,livemanage))
     =l= available("water");

  Primarybal(primary)..
     sales(primary)+
     sum((feedalt,feedtype),mixfeeds(feedalt,feedtype)*
       feedmixrec( primary,feedalt,feedtype))
     =l=
     sum((crop,irrigation,cropmanage),
               cropdata(crop,irrigation,primary,cropmanage)
              *cropprod(crop,irrigation,cropmanage))
    +sum((animals,livemanage),
               livebud(primary,animals,livemanage)
              *liveprod(animals,livemanage));

  feedbal(feedtype)..
     +sum((animals,livemanage),livebud(feedtype,animals,livemanage)
                 *liveprod(animals,livemanage))
      =l= sum(feedalt$sum(primary,feedmixrec( primary,feedalt,feedtype))
                     ,mixfeeds(feedalt,feedtype));

  inputbal(purchinput)..
      sum((feedalt,feedtype),mixfeeds(feedalt,feedtype)*
               feedmixrec( purchinput,feedalt,feedtype))
     +sum((crop,irrigation,cropmanage),
                cropdata(crop,irrigation,purchinput,cropmanage)
               *cropprod(crop,irrigation,cropmanage))
    +sum((animals,livemanage),
            livebud(purchinput,animals,livemanage)
           *liveprod(animals,livemanage))
     =l= buyinput(purchinput);
*  option lp=gamschk;
  MODEL FARM /ALL/;
  option solprint=off;
  SOLVE FARM USING LP MAXIMIZING NETINCOME;

parameter inputuse(alli,*) input usage by production system;
parameter landuse(landtype,*,*) land use;
parameter cropping(Crop,irrigation,cropmanage) crop land use;
parameter Primarysd(primary,*) primary product supply demand disappearance;
Set measures  output measures
     / "Net Income", "Land use", "Dry Cropping", "Irr Cropping",
       "Livestock", "Resource Value","Product Value"/
Parameter summary(alli,measures)   Farm Summary;

$ontext
#user model library stuff
Main topic  Comparative analysis
Featured item 1 Comparative analysis
Featured item 2
Featured item 3
Featured item 4
Description
Base model for comparative analysis

$offtext
