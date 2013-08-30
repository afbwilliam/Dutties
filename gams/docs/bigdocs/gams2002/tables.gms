*Illustrate use of a Table statement

set i            /i1,i2,i3,i5,i6*i11,land,labor/
    j            /j1*j4,x1*x3,corn,wheat,cotton/
    k            /k1*k11/, l /l1*l9/,m /m1*m9/
    RESOURCE     / plantcap, salecontrct,constrain1,constrain2/
    process      /x1*x3, Makechair, Maketable, Makelamp/
    state        /al,in/;

Table ta(i,j)
                            J1        j2*j4
        (i1,i5)             3          1
        (i6*i11)            5          8
;TABLE a(i,j) crop data
            corn  wheat cotton
    land      1     1      1
    labor     6     4      8      ;

TABLE RESOURUSE(RESOURCE,PROCESS) RESOURCE USAGE
             Makechair Maketable Makelamp
 plantcap        3        2        1.1
 salecontrct     1                 -1    ;

Table fivedim(i,j,k,l,m) fivedimensional
                 l1.m1  l2.m2
        i1.j1.k2   11    13
        i2.j1.k11   6    -3
+                 l3.m1   l2.m7
        i1.j1.k2    1      3
        i10.j1.k4   7      9;
TABLE avariant1(i,j,state) crop data
            corn.al  wheat.al cotton.al corn.in  wheat.in cotton.in
    land      1           1      1        1        1         1
    labor     6           4      8        5           7       2;
TABLE avariant2(i,j,state) crop data
                   al  in
    land.corn      1    1
    labor.corn     6    5
    land.wheat     1    1
    labor.wheat    4    7
    land.cotton    1    1
    labor.cotton   8    2;

$ontext
#user model library stuff
Main topic Table
Featured item 1 Table
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate use of a Table statement

$offtext
