$title Test xp_example1do.dpr

$if not set dcomp $set dcomp dcc32

$call rm -rf demanddata.gdx

$call cd ..\Delphi && %dcomp% xp_example1do.dpr
$if errorlevel 1 $abort 'Problem compiling xp_example1do.dpr'
$call ..\Delphi\xp_example1do ../..
$if errorlevel 1 $abort 'Problem executing xp_example1do writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call ..\Delphi\xp_example1do ../.. ..\GAMS\trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1do reading GDX file'
