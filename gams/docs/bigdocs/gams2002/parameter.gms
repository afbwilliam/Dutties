*illustrate parameter entry

set j /j1,j2,x1*x3/,i /r1*r2,i1*i2/,k /k1,k2/
    process /x1*x3/,resource /constrain1,constrain2/;
PARAMETER     c(j)      / x1     3    ,x2   2 ,x3    0.5/
              b(i)     /r1 10
                        r2 3/;
PARAMETER
              PRICE(PROCESS)     PRODUCT PRICES BY PROCESS
                                /X1 3,X2 2,X3 0.5/
              RESORAVAIL(RESOURCE)  RESOURCE AVAIL
                      /CONSTRAIN1 10 ,CONSTRAIN2 3/;
Parameter         multd(i,j,k) three dimensional /
                    i1.j1.k1 10 ,
                    i2.j1.k2 90 /;
parameter                 cc(j),        cb(i) /i1 2/;

parameter    hh(j) define all elements to 10 /set.j 10/;
$ontext
#user model library stuff
Main topic Parameters
Featured item 1 Parameter
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate parameter entry
$offtext