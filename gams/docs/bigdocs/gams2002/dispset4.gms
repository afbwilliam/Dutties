*display ordering using order set

Set  numberordr                /r1*r100/
set     one                     /A,B,C,D,F,Average/
Set     order2(numberordr,one)  /r3.(A,D,F),r2.Average,r1.(C,B)/
Set     PQ /Price,Quantity/
Table Items(one,PQ)
         Price  Quantity
     A     2     9000
     B     6     3000
     C     2.5   4000
     D     2.1   3000
     F     2.4   1.90;
parameter items1(numberordr,one,pq) item reordered first way;
items("Average",PQ)=    SUM(one,items(one,pq))/sum(one,1$items(one,pq));
items1("r2",one,pq)$(not sameas(one,"average"))=items(one,pq);
items1("r1","average",pq)=items("average",pq);
parameter items2(numberordr,one,pq) item ordered second way;
items2(numberordr,one,pq)=sum(order2(numberordr,one),items(one,pq));
display items,items1,items2;

$ontext
#user model library stuff
Main topic Output
Featured item 1 Display
Featured item 2 Ordering
Featured item 3 Order set
Featured item 4
Description
display ordering using order set

$offtext
