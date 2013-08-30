*Ilustrate model, equation and variable attributes

set j /j1,j2/;
set source supply /boston,lasvegas/;
set sink   demand /newyork,seattle/;
Table historicmove(source,sink) historic moves
            newyork  seattle
boston         3
lasvegas       1        2;
Table costtomove(source,sink) historic moves
            newyork  seattle
boston         1        4
lasvegas       3        2;
parameter supply(source) supply;
parameter demand(sink)   demand;
supply(source)=sum(sink,historicmove(source,sink));
demand(sink)=sum(source,historicmove(source,sink));
variable cost;
positive variable move(source,sink);
equations obj
          sinkdemand(sink)
          sourcesupply(source);
obj..  cost=e=sum((source,sink),
           costtomove(source,sink)*move(source,sink));
sinkdemand(sink).. sum(source,move(source,sink))=g=demand(sink);
sourcesupply(source).. sum(sink,move(source,sink))=l=supply(source);
model transport /all/;
variable x(j);

X.l(j)=1;
Move.l(source,sink)=historicmove(source,sink);
sinkdemand.m(sink)=1;
sourcesupply.m(source)=1;
Move.m("boston","seattle")=1;
solve transport using lp minimizing cost;

scalar totalcost;
Totalcost=sum((source,sink ),
              costtomove(source,sink )*Move.l(source,sink ));
parameter shadowprices(*,*);
shadowprices("demand",sink)=sinkdemand.m(sink);
shadowprices("supply",source)=sourcesupply.m(source);
display totalcost,shadowprices;

Move.lo(source,sink)=0.1;
solve transport using lp minimizing cost;
display sinkdemand.lo;

Move.up(source,sink)=1000.1;
solve transport using lp minimizing cost;
display sinkdemand.up;

Move.fx("boston","seattle")=1.;
solve transport using lp minimizing cost;
display move.lo,move.up;

Transport.scaleopt=1;
Move.scale("boston","seattle")=10.;
solve transport using lp minimizing cost;

scalar xx;
xX=transport.modelstat;
Display xx,transport.modelstat;
If(transport.modelstat gt %ModelStat.Locally Optimal%,
      Display '**** Model did not terminate with normal solution',
                 transport.modelstat;)     ;
xX=transport.solvestat;
Display xx,transport.solvestat;
If(transport.solvestat gt %Solvestat.Normal Completion%,
      Display '**** Solver did not terminate normally',
                 transport.solvestat;)
set scenarios /goodone,toomuchdemand, solveproblem/;
set casewithbadanswer(scenarios,*);
loop (scenarios,
         if(sameas(scenarios,"solveproblem"),
             demand(sink)=0.1;
             transport.iterlim=1;  );
         solve transport using lp minimizing cost;
         xX=transport.solvestat;
         Display xx,transport.solvestat,transport.modelstat;
         demand(sink)=demand(sink)*1.1;
         casewithbadanswer(scenarios,"model")$(transport.modelstat gt 2)=yes;
         casewithbadanswer(scenarios,"solve")$(transport.solvestat gt 1)=yes;
);
display casewithbadanswer;

transport.solprint=0;
transport.iterlim=10000;
solve transport using lp minimizing cost;

display   transport.line
          transport.nodusd
          transport.number
          transport.numnlins
          transport.numnlnz
          transport.numnopt
          transport.numinfes
          transport.numredef
          transport.objest
          transport.objval
          transport.resgen
          transport.suminfes
display move.range;
$ontext
#user model library stuff
Main topic Attributes
Featured item 1  Model
Featured item 2  Variable
Featured item 3  Equation
Featured item 4
Description
Illustrate model, equation and variable attributes

$offtext
