
*display "%1","%2","%3",'%4';
$if not declared endtable $libinclude report_puthtmlcodes.gms
$if not declared sczz scalar sczz temporary;
$if not declared icount  scalar icount temporary counter /0/;
$if not declared icount2 scalar icount2 temporary counter  /0/;
$if not declared usexs   scalar usexs temporary scalar /0/;
$if not declared twidut scalar twidut   width in put files           /0/
$ifthen not declared iicntqq
set    iicntqq  set used in generic html put /ssqq1*ssqq20/;
alias (*,rssqq);
set    rassz1(rssqq) temporary set in generic put
       rassz2(rssqq) temporary set in generic put
       rassz3(rssqq) temporary set in generic put
       rassz4(rssqq) temporary set in generic put
       rassz5(rssqq) temporary set in generic put
       rassz6(rssqq) temporary set in generic put
       rassz7(rssqq) temporary set in generic put
       rassz8(rssqq) temporary set in generic put
       rassz9(rssqq) temporary set in generic put
       rassz10(rssqq) temporary set in generic put
       rassz11(rssqq) temporary set in generic put
       rassz12(rssqq) temporary set in generic put
       rassz13(rssqq) temporary set in generic put
       rassz14(rssqq) temporary set in generic put
       rassz15(rssqq) temporary set in generic put
       rassz16(rssqq) temporary set in generic put
       rassz17(rssqq) temporary set in generic put
       rassz18(rssqq) temporary set in generic put
       rassz19(rssqq) temporary set in generic put
       rassz20(rssqq) temporary set in generic put
       cassz1(rssqq) temporary set in generic put
       cassz2(rssqq) temporary set in generic put
       cassz3(rssqq) temporary set in generic put
       cassz4(rssqq) temporary set in generic put
       cassz5(rssqq) temporary set in generic put
       cassz6(rssqq) temporary set in generic put
       cassz7(rssqq) temporary set in generic put
       cassz8(rssqq) temporary set in generic put
       cassz9(rssqq) temporary set in generic put
       cassz10(rssqq) temporary set in generic put
       cassz11(rssqq) temporary set in generic put
       cassz12(rssqq) temporary set in generic put
       cassz13(rssqq) temporary set in generic put
       cassz14(rssqq) temporary set in generic put
       cassz15(rssqq) temporary set in generic put
       cassz16(rssqq) temporary set in generic put
       cassz17(rssqq) temporary set in generic put
       cassz18(rssqq) temporary set in generic put
       cassz19(rssqq) temporary set in generic put
       cassz20(rssqq) temporary set in generic put
$endif

$if not declared  skipcolumns   scalar skipcolumns        columns to skip in html code                                    /0/;
$if not declared  newtable      scalar newtable           do i start a new table (0) or continue one (1) in in html code  /0/;
$if not declared  tl_or_te      scalar tl_or_te           do i use tl (1) or te (0) when putting out sets                 /1/;
$if not declared  decimalsiwant scalar decimalsiwant      decimals in html put                                            /0/;
$if not declared  iwantzeros    scalar iwantzeros         do i want zeros in in html put                                  /1/;

$if "a%1" == "a" $exit
$offlisting
$ontext
This creates an html or csv table of a gams parameter

it has several main parameters

bat include
%1 number of items in a row
%2 number of items in a column
%3 full name and dimensionality of parameter
%4-%13 names of sets to vary in order to vary where %1 and %2 control ones to put in row or column not all sets have to be there as some can be controlled in external loop

others
         decimalsiwant number of decimals to output currently for all columns
         skipcolumns        columns to skip in html code
         newtable           do i start a new table (0) or continue one (1) in in html code
         tl_or_te           do i use tl (1) or te (0) wen putting out sets

$setglobal         codetocsv   if set global causes this to go to csv format

it works as follows

given parameter a(i,j,k)

you can call and dump out a in many forms
$libinclude report_puthtmltable 2 1 a (i,j,k) k j i
puts out
               i1   i2
k1  j1        a     a
k1  j2        a     a
k2  j1        a     a
k2  j2        a     a

$libinclude report_puthtmltable 1 2 a (i,j,k) j k  i
puts out
          k1   k1    k2  k2
          i1   i2     i1   i2
j1       a     a     a     a
j2       a     a     a     a
j1       a     a     a     a
j2       a     a     a     a

also you can do
loop(k,
$   libinclude report_puthtmltable 1 1 a (i,j,k) i j
) ;

that put out a table for each k value

$offtext
$onlisting



$ifthen not putopen
                   file  testhtml           file name to use /it.html/;
                   put   testhtml ;
$endif

$if "a%1"=="a" $exit




*generic put file


$offlisting
$ontext
examples below

set r1 /s11*s12/;
set r2 /s21*s22/;
set r3 /s31*s32/;
set r4 /s41*s42/;
set r5 /s51*s52/;
parameter a(r1,r2,r3,r4,r5);
a(r1,r2,r3,r4,r5)=9998889977888;
a("s12",r2,r3,r4,r5)=0;
$setglobal codetocsv

$libinclude %whereissource%report_puthtmltable 1 4 a(r1,r2,r3,r4,r5) r2 r1 r3 r4 r5
$libinclude %whereissource%report_puthtmltable 2 3 a(r1,r2,r3,r4,r5) r2 r1 r3 r4 r5
$libinclude %whereissource%report_puthtmltable 3 2 a(r1,r2,r3,r4,r5) r2 r1 r3 r4 r5
$libinclude %whereissource%report_puthtmltable 4 1 a(r1,r2,r3,r4,r5) r2 r1 r3 r4 r5
$offtext

$onlisting


$setlocal rvary ""
$setlocal rvary1 ""
$setlocal cvary ""
$setlocal cvary1 ""
$setlocal cvary2 ""
$setlocal rowcount %1
$shift
$setlocal colcount %1
$shift
$setlocal array2 %1
$setlocal array %1%2
$shift
$shift
$setlocal r1 %1

$if "%colcount%" == "0" $goto vector
$if "%rowcount%" == "0" $goto vector
$     setlocal rvary "%rvary%%1"
$     setlocal rvary1 "%1"
$     setlocal rvary2 "rassz1"
$     setlocal rvary3 "sameas(rassz1,%1)"
$     setlocal r1 %1
$     shift
$if "%rowcount%" == "1" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz2"
$     setlocal rvary3 "%rvary3% and sameas(rassz2,%1)"
$     setlocal r2 %1
$     shift
$if "%rowcount%" == "2" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz3"
$     setlocal rvary3 "%rvary3% and sameas(rassz3,%1)"
$     setlocal r3 %1
$     shift
$if "%rowcount%" == "3" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz4"
$     setlocal rvary3 "%rvary3% and sameas(rassz4,%1)"
$     setlocal r4 %1
$     shift
$if "%rowcount%" == "4" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz5"
$     setlocal rvary3 "%rvary3% and sameas(rassz5,%1)"
$     setlocal r5 %1
$     shift
$if "%rowcount%" == "5" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz6"
$     setlocal rvary3 "%rvary3% and sameas(rassz6,%1)"
$     setlocal r6 %1
$     shift
$if "%rowcount%" == "6" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz7"
$     setlocal rvary3 "%rvary3% and sameas(rassz7,%1)"
$     setlocal r7 %1
$     shift
$if "%rowcount%" == "7" $goto endrows
$     setlocal rvary "%rvary%%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz8"
$     setlocal rvary3 "%rvary3% and sameas(rassz8,%1)"
$     setlocal r8 %1
$     shift
$if "%rowcount%" == "8" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz9"
$     setlocal rvary3 "%rvary3% and sameas(rassz9,%1)"
$     setlocal r9 %1
$     shift
$if "%rowcount%" == "9" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz10"
$     setlocal rvary3 "%rvary3% and sameas(rassz10,%1)"
$     setlocal r10 %1
$     shift
$if "%rowcount%" == "10" $goto endrows
$     setlocal rvary "%rvary%%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz11"
$     setlocal rvary3 "%rvary3% and sameas(rassz11,%1)"
$     setlocal r11 %1
$     shift
$if "%rowcount%" == "11" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz12"
$     setlocal rvary3 "%rvary3% and sameas(rassz12,%1)"
$     setlocal r12 %1
$     shift
$if "%rowcount%" == "12" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz13"
$     setlocal rvary3 "%rvary3% and sameas(rassz13,%1)"
$     setlocal r13 %1
$     shift
$if "%rowcount%" == "13" $goto endrows
$     setlocal rvary "%rvary%%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz14"
$     setlocal rvary3 "%rvary3% and sameas(rassz14,%1)"
$     setlocal r14 %1
$     shift
$if "%rowcount%" == "14" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz15"
$     setlocal rvary3 "%rvary3% and sameas(rassz15,%1)"
$     setlocal r15 %1
$     shift
$if "%rowcount%" == "15" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz16"
$     setlocal rvary3 "%rvary3% and sameas(rassz16,%1)"
$     setlocal r16 %1
$     shift
$if "%rowcount%" == "16" $goto endrows
$     setlocal rvary "%rvary%%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz17"
$     setlocal rvary3 "%rvary3% and sameas(rassz17,%1)"
$     setlocal r17 %1
$     shift
$if "%rowcount%" == "17" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz18"
$     setlocal rvary3 "%rvary3% and sameas(rassz18,%1)"
$     setlocal r18 %1
$     shift
$if "%rowcount%" == "18" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz19"
$     setlocal rvary3 "%rvary3% and sameas(rassz19,%1)"
$     setlocal r19 %1
$     shift
$if "%rowcount%" == "19" $goto endrows
$     setlocal rvary "%rvary%,%1"
$     setlocal rvary1 "%rvary1%,%1"
$     setlocal rvary2 "%rvary2%,rassz20"
$     setlocal rvary3 "%rvary3% and sameas(rassz20,%1)"
$     setlocal r20 %1
$     shift
*$if "%rowcount%" == "20" $goto endrows
$label endrows
$     setlocal rvary "%rvary%"


$if "%colcount%" == "0" $goto endcols
$     setlocal cvary "%cvary%%1"
$     setlocal cvary1 "cassz1(%1)"
$     setlocal cvary2 "cassz1(%1)"

$     setlocal c1 %1
$     shift
$if "%colcount%" == "1" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz2(%1)"
$     setlocal cvary2 "%cvary2% and cassz2(%1)"
$     setlocal c2 %1
$     shift
$if "%colcount%" == "2" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz3(%1)"
$     setlocal cvary2 "%cvary2% and cassz3(%1)"
$     setlocal c3 %1
$     shift
$if "%colcount%" == "3" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz4(%1)"
$     setlocal cvary2 "%cvary2% and cassz4(%1)"
$     setlocal c4 %1
$     shift
$if "%colcount%" == "4" $goto endcols
$     setlocal cvary "%cvary%%1"
$     setlocal cvary1 "%cvary1%,cassz5(%1)"
$     setlocal cvary2 "%cvary2% and cassz5(%1)"
$     setlocal c5 %1
$     shift
$if "%colcount%" == "5" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz6(%1)"
$     setlocal cvary2 "%cvary2% and cassz6(%1)"
$     setlocal c6 %1
$     shift
$if "%colcount%" == "6" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz7(%1)"
$     setlocal cvary2 "%cvary2% and cassz7(%1)"
$     setlocal c7 %1
$     shift
$if "%colcount%" == "7" $goto endcols
$     setlocal cvary "%cvary%%1"
$     setlocal cvary1 "%cvary1%,cassz8(%1)"
$     setlocal cvary2 "%cvary2% and cassz8(%1)"
$     setlocal c8 %1
$     shift
$if "%colcount%" == "8" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz9(%1)"
$     setlocal cvary2 "%cvary2% and cassz9(%1)"
$     setlocal c9 %1
$     shift
$if "%colcount%" == "9" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz10(%1)"
$     setlocal cvary2 "%cvary2% and cassz10(%1)"
$     setlocal c10 %1
$     shift
$if "%colcount%" == "10" $goto endcols
$     setlocal cvary "%cvary%%1"
$     setlocal cvary1 "%cvary1%,cassz11(%1)"
$     setlocal cvary2 "%cvary2% and cassz11(%1)"
$     setlocal c11 %1
$     shift
$if "%colcount%" == "11" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz12(%1)"
$     setlocal cvary2 "%cvary2% and cassz12(%1)"
$     setlocal c12 %1
$     shift
$if "%colcount%" == "12" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz13(%1)"
$     setlocal cvary2 "%cvary2% and cassz13(%1)"
$     setlocal c13 %1
$     shift
$if "%colcount%" == "13" $goto endcols
$     setlocal cvary "%cvary%%1"
$     setlocal cvary1 "%cvary1%,cassz14(%1)"
$     setlocal cvary2 "%cvary2% and cassz14(%1)"
$     setlocal c14 %1
$     shift
$if "%colcount%" == "14" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz15(%1)"
$     setlocal cvary2 "%cvary2% and cassz15(%1)"
$     setlocal c15 %1
$     shift
$if "%colcount%" == "15" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz16(%1)"
$     setlocal cvary2 "%cvary2% and cassz16(%1)"
$     setlocal c16 %1
$     shift
$if "%colcount%" == "16" $goto endcols
$     setlocal cvary "%cvary%%1"
$     setlocal cvary1 "%cvary1%,cassz17(%1)"
$     setlocal cvary2 "%cvary2% and cassz17(%1)"
$     setlocal c17 %1
$     shift
$if "%colcount%" == "17" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz18(%1)"
$     setlocal cvary2 "%cvary2% and cassz18(%1)"
$     setlocal c18 %1
$     shift
$if "%colcount%" == "18" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz19(%1)"
$     setlocal cvary2 "%cvary2% and cassz19(%1)"
$     setlocal c19 %1
$     shift
$if "%colcount%" == "19" $goto endcols
$     setlocal cvary "%cvary%,%1"
$     setlocal cvary1 "%cvary1%,cassz20(%1)"
$     setlocal cvary2 "%cvary2% and cassz20(%1)"
$     setlocal c20 %1
$     shift
*$if "%colcount%" == "20" $goto endcols
$label endcols
*$     setlocal cvary "%cvary%"
*$     setlocal cvary2 "%cvary2% and sum((%rvary1%)$%array%,1)"
$show

Loop((%rvary%,%cvary%)$%array%,
         rassz1(%r1%)=yes;
$        if "%rowcount%"=="1" $goto doner5
         rassz2(%r2%)=yes;
$        if "%rowcount%"=="2" $goto doner5
         rassz3(%r3%)=yes;
$        if "%rowcount%"=="3" $goto doner5
         rassz4(%r4%)=yes;
$        if "%rowcount%"=="4" $goto doner5
         rassz5(%r5%)=yes;
$        if "%rowcount%"=="5" $goto doner5
         rassz6(%r6%)=yes;
$        if "%rowcount%"=="6" $goto doner5
         rassz7(%r7%)=yes;
$        if "%rowcount%"=="7" $goto doner5
         rassz8(%r8%)=yes;
$        if "%rowcount%"=="8" $goto doner5
         rassz9(%r9%)=yes;
$        if "%rowcount%"=="9" $goto doner5
         rassz10(%r10%)=yes;
$        if "%rowcount%"=="10" $goto doner5
         rassz11(%r11%)=yes;
$        if "%rowcount%"=="11" $goto doner5
         rassz12(%r12%)=yes;
$        if "%rowcount%"=="12" $goto doner5
         rassz13(%r13%)=yes;
$        if "%rowcount%"=="13" $goto doner5
         rassz14(%r14%)=yes;
$        if "%rowcount%"=="14" $goto doner5
         rassz15(%r15%)=yes;
$        if "%rowcount%"=="15" $goto doner5
         rassz16(%r16%)=yes;
$        if "%rowcount%"=="16" $goto doner5
         rassz17(%r17%)=yes;
$        if "%rowcount%"=="17" $goto doner5
         rassz18(%r18%)=yes;
$        if "%rowcount%"=="18" $goto doner5
         rassz19(%r19%)=yes;
$        if "%rowcount%"=="19" $goto doner5
         rassz20(%r20%)=yes;
$        label doner5

         cassz1(%c1%)=yes;
$        if "%colcount%"=="1" $goto donec5
         cassz2(%c2%)=yes;
$        if "%colcount%"=="2" $goto donec5
         cassz3(%c3%)=yes;
$        if "%colcount%"=="3" $goto donec5
         cassz4(%c4%)=yes;
$        if "%colcount%"=="4" $goto donec5
         cassz5(%c5%)=yes;
$        if "%colcount%"=="5" $goto donec5
         cassz6(%c6%)=yes;
$        if "%colcount%"=="6" $goto donec5
         cassz7(%c7%)=yes;
$        if "%colcount%"=="7" $goto donec5
         cassz8(%c8%)=yes;
$        if "%colcount%"=="8" $goto donec5
         cassz9(%c9%)=yes;
$        if "%colcount%"=="9" $goto donec5
         cassz10(%c10%)=yes;
$        if "%colcount%"=="10" $goto donec5
         cassz11(%c11%)=yes;
$        if "%colcount%"=="11" $goto donec5
         cassz12(%c12%)=yes;
$        if "%colcount%"=="12" $goto donec5
         cassz13(%c13%)=yes;
$        if "%colcount%"=="13" $goto donec5
         cassz14(%c14%)=yes;
$        if "%colcount%"=="14" $goto donec5
         cassz15(%c15%)=yes;
$        if "%colcount%"=="15" $goto donec5
         cassz16(%c16%)=yes;
$        if "%colcount%"=="16" $goto donec5
         cassz17(%c17%)=yes;
$        if "%colcount%"=="17" $goto donec5
         cassz18(%c18%)=yes;
$        if "%colcount%"=="18" $goto donec5
         cassz19(%c19%)=yes;
$        if "%colcount%"=="19" $goto donec5
         cassz20(%c20%)=yes;
$        label donec5
         );
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
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),
           icount=icount+1;
           put '%lelementl%'   ;
$         if declared r1  put  '%r1%':twidut;
$         if declared r2  put  '%r2%':twidut;
$         if declared r3  put  '%r3%':twidut;
$         if declared r4  put  '%r4%':twidut;
$         if declared r5  put  '%r5%':twidut;
$         if declared r6  put  '%r6%':twidut;
$         if declared r7  put  '%r7%':twidut;
$         if declared r8  put  '%r8%':twidut;
$         if declared r9  put  '%r9%':twidut;
$         if declared r10 put '%r10%':twidut;
$         if declared r11 put '%r11%':twidut;
$         if declared r12 put '%r12%':twidut;
$         if declared r13 put '%r13%':twidut;
$         if declared r14 put '%r14%':twidut;
$         if declared r15 put '%r15%':twidut;
$         if declared r16 put '%r16%':twidut;
$         if declared r17 put '%r17%':twidut;
$         if declared r18 put '%r18%':twidut;
$         if declared r19 put '%r19%':twidut;
          put '%lendelement%';
$         if not setglobal codetocsv put /;
          );
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c1%.te(%c1%):twidut);
           if(tl_or_te =1, put %c1%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;
$    if "%colcount%"=="1" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c2%.te(%c2%):twidut);
           if(tl_or_te =1, put %c2%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;
$    if "%colcount%"=="2" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c3%.te(%c3%):twidut);
           if(tl_or_te =1, put %c3%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="3" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c4%.te(%c4%):twidut);
           if(tl_or_te =1, put %c4%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="4" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c5%.te(%c5%):twidut);
           if(tl_or_te =1, put %c5%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="5" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c6%.te(%c6%):twidut);
           if(tl_or_te =1, put %c6%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="6" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c7%.te(%c7%):twidut);
           if(tl_or_te =1, put %c7%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="7" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c8%.te(%c8%):twidut);
           if(tl_or_te =1, put %c8%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="8" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementl%';
           if(tl_or_te<>1, put %c9%.te(%c9%):twidut);
           if(tl_or_te =1, put %c9%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="9" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementl%';
           if(tl_or_te<>1, put %c10%.te(%c10%):twidut);
           if(tl_or_te =1, put %c10%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="10" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c11%.te(%c11%):twidut);
           if(tl_or_te =1, put %c11%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;

$    if "%colcount%"=="11" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c12%.te(%c12%):twidut);
           if(tl_or_te =1, put %c12%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;

$    if "%colcount%"=="12" $goto donec2
     put '%starttabrow%'    /;
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c13%.te(%c13%):twidut);
           if(tl_or_te =1, put %c13%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /;

$    if "%colcount%"=="13" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c14%.te(%c14%):twidut);
           if(tl_or_te =1, put %c14%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="14" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c15%.te(%c15%):twidut);
           if(tl_or_te =1, put %c15%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="15" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c16%.te(%c16%):twidut);
           if(tl_or_te =1, put %c16%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="16" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c17%.te(%c17%):twidut);
           if(tl_or_te =1, put %c17%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="17" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementr%';
           if(tl_or_te<>1, put %c18%.te(%c18%):twidut);
           if(tl_or_te =1, put %c18%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /
$    if "%colcount%"=="18" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementl%';
           if(tl_or_te<>1, put %c19%.te(%c19%):twidut);
           if(tl_or_te =1, put %c19%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

$    if "%colcount%"=="19" $goto donec2
     put '%starttabrow%'
     if(skipcolumns>0,
       for (icount2=1 to skipcolumns,
            put '%lelementl%' '%spaces%':twidut '%lendelement%';
$         if not setglobal codetocsv put /;
           ));
     loop(iicntqq$(ord(iicntqq) <= %rowcount%),put '%lelementl%' '%spaces%':twidut '%lendelement%');
$    if not setglobal codetocsv put /;
     loop((%cvary%)$(%cvary2%),
           put '%lelementl%';
           if(tl_or_te<>1, put %c20%.te(%c20%):twidut);
           if(tl_or_te =1, put %c20%.tl      :twidut);
           put     '%lendelement%';
$          if not setglobal codetocsv put /;
         );
     put '%endtabrow%' /

******************************
$label donec2
*is it there
     loop((%rvary2%)$sum((%cvary%,%rvary%)$(%rvary3% and %array%),1),
              put '%starttabrow%'
              if(skipcolumns>0,
                for (icount=1 to skipcolumns,
                     put '%lelementl%' '%spaces%':twidut '%lendelement%';
$                 if not setglobal codetocsv put /;
                 ));
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r1%,rassz1),put %r1%.te(%r1%):twidut));
           if(tl_or_te =1, put rassz1.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="1" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r2%,rassz2),put %r2%.te(%r2%):twidut));
           if(tl_or_te =1, put rassz2.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="2" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r3%,rassz3),put %r3%.te(%r3%):twidut));
           if(tl_or_te =1, put rassz3.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="3" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r4%,rassz4),put %r4%.te(%r4%):twidut));
           if(tl_or_te =1, put rassz4.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="4" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r5%,rassz5),put %r5%.te(%r5%):twidut));
           if(tl_or_te =1, put rassz5.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="5" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r6%,rassz6),put %r6%.te(%r6%):twidut));
           if(tl_or_te =1, put rassz6.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="6" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r7%,rassz7),put %r7%.te(%r7%):twidut));
           if(tl_or_te =1, put rassz7.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="7" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r8%,rassz8),put %r8%.te(%r8%):twidut));
           if(tl_or_te =1, put rassz8.tl      :twidut);
           put     '%lendelement%';
$    if not setglobal codetocsv put /;
$    if "%rowcount%"=="8" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r9%,rassz9),put %r9%.te(%r9%):twidut));
           if(tl_or_te =1, put rassz9.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="9" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r10%,rassz10),put %r10%.te(%r10%):twidut));
           if(tl_or_te =1, put rassz10.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="10" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r11%,rassz11),put %r11%.te(%r11%):twidut));
           if(tl_or_te =1, put rassz11.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="11" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r12%,rassz12),put %r12%.te(%r12%):twidut));
           if(tl_or_te =1, put rassz12.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="12" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r13%,rassz13),put %r13%.te(%r13%):twidut));
           if(tl_or_te =1, put rassz13.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="13" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r14%,rassz14),put %r14%.te(%r14%):twidut));
           if(tl_or_te =1, put rassz14.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="14" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r15%,rassz15),put %r15%.te(%r15%):twidut));
           if(tl_or_te =1, put rassz15.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="15" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r16%,rassz16),put %r16%.te(%r16%):twidut));
           if(tl_or_te =1, put rassz16.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="16" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r17%,rassz17),put %r17%.te(%r17%):twidut));
           if(tl_or_te =1, put rassz17.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="17" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r18%,rassz18),put %r18%.te(%r18%):twidut));
           if(tl_or_te =1, put rassz18.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="18" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r19%,rassz19),put %r19%.te(%r19%):twidut));
           if(tl_or_te =1, put rassz19.tl      :twidut);
           put     '%lendelement%';
$    if "%rowcount%"=="19" $goto doner2
           put '%lelementl%';
           if(tl_or_te<>1, loop(sameas(%r20%,rassz20),put %r20%.te(%r20%):twidut));
           if(tl_or_te =1, put rassz20.tl      :twidut);
           put     '%lendelement%';
$label doner2
*is it here
      loop((%cvary%)$(%cvary2%),put '%nelementr%';
                  sczz=sum((%rvary%)$(%rvary3%),%array%);
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

*figure out what is not here
rassz1(%r1%)=no;
$if "%rowcount%"=="1" $goto doner6
rassz2(%r2%)=no;
$if "%rowcount%"=="2" $goto doner6
rassz3(%r3%)=no;
$if "%rowcount%"=="3" $goto doner6
rassz4(%r4%)=no;
$if "%rowcount%"=="4" $goto doner6
rassz5(%r5%)=no;
$if "%rowcount%"=="5" $goto doner6
rassz6(%r6%)=no;
$if "%rowcount%"=="6" $goto doner6
rassz7(%r7%)=no;
$if "%rowcount%"=="7" $goto doner6
rassz8(%r8%)=no;
$if "%rowcount%"=="8" $goto doner6
rassz9(%r9%)=no;
$if "%rowcount%"=="9" $goto doner6
rassz10(%r10%)=no;
$if "%rowcount%"=="10" $goto doner6
rassz11(%r11%)=no;
$if "%rowcount%"=="11" $goto doner6
rassz12(%r12%)=no;
$if "%rowcount%"=="12" $goto doner6
rassz13(%r13%)=no;
$if "%rowcount%"=="13" $goto doner6
rassz14(%r14%)=no;
$if "%rowcount%"=="14" $goto doner6
rassz15(%r15%)=no;
$if "%rowcount%"=="15" $goto doner6
rassz16(%r16%)=no;
$if "%rowcount%"=="16" $goto doner6
rassz17(%r17%)=no;
$if "%rowcount%"=="17" $goto doner6
rassz18(%r18%)=no;
$if "%rowcount%"=="18" $goto doner6
rassz19(%r19%)=no;
$if "%rowcount%"=="19" $goto doner6
rassz20(%r20%)=no;
$label doner6

cassz1(%c1%)=no;
$if "%colcount%"=="1" $goto donec6
cassz2(%c2%)=no;
$if "%colcount%"=="2" $goto donec6
cassz3(%c3%)=no;
$if "%colcount%"=="3" $goto donec6
cassz4(%c4%)=no;
$if "%colcount%"=="4" $goto donec6
cassz5(%c5%)=no;
$if "%colcount%"=="5" $goto donec6
cassz6(%c6%)=no;
$if "%colcount%"=="6" $goto donec6
cassz7(%c7%)=no;
$if "%colcount%"=="7" $goto donec6
cassz8(%c8%)=no;
$if "%colcount%"=="8" $goto donec6
cassz9(%c9%)=no;
$if "%colcount%"=="9" $goto doner6
cassz10(%c10%)=no;
$if "%colcount%"=="10" $goto doner6
cassz11(%c11%)=no;
$if "%colcount%"=="11" $goto doner6
cassz12(%c12%)=no;
$if "%colcount%"=="12" $goto doner6
cassz13(%c13%)=no;
$if "%colcount%"=="13" $goto doner6
cassz14(%c14%)=no;
$if "%colcount%"=="14" $goto doner6
cassz15(%c15%)=no;
$if "%colcount%"=="15" $goto doner6
cassz16(%c16%)=no;
$if "%colcount%"=="16" $goto doner6
cassz17(%c17%)=no;
$if "%colcount%"=="17" $goto doner6
cassz18(%c18%)=no;
$if "%colcount%"=="18" $goto doner6
cassz19(%c19%)=no;
$if "%colcount%"=="19" $goto doner6
cassz20(%c20%)=no;
$label donec6

$label bombout
*$show
$exit
$label vector
$ifthen settype %array2%
     put '%blankline%' /;
     put '%blankline%' ;
     put '%starttable%' /;
     loop(%array%,
          put '%starttabrow%'
              '%lelementl%'
              %array%.tl:0
              '%lendelement%'
              '%lelementl%'
              %array%.te(%array%):0:decimalsiwant
              '%lendelement%'
          put '%endtabrow%' /);
     put '%endtable%'
$endif
*$ontext
$ifthen partype %array2%
     put '%blankline%' /;
     put '%blankline%' ;
     put '%starttable%' /;
     loop(%r1%,
          put '%starttabrow%'
              '%lelementl%'
              %r1%.tl:0
              '%lendelement%'
              '%lelementl%'
              %array%:0
              '%lendelement%'
          put '%endtabrow%' /);
     put '%endtable%'
$endif
*$offtext
