*Illustrate global field width in put files

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
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here       $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large number here $':0 largenumber '$ end here'/;
put /;

put // ' Change nw to 0':40 /;
my1.nw=0;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here       $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large number here $':0 largenumber '$ end here'/;
put /;

put // ' Change nw to 4':40 /;
my1.nw=4;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here       $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large number here $':0 largenumber '$ end here'/;
put /;

put // ' Change nd to 0':40 /;
my1.nw=12;
my1.nd=0;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here       $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large number here $':0 largenumber '$ end here'/;
put /;

put // ' Change lw to 30':40 /;
my1.nd=2;
my1.lw=30;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large umber here $':0 largenumber '$ end here'/;
put /;

put // ' Change tw to 20 lower lw to 12':40 /;
my1.nw=12;
my1.tw=20;
my1.lw=12;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large umber here $':0 largenumber '$ end here'/;
put /;

put // ' Change nw to 20 lower tw to 12':40 /;
my1.nw=20;
my1.lw=0;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large umber here $':0 largenumber '$ end here'/;
put /;

put // ' Change nd to 7 ':40 /;
my1.nw=20;
my1.nd=7;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large umber here $':0 largenumber '$ end here'/;
put /;

put // ' Change nd, nw , tw , sw , and lw to 0 ':40 /;

my1.nw=0;
my1.nd=0;
my1.sw=0;
my1.lw=0;
my1.tw=0;
put 'start quoted text here $':0 'Quotedabcedeghijklmnopqrstuvwxyz'
             '$ end here'//;
put 'start item explanatory text here $':0 mine.ts '$ end here'/;
put 'start item explanatory text here $':0 number.ts '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine) '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine) '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine) '$ end here for name ' mine.tl /;)
put /;
put 'start number here $':0 number '$ end here'/;
put 'start small number here $':0 smallnumber '$ end here'/;
put 'start large umber here $':0 largenumber '$ end here'/;
put /;

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 Nd
Featured item 3 LW
Featured item 4 Nw
Description
Illustrate global field width and decimals in put files
$offtext
