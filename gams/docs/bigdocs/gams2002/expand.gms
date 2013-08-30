*illustrates expandability of model

SET       Products  Items produced by firm
              /Chairs  , Tables , Dressers, HeadBoards, Cabinets /
          Resources  Resources limiting firm production
              /RawWood , Labor  , WarehouseSpace , Hardware, ShopTime/;
PARAMETER Netreturns(products)  Net returns per unit produced
          /Chairs 19,Tables 50,Dressers 75,HeadBoards 28,Cabinets 25/
          Endowments(resources) Amount of each resource available
          /RawWood 700,Labor 1000,WarehouseSpace 240,Hardware 100, Shoptime 600/;
TABLE     Resourceusage(resources,products) Resource usage per unit produced
                          Chairs   Tables  Dressers HeadBoards Cabinets
          RawWood            8        20      32         22      15
          Labor             12        32      45         12      18
          WarehouseSpace     4        12      10          3       7
          Hardware           1         1       3          0       2
          Shoptime           6         8      30          5      12;
POSITIVE VARIABLES   Production(products) Number of units produced;
VARIABLES            Profit               Total fir summed net returns ;
EQUATIONS            ProfitAcct           Profit accounting equation ,
                     Available(Resources) Resource availability limit;
 ProfitAcct..
      PROFIT
      =E= SUM(products,netreturns(products)*production(products)) ;
 available(resources)..
      SUM(products,
          resourceusage(resources,products) *production(products))
      =L= endowments(resources);
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
Main topic  Algebraic modeling
Featured item 1 Expandability
Featured item 2
Featured item 3
Featured item 4
Description
illustrates expandability of model
$offtext
