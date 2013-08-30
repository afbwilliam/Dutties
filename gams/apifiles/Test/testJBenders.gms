$title Test Java Benders2Stage Examples

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

* compile Bender2Stage.java
$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%javac -cp .%S%api%S%GAMSJavaAPI.jar%C%. -d .  Benders2Stage.java
$if errorlevel 1 $abort 'Problem compiling Benders2Stagejava'

* run Bender2Stage.class
$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%java -cp .%S%api%S%GAMSJavaAPI.jar%C%. -Djava.library.path=.%S%api %package%.Benders2Stage
$if errorlevel 1 $abort 'Problem executing Benders2Stage.class'

* compile Bender2StageMT.java
$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%javac -cp .%S%api%S%GAMSJavaAPI.jar%C%. -d .  Benders2StageMT.java
$if errorlevel 1 $abort 'Problem compiling Benders2StageMT.java'

* run Bender2StageMT.class
$call cd ..%S%Java && %DOLLAR1%JPATH%DOLLAR2%%S%java -cp .%S%api%S%GAMSJavaAPI.jar%C%. -Djava.library.path=.%S%api %package%.Benders2StageMT
$if errorlevel 1 $abort 'Problem executing Benders2StageMT.class'
