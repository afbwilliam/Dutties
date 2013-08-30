*Control variables

$setglobal notunique aa
$setlocal notunique bb
$set notunique cc

$show

$if "%notunique%" == "aa" display "it is aa";
$if "%notunique%" == "bb" display "it is bb";
$if "%notunique%" == "cc" display "it is cc";

$setlocal notunique2 bb
$setglobal notunique2 aa
$set notunique2 cc

$show

$if "%notunique2%" == "aa" display "it is aa";
$if "%notunique2%" == "bb" display "it is bb";
$if "%notunique2%" == "cc" display "it is cc";

$setglobal notunique3 aa
$set notunique3 cc

$show

$if "%notunique3%" == "aa" display "it is aa";
$if "%notunique3%" == "bb" display "it is bb";
$if "%notunique3%" == "cc" display "it is cc";

$setglobal notunique4 aa

$show

$if "%notunique4%" == "aa" display "it is aa";
$if "%notunique4%" == "bb" display "it is bb";
$if "%notunique4%" == "cc" display "it is cc";

$set n 10
$eval powern 2**%n%
$log %powern%

$set znumber 4
$Evalglobal anumber %znumber%+10
$Evalglobal vnumber %znumber%+9
$Evalglobal anumber3 (%znumber%) /200000000000
$Evalglobal anumber4 %znumber%   /100000000000
$ife %anumber3%==%anumber4% display "they are close" ,"%anumber3%","%anumber4%";
$ife %anumber3%==%anumber3% display "they are close 2" ,"%anumber3%","%anumber3%";
$ife %anumber%>14 display "it exceeds 14" ,"%anumber%" ;
$ife %anumber%<14 display "it is less than 14" ,"%anumber%"  ;
$ife %anumber%=14 display "it equals 14" ,"%anumber%";
$ife %anumber%<>14 display "it does not equal 14", "%anumber%";
$ife %anumber%>%vnumber% display "it exceeds vnumber", "%anumber%", "%vnumber%";
$ife %anumber% display "anumber is nonzero";
$ife %anumber%<>0 display "anumber is nonzero";


$iftheni %type% == low display "abc"
$elseifi %type% == med display "efg"
$else                  display "xyz"
$endif

$setglobal aroundit
$ifthen setglobal aroundit
 display "statement 1";
 display "statement 2";
$else
 display "statment 3";
$endif

$maxgoto 10 $set x a
$label two
$ifthen %x% == a $set x 'c' $log $ifthen   with x=%x%
$elseif %x% == b $set x 'k' $log $elseif 1 with x=%x%
$elseif %x% == c $set x 'b' $log $elseif 2 with x=%x%
$else            $set x 'e' $log $else     with x=%x%
$endif $if NOT %x% == e $goto two

$eval x 1
$label three
display 'x=%x%';
$ifthen %x% == 1 $eval x %x%+1
$elseif %x% == 2 $eval x %x%+1
$elseif %x% == 3 $eval x %x%+1
$elseif %x% == 4 $eval x %x%+1
$else            $set  x done
$endif $if NOT %x% == done $goto three

$ifthen.onea x == x
display "it";
$ifthen.twoa a == a
display "it2";
$endif.twoa
$endif.onea


$ifthen.twob   c==c  display 'true for tag two';
$ifthen.threeb a==a  $log true for tag three
display '   then clause for tag three';
$ifthen.fourb x==x display 'true for tag four';
$log true for tag four
$else
display '      else clause for tag four';
$endif.fourb          $log endif four
$endif.threeb         $log endif three
$endif.twob           $log endif two


