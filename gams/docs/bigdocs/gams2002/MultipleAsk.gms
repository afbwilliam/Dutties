$ontext
   This examples illustrates the use of ask utility for different
   input types
$offtext

* asks the user to enter an integer between 0 and 5 and assigns it to scalar n1
$call =ask T=integer M="Give integer, between 0 and 5" L=0 U=5 O=n1.inc
scalar n1 'an integer 0..5' /
$include n1.inc
/;
display n1;

* asks the user to enter an unbounded float and assigns it to scalar x
$call =ask T=float M="Give floating point number, no bounds" O=x.inc
scalar x 'real' /
$include x.inc
/;
display x;

* asks the user to enter a float between 0 and 5.0 and assigns it to scalar x1
$call =ask T=float M="Give floating point number, between 0 and 5" L=0 U=5.0 O=x1.inc
scalar x1 'real' /
$include x1.inc
/;
display x1;

* asks the user to enter a year between 1990 and 2010 and sets the value to be
* the final element of the range in set i
$call =ask T=integer M="Give year between 1990 and 2010." C="My Title" L=1990 U=2010 R="set i /1990*%s/;" O=i.inc
$include i.inc
display i;
