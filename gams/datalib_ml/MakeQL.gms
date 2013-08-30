$ontext

This model demonstrates how to generate include files automatically which are
needed for extrinsic function libraries. The files which are generated here are
used in the GAMS Test Library models TRILIB01, TRILIB02 and TRILIB03.

$offtext

$call gams extfwrapper.gms lo=%GAMS.lo% --extflib=tricclib.gms
$if errorlevel 1 $abort problem creating tricclib files
$call gams extfwrapper.gms lo=%GAMS.lo% --extflib=tridclib.gms
$if errorlevel 1 $abort problem creating tridclib files
$call gams extfwrapper.gms lo=%GAMS.lo% --extflib=triifort.gms
$if errorlevel 1 $abort problem creating triifort files
