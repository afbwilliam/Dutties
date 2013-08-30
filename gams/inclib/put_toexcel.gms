
$ontext
the following puts files to excel in a fashion that allows sets to be moved around

call is of form

$libinclude put_toexcel n1 n2 a1 param st1 st2 ... workbook sheet
where  n1 is number of sets to vary in rows
       n2 is number of sets to vary in columns
       a1 is the name of the item to put into excel for now only parameters
       param is the set dependence in parenthesis
       st1  is the name of the first set to put in rows
       st2  is the name of next set to use
       st   specifications continue until you have n1+n2 of them
       workbook is name of excel workbook to put information to
       sheet is the name of the sheet in the workbook

also
   excelrownumber is the row number in the a column where this would start
   you can put some labeling at the top
      to do this
        you must define a set as a subset of the universal set
           set onetouse(*)
        you must use a statement like
           $setglobal settoexcel onetouse
        you then can have up to 10 elements in that set that will appear just before the table
      to stop this use
           $dropglobal settoexcel

examples

$offtext

$if not declared excelrownumber      scalar excelrownumber row number in excel /1/;

$ifthen not declared tempdatazz1
$libinclude put_initialize
$endif


*exit if no arguments used
$if "a%1" == "a" $exit
$setglobal args "%1 %2 %3 %4 %5 %6 %7 %8 %9 %10 %11 %12 %13 %14 %15 %16 %17 %18 %19 %20 %21 %22 %23 %24 %25 %26 %27 %28 %29 %30"
$if settype %3 $setglobal settoexcel

$libinclude put_reorderit %args%

*put out gdxxrw instructions
put toexcel;
$ifthen setglobal settoexcel
   put 'set=tempsetzz%itc%      Rng=%sheetnameh%!a' excelrownumber:0:0 ' rdim=%rowcount% trace=3' /;
$endif
$ifthen not setglobal settoexcel
   put 'par=tempdatazz%itc%      Rng=%sheetnameh%!a' excelrownumber:0:0 '  cdim=%colcount% trace=3' /;
$endif
*:iv20000
putclose;

$show
rcountzz=0;
$if a%rvary%==a loop((%cvary%),rcountzz=rcountzz+1);
$ifthen not a%rvary%==a
$   if not a%cvary%==a  loop((%rvary%)$sum((%cvary%)$%array%,1),rcountzz=rcountzz+1);
$   if     a%cvary%==a  loop((%rvary%),rcountzz=rcountzz+1);
$endif
*send data to gdx file
execute_unload 'temp.gdx',
$if not setglobal settoexcel tempdatazz%itc%
$if setglobal settoexcel tempsetzz%itc%
;

*put data into excel
execute 'gdxxrw temp.gdx o=%workbookh%.xls   @toexcel.txt' ;

*zero out the temporary array
option clear=tempdatazz%itc%;
option clear=tempsetzz%itc%;

excelrownumber=excelrownumber+rcountzz+5;
$dropglobal settoexcel
