$title Test xp_example1.f90

$ifthen %system.buildcode% == DEG
$ if not set fcomp   $set fcomp  gfortran -m64
$ if not set ccomp   $set ccomp  gcc -m64
$ if not set libs    $set libs   -ldl
$ if not set symsty  $set symsty -DAPIWRAP_LCASE_DECOR
$endif

$ifthen %system.buildcode% == DIG
$ if not set fcomp   $set fcomp  gfortran -m32
$ if not set ccomp   $set ccomp  gcc -m32
$ if not set libs    $set libs   -ldl
$ if not set symsty  $set symsty -DAPIWRAP_LCASE_DECOR
$endif

$ifthen %system.buildcode% == LNX
$ if not set fcomp   $set fcomp  gfortran -m32
$ if not set ccomp   $set ccomp  gcc -m32
$ if not set libs    $set libs   -ldl
$ if not set symsty  $set symsty -DAPIWRAP_LCASE_DECOR
$endif

$ifthen %system.buildcode% == LEG
$ if not set fcomp   $set fcomp  gfortran
$ if not set ccomp   $set ccomp  gcc
$ if not set libs    $set libs   -ldl
$ if not set symsty  $set symsty -DAPIWRAP_LCASE_DECOR
$endif

$ifthen %system.buildcode% == SIG
$ if not set fcomp   $set fcomp  gfortran -m64
$ if not set ccomp   $set ccomp  gcc -m64
$ if not set libs    $set libs   -ldl
$ if not set symsty  $set symsty -DAPIWRAP_LCASE_DECOR
$endif

$ifthen %system.buildcode% == SOL
$ if not set fcomp   $set fcomp  f90
$ if not set ccomp   $set ccomp  gcc
$ if not set libs    $set libs   -ldl
$ if not set symsty  $set symsty -DAPIWRAP_LCASE_DECOR
$endif

$ifthen %system.buildcode% == SOX
$ if not set fcomp   $set fcomp  f90 -m64
$ if not set ccomp   $set ccomp  gcc -m64
$ if not set libs    $set libs   -ldl
$ if not set symsty  $set symsty -DAPIWRAP_LCASE_DECOR
$endif

$if not set fcomp   $set  fcomp  ifort
$if not set ccomp   $set  ccomp  cl
$if not set libs    $set  libs
$if not set symsty  $set  symsty -DAPIWRAP_LCASE_NODECOR

$set                              S \
$if %system.filesys% == UNIX $set S /
$set                              LIB lib
$if %system.filesys% == UNIX $set LIB ar ruv
$set                              LIBOP -out:
$if %system.filesys% == UNIX $set LIBOP
$set                              LIBEX lib
$if %system.filesys% == UNIX $set LIBEX a
$set                              OBJEX obj
$if %system.filesys% == UNIX $set OBJEX o
$set                              OUT -exe:xp_example1.exe
$if %system.filesys% == UNIX $set OUT -o xp_example1

$call rm -rf demanddata.gdx

$call cd ..%S%Fortran && %fcomp% -c api%S%gdxf9def.f90
$if errorlevel 1 $abort 'Problem compiling gdxf9def.f90'
$call cd ..%S%Fortran && %ccomp% %symsty% -c api%S%gdxf9glu.c -I..%S%C%S%api -I..%S%Fortran%S%api
$if errorlevel 1 $abort 'Problem compiling gdxf9glu.c'
$call cd ..%S%Fortran && %LIB% %LIBOP%gdxf90lib.%LIBEX% gdxf9def.%OBJEX% gdxf9glu.%OBJEX%
$if errorlevel 1 $abort 'Problem creating lib file'
$call cd ..%S%Fortran && %fcomp% -c api%S%gamsglobals_mod.f90 xp_example1.f90
$if errorlevel 1 $abort 'Problem compiling xp_example1.f90'
$call cd ..%S%Fortran && %fcomp% %OUT% gamsglobals_mod.%OBJEX% xp_example1.%OBJEX% gdxf90lib.%LIBEX% %LIBS%
$if errorlevel 1 $abort 'Problem while linking'
$call ..%S%Fortran%S%xp_example1 ..%S%..
$if errorlevel 1 $abort 'Problem executing xp_example1 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call ..%S%Fortran%S%xp_example1 ..%S%.. ..%S%GAMS%S%trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1 reading GDX file'
