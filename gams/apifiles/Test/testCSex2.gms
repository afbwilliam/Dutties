$title Test xp_example2.cs

$if %system.filesys% == UNIX $abort Do not test C# on Unix


$if %system.buildcode% == VS8
$if not set flags $set flags /platform:x86
$if %system.buildcode% == WEI
$if not set flags $set flags /platform:x64

$call rm -rf demanddata.gdx

$call cd ..\CSharp && csc.exe %flags% xp_example2.cs api\gamsxcs.cs api\gdxcs.cs api\optcs.cs api\gamsglobals.cs
$if errorlevel 1 $abort 'Problem compiling xp_example2.cs'
$call ..\CSharp\xp_example2.exe ..\..
$if errorlevel 1 $abort 'Problem executing xp_example2 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
