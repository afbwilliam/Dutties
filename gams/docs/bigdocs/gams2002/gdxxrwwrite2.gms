*Illustrates GDXXRW use with instructions placed in index area in spreadsheet

set j1/ship ,       truck,                rail/;
set i7/brussels      ,"san francisco"/
set i8/  cleveland,  chicago/;
$ondollar

parameter moded3(i7,i8,j1);
*set from data
$call "gdxxrw gdxxrwss.xls o=gdxse.gdx se=0 par=moded3 rng=skipempty!a2:g69 rdim=2 cdim=1"
$gdxin gdxse.gdx
$load moded3
display moded3;

parameter moded4(i7,i8,j1);
*set from data
$call "gdxxrw gdxxrwss.xls o=gdxse.gdx se=1 par=moded4 rng=skipempty!a2:g69 rdim=2 cdim=1"
$gdxin gdxse.gdx
$load moded4
display moded4;

$gdxout gdxse.gdx
$unload moded4
$gdxout
$call "gdxxrw i=gdxse.gdx o=gdxxrwss.xls  index=writeindex!a2"



$ontext
#user model library stuff
Main topic GDXXRW
Featured item 1 Spreadsheet
Featured item 2 GDXXRW
Featured item 3 Index
Featured item 4
include gdxxrwss.xls
Description
Illustrates GDXXRW use with instructions placed in index area in spreadsheet

$offtext
