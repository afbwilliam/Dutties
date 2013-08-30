*illustrate control variable definition and display
*as well as scoping when defined in included file

$oneolcom
$set it 1
$setlocal  yy
$setglobal gg what
*show before include
$show
$include includ
*show after include
$show
$set it 4
$set todrop
$drop todrop
$droplocal  yy
$dropglobal gg
*show at end
$show

*sets on status only

$set hereit
$setlocal hereyy
$setglobal heregg
$show

*set values
$set it
$setlocal  yy no
$setglobal gg what
$show

$onecho  > mine2.txt
line 1 of text to be sent
line 2 of text to be sent
...
last line of text to be sent
$offecho

$onecho  >> mine2.txt
more
additional line 1 of text to be sent
additional line 2 of text to be sent
...
additional last line of text to be sent
$offecho

$setnames d:\gams\xxx.txt filepath filename fileextension
$setglobal name %filepath%%filename%%fileextension%

$setcomps s1.s2.s3 sel1 sel2 sel3
$setglobal nam1 %sel1%.%sel2%.%sel3%

$show

scalar count /0/;
set sels /s1*s3/;
loop(sels,count=count+1;
   if(sameas(sels,"%sel2%"),display "found element %sel2% in position",count;);
     );

$if warnings $goto none
      display "no warnings";
$label none

$remark my comment %name%

$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 $Set
Featured item 2 $Show
Featured item 3 $Setglobal
Featured item 4 $On/Offecho
Description
Illustrate control variable definition and display
as well as scoping when defined in included file

$offtext
