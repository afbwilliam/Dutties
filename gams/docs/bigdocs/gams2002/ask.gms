$ontext
$call =ask T=integer M="Enter number of cities" o=n.inc
scalar n 'number of cities' /
$include n.inc
/;
display n;

*an integer with bounds
*This will only accept values between 0 and 5.
$call =ask T=integer M="Give integer, between 0 and 5" L=0 U=5 O=n1.inc
scalar n1 'an integer 0..5' /
$include n1.inc
/;
display n1;

*To allow the user to specify a floating point number, we can use T=float. An example is:
$call =ask T=float M="Give floating point number, no bounds" O=x.inc
scalar x 'real' /
$include x.inc
/;
display x;

*The floating point popup window can be told to make sure the number entered is within certain
*bounds, using the L=lowerbound and U=upperbound syntax:
$call =ask T=float M="Give floating point number, between 0 and 5" L=0 U=5.0 O=x1.inc
scalar x1 'real' /
$include x1.inc
/;
display x1;

* import a set
$call =ask T=integer M="Give year between 1990 and 2010." C="My Title" L=1990 U=2010 R="set i /1990*%s/;" O=i.inc
$include i.inc
display i;

*import a number through radio buttons
$call =ask T=radiobuttons M="Choose single option" D="option 1|option 2|option 3|option 4|option 5" E="1|2|3|4|5" R="scalar n2 option /%s/;" o=n2.inc
$include n2.inc
display n2;

* id, now 2 columns and using a parameter file
$call =ask @"ask.opt"
$include n3.inc
display n3;


* import a number through a combo box
$call =ask T=combobox M="Choose single option" D="option 1|option 2|option 3|option 4|option 5" E="1|2|3|4|5" R="scalar n4 option /%s/;" O=n4.inc
$include n4.inc
display n4;

$onecho > ask.opt
T=combobox
M=choose data set
D=Small data set|Medium data set|Large data set
E=small.inc|medium.inc|large.inc
R=$include %s
O=dataset.inc
$offecho
$call =ask @ask.opt
$include dataset.inc

*listbox:
* import a set through a listbox
$call =ask T=listbox M="Choose multiple options" D="option 1|option 2|option 3|option 4|option 5" E="1|2|3|4|5" R="%s list box choice" O=k.inc
set k /
$include k.inc
/;
display k;

*T=checklistbox:
* import a set through a checked listbox
$call =ask T=checklistbox M="Choose multiple options" D="option 1|option 2|option 3|option 4|option 5" E="1|2|3|4|5" R="%s 'checked list box choice'" O=k2.inc
set k2 /
$include k2.inc
/;
display k2;

$call =ask T=fileopenbox I="%system.fp%" F="*.inc" o=fln.inc R="$setglobal incfile '%s'" C="Select include file"
$include fln.inc
$include %incfile%
*where we use a $setglobal to set the macro incfile to contain the user-specified file name.


*To let the user choose from a set of related GDX files, one could use something like:
$call =ask T=fileopenbox I="%system.fp%" F="*.gdx" o=setgdxname.inc R="$setglobal gdxfile '%s'" C="Select GDX file"
$include setgdxname.inc
$gdxin %gdxfile%
$load i
$load j


*In case you want to ask for a filename of a file to be written, use the type T=filesavebox. E.g.:
$call =ask T=filesavebox I="%system.fp%" F="*.gdx" o=fln.inc R="$setglobal gdxfile '%s'" C="Specify gdx file"
$include fln.inc
set i /a,b,c/;
execute_unload '%gdxfile%',i;

$onecho > ask10.opt
T=radiobuttons
M=Choose single option
D=option 1|option 2|option 3|option 4|option 5|option 6|option 7|option 8|option 9|option 10
E=1|2|3|4|5|6|7|8|9|10
2
R=scalar n3 option /%s/;
O=n3.inc
$offecho

*Every command line parameter is specified on a separate line. Notice the strange option '2';
*this tells ASK to display the radio buttons in two columns. We can use this option file as
*follows:

* id, now 2 radio button columns and using a parameter file
$call =ask @"ask10.opt"
$include n3.inc
display n3;
$offtext

$onecho > asktest.opt
T=checklistbox
M=Choose multiple options
D=option 1|option 2|option 3|option 4|option 5
E=1|2|3|4|5
R=%s checked list box choice
O=k2.inc
$offecho
$call =ask @asktest.opt
set k2 /
$include k2.inc
/;
display k2;
