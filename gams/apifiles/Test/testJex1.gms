$title Test xp_example1.java

$set S     \
$if %system.filesys% == UNIX $set S /
$set P
$if %system.filesys% == UNIX $set P -p
$set d64
$if %system.buildcode% == SIG $set d64 -d64
$if %system.buildcode% == DIG $set d64 -d32
$if %system.buildcode% == SOL $set d64 -d32
$if not set jcomp $set jcomp javac

$call rm -rf demanddata.gdx com

$call cd ..%S%Java && mkdir %P% com%S%gams%S%api
$call cd ..%S%Java && mkdir %P% com%S%gams%S%xp_examples
$call cd ..%S%Java && %jcomp% xp_example1.java api%S%gdx.java api%S%gamsglobals.java
$if errorlevel 1 $abort 'Problem compiling xp_example1.java'
$call cd ..%S%Java && cp xp_example1.class com%S%gams%S%xp_examples
$call cd ..%S%Java && cp api%S%gdx.class api%S%gamsglobals.class com%S%gams%S%api
$call java %d64% -cp ..%S%Java -Djava.library.path=..%S%Java%S%api com.gams.xp_examples.xp_example1 ../..
$if errorlevel 1 $abort 'Problem executing xp_example1 writing GDX file'
$call gdxdiff demanddata.gdx demandwant.gdx
$if errorlevel 1 $abort 'Demanddata not as expected'
$call java %d64% -cp ..%S%Java -Djava.library.path=..%S%Java%S%api com.gams.xp_examples.xp_example1 ../.. ..%S%GAMS%S%trnsport.gdx
$if errorlevel 1 $abort 'Problem executing xp_example1 reading GDX file'
