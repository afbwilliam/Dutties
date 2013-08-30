$title 'Test GDXCOPY utility with -V5 option' (GDXCOPY1,SEQ=290)

$ontext

Gdxcopy should write a version 5 GDX file
(i.e. one compatible with Distribution 22.2) if the -v5
flag is used.

Contributor: Steve Dirkse
$offtext

$set subdir gdxcopy.dir
$set dirsep \
$if %system.filesys% == UNIX $set dirsep /

$onecho > makegdx.gms
set I / 1 * 10 /;
parameter c(I);
c(I) = ord(I);
positive variable x(I);
x.up(I) = 2 * c(I);
x.l(I)  = c(I);
x.m(I) = 3 * c(I);
$offecho

$if dexist %subdir% $call rm -r %subdir%
$if dexist %subdir% $abort directory %subdir% still exists!
$call =gams makegdx.gms lo=%GAMS.lo% gdx=tcopy.gdx

* $call mkdir %subdir%
$call gdxcopy -v5 tcopy.gdx %subdir%
$if not dexist %subdir%                  $abort directory %subdir% should exist after gdxdopy call
$if not  exist %subdir%%dirsep%tcopy.gdx $abort file %subdir%%dirsep%tcopy.gdx should exist after gdxdopy call

$call =gdxdiff tcopy.gdx %subdir%%dirsep%tcopy.gdx
$if errorlevel 1 $abort "Files differ: bad gdxcopy or gdxdiff"

$log All done: the test passed
