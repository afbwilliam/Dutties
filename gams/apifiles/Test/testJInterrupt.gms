$title Test Java ConsoleInterrupt Example

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

* compile ConsoleInterrupt.java
$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%javac -cp .%S%api%S%GAMSJavaAPI.jar%C%. -d .  ConsoleInterrupt.java
$if errorlevel 1 $abort 'Problem compiling ConsoleInterrupt.java'

* run ConsoleInterrupt.class
$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%java -cp .%S%api%S%GAMSJavaAPI.jar%C%. -Djava.library.path=.%S%api %package%.ConsoleInterrupt
$if errorlevel 1 $abort 'Problem executing ConsoleInterrupt.class'


