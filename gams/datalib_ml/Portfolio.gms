$Title  Portfolio Optimization in Excel
$Ontext

In this example GAMS runs only in the background. We use the vba version of the
GDX API to write a GDX file from data defined in the spreadsheet. To solve the
model we call the GAMS executable with a CreateProcess call out of vba.

$Offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$call "start portfolio.xls"
