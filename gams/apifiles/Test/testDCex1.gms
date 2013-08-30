$title Test xp_example1.dpr

$if not set dcomp $set dcomp dcc32

$call rm -rf demanddata.gdx

$call cd ..\Delphi && %dcomp% xp_example1.dpr
$if errorlevel 1 $abort 'Problem compiling xp_example1.dpr'
$call ..\Delphi\xp_example1 ../..
$if errorlevel 1 $abort 'Problem executing xp_example1 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call ..\Delphi\xp_example1 ../.. ..\GAMS\trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1 reading GDX file'
