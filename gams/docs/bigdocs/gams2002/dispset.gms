*illustrate set element ordering
set         ONE         /A,C,B,Total,8/;
Set         TWO        /D,A,F,TOTAL/;
Set items1through10 /1*10/;
Parameter         item(two) /D 1,A 3, F 5/;
item("total")=sum(two$(not sameas(two,"total")),item(two));
display item,items1through10;
$onuellist


$ontext
#user model library stuff
Main topic Output
Featured item 1 Display
Featured item 2 Set
Featured item 3 Element order
Featured item 4
Description
illustrate set element ordering

$offtext
