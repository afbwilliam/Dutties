*Illustrates batinclude of conditional compile routine
*that figures out item status and type then puts it

$if not "a%1" == "a" $goto start
$error Error in outit: item to be printed is not specified.
$label start
$if declared %1    $goto declared
$error Error in outit: identfier %1 is undeclared.
$exit
$label declared
$if defined %1     $goto defined
$error Error in outit: identfier %1 is undefined.
$exit
$label defined
$if settype %1  $goto doset
$if partype %1  $goto dopar
$error Error in outit: identfier %1 is not a set or a parameter.
$exit
$label doset
put /' set %1  ' %1.ts /
loop(%1,put '    Element called ' %1.tl ' defined as ' %1.te(%1) /)
put  /
$goto end
$label dopar
$if not dimension 1 %1 $goto badnews
$if not declared wkset1 alias(wkset1,*);
$if not declared wkset2 set wkset2(wkset1);
wkset2(wkset1)=no;
$onuni
wkset2(wkset1)$%1(wkset1)=yes;
display wkset2;
put /' Parameter %1  ' %1.ts  /
loop(wkset2,put '    Element ' wkset2.tl ' equals ' %1(wkset2) /)
put  /
$offuni
$goto end
$label badnews
$error Error in outit: identfier %1 is not a one dimensional parameter.
$label end

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 $If defined
Featured item 3 $If declared
Featured item 4 $If settype
include putcond.gms
Description
Illustrates batinclude of conditional compile routine
that figures out item status and type then puts it
$offtext
