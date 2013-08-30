*well formatted algebraic version of model optimize.gms
*also illustrates report writing and display formatting

SET       Products  Items produced by firm
              /Corn   in acres,
               Wheat  in acres ,
               Cotton in acres/
          Resources  Resources limiting firm production
              /Land   in acres,
               Labor  in hours/;
PARAMETER Netreturns(products)  Net returns per unit produced
              /corn 109 ,wheat 90 ,cotton 115/
          Endowments(resources) Amount of each resource available
              /land 100 ,labor 500/;
TABLE     Resourceusage(resources,products) Resource usage per unit produced
                          corn    wheat  cotton
               land          1       1       1
               labor         6       4       8      ;
POSITIVE VARIABLES   Production(products) Number of units produced;
VARIABLES            Profit               Total fir summed net returns ;
EQUATIONS            ProfitAcct           Profit accounting equation ,
                     Available(Resources) Resource availability limit;
$ontext
      specify definition of profit
$offtext

 ProfitAcct..
      PROFIT
      =E= SUM(products,netreturns(products)*production(products)) ;

$ontext
      Limit available resources
      Fix at exogenous levels
$offtext

 available(resources)..
      SUM(products,
          resourceusage(resources,products) *production(products))
      =L= endowments(resources);

MODEL RESALLOC /ALL/;
SOLVE RESALLOC USING LP MAXIMIZING PROFIT;

set item  /Total,"Use by",Marginal/;
set qitem /Available,Corn,Wheat,Cotton,Value/;
parameter Thisreport(resources,item,qitem) Report on resources;
Thisreport(resources,"Total","Available")=endowments(resources);
Thisreport(resources,"Use by",qitem)=
    sum(products$sameas(products,qitem),
        resourceusage(resources,products) *production.l(products));
Thisreport(resources,"Marginal","Value")=
         available.m(resources);

*illustrate display formatting

option thisreport:2:1:2;
display thisreport;
option thisreport:4:2:1;
display thisreport;


$ontext
#user model library stuff
Main topic Good Modeling
Featured item 1 Formatting
Featured item 2 Display
Featured item 3 Report writing
Featured item 4
Description
Well formatted algebraic version of model optimize.gms
Also illustrates report writing and display formatting

$offtext
