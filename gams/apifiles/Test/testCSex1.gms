$title Test xp_example1.cs

$if %system.filesys% == UNIX $abort Do not test C# on Unix


$if %system.buildcode% == VS8
$if not set flags $set flags /platform:x86
$if %system.buildcode% == WEI
$if not set flags $set flags /platform:x64

$call rm -rf demanddata.gdx

$call cd ..\CSharp && csc.exe %flags% xp_example1.cs api\gdxcs.cs api\gamsglobals.cs
$if errorlevel 1 $abort 'Problem compiling xp_example1.cs'
$call ..\CSharp\xp_example1.exe ..\..
$if errorlevel 1 $abort 'Problem executing xp_example1 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call ..\CSharp\xp_example1.exe ..\.. ..\GAMS\trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1 reading GDX file'
