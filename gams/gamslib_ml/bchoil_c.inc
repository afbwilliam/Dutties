$Title cutting planes for Oil Pipeline Design Problem

$include oilbase.inc
$gdxin net
$load  n k kk port regnode arc p cap dist pipecost cap1 pipecost1

$gdxin dsh
$load siter dsh

Scalar numcuts number of cuts to be added /0/;

$if not exist bchout_i.gdx $exit
$gdxin bchout_i
$load b

Set      soltree(n,n)      acrs in the solution
         desc(n,n)         descendants of a node
         level             levels in the tree / 1*50 /
         unvisit(n)        nodes that have yet been visited
         visit(n)          nodes that have been visited
         from(level,n)     nodes to traverse from at each level
         to(level,n)       nodes to be traversed to at each level
         notreenode(n)     node no in soltuino tree
Scalar   maxlevel          maximum level in the tree / 0 /
         i                 for index;

$eolcom //

soltree(arc) = round(b.l(arc));
notreenode(regnode) = sum(soltree(regnode,n), 1) = 0;

from('1',port) = yes;            // We start traversing with the port node
unvisit(n) = not notreenode(n);  // All nodes are currently unvisited
visit(n) = notreenode(n);        // No node has been visited
loop(level$card(unvisit),        // loop through each level until every node has been visited
  maxlevel = maxlevel+1;
  unvisit(n)$from(level,n) = no;       // mark the 'from' nodes to be visited
  visit(n)$from(level,n) = yes;
  to(level,unvisit) = sum((from(level,n),soltree(unvisit,n)), yes);  // identify the 'to' nodes at this level
  from(level+1,n)$to(level,n) = yes;   // move one layer down
);

abort$card(unvisit) 'level set too small';

* Travel the tree from the leaves to the root
for (i=maxlevel downto 1,
  loop(from(level,n)$(ord(level) = i),
    desc(n,n) = yes;
    loop((to(level,m),soltree(m,n)), desc(n,nn)$desc(m,nn) = yes);
  )
);

* Add nodes outside the tree to descendants so that all arcs from this node stay
* in the decendant set
Set ndesc(n)
    nunion(n);

loop(n$notreenode(n),
  visit(nn) = no;
  visit(nn)$arc(n,nn) = yes;
  loop(nn$(not notreenode(nn)),
    ndesc(m) = no;
    ndesc(m)$desc(nn,m) = yes;
    nunion(m) = visit(m) + ndesc(m);
    desc(nn,n) = card(nunion) = card(ndesc);
  )
);

* We need the optimal solution
oilbase.optcr=0;
oilbase.solvelink=%solvelink.CallModule%;
option limrow=0, limcol=0, solprint=off, mip=%mipsolver%;

Scalar    dup             indicator for duplicated node set / 0 /
Parameter lb(n)           the rhs lower bound for each cut;

loop(nn$(not notreenode(nn)),
  dup = 0;
  nw(n) = no;
  nw(n)$desc(nn,n) = yes;
  i = card(nw);
  if(card(nw)<17, // if the node block is of proper size, check for duplication
    loop(ss$((ord(ss)<siter and dup=0)),
      ndesc(n) = no;
      ndesc(n)$dsh(ss,nn,n) = yes;
      nunion(n) = nw(n) + ndesc(n);
      dup = card(nunion) = card(nw);
    );
    if(dup=0,
      solve oilbase using mip minimizing cost;
      lb(nn)$(oilbase.modelstat=%modelstat.Optimal% or
              oilbase.modelstat=%modelstat.IntegerSolution%) = oilbase.objest;
    );
  else
    desc(nn,n) = no; // don't store this descendant set
  );
);

* Update descendant history
dsh(ss,desc(m,n))$(ord(ss)=siter) = yes;
siter = siter+1;
execute_unload 'dsh.gdx', siter, dsh;

* Build the cut data structures
Alias (n,cc)
Set      c(cc)            actual cut
Parameter
         b_c(cc,n,n)      coefficient of build variables in the cut
         bk_c(cc,n,n,k)   coefficient of the buildk variables in the cut
         rhs_c(cc)        cut rhs
         sense_c(cc)      "the sense of the cuts 1 =L=, 2 =E=, 3 =G=";

c('1') = yes;
loop(n$lb(n),
    numcuts = numcuts + 1;

    i = ord(n);
    nw(nn) = no;
    nw(nn)$desc(n,nn) = yes;

    rhs_c(c) = round(lb(n),4);
    sense_c(c) = 3;

    b_c(c,arc(nw,nn)) = pipecost1*dist(arc);
    bk_c(c,arc(nw,nn),kk) = pipecost(kk)*dist(arc);

    c(cc) = c(cc-1);
);
