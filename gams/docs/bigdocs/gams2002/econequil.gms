*simple mcp of econ equilibrium

POSITIVE VARIABLES  P, Qd , Qs;
EQUATIONS     PDemand,PSupply, Equilibrium;
Pdemand..     P            =g= 6 - 0.3*Qd;
Psupply..    ( 1 + 0.2*Qs) =g= P;
Equilibrium.. Qs           =g=  Qd;
MODEL PROBLEM /Pdemand.Qd, Psupply.Qs,Equilibrium.P/;
SOLVE PROBLEM USING MCP;

$ontext
#user model library stuff
Main topic MCP
Featured item 1 Model
Featured item 2 Mcp
Featured item 3 Complementarity
Featured item 4
Description
*simple mcp of econ equilibrium

$offtext
