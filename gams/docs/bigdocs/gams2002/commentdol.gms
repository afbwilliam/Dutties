$ontext
Here is a file showing how to use
various types of comments and comment related dollar sign commands

valid GAMS statements can also be in the
comment but will not be compiled

set a /1*11/;

$offtext


$hidden a comment I do not want in LST file
set a /a1,a2/;
set b /a2,c2/
set c /a3,d3/;
$double
$onupper

parameter d(a,b,c);
d(a,b,c)=1.234567;

option d:1;display d;
option eject

*normal comment
$comment !
!comment with new character
$comment *
$dollar #
#onsymlist
scalar e/1/,f/0/;
f$e=e;

#dollar $
scalar x /0/;
$oneolcom
x=x+1;      !! eol comment
x = x   !! eol comment in line that continues on
   +1;
$eolcom &&
x=x+1;      && eol comment with new character
$eolcom #

$hidden message to me

$oninline
x=1;
$oninline
x=x      /* in line comment*/ +1;
x = x  /* in line comment in line
 that continues on */
   +1;
$inlinecom /&  &/
x=x      /& eol comment with new character &/ +1;

$log
$log The following message will be written to the log file
$log with leading blanks ignored. All special % symbols will
$log be substituted out before this text is sent to the log file.
$log This was line %system.incline% of file %system.incname%
$log

$onempty
set i / i2 /;
parameter data(i) /  /;
table aa(I,I)
     i2
i2        ;

$onmulti
Scalar x /3/
Scalar x /4/;
Set I /i1/;
Set I /i2/;

$inlinecom { } onnestcom
{ nesting is now possible in comments { braces have to match } }
parameter z(i) ;
z(i)=1;
scalar r;

* this is a one line comment that could describe data
$ontext
My data would be described in this multiline comment
This is the second line
$offtext
x = sum(I,z(i)) ; # this is an end of line comment
x = sum(I,z(i)) ; { this is an inline comment } r=sum(I,z(i)) ;


$ontext
#user model library stuff
Main topic Comments
Featured item 1 Comments
Featured item 2 $Hidden
Featured item 3 Inline
Featured item 4 End of line
Description
A file showing how to use
various types of comments and and comment related dollar sign commands



$offtext
