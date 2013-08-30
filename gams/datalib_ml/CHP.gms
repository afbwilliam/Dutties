$Title  Combined Heat and Power Generation
$Ontext

In this example GAMS runs only in the background. We use gdxxrw to write a GDX
file from data defined in the spreadsheet. With the vba version of the option
object API we set several GAMS options from vba and solve the model using the
gamsx API out of vba. At the end the solution is written into a user defined
workbook using gdxxrw again.

$Offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$call "start chp.xls"
