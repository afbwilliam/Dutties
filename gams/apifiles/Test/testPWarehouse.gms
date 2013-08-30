$title Test warehouse.py

$set S     \
$if %system.filesys% == UNIX $set S /
$set C     ;
$if %system.filesys% == UNIX $set C :
$set SET   set
$if %system.filesys% == UNIX $set SET export

* The C extension comes with the system, this is only required when doing manual changes there
$if not set rebuildCExtension $goto haveCExtension

$call cd ..%S%Python%S%api && python setup.py build --build-lib .
$if errorlevel 1 $abort 'Problem running dist utils (setup.py)'

$label haveCExtension

$call %SET% PYTHONPATH=..%S%Python%S%api && python ..%S%Python%S%warehouse.py ../..
$if errorlevel 1 $abort 'Problem executing warehouse.py'

$escape &
$ifThen not %sysenv.p26path% == %&sysenv.p26path%&
$call %SET% PYTHONPATH=..%S%Python%S%api_26 && %sysenv.p26path%%S%python ..%S%Python%S%warehouse.py ../..
$if errorlevel 1 $abort 'Problem executing warehouse.py with Python 2.6'
$endif