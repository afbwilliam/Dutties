$title Test xp_example2.java

$set S     \
$if %system.filesys% == UNIX $set S /
$set P
$if %system.filesys% == UNIX $set P -p
$set C     ;
$if %system.filesys% == UNIX $set C :
$set d64
$if %system.buildcode% == SIG $set d64 -d64
$if %system.buildcode% == DIG $set d64 -d32
$if %system.buildcode% == SOL $set d64 -d32
$if not set jcomp $set jcomp javac

$call rm -rf demanddata.gdx com

$call cd ..%S%Java && mkdir %P% com%S%gams%S%api
$call cd ..%S%Java && mkdir %P% com%S%gams%S%xp_examples
$call cd ..%S%Java && %jcomp% xp_example2.java api%S%gdx.java api%S%opt.java api%S%gamsx.java api%S%gamsglobals.java
$if errorlevel 1 $abort 'Problem compiling xp_example2.java'
$call cd ..%S%Java && cp xp_example2.class com%S%gams%S%xp_examples
$call cd ..%S%Java && cp api%S%gdx.class api%S%opt.class api%S%gamsx.class api%S%gamsglobals.class com%S%gams%S%api
$call java %d64% -cp ..%S%Java -Djava.library.path=..%S%Java%S%api com.gams.xp_examples.xp_example2 ../..
$if errorlevel 1 $abort 'Problem executing xp_example2'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
