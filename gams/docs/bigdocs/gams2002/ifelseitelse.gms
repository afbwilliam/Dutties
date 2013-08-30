*illustrate basic if with else and elseif

scalar key /1/,key2;
acronym case1,case2,case3,case4;
set i /i1*i10/;
parameter data1(i);
data1(i)=ord(i);

if (key <= 0,
        data1(i) = -1 ;
        key2=case1;
) ;

if (key <= 0,
        data1(i) = -1 ;
        key2=case1;
else
        data1(i) = data1(i)**3 ;
        key2=case4;
) ;

if (key <= 0,
         data1(i) = -1 ;
         key2=case1;
         display 'pass1',data1;
elseif ((key > -1) and (key < 1)),
         data1(i) = data1(i)**2 ;
         key2=case2;
         display 'pass2',data1;
elseif ((key >= 1) and (key < 2)),
         data1(i) = data1(i)/2 ;
         key2=case3;
         display 'pass3',data1;
else
         data1(i) = data1(i)**3 ;
         key2=case4;
         display 'pass4',data1;
) ;
display 'after',data1,key2;

variable z;
positive variable x(i);
x.up(i)=1;

equation zz,sumvar;
option limrow=0,limcol=0;
zz.. z=e=sum(i,x(i));
sumvar.. sum(i,x(i))=g=card(i)+8;
model ml /all/;

solve ml using lp maximizing z;
if ((ml.modelstat eq 4),
display 'model ml was infeasible',
        'relaxing bounds on x and solving again';
x.up(i) = 2*x.up(i) ;
solve ml using lp minimizing z ;
else
if ((ml.modelstat ne 1),
abort "error solving model ml" ;
);
);

$ontext
#user model library stuff
Main topic Control structures
Featured item 1 If
Featured item 2 Else
Featured item 3 Elseif
Featured item 4 Abort
Description
Illustrate basic if with else and elseif

$offtext

$onend
If key <= 0 then
        data1(i) = -1 ;
        key2=case1;
endif ;
