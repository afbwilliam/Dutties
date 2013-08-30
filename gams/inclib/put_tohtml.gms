
*display "%1","%2","%2","%4","%5","%6"
$offlog
$ontext
Programmed by Bruce McCarl
This creates an html or csv table of a gams parameter
$offtext

*display 'top htmltable2','%1','%2','%3','%4';
$setglobal RTUPLE
$setglobal cTUPLE
$setglobal Rvary
$setglobal cvary


$libinclude put_initialize

$if "a%1" == "a" $exit


$setglobal args "%1 %2 %3 %4 %5 %6 %7 %8 %9 %10 %11 %12 %13 %14 %15 %16 %17 %18 %19 %20 %21 %22 %23 %24 %25 %26 %27 %28 %29 %30"
$offlisting
$onlisting



$ifthen not putopen
                   file  testhtml           file name to use /it.html/;
                   put   testhtml ;
$endif

$libinclude put_reorderit %args%

display "%rvary% zz %cvary%  zz %array%";

if (newtable=0,
     put '%blankline%' /;
     put '%blankline%' ;
     put '%starttable%' /;
);
if (newtable <>0,
     put '%blankrow%'  /;
     put '%starttabrow%'    /;);
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     icount=0;
           put$(%rowcount%=0) '%lelementl%'  ' ':twidut '%lendelement%';
           put$(%rowcount%>0) '%lelementl%'  '%rzz1%':twidut '%lendelement%';
           put$(%rowcount%>1)  '%lelementl%' '%rzz2%':twidut '%lendelement%';
           put$(%rowcount%>2)  '%lelementl%' '%rzz3%':twidut '%lendelement%';
           put$(%rowcount%>3)  '%lelementl%' '%rzz4%':twidut '%lendelement%';
           put$(%rowcount%>4)  '%lelementl%' '%rzz5%':twidut '%lendelement%';
           put$(%rowcount%>5)  '%lelementl%' '%rzz6%':twidut '%lendelement%';
           put$(%rowcount%>6)  '%lelementl%' '%rzz7%':twidut '%lendelement%';
           put$(%rowcount%>7)  '%lelementl%' '%rzz8%':twidut '%lendelement%';
           put$(%rowcount%>8)  '%lelementl%' '%rzz9%':twidut '%lendelement%';
           put$(%rowcount%>9)  '%lelementl%' '%rzz10':twidut '%lendelement%';
           put$(%rowcount%>10) '%lelementl%' '%rzz11%':twidut '%lendelement%';
           put$(%rowcount%>11) '%lelementl%' '%rzz12%':twidut '%lendelement%';
           put$(%rowcount%>12) '%lelementl%' '%rzz13%':twidut '%lendelement%';
           put$(%rowcount%>13) '%lelementl%' '%rzz14%':twidut '%lendelement%';
           put$(%rowcount%>14) '%lelementl%' '%rzz15%':twidut '%lendelement%';
           put$(%rowcount%>15) '%lelementl%' '%rzz16%':twidut '%lendelement%';
           put$(%rowcount%>16) '%lelementl%' '%rzz17%':twidut '%lendelement%';
           put$(%rowcount%>17) '%lelementl%' '%rzz18%':twidut '%lendelement%';
           put$(%rowcount%>18) '%lelementl%' '%rzz19%':twidut '%lendelement%';
           put$(%rowcount%>19) '%lelementl%' '%rzz20%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
$    if %colcount% == 0 $goto vectorh
$    if %rowcount% == 0 $goto vectorh
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz1%.te(%czz1%):twidut);
           if(tl_or_te<=0, put %czz1%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;
$    if "%colcount%"=="1" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz2%.te(%czz2%):twidut);
           if(tl_or_te<=0, put %czz2%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;
$    if "%colcount%"=="2" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz3%.te(%czz3%):twidut);
           if(tl_or_te<=0, put %czz3%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="3" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz4%.te(%czz4%):twidut);
           if(tl_or_te<=0, put %czz4%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="4" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz5%.te(%czz5%):twidut);
           if(tl_or_te<=0, put %czz5%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="5" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz6%.te(%czz6%):twidut);
           if(tl_or_te<=0, put %czz6%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="6" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz7%.te(%czz7%):twidut);
           if(tl_or_te<=0, put %czz7%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="7" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz8%.te(%czz8%):twidut);
           if(tl_or_te<=0, put %czz8%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="8" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz9%.te(%czz9%):twidut);
           if(tl_or_te<=0, put %czz9%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="9" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz10%.te(%czz10%):twidut);
           if(tl_or_te<=0, put %czz10%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="10" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz11%.te(%czz11%):twidut);
           if(tl_or_te<=0, put %czz11%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;

$    if "%colcount%"=="11" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz12%.te(%czz12%):twidut);
           if(tl_or_te<=0, put %czz12%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;

$    if "%colcount%"=="12" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz13%.te(%czz13%):twidut);
           if(tl_or_te<=0, put %czz13%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;

$    if "%colcount%"=="13" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz14%.te(%czz14%):twidut);
           if(tl_or_te<=0, put %czz14%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="14" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz15%.te(%czz15%):twidut);
           if(tl_or_te<=0, put %czz15%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="15" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz16%.te(%czz16%):twidut);
           if(tl_or_te<=0, put %czz16%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="16" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz17%.te(%czz17%):twidut);
           if(tl_or_te<=0, put %czz17%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="17" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz18%.te(%czz18%):twidut);
           if(tl_or_te<=0, put %czz18%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="18" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz19%.te(%czz19%):twidut);
           if(tl_or_te<=0, put %czz19%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="19" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementr%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementr%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop(%ctuple%(%cvary%),
           put '%lelementr%';
           if(tl_or_te>0, put %czz20%.te(%czz20%):twidut);
           if(tl_or_te<=0, put %czz20%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

******************************
$label donec2
*is it there
     loop(%rtuple%(%rvary%),
              put '%starttabrow%'
              if(skipcolumns>0,
                for (icount=1 to skipcolumns,
                     put '%lelementl%' '%spaces%':twidut '%lendelement%';
$                 if not setglobal codetocsv put /;
                 ));
           put '%lelementl%';
           if(tl_or_te>0, put %rzz1%.te(%rzz1%):twidut);
           if(tl_or_te<=0, put %rzz1%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="1" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz2%.te(%rzz2%):twidut);
           if(tl_or_te<=0, put %rzz2%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="2" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz3%.te(%rzz3%):twidut);
           if(tl_or_te<=0, put %rzz3%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="3" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz4%.te(%rzz4%):twidut);
           if(tl_or_te<=0, put %rzz4%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="4" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz5%.te(%rzz5%):twidut);
           if(tl_or_te<=0, put %rzz5%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="5" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz6%.te(%rzz6%):twidut);
           if(tl_or_te<=0, put %rzz6%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="6" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz7%.te(%rzz7%):twidut);
           if(tl_or_te<=0, put %rzz7%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="7" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz8%.te(%rzz8%):twidut);
           if(tl_or_te<=0, put %rzz8%.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="8" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz9%.te(%rzz9%):twidut);
           if(tl_or_te<=0, put %rzz9%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="9" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz10%.te(%rzz10%):twidut);
           if(tl_or_te<=0, put %rzz10%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="10" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz11%.te(%rzz11%):twidut);
           if(tl_or_te<=0, put %rzz11%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="11" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz12%.te(%rzz12%):twidut);
           if(tl_or_te<=0, put %rzz12%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="12" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz13%.te(%rzz13%):twidut);
           if(tl_or_te<=0, put %rzz13%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="13" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz14%.te(%rzz14%):twidut);
           if(tl_or_te<=0, put %rzz14%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="14" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz15%.te(%rzz15%):twidut);
           if(tl_or_te<=0, put %rzz15%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="15" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz16%.te(%rzz16%):twidut);
           if(tl_or_te<=0, put %rzz16%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="16" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz17%.te(%rzz17%):twidut);
           if(tl_or_te<=0, put %rzz17%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="17" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz18%.te(%rzz18%):twidut);
           if(tl_or_te<=0, put %rzz18%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="18" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz19%.te(%rzz19%):twidut);
           if(tl_or_te<=0, put %rzz19%.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="19" $goto doner2
           put '%lelementl%';
           if(tl_or_te>0, put %rzz20%.te(%rzz20%):twidut);
           if(tl_or_te<=0, put %rzz20%.tl      :twidut);
           put     '%lendelement%';
$label doner2
*is it here
      loop(%ctuple%(%cvary%),put '%nelementr%';
                  sczz=%array%*multconst;
$                 if settype %array2%   if(sczz ,put 'X');
$                 if settype %array2%   if(not sczz ,put '%spaces%');
$                 if not settype %array2%   if((iwantzeros or  sczz and (not usexs)) ,put sczz:twidut:decimalsiwant);
$                 if not settype %array2%   if(usexs and  (not sczz) ,put '%spaces%');
$                 if not settype %array2%   if(usexs and  (sczz) ,put 'X');
$                 if not settype %array2%   if(iwantzeros=0 and not sczz,put '%spaces%'; );
                         put '%nendelement%';
$                         if not setglobal codetocsv put /;
                          );
                    put / '%endtabrow%'
           );
       if(newtable<>1,
          put '%endtable%' /);
       put / / ;



$label bombout
*$show
$exit
$label vectorh
*on a vector
$ifthen settype %array2%
     put '%starttable%' /;
     loop(%array2%,
          put '%starttabrow%'
              '%lelementl%'
              %array2%.tl:0
              '%lendelement%'
              '%lelementl%'
              %array2%.te(%array2%):0:decimalsiwant
              '%lendelement%'
          put '%endtabrow%' /);
     put '%endtable%' ;
$endif
*$ontext
$ifthen partype %array2%
     put '%starttable%' /;
     loop(%r1%,
          sczz=%array%*multconst;
          put '%starttabrow%'
              '%lelementl%'
              %r1%.tl:0
              '%lendelement%'
              '%lelementl%'
              sczz:0
              '%lendelement%';
          put '%endtabrow%' / ;);
     put '%endtable%'         ;

$if "a%rtuple%" == "a" $goto zzzcc
$if not "a%rvary%" == "a" %RTUPLE%(%RVARY%)=NO;
$label zzzcc
$if "a%ctuple%" == "a" $goto zzzcc2
$if not "a%cvary%" == "a" %CTUPLE%(%CVARY%)=NO;
$label zzzcc2
$endif

