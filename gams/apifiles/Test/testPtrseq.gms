$title Test transport_seq.py

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


$onechoV > exTrans
$set S     \
$if %system.filesys% == UNIX $set S /
$set C     ;
$if %system.filesys% == UNIX $set C :
$set SET   set
$if %system.filesys% == UNIX $set SET export

$call %SET% PYTHONPATH=..%S%Python%S%api && python ..%S%Python%S%transport%1.py ../..
$if errorlevel 1 $abort 'Problem executing transport%1.py'

$escape &
$ifThen not %sysenv.p26path% == %&sysenv.p26path%&
$call %SET% PYTHONPATH=..%S%Python%S%api_26 && %sysenv.p26path%%S%python ..%S%Python%S%transport%1.py ../..
$if errorlevel 1 $abort 'Problem executing transport%1.py with Python 2.6'
$endif
$offecho

$batinclude exTrans 1
$batinclude exTrans 2
$batinclude exTrans 3
$batinclude exTrans 4
$batinclude exTrans 5
$batinclude exTrans 6
$batinclude exTrans 7
* Skip this until MT issues are resolved
*$batinclude exTrans 8
* These two need more references, cannot assume that they are the same one all machines
*$batinclude exTrans 9
*$batinclude exTrans 10
$batinclude exTrans 11
