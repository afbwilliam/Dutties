$title Test Benders2Stage.cs

$if %system.filesys% == UNIX $abort Do not test C# on Unix


$if %system.buildcode% == VS8
$if not set flags $set flags /platform:x86
$if %system.buildcode% == WEI
$if not set flags $set flags /platform:x64

* Make sure that correct GAMS system is found when checking the registry
$call findthisgams -q

$call cd ..\CSharp\Benders2Stage && cp ..\..\..\GAMS.net4.dll . && csc.exe %flags% Benders2Stage.cs -r:GAMS.net4.dll
$if errorlevel 1 $abort 'Problem compiling Benders2Stage.cs'
$call cd ..\CSharp\Benders2Stage && Benders2Stage.exe ..\..\..
$if errorlevel 1 $abort 'Problem executing Benders2Stage'
