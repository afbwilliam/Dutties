$title Test xp_example1dp.dpr

$if not set dcomp $set dcomp dcc32

$call rm -rf demanddata.gdx

$call cd ..\Delphi && %dcomp% xp_example1dp.dpr
$if errorlevel 1 $abort 'Problem compiling xp_example1dp.dpr'
$call ..\Delphi\xp_example1dp ../..
$if errorlevel 1 $abort 'Problem executing xp_example1dp writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call ..\Delphi\xp_example1dp ../.. ..\GAMS\trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1dp reading GDX file'
