%$dollar $
$offlisting offinclude
$if not setglobal XLLINK $libinclude xllink

$setargs sym xls range flag more

$set merge clear
$set rng ''

* For Variables and Equations sym is v.l v.m etc
* We need the basename of the symbol:
$echon "$setglobal symstrip "    > %gams.scrdir%symb.scr
$call echo %sym% | sed s/\..*// >> %gams.scrdir%symb.scr

$if NOT '%flag%' == '' $set merge merge

$if '' ==  '%sym%'      $exit
$if '' ==  '%xls%'      $goto nosxls
$if NOT declared %sym%  $goto notknown
$if NOT defined  %sym%  $goto nodata
$if NOT readable %sym%  $goto notreadable
$if NOT "" == "%range%" $set rng rng=%range%
$if     ParType  %sym%  $goto unloadepar
$if     VarType  %sym%  $goto unloadevar
$if     EquType  %sym%  $goto unloadequ
$if     FilType  %sym%  $goto doscalar
$if     ModType  %sym%  $goto doscalar
$if     SetType  %sym%  $goto unloadeset

$error cannot xlexport symbol %sym%
$exit
$label noxls
$error no xls file specified
$exit
$label notknown
$error symbol %sym% not declared

$exit
$label nodata
$error symbol %sym% has no data
$exit
$label notreadable
$error symbol %sym% is not readable
$exit

$label doscalar
xldumpscalar := %sym%;
$set sym xldumpscalar

$label unloadepar
execute_unload %sym%;
putclose xllinkparams 'o="%xls%"' / 'epsout=0' / 'par=%sym%' / '%rng%' / '%merge%';
$goto dump

$label unloadeset
execute_unload %sym%;
putclose xllinkparams 'o="%xls%"' / 'set=%sym%' / '%rng%' / '%merge%';
$goto dump

$label unloadevar
$include %gams.scrdir%symb.scr
execute_unload %symstrip%;
putclose xllinkparams 'o="%xls%"' / 'epsout=0' / "zeroout=''" / 'var=%sym%' / '%rng%' / '%merge%';
$goto dump

$label unloadeequ
$include %gams.scrdir%symb.scr
execute_unload %symstrip%;
putclose xllinkparams 'o="%xls%"' / 'epsout=0' / "zeroout=''" / 'equ=%sym%' / '%rng%' / '%merge%';

$label dump
execute '=gdxxrw xllink.gdx @xllink.txt log=xllink.log';
if(errorlevel > 0,
   display 'Problems with Xlexport - look at xllink.err';
   execerror := execerror + 1;
   execute 'type xllink.log >> xllink.err' );

