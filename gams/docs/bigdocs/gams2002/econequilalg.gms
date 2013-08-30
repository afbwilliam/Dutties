
Set commodities /Corn,Wheat/;
Set curvetype /Supply,Demand/;
Table intercepts(curvetype,commodities)
                  corn   wheat
         demand    4       8
         supply    1       2;
table slopes(curvetype,commodities,commodities)
                   corn  wheat
     demand.corn   -.3    -.1
     demand.wheat  -.07   -.4
     supply.corn    .5     .1
     supply.wheat   .1     .3     ;
POSITIVE VARIABLES  P(commodities)
                    Qd(commodities)
                    Qs(commodities)  ;
EQUATIONS     PDemand(commodities)
              PSupply(commodities)
              Equilibrium(commodities)  ;
alias (cc,commodities);
Pdemand(commodities)..
    P(commodities)=g=
       intercepts("demand",commodities)
       +sum(cc,slopes("demand",commodities,cc)*Qd(cc));
Psupply(commodities)..
    intercepts("supply",commodities)
   +sum(cc,slopes("supply",commodities,cc)* Qs(cc))
    =g= P(commodities);
Equilibrium(commodities)..
     Qs(commodities)=g=  Qd(commodities);
MODEL PROBLEM /Pdemand.Qd, Psupply.Qs,Equilibrium.P/;
SOLVE PROBLEM USING MCP;

set qitem /Demand, Supply, "Market Clearing"/;
set item /Quantity,Price/
parameter myreport(qitem,item,commodities);
myreport("Demand","Quantity",commodities)= Qd.l(commodities);
myreport("Supply","Quantity",commodities)= Qs.l(commodities);
myreport("Market Clearing","Price",commodities)= p.l(commodities);
display myreport;

$ontext
#user model library stuff
Main topic Algebraic modeling
Featured item 1 Model
Featured item 2 Mcp
Featured item 3 Complementarity
Featured item 4 Sets
Description
*Algebraic mcp of econ equilibrium

$offtext
