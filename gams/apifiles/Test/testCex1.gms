$title Test xp_example1.c

$ifThen %system.buildcode% == DIG
$ if not set ccomp $set ccomp gcc
$ if not set flags $set flags -m32 -ldl
$endIf
$ifThen %system.buildcode% == DEG
$ if not set ccomp $set ccomp gcc
$ if not set flags $set flags -ldl
$endIf
$ifThen %system.buildcode% == LNX
$ if not set ccomp $set ccomp gcc
$ if not set flags $set flags -m32 -ldl
$endIf
$ifThen %system.buildcode% == LEG
$ if not set ccomp $set ccomp gcc
$ if not set flags $set flags -ldl
$endIf
$ifThen %system.buildcode% == SIG
$ if not set ccomp $set ccomp gcc
$ if not set flags $set flags -ldl -m64
$endIf
$ifThen %system.buildcode% == SOL
$ if not set ccomp $set ccomp gcc
$ if not set flags $set flags -ldl -m32
$endIf
$ifThen %system.buildcode% == SOX
$ if not set ccomp $set ccomp gcc
$ if not set flags $set flags -ldl -m64
$endIf


$if not set ccomp $set ccomp cl
$if not set flags $set flags

$set                              S \
$if %system.filesys% == UNIX $set S /
$set                              OUT -Fexp_example1.exe
$if %system.filesys% == UNIX $set OUT -oxp_example1

$call rm -rf demanddata.gdx

$call cd ..%S%C && %ccomp% xp_example1.c api%S%gdxcc.c -Iapi %OUT% %flags%
$if errorlevel 1 $abort 'Problem compiling xp_example1.c'
$call ..%S%C%S%xp_example1 ..%S%..
$if errorlevel 1 $abort 'Problem executing xp_example1 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call ..%S%C%S%xp_example1 ..%S%.. ..%S%GAMS%S%trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1 reading GDX file'
