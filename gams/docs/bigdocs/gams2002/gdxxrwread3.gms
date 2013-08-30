*Illustrates GDXXRW use for loading data with instructions placed in text file

*all the i sets are rowwise

*just read strings
set i1;
set i1a
set i3;
set i4a;
set i4;
set i5;
set i6;
set i6a;
set i6c;
set i7;
set i8;
set i9(i6a);
set i10(i7,i8);
set i10a(i7,i8);
set j1;
set j1a;
set j2;
set j3;
set j4;
set j5;
set j6;
parameter distance(j4,i6);
parameter modedistance(j1,i7,i8);
parameter modedistance2(i7,i8,j1);
parameter modedistance3(i7,i8,j1);
parameter modedistance4(i7,i8,j1);

$call "del gdxall.gdx"
$call 'gdxxrw gdxxrwss.xls  o=gdxall.gdx @gdxxrwparam.txt'

*starting it
$gdxin gdxall
$load i1 i1a i3
display i1;
display i1a;
display i3;
file tryit
put tryit
loop(i3,put i3.tl ' ' i3.te(i3);put /);

$load i4
display i4;

$load i4a
display i4a;

$load i5
display i5;

$load i6
display i6;

$load i6a
display i6a;

$load i6c
display i6c;

$load i7
display i7;

$load i8
display i8;

Execute_load 'gdxall' i9
display i9;

$Load i10
display i10;


*all j's ar column vectors

$load j1
display j1;

$load j1a
display j1a;

*set from data
$load j2
display j2;

*set from data
*s3,s4 does not make it because of blank and no
$load j3
display j3;

*set from data
$load j4
display j4;

*set from data
$load j5
display j5;

*set from data
$load j6
display j6;

*now read some data

$load distance
display distance;

execute_load 'gdxall.gdx' distance
display distance;

*note barge data dropped because not in set
$call "gdxxrw gdxxrwss.xls par=modedistance rng=sheet1!a26:e31 rdim=1 cdim=2"
$load modedistance
display modedistance;

*set from data
*note barge data dropped because not in set
$load modedistance2
display modedistance2;

*set from data
$load modedistance3
display modedistance3;

*set from data
$load modedistance4
display modedistance4;


$ontext
#user model library stuff
Main topic GDXXRW
Featured item 1 Spreadsheet
Featured item 2 GDXXRW
Featured item 3 TXT file
Featured item 4 @
include gdxxrwss.xls

Description
Illustrates GDXXRW use for loading data with instructions placed in text file

$offtext
