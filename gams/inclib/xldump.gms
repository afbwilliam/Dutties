%$dollar $
$hidden xldump.gms exports raw
$offlisting offinclude
$if not setglobal XLLINK $libinclude xllink
$setargs sym xls sheet more

* For Variables and Equations sym is v.l v.m etc
* We need the basename of the symbol:
$echon "$setglobal symstrip "    > %gams.scrdir%symb.%gams.scrext%
$call echo %sym% | sed s/\..*// >> %gams.scrdir%symb.%gams.scrext%

$set rng ''

$if '' ==  '%sym%'      $exit
$if '' ==  '%xls%'      $goto noxls
$if NOT declared %sym%  $goto notknown
$if NOT defined  %sym%  $goto nodata
$if NOT readable %sym%  $goto notreadable
$if NOT "" == "%sheet%" $set rng rng=%sheet%
$if     ParType  %sym%  $goto unloadepar
$if     VarType  %sym%  $goto unloadevar
$if     EquType  %sym%  $goto unloadeequ
$if     FilType  %sym%  $goto doscalar
$if     ModType  %sym%  $goto doscalar
$if     SetType  %sym%  $goto unloadeset


$error cannot xldump symbol %sym%
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
xllinkscalar := %sym%;
$set sym xllinkscalar

$label unloadepar
execute_unload %sym%;
putclose xllinkparams 'o="%xls%"' / 'nc=1' / 'epsout=0' / 'par=%sym%' / '%rng%';
$goto dump

$label unloadeset
execute_unload %sym%;
putclose xllinkparams 'o="%xls%"' / 'nc=1' / 'set=%sym%' / '%rng%';
$goto dump

$label unloadevar
$include %gams.scrdir%symb.%gams.scrext%
execute_unload %symstrip%;
putclose xllinkparams 'o="%xls%"' / 'nc=1' / 'epsout=0' / "zeroout=''" / 'var=%sym%' / '%rng%';
$goto dump

$label unloadeequ
$include %gams.scrdir%symb.%gams.scrext%
execute_unload %symstrip%;
putclose xllinkparams 'o="%xls%"' / 'nc=1' / 'epsout=0' / "zeroout=''" / 'equ=%sym%' / '%rng%';

$label dump
execute '=gdxxrw "%gams.wdir%xllink.gdx" @xllink.txt log=xllink.log';
if(errorlevel > 0,
   display 'Problems with Xldump - look at xllink.err';
   execerror := execerror + 1;
   execute 'type xllink.log >> xllink.err' );
