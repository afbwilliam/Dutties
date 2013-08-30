*illustrate logical implication and equivalence

set case /case1*case4/;
set item /a,b/
table data(case,item)
         a  b
case1    0  0
case2    0  1
case3    1  0
case4    1  1            ;
parameter result(case,*);

LOOP(CASE,
  result(case,"isimp")=0;
  result(case,"isimp")=0;
  result(case,item)=data(case,item);
  IF(DATA(case,"a") imp data(case,"b"),result(case,"isimp")=1;);
  IF(DATA(case,"a") eqv data(case,"b"),result(case,"iseqv")=1;);
);
display result;
LOOP(CASE,
  result(case,"isimp")=0;
  result(case,"isimp")=0;
  result(case,item)=data(case,item);
  IF(DATA(case,"a") ->  data(case,"b"),result(case,"isimp")=1;);
  IF(DATA(case,"a") <=> data(case,"b"),result(case,"iseqv")=1;);
);
display result;


$ontext
#user model library stuff
Main topic Conditionals
Featured item 1 Logical
Featured item 2 Imp
Featured item 3 Eqv
Featured item 4
Description
Graphing with Excel
$offtext

illustrate logical implication and equivalence
