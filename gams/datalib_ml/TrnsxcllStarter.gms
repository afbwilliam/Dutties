$Title  Trnsxcll: Excel Spreadsheet in Charge of GAMS
$Ontext

This Transportation Model text is implemented in conjuction with an Excel workbook

The worksheet writes the files included below named:
            supply.set
            demand.set
            supply.dat
            demand.dat
            distance.dat
            tran.dat
This code sends back solution in output.csv

Contributor: Bruce McCarl, March 2012

$Offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

$call "start Trnsxcll.xls"
