*compiler errors in MCP

POSITIVE VARIABLES  P, Qd , Qs;
EQUATIONS     PDemand,PSupply, Equilibrium;
Pdemand..     P            =g= 6 - 0.3*Qdemand;
Psupply..    ( 1 + 0.2*Qs) =g= P
Equilibrium.. Qs           =g=  Qdemand;
MODEL PROBLEM /Pdemand.Qdemand, Psupply.Qs,Equilibrium.P/;
SOLVE PROBLEM USING MCP;

$ontext
#user model library stuff
Main topic  Tutorial
Featured item 1  MCP
Featured item 2  Compiler error
Featured item 3
Featured item 4
Description
compiler errors in MCP

$offtext
