*all the i sets are rowwise

*just read strings
set i1;
$call "gdxxrw gdxxrwss.xls set=i1 rng=sheet1!a2:c2 cdim=1"
$gdxin gdxxrwss.gdx
$load i1
display i1;

*just read set elements with dset
set i1a
$call "gdxxrw gdxxrwss.xls dset=i1a rng=sheet1!a2:c2 cdim=1"
$gdxin gdxxrwss.gdx
$load i1a
display i1a;

*just read set elements with dset
set i2
$call "gdxxrw gdxxrwss.xls set=i2 rng=sheet1!a5:d6 cdim=1 values=yn"
$gdxin gdxxrwss.gdx
$load i2
display i2;

set i3;
*just read set elements and explanatory text
$call "gdxxrw gdxxrwss.xls set=i3 rng=sheet1!a9:e10 cdim=1"
$gdxin gdxxrwss.gdx
$load i3
display i3;
file tryit
put tryit
loop(i3,put i3.tl ' ' i3.te(i3);put /);

set i4;
*dont specify ending point
$call "gdxxrw gdxxrwss.xls dset=i4 rng=sheet1!a13 cdim=1"
$gdxin gdxxrwss.gdx
$load i4
display i4;

set i4a;
*dont specify ending point
*many errors here but set is ok
*shoulkd probably give full rectangle
$call "gdxxrw gdxxrwss.xls se=0 set=i4a rng=sheet1!a13 cdim=1"
$gdxin gdxxrwss.gdx
$load i4a
display i4a;

set i5;
*no ending point
*houston skipped because of no id
*many errors here but set is ok
$call "gdxxrw gdxxrwss.xls se=0 set=i5 rng=sheet1!a16 cdim=1"
$gdxin gdxxrwss.gdx
$load i5
display i5;

set i6;
*set from data
$call "gdxxrw gdxxrwss.xls set=i6 rng=sheet1!b20:d20 cdim=1"
$gdxin gdxxrwss.gdx
$load i6
display i6;

set i6a;
*set from data
$call "gdxxrw gdxxrwss.xls dset=i6a rng=sheet1!b20:d20 cdim=1"
$gdxin gdxxrwss.gdx
$load i6a
display i6a;

set i6c;
*set from data
$call "gdxxrw gdxxrwss.xls set=i6c rng=sheet1!b20:d21 cdim=1"
$gdxin gdxxrwss.gdx
$load i6c
display i6c;


set i7;
*set from data
$call "gdxxrw gdxxrwss.xls dset=i7 rng=sheet1!b26:e26 cdim=1"
$gdxin gdxxrwss.gdx
$load i7
display i7;

set i8;
*set from data
$call "gdxxrw gdxxrwss.xls dset=i8 rng=sheet1!b27:e27 cdim=1"
$gdxin gdxxrwss.gdx
$load i8
display i8;

*execution time read of subset
set i9(i6a);
*set from data
execute "gdxxrw gdxxrwss.xls set=i9 rng=sheet1!b20:c21 cdim=1"
Execute_load 'gdxxrwss' i9
display i9;

*take a tuple
set i10(i7,i8);
*set from data
$call "gdxxrw gdxxrwss.xls set=i10 rng=sheet1!b26:e27 cdim=2"
$gdxin gdxxrwss.gdx
$Load i10
display i10;
set i10a(i7,i8);
i10a(i7,i8)=yes;
execute "gdxxrw gdxxrwss.xls set=i10a rng=sheet1!b26:e27 cdim=2"
execute_load 'gdxxrwss' i10a
display i10a;

*all j's ar column vectors

set j1;
$call "gdxxrw gdxxrwss.xls set=j1 rng=sheet1!a35:a37 rdim=1"
$gdxin gdxxrwss.gdx
$load j1
display j1;

set j1a;
$call "gdxxrw gdxxrwss.xls dset=j1a rng=sheet1!a35:a37 rdim=1"
$gdxin gdxxrwss.gdx
$load j1a
display j1a;

set j2;
*set from data
$call "gdxxrw gdxxrwss.xls set=j2 rng=sheet1!a40:b43 rdim=1"
$gdxin gdxxrwss.gdx
$load j2
display j2;

set j3;
*set from data
$call "gdxxrw gdxxrwss.xls set=j3 rng=sheet1!a46:b50 rdim=1"
$gdxin gdxxrwss.gdx
$load j3
display j3;

set j4;
*set from data
$call "gdxxrw gdxxrwss.xls dset=j4 rng=sheet1!a21:a23 rdim=1"
$gdxin gdxxrwss.gdx
$load j4
display j4;

set j5;
*set from data
$call "gdxxrw gdxxrwss.xls dset=j5 rng=sheet1!a53:a56 rdim=1"
$gdxin gdxxrwss.gdx
$load j5
display j5;

set j6;
*set from data
$call "gdxxrw gdxxrwss.xls dset=j6 rng=sheet1!b53:b56 rdim=1"
$gdxin gdxxrwss.gdx
$load j6
display j6;

*now read some data

parameter distance(j4,i6);
*data
$call "gdxxrw gdxxrwss.xls par=distance rng=sheet1!a20:d23 rdim=1 cdim=1"
$gdxin gdxxrwss.gdx
$load distance
display distance;

parameter distance2(j4,i6);
execute "gdxxrw gdxxrwss.xls par=distance2 rng=sheet1!a20:d23"
execute_load 'gdxxrwss.gdx' distance2
display distance2;

parameter modedistance(j1,i7,i8);
*set from data
*note barge data dropped because not in set
*$call "gdxxrw gdxxrwss.xls par=modedistance rng=sheet1!a26:e31 rdim=1 cdim=2"
$call "gdxxrw gdxxrwss.xls par=modedistance rng=sheet1!a26:e31 dim=3 cdim=2"
$gdxin gdxxrwss.gdx
$load modedistance
display modedistance;

parameter modedistance2(i7,i8,j1);
*set from data
*note barge data dropped because not in set
*$call "gdxxrw gdxxrwss.xls par=modedistance2 rng=sheet1!a52:e56 rdim=2 cdim=1"
$call "gdxxrw gdxxrwss.xls par=modedistance2 rng=sheet1!a52:e56 rdim=2 dim=3"
$gdxin gdxxrwss.gdx
$load modedistance2
display modedistance2;

parameter modedistance3(i7,i8,j1);
*set from data
$call "gdxxrw i=gdxxrwss.xls o=gdxse.gdx se=0 par=modedistance3 rng=skipempty!a2:g69 rdim=2 cdim=1"
$gdxin gdxse.gdx
$load modedistance3
display modedistance3;

parameter modedistance4(i7,i8,j1);
*set from data
$call "gdxxrw i=gdxxrwss.xls o=gdxse.gdx se=1 par=modedistance4 rng=skipempty!a2:g69 rdim=2 cdim=1"
$gdxin gdxse.gdx
$load modedistance4
display modedistance4;

$ontext
*this does not work for now
display j1;
variable x(j1);
x.lo(j1)=1;
x.m(j1)=1;
x.up(j1)=10000;
x.scale(j1)=1;
x.l(j1)=9999;
$call "gdxxrw gdxxrwss.xls var=x.l rng=sheet1!c59:e60 cdim=1"
$gdxin gdxxrwss.gdx
$load x
display x.l,x.up,x.lo;

execute_unload 'gdxxrwtoss' i7,i8,j1,i11,modedistance2=distance;
$call "gdxxrw gdxxrwss.xls var=x.l rng=sheet1!c59:e60 cdim=1"
$offtext


$ontext
#user model library stuff
Main topic GDXXRW
Featured item 1 Spreadsheet
Featured item 2 GDXXRW
Featured item 3 Load
Featured item 4 Execute_Load
include gdxxrwss.xls
Description
Illustrates GDXXRW use for loading data

$offtext
