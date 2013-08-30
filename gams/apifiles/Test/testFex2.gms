$title Test xp_example2.f90


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
$set                              OUT -exe:xp_example2.exe
$if %system.filesys% == UNIX $set OUT -o xp_example2

$call rm -rf demanddata.gdx

$call cd ..%S%Fortran && %fcomp% -c api%S%gamsxf9def.f90
$if errorlevel 1 $abort 'Problem compiling gamsxf9def.f90'
$call cd ..%S%Fortran && %fcomp% -c api%S%gdxf9def.f90
$if errorlevel 1 $abort 'Problem compiling gdxf9def.f90'
$call cd ..%S%Fortran && %fcomp% -c api%S%optf9def.f90
$if errorlevel 1 $abort 'Problem compiling optf9def.f90'

$call cd ..%S%Fortran && %ccomp% %symsty% -c api%S%gamsxf9glu.c -I..%S%C%S%api -I..%S%Fortran%S%api
$if errorlevel 1 $abort 'Problem compiling gamsxf9glu.c'
$call cd ..%S%Fortran && %ccomp% %symsty% -c api%S%gdxf9glu.c -I..%S%C%S%api -I..%S%Fortran%S%api
$if errorlevel 1 $abort 'Problem compiling gdxf9glu.c'
$call cd ..%S%Fortran && %ccomp% %symsty% -c api%S%optf9glu.c -I..%S%C%S%api -I..%S%Fortran%S%api
$if errorlevel 1 $abort 'Problem compiling optf9glu.c'

$call cd ..%S%Fortran && %LIB% %LIBOP%gamsxf90lib.%LIBEX% gamsxf9def.%OBJEX% gamsxf9glu.%OBJEX%
$if errorlevel 1 $abort 'Problem creating gamsx lib file'
$call cd ..%S%Fortran && %LIB% %LIBOP%gdxf90lib.%LIBEX% gdxf9def.%OBJEX% gdxf9glu.%OBJEX%
$if errorlevel 1 $abort 'Problem creating gdx lib file'
$call cd ..%S%Fortran && %LIB% %LIBOP%optf90lib.%LIBEX% optf9def.%OBJEX% optf9glu.%OBJEX%
$if errorlevel 1 $abort 'Problem creating opt lib file'

$call cd ..%S%Fortran && %fcomp% -c api%S%gamsglobals_mod.f90 xp_example2.f90
$if errorlevel 1 $abort 'Problem compiling xp_example2.f90'
$call cd ..%S%Fortran && %fcomp% %OUT% gamsglobals_mod.%OBJEX% xp_example2.%OBJEX% gamsxf90lib.%LIBEX% gdxf90lib.%LIBEX% optf90lib.%LIBEX% %LIBS%
$if errorlevel 1 $abort 'Problem while linking'
$call ..%S%Fortran%S%xp_example2 ..%S%..
$if errorlevel 1 $abort 'Problem executing xp_example2
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
