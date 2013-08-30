$title Test TransportSeq.cs

$if %system.filesys% == UNIX $abort Do not test C# on Unix

$set x64
$if %system.buildcode% == WEI $set x64 x64\

$if %system.buildcode% == VS8
$if not set flags $set flags  -t:rebuild -p:Configuration=Release -p:Platform="Win32"
$if %system.buildcode% == WEI
$if not set flags $set flags  -t:rebuild -p:Configuration=Release -p:Platform="x64"

$onechoV > cmexTrans
$call cd ..\C++\Transport%1 && MSBuild.exe %flags% Transport%1.vcxproj
$if errorlevel 1 $abort 'Problem compiling Transport%1.cs'
$call cd ..\C++\Transport%1 && %x64%Release\Transport%1.exe ..\..\..
$if errorlevel 1 $abort 'Problem executing Transport%1'
$offecho

* Make sure that correct GAMS system is found when checking the registry
$call findthisgams -q

$batinclude cmexTrans 1
$batinclude cmexTrans 2
$batinclude cmexTrans 3
$batinclude cmexTrans 4
$batinclude cmexTrans 5
$batinclude cmexTrans 6
$batinclude cmexTrans 7
$batinclude cmexTrans 8
* These two need more references, cannot assume that they are the same one all machines
*$batinclude cmexTrans 9
*$batinclude cmexTrans 10
$batinclude cmexTrans 11
