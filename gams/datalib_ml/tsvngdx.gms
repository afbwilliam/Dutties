$Title Support GDX Files with TortoiseSVN diff (TSVNGDX,SEQ=75)

$Ontext

This gams program helps to integrate gdxdiff with TortoiseSVN.
Two modes are implemented.

--mode=bin (default)
 Calls gdxdiff and shows resulting difffile as well as the log in the GAMS IDE

--mode=text
 Uses gdxdump to write out the correspoding text files and uses the diff utility
 specified by the user. In this case it is TortoiseMerge

In order to integrate this with TortoiseSVN do the following
- open TortoiseSVN's Settings
- go to DiffViewer
- choose Advanced
- choose Add
- Enter extension .gdx
- Enter external program (replace with your GAMS System Directory):
"C:\Program Files\GAMS23.7\gams" "C:\Program Files\GAMS23.7\datalib_ml\tsvngdx.gms" lo=0 --mine=%mine --base=%base --mode=bin

NOTE: So far this only works on Windows since it depends upon Windows programs.

Contributor: Jan-H. Jagla, February 2010

$Offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$if not set base $abort
$if not set mine $abort
$if not set mode $set mode bin
$if %mode%==text $goto gotall
$if %mode%==bin  $goto gotall
$abort mode=%mode% invalid

$label gotall

$ifi NOT %system.filesys% == unix $goto runme
$log Not supported on non Windows system yet
$abort

$label runme

$setnames '%mine%' filepath filename filextension
$log %filename%

$ifthen %mode%==bin
$call IDECmds ViewClose "%sysenv.temp%\difffile.gdx"
$call gdxdiff %base% %mine% "%sysenv.temp%\difffile.gdx" > "%sysenv.temp%\difflog.txt"
$call shellexecute gamside "%sysenv.temp%\difffile.gdx" "%sysenv.temp%\difflog.txt"
$endif

$ifthen %mode%==text
$call gdxdump "%base%" > "%sysenv.temp%\%filename%base.dmp"
$call gdxdump "%mine%" > "%sysenv.temp%\%filename%mine.dmp"
$call shellexecute "C:\Program Files\TortoiseSVN\bin\TortoiseMerge.exe" "%sysenv.temp%\%filename%base.dmp" "%sysenv.temp%\%filename%mine.dmp"
$endif
