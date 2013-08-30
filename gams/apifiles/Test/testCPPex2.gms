$title Test xp_example2.cpp

$ifThen %system.buildcode% == DIG
$ if not set ccomp $set ccomp g++
$ if not set flags $set flags -m32 -ldl
$endIf
$ifThen %system.buildcode% == DEG
$ if not set ccomp $set ccomp g++
$ if not set flags $set flags -ldl
$endIf
$ifThen %system.buildcode% == LNX
$ if not set ccomp $set ccomp g++
$ if not set flags $set flags -m32 -ldl
$endIf
$ifThen %system.buildcode% == LEG
$ if not set ccomp $set ccomp g++
$ if not set flags $set flags -ldl
$endIf
$ifThen %system.buildcode% == SIG
$ if not set ccomp $set ccomp g++
$ if not set flags $set flags -m64 -ldl
$endIf
$ifThen %system.buildcode% == SOL
$ if not set ccomp $set ccomp g++
$ if not set flags $set flags -m32 -ldl
$endIf
$ifThen %system.buildcode% == SOX
$ if not set ccomp $set ccomp g++
$ if not set flags $set flags -m64 -ldl
$endIf

$if not set ccomp $set ccomp cl
$if not set flags $set flags

$set                              S \
$if %system.filesys% == UNIX $set S /
$set                              OUT -Fexp_example2.exe
$if %system.filesys% == UNIX $set OUT -oxp_example2

$call rm -rf demanddata.gdx

$call cd ..%S%C++ && %ccomp% xp_example2.cpp api%S%gdxco.cpp ..%S%C%S%api%S%gdxcc.c api%S%optco.cpp ..%S%C%S%api%S%optcc.c api%S%gamsxco.cpp ..%S%C%S%api%S%gamsxcc.c -Iapi -I..%S%C%S%api %OUT% %flags%
$if errorlevel 1 $abort 'Problem compiling xp_example2.cpp'
$call ..%S%C++%S%xp_example2 ..%S%..
$if errorlevel 1 $abort 'Problem executing xp_example2'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
