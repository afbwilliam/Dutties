$ontext
   This program illustrates the use of radio buttons through two
   examples
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

* displays five radio button options from which the user must choose one.
* Display values are listed in parameter D whereas corresponding return values
* from ask popup are listed in parameter E. The returned value is substituted
* for %s in parameter R if any.
$call =ask T=radiobuttons M="Choose single option" D="option 1|option 2|option 3|option 4| option 5" E="1|2|3|4|5" R="scalar n2 option /%s/;" o=n2.inc
$include n2.inc
display n2;

* writes radio button options to file "AskRadioButton.opt", the number below parameter E
* shows number of columns to be used. Note that each parameter value should be
* entered on a single line and lines should not be broken.
$onecho > AskRadioButton.opt
T=radiobuttons
M=Choose single option
D=option 1|option 2|option 3|option 4|option 5|option 6|option 7|option 8|option 9|option 10
E=1|2|3|4|5|6|7|8|9|10
2
R=scalar n3 option /%s/;
O=n3.inc
$offecho

* calls ask utility with the option file written above
$call =ask @"AskRadioButton.opt"
$include n3.inc
display n3;
