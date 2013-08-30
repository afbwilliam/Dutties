*illustrate ordering and capitalization

set     ONE     /A,C,B,Total,new8/
        Set     TWO     /D,A,F,TOTAL2/
Set items1through10 /1*10/;
Parameter       item(two) /d 1,a 3, f 5/;
item("total2")=sum(two$(not sameas(two,"total2")),item(two));
display item,items1through10;


$ontext
#user model library stuff
Main topic Output
Featured item 1 Display
Featured item 2 Set ordering
Featured item 3 Capitalization
Featured item 4
Description
illustrate numerical displays

$offtext
