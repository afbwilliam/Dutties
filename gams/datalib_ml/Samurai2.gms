$Title  Samurai Sudoku in Excel
$Ontext

In this example GAMS runs only in the background. We use the vba version of the
GDX API to write a GDX file from data defined in the spreadsheet. With the
option object API we set several GAMS options from vba and solve the model using
the gamsx API out of vba.

$Offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$call "start samurai2.xls"
