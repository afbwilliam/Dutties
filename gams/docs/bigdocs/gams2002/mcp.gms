*illustrate mcp model

*This is from the GAMS model library and is a revised version of qp6

* Formulate the QP as an LCP, ie write down the first order
* conditions of QP4 and solve.
*
* Michael Ferris, 1998
*
$include qpdata.inc

set d(days)   selected days
    s(stocks) selected stocks
alias(s,t);

* select subset of stocks and periods
d(days)   = ord(days) >1 and ord(days) < 31;
s(stocks) = ord(stocks) < 51;

parameter mean(stocks)           mean of daily return
          dev(stocks,days)       deviations
          totmean                total mean return;

mean(s)  = sum(d, return(s,d))/card(d);
dev(s,d) = return(s,d)-mean(s);
totmean  = sum(s, mean(s))/(card(s));

variables x(stocks)  investments
          w(days)    intermediate variables
          ;
positive variables x;

equations budget
          retcon return constraint
          wdef(days)
          ;

wdef(d)..  w(d) =e= sum(s, x(s)*dev(s,d));
budget.. sum(s, x(s)) =e= 1.0;
retcon.. sum(s, mean(s)*x(s)) =g= totmean*1.25;

equations
    d_x(stocks),
    d_w(days);

variables
    m_budget,
    m_wdef(days);

positive variables
    m_retcon;

m_wdef.fx(days)$(not d(days)) = 0;

d_x(s).. sum(d,m_wdef(d)*dev(s,d)) =g= m_retcon*mean(s) + m_budget;

d_w(d).. 2*w(d)/(card(d)-1)  =e= m_wdef(d);

model qp6 Michael Ferris example of QP4 expressed as MCP/
    d_x.x,
    d_w.w,
    retcon.m_retcon,
    budget.m_budget,
    wdef.m_wdef        /;

solve qp6 using mcp;

parameter z;
z = sum(d, sqr(w.l(d)))/(card(d)-1);
display x.l,z;


$ontext
#user model library stuff
Main topic Model setup
Featured item 1 MCP
Featured item 2 Model
Featured item 3 Complementarity
Featured item 4
include (qpdata.inc)
Description
Illustrate mcp model

This is from the GAMS model library and is a revised version of qp6

$offtext
