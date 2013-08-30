$title Test xp_example2.dpr

$if not set dcomp $set dcomp dcc32

$call rm -rf demanddata.gdx

$call cd ..\Delphi && %dcomp% xp_example2.dpr
$if errorlevel 1 $abort 'Problem compiling xp_example2.dpr'
$call ..\Delphi\xp_example2 ../..
$if errorlevel 1 $abort 'Problem executing xp_example2'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
