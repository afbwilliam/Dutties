$title Test xp_example2.vb

$if %system.filesys% == UNIX $abort Do not test VB.net on Unix


$if %system.buildcode% == VS8
$if not set flags $set flags /platform:x86
$if %system.buildcode% == WEI
$if not set flags $set flags /platform:x64

$call rm -rf demanddata.gdx

$call cd ..\VBNet && vbc.exe %flags% xp_example2.vb api\gamsxvbnet.vb api\gdxvbnet.vb api\optvbnet.vb api\gamsglobals.vb
$if errorlevel 1 $abort 'Problem compiling xp_example2.vb'
$call ..\VBNet\xp_example2.exe ..\..
$if errorlevel 1 $abort 'Problem executing xp_example2 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
