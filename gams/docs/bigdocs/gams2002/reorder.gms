*Illustrates use of an order set for report writing order rearrangement

Set I /1*4/;
set j /a1*a3
       a4 this is element 4
     a5 has a crummy name/;
set newnames(j) /a1 nuts
                 a2 bolts
                 a3 cars
                 a4 trucks
                 a5/;
table data(i,j) data to be put
    a1   a2   a3  a4   a5
1   11   12
2             14  15
3   1                   1
4         2       4.10   ;
file my1;
put my1;

put // 'Data as originally ordered' / @29
loop(j,put newnames.te(j):12 ' '); put /;
loop(i, put i.te(i):20 ' ';
   loop(j,if((not sameas(j,'a4')),put data(i,j):12:0 ' ';);
        if(sameas(j,'a4'),put data(i,j):12:4 ' ';)); put /);
set iwantord /o1*o100/;
set ordit(iwantord,j) / o1.a4,o2.(a1,a3),o3.a4/;
put // 'Data as reordered' / @29
loop(ordit(iwantord,j),put newnames.te(j):12 ' ');put /;
loop(i,                put i.te(i):20 ' '
loop(ordit(iwantord,j),
if((not sameas(j,'a4')),put data(i,j):12:0 ' ';);
if(sameas(j,'a4'),put data(i,j):12:4 ' ';));put /);

$ontext
#user model library stuff
Main topic Output
Featured item 1 Ordering
Featured item 2 Order set
Featured item 3
Featured item 4
Description
Illustrates use of an order set for report writing order rearrangement
$offtext
