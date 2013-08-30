$ontext
   This program illustrates the use of filesavebox.

$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

* Set i is saved under the chosen name by the user in GDX format
* By default the project directory will open, in order to save files in other directories
* option "i" must be used to set directory path as in the following example:
*$call =ask T=filesavebox I="%system.fp%" o=fln.inc R="$setglobal gdxfile '%s'" C="Specify gdx file"
$call =ask T=filesavebox o=fln.inc R="$setglobal gdxfile '%s'" C="Specify gdx file"
$include fln.inc
set i /a,b,c/;
execute_unload '%gdxfile%',i;
