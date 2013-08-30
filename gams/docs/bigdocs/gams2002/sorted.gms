*example of output sorting

set i /a1*a6/;
parameter unsort(i) /a1 22, a2 33, a3 12, a4 15, a5 47, a6 22/;
parameter r(i) ranks orders;
set asord /1*1000/;
parameter gg(i),rankdata(i);
alias(i,j);
gg(i)=sum(j$(unsort(j)>unsort(i)),1);
set orddat(asord,i);
orddat(asord,i)$(ord(asord)=(gg(i)+1))=yes;
file sorted;
put sorted;
loop(asord,
 if(sum(orddat(asord,i),1)=1,
  put 'In place ' asord.tl:0 ' with a value of '
   loop(orddat(asord,i),
                                put unsort(i):0:0 ' is item ' @42 i.tl:0/))
     if(sum(orddat(asord,i),1)>1,
         put 'In place ' asord.tl:0 ' with a value of '
            smax(orddat(asord,i),unsort(i)):0:0  ' are items '
            loop(orddat(asord,i),put @42 i.tl:0 ' ' /);)        );

$LIBINCLUDE rank unsort i rankdata
put // 'After rank which sorts low' //;
loop(asord,
 loop(i$(rankdata(i)=ord(asord)),
  put 'In place ' asord.tl:0 ' with a value of ' unsort(i):0:0 ' is item ' @42 i.tl:0/));
display rankdata;

$ontext
#user model library stuff
Main topic Output
Featured item 1 Sorting
Featured item 2
Featured item 3
Featured item 4
Description
Example of output sorting
$offtext
