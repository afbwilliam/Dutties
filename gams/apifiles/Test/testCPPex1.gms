$title Test xp_example1.cpp

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
$set                              OUT -Fexp_example1.exe
$if %system.filesys% == UNIX $set OUT -oxp_example1

$call rm -rf demanddata.gdx

$call cd ..%S%C++ && %ccomp% xp_example1.cpp api%S%gdxco.cpp ..%S%C%S%api%S%gdxcc.c -Iapi -I..%S%C%S%api %OUT% %flags%
$if errorlevel 1 $abort 'Problem compiling xp_example1.cpp'
$call ..%S%C++%S%xp_example1 ..%S%..
$if errorlevel 1 $abort 'Problem executing xp_example1 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call ..%S%C++%S%xp_example1 ..%S%.. ..%S%GAMS%S%trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1 reading GDX file'
