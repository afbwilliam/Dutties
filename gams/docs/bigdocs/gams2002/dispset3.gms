*illustrate ordering and capitalization

set     UELORDER    /A,B,C,D,F,Total,1*20/
set     ONE     /A,C,B,Total,8/
        Set     TWO     /D,A,F,TOTAL2/
Set items1through10 /1*10/;
Parameter       item(two) /d 1,a 3, f 5/;
item("total2")=sum(two$(not sameas(two,"total2")),item(two));
display item,items1through10;

$ontext
#user model library stuff
Main topic Output
Featured item 1 Display
Featured item 2 Set elements
Featured item 3 UEL set
Featured item 4 Capitalization
Description
illustrate ordering and capitalization and UEL set

$offtext
