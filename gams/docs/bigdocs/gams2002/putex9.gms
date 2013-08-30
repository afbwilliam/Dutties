*Illustrate justification of objects in put command

file my1;
put my1;
set mine abcdefghijklmnopqrstuvwxyz
/a1  seta1
 b12345678901234567890  setbabcdefghijklmnopqrstuvwxyz
 small/;
set small(mine) smallone /small/;
scalar number regnumber /1.2356/
       smallnumber /0.00000001/
       largenumber /1000000000/;

Put 'default settings in place'/;
put 'lj = ' my1.lj:2:0/;
put 'tj = ' my1.tj:2:0/;
put 'sj = ' my1.sj:2:0/;
put 'nj = ' my1.nj:2:0/;

put 'start quoted text here $':0 'Quot':15 '$ end here'//;
put 'start quoted text here $':0 'Long Quoted Text Entry':15 '$ end here'//;
put 'start item explanatory text here $':0 mine.ts:20 '$ end here'/;
put 'start item explanatory text here $':0 number.ts:20 '$ end here'/;
put /;
loop(mine,
put 'start set element name here $':0 mine.tl:20 '$ end here'/;)
put /;
loop(mine,
put 'start set element explanatory text here $':0 mine.te(mine):20 '$ end here'/;)
put /;
loop(mine,
put 'start set element value here $':0 mine(mine):10 '$ end here for name ' mine.tl /;)
put /;
loop(mine,
put 'start subset element value here $':0 small(mine):10 '$ end here for name ' mine.tl /;)
put /;
put 'start number here       $':0 number:20:4 '$ end here'/;
put 'start small number here $':0 smallnumber:20:4 '$ end here'/;
put 'start large number here $':0 largenumber:20:4 '$ end here'/;
put 'start large number here $':0 largenumber:10:4 '$ end here'/;
put /;

set tovary /lj,tj,nj,sj/;
parameter default(tovary) /lj 2 , tj 2, nj 1, sj 1/;
set nums /1*3/
loop(tovary,
  my1.lj=default("lj");
  my1.nj=default("nj");
  my1.sj=default("sj");
  my1.tj=default("tj");
  loop(nums$(default(tovary) ne ord(nums)),
    if(sameas(tovary,"lj"),my1.lj=ord(nums));
    if(sameas(tovary,"nj"),my1.nj=ord(nums));
    if(sameas(tovary,"sj"),my1.sj=ord(nums));
    if(sameas(tovary,"tj"),my1.tj=ord(nums));
    Put '$$$$ change ' tovary.tl:0 ' to ' ord(nums):0:0 ' from default of '
               default(tovary):0:0/;
    put 'lj = ' my1.lj:2:0/;
    put 'tj = ' my1.tj:2:0/;
    put 'sj = ' my1.sj:2:0/;
    put 'nj = ' my1.nj:2:0/;

    put 'start quoted text here $':0 'Quot':15 '$ end here'//;
    put 'start quoted text here $':0 'Long Quoted Text Entry':15 '$ end here'//;
    put 'start item explanatory text here $':0 mine.ts:20 '$ end here'/;
    put 'start item explanatory text here $':0 number.ts:20 '$ end here'/;
    put /;
    loop(mine,
      put 'start set element name here $':0 mine.tl:20 '$ end here'/;)
    put /;
    loop(mine,
       put 'start set element explanatory text here $':0 mine.te(mine):20 '$ end here'/;)
    put /;
    loop(mine,
       put 'start set element value here $':0 mine(mine):10 '$ end here for name ' mine.tl /;)
    put /;
    loop(mine,
      put 'start subset element value here $':0 small(mine):10 '$ end here for name ' mine.tl /;)
    put /;
    put 'start number here       $':0 number:20:4 '$ end here'/;
    put 'start small number here $':0 smallnumber:20:4 '$ end here'/;
    put 'start large number here $':0 largenumber:20:4 '$ end here'/;
    put 'start large number here $':0 largenumber:10:4 '$ end here'/;
    put //;
    )put /);

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 Nj
Featured item 3 Lj
Featured item 4 Tj
Description
Illustrate justification of objects in put command

$offtext
