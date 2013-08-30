$title Test cutstock.py

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

$call %SET% PYTHONPATH=..%S%Python%S%api && python ..%S%Python%S%cutstock.py ../..
$if errorlevel 1 $abort 'Problem executing cutstock.py'