*well formatted algebraic version of model optimize.gms
*also illustrates report writing and display formatting

SET       Products  Items produced by firm
              /Chairs  , Tables , Dressers /
          Resources  Resources limiting firm production
              /RawWood , Labor  , WarehouseSpace/
          Hireterms  Resource hiring terms
              /Cost , Maxavailable /;
PARAMETER Netreturns(products)  Net returns per unit produced
              /Chairs 19  , Tables 50, Dressers 75/
          Endowments(resources) Amount of each resource available
              /RawWood 700 , Labor 1000 , WarehouseSpace 240/;
TABLE     Resourceusage(resources,products) Resource usage per unit produced
                          Chairs   Tables  Dressers
          RawWood            8        20      32
          Labor             12        32      45
          WarehouseSpace     4        12      10   ;
Table     Hiredata(Resources,hireterms)  Resource hiring data
                          Cost   Maxavailable
          RawWood            3        200
          Labor             12        120
          WarehouseSpace     4        112;
POSITIVE VARIABLES   Production(products)    Number of units produced
                     HireResource(Resources) Resources hired;
VARIABLES            Profit                  Total firm summed net returns ;
EQUATIONS            ProfitAcct              Profit accounting equation ,
                     Available(Resources)    Resource availability limit
                     Hirelimit(Resources)    Resource hiring limit;
 ProfitAcct..
      PROFIT
      =E= SUM(products,netreturns(products)*production(products))
         -SUM(resources,hiredata(resources,"cost")* HireResource(Resources))   ;
 available(resources)..
      SUM(products,
          resourceusage(resources,products) *production(products))
      =L= endowments(resources) +  HireResource(Resources);
Hirelimit(Resources)..
          HireResource(Resources) =l= hiredata(resources,"maxavailable");
MODEL RESALLOC /ALL/;
SOLVE RESALLOC USING LP MAXIMIZING PROFIT;

set item  /Total,"Use by",Marginal/;
*use universal set
set qitem(*) /Available,Value/;
qitem(products)=yes;
parameter Thisreport(resources,item,*) Report on resources;
Thisreport(resources,"Total","Available")=endowments(resources);
Thisreport(resources,"Use by",qitem)=
    sum(products$sameas(products,qitem),
        resourceusage(resources,products) *production.l(products));
Thisreport(resources,"Marginal","Value")=
         available.m(resources);

*illustrate display formatting

option thisreport:2:1:2;
display thisreport;
$ontext
#user model library stuff
Main topic Model adaptation
Featured item 1 Adding to model
Featured item 2 Report writing
Featured item 3 Display formatting
Description
well formatted algebraic version of model optimize.gms
also illustrates report writing and display formatting
$offtext
