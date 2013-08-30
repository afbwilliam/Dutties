*illustrate local decimal formatting with put

file my1;
put my1;
set mine abcdefghijklmnopqrstuvwxyz
/a12345678901234567890  setaabcdefghijklmnopqrstuvwxyz
 b12345678901234567890  setbabcdefghijklmnopqrstuvwxyz
 small smallone/;
set small(mine) /small/;
scalar number regnumber /1.2356/
       smallnumber /0.00000001/
       largenumber /1000000000/;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz':5
             '$ end here'//;
put 'start item explanatory text here $':4 mine.ts:22 '$ end here'/;
put 'start item explanatory text here $':0 number.ts:7 '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':20 mine.tl:0 '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine):0 '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine):5 '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine):0 '$ end here for name ' mine.tl /;)
put /;
put 'start number here       $':0 number:10:2 '$ end here'/;
put 'start number here       $':0 number:10:4 '$ end here'/;
put 'start number here       $':0 number:15:4 '$ end here'/;
put 'start number here       $':0 number:0:4 '$ end here'/;

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 Decimals
Featured item 3 Local
Featured item 4 :Width:Decimals
Description
Illustrate local decimal formatting with put

$offtext
