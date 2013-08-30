$ontext
    This program illustrates the use of comboboxes. Note
    include file names can also be given as return parameters
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

* Display values are listed in parameter D whereas corresponding return values
* from ask popup are listed in parameter E. The returned values are substituted
* for %s in parameter R if any.

* imports a number through a combo box
$call =ask T=combobox M="Choose single option" D="option 1|option 2|option 3|option 4| option 5" E="1|2|3|4|5" R="scalar n4 option /%s/;" O=n4.inc
$include n4.inc
display n4;

* imports a include file name through combobox. Note that each parameter value should be
* entered on a single line and lines should not be broken.
$onecho > AskCombobox.opt
T=combobox
M=Choose appropriate city list
D=Small data set|Medium data set|Large data set
E=CityListSmall.inc|CityListMedium.inc|CityListLarge.inc
R=$include %s
O=CityList.inc
$offecho
$call =ask @AskCombobox.opt
set cities /
$include CityList.inc
/;
display cities;

