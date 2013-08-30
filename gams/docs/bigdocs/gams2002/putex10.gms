*Illustrates local justification of elements in Put file

file my1;
put my1;
set mine abc
/a1  seta1
 b1234  setbabhijklmnopqrstuvwxyz
 small/;
set small(mine) smallone /small/;
scalar number regnumber /1.2356/
       smallnumber /0.00000001/
       largenumber /1000000000/;

put 'start quoted text here $':0 'Quot':>15 '$ end here'/;
put 'start quoted text here $':0 'Quot':<15 '$ end here'/;
put 'start quoted text here $':0 'Quot':<>15 '$ end here'//;
put 'start item explanatory text here $':0 mine.ts:>20 '$ end here'/;
put 'start item explanatory text here $':0 mine.ts:<20 '$ end here'/;
put 'start item explanatory text here $':0 mine.ts:<>20 '$ end here'//;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl:>20 '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine):<20 '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine):<>10 '$ end here for name ' mine.tl /;)
put /;
put 'start number here       $':0 number:<20:4 '$ end here'/;
put 'start number here       $':0 number:>20:4 '$ end here'/;
put 'start number here       $':0 number:<>20:4 '$ end here'/;
put 'start large number here $':0 largenumber:10:4 '$ end here'/;
put 'start large number here $':0 largenumber:<10:4 '$ end here'/;
put /;

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2  <
Featured item 3  >
Featured item 4  <>
Description
*Illustrates local justification of elements in Put file
$offtext
