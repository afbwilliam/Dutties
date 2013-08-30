$ontext
   This program illustrates the use of listbox and checklistbox.
$offtext

* Display values are listed in parameter D whereas corresponding return values
* from ask popup are listed in parameter E. The returned values are substituted
* for %s in parameter R if any. Note that options might also be written to a file.

* import a set through a listbox
$call =ask T=listbox M="Choose multiple options" D="option 1|option 2|option 3|option 4|option 5" E="1|2|3|4|5" R="%s list box choice" O=k.inc

set k /
$include k.inc
/;
display k;

* import a set through a checked listbox
$call =ask T=checklistbox M="Choose multiple options" D="option 1|option 2|option 3|option 4|option 5" E="1|2|3|4|5" R="%s 'checked list box choice'" O=k2.inc

set k2 /
$include k2.inc
/;
display k2;

$onecho > AskChecklistbox.opt
T=checklistbox
M=Choose multiple options
D=option 1|option 2|option 3|option 4|option 5
E=1|2|3|4|5
R=%s checked list box choice
O=k3.inc
$offecho

* calls ask utility with the option file written above
$call =ask @AskChecklistbox.opt
set k3 /
$include k2.inc
/;
display k3;
