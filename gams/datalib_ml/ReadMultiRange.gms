$ontext
   This program illustrates how multiple-area ranges can be handled.
   It also does post processing to change invalid entries.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

set c 'countries' /Algeria,Angola,Benin,Botswana,'Burkina Faso',Burundi,
                   Cameroon,'Cape Verde','Central African Republic',
                   Chad,Comoros,Congo/;

set exp 'percentage distribution of current expenditure' /prim,sec,tert/;

$onecho > commands.txt
I=UNESCO.xls
R=A10,E10:G10,A14:A19,E14:G19
O=UNESCO.inc
B
$offecho

$call =xls2gms @commands.txt

$onecho > sedcommands.txt
s/prim\./prim /
s/Sec\./sec /
s/Tert\./tert /
s/\.\.\./   /g
s/\.\/\./   /g
$offecho

$call sed.exe -f sedcommands.txt UNESCO.inc > UNESCOX.inc

table distr(c,exp)
$include UNESCOX.inc
;

display distr;
