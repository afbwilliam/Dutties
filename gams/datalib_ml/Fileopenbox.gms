$ontext
   This program illustrates the use of fileopenbox. The trnsport.gms
   is divided into three files: TrnsportSetDec.inc, TrnsportSetData.gdx,
   Trnsport.inc. In the first popup TrnsportSetDec.inc, in the second
   TrnsportSetData.gdx and in the third one Trnsport.inc should be
   selected.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

* The file FLN1.INC will contain an include statement with the file the user has selected.
* By default the project directory will open, in order to open files from other directories
* option "i" must be used to set directory path as in the following example:
* $call =ask T=fileopenbox I="%system.fp%" F="Trns*.inc" o=fln1.inc R="$include '%s'" C="Select include file"
$call =ask T=fileopenbox F="Trns*.inc" o=fln1.inc R="$include '%s'" C="Select include file"
$include fln1.inc

* "$setglobal" is used to set the macro in the SETGDXNAME.INC to contain the user-specified file name
$call =ask T=fileopenbox F="Trns*.gdx" o=setgdxname.inc R="$setglobal gdxfile '%s'" C="Select GDX file"
$include setgdxname.inc
$gdxin %gdxfile%
$load i
$load j


* "$setglobal" is used to set the macro in the FLN2.INC to contain the user-specified file name
$call =ask T=fileopenbox F="Trns*.inc" o=fln2.inc R="$setglobal incfile '%s'" C="Select include file"
$include fln2.inc
$include %incfile%

