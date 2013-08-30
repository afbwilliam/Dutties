$ontext
Store data from Access database into a GDX file.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

execute '=gams.exe MDBsr0 lo=%GAMS.lo% gdx=Transportation.gdx';
abort$errorlevel "step 0 failed";
execute '=gdxviewer.exe Transportation.gdx';
