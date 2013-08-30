$title Test xp_example2.py

$set S     \
$if %system.filesys% == UNIX $set S /
$set C     ;
$if %system.filesys% == UNIX $set C :
$set SET   set
$if %system.filesys% == UNIX $set SET export

$call rm -rf demanddata.gdx com

* The C extension comes with the system, this is only required when doing manual changes there
$if not set rebuildCExtension $goto haveCExtension

$call cd ..%S%Python%S%api && python gamsxsetup.py build --build-lib .
$if errorlevel 1 $abort 'Problem running dist utils (gamsx)'
$call cd ..%S%Python%S%api && python gdxsetup.py build --build-lib .
$if errorlevel 1 $abort 'Problem running dist utils (gdx)'
$call cd ..%S%Python%S%api && python optsetup.py build --build-lib .
$if errorlevel 1 $abort 'Problem running dist utils (opt)'

$label haveCExtension

$call %SET% PYTHONPATH=..%S%Python%S%api && python ..%S%Python%S%xp_example2.py ../..
$if errorlevel 1 $abort 'Problem executing xp_example2'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'

$escape &
$ifThen not %sysenv.p26path% == %&sysenv.p26path%&
$call %SET% PYTHONPATH=..%S%Python%S%api_26 && %sysenv.p26path%%S%python ..%S%Python%S%xp_example2.py ../..
$if errorlevel 1 $abort 'Problem executing xp_example2 with Python 2.6'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected with Python 2.6'
$endif