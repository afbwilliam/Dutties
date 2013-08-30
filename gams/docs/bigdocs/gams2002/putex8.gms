*Illustrate use of zero (exact size with no padding) field width
* for put file entries

file my1;
put my1;
set i /i1 Nuts
       i2 Bolts/;
parameter jdata Hardware Data
              /i1 22.73
               i2 100.918/;
put 'Here is a report for the ' jdata.ts:0 ' entries in my GAMS code' //;
loop(i,
    put @5 'For element ' i.tl:0 ' named ' i.te(i):0 ' the data are '
          jdata(i):0:3 ' as entered' /;
     );

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 0 field width
Featured item 3 :0
Featured item 4
Description
Illustrate use of zero (exact size with no padding) field width
 for put file entries
$offtext
