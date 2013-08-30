$title Test Java Transport Sequence Examples

$set S     \
$if %system.filesys% == UNIX $set S /
$set C     ;
$if %system.filesys% == UNIX $set C :
$set SET   set
$if %system.filesys% == UNIX $set SET export
$set DOLLAR1 %
$if %system.filesys% == UNIX $set DOLLAR1 ${
$set DOLLAR2 %
$if %system.filesys% == UNIX $set DOLLAR2 }
$set package com.gams.examples

$onechoV > JexTrans

$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%javac -cp .%S%api%S%GAMSJavaAPI.jar%C%. -d .  Transport%1.java
$if errorlevel 1 $abort 'Problem compiling Transport%1.java'

$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%java -cp .%S%api%S%GAMSJavaAPI.jar%C%. -Djava.library.path=.%S%api %package%.Transport%1
$if errorlevel 1 $abort 'Problem executing transport%1.class'

$offecho

$batinclude JexTrans 1
$batinclude JexTrans 2
$batinclude JexTrans 3
$batinclude JexTrans 4
$batinclude JexTrans 5
$batinclude JexTrans 6

* no gurobi on SIG, SOL, SOX
$if not %system.buildcode% == SIG $if not %system.buildcode% == SOL $if not  %system.buildcode% == SOX $batinclude JexTrans 7

$batinclude JexTrans 8

* do not test examples using msaccess/msexcel java library
* $batinclude JexTrans 9
* $batinclude JexTrans 10

$batinclude JexTrans 11
$batinclude JexTrans 12

