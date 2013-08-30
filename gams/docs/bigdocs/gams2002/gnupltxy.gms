*source code for GNUPLTXY.gms
*  #####  #     # #     # ######  #      ####### #     # #     #
* #     # ##    # #     # #     # #         #     #   #   #   #
* #       # #   # #     # #     # #         #      # #     # #
* #  #### #  #  # #     # ######  #         #       #       #
* #     # #   # # #     # #       #         #      # #      #
* #     # #    ## #     # #       #         #     #   #     #
*  #####  #     #  #####  #       #######   #    #     #    #
*
*
*

$onlisting
$onuni

*       Exit compilation if there is a pre-existing program error:

$if "%gp_version%"   == "3.5" $abort "Error: get newer GNUPLOT Version. "
$if %system.filesys% == DOS   $abort "Error: get 32 bit (Windows 95/NT)."

$if not errorfree                    $exit
$if declared u__1                    $goto declared1
alias(u__1,u__2,u__3,*);
set u___1(u__1);
set u___2(u__2);
set u___3(u__3);
set allu(u__1,u__2,u__3);

$label declared1
$if a%1==a                           $exit
$if declared %1                      $goto declared2
$error GNUPLOT: Identifier %1 is not declared.
$exit

$label declared2
$if defined %1                       $goto defined0
$error GNUPLOT: Identifier %1 is not defined.
$exit

$label defined0
$if dimension 3 %1                   $goto defined1
$error GNUPLOT: Identifier %1 is not three-dimensional.
$exit

$label defined1
$if defined %1                       $goto defined2
$error GNUPLOT2: Data to be graphed - %1 - is not declared.
$exit

$label defined2
$if not a%2==a                       $goto defined3
$error GNUPLOT2: Vertical axis to be graphed 2nd argument is not present.
$exit

$label defined3
$if not a%3==a                       $goto defined4
$error GNUPLOT2: Horizontal axis to be graphed 3rd argument is not present.
$exit

$label defined4
allu(u__1,u__2,u__3)$(%1(u__1,u__2,"%2") or %1(u__1,u__2,"%3"))=yes;
u___3("%2")=yes;
u___3("%3")=yes;
u___2(u__2)$sum(allu(u__1,u__2,u___3),1) =yes;
u___1(u__1)$sum(allu(u__1,u___2,u___3),1)=yes;
allu(u__1,u__2,u__3)$(%1(u__1,u__2,"%2") or %1(u__1,u__2,"%3"))=no;

$offuni

$setglobal gp_scen 'u___1'
$setglobal gp_obsv 'u___2'
$setglobal gp_vert "%2"
$setglobal gp_horz "%3"
$setglobal gp_name '%1'
$if not    "%4"==""                  $setglobal gp_name '%4'
$if        "%5"==""                  $setglobal gp_term 'windows'
$if not    "%5"==""                  $setglobal gp_term '%5'
$if "%gp_term%" == "windows"         $goto abort
$if "%gp_term%" == "WINDOWS"         $goto abort
$if "%gp_term%" == "Windows"         $goto abort
$setglobal gp_output '%gp_name%.%gp_term%'
$goto abort

$label abort
$onuni

abort$(sum((%gp_scen%,%gp_obsv%)
  $%1(%gp_scen%,%gp_obsv%,'%gp_horz%'),1) eq 0)
  '**** data for %gp_horz% column are all zero', %1;
abort$(sum((%gp_scen%,%gp_obsv%)
  $%1(%gp_scen%,%gp_obsv%,'%gp_vert%'),1) eq 0)
  '**** data for %gp_vert% column are all zero', %1;

*_____________________
*
*       Gnuplot.inp
*_____________________
*


$if not declared gp_inp              file gp_inp  /gnuplot.inp/;
put gp_inp;
file.lw =  0;
file.nr =  0;
file.nd =  0;
file.nw =  6;
file.pw =200;
*       The user has specified a terminal format and options:

put "set terminal %gp_term%";

$if     "%gp_term%" == "cgm"         put ' winword6';
$if     "%gp_term%" == "aifm"        $goto moreoption
$if     "%gp_term%" == "windows"     $goto moreoption
$if     "%gp_term%" == "postscript"  $goto moreoption
$if     "%gp_term%" == "cgm"         $goto moreoption
$if     "%gp_term%" == "gif"         $goto gif
$if     "%gp_term%" == "svga"        $goto range
$if     "%gp_term%" == ""            $goto range
$if     "%gp_term%" == "cmg"         $error cmg not a valid terminal
$if     "%gp_term%" == "cmg"         $exit
$goto skipoption

$label moreoption
$if     "%gp_term%" =="aifm"         $goto color
$if     "%gp_term%" =="windows"      $goto color
$if     setglobal gp_orient          put ' %gp_orient%';
$goto   color

$label  color
$if     setglobal gp_color           put ' %gp_color%';
$if     "%gp_term%" =="aifm"         $goto linestyle
$if     "%gp_term%" =="windows"      $goto linestyle
$if     "%gp_term%" =="cgm"          $goto linestyle
$if     setglobal gp_line            put ' %gp_line%';
$goto linestyle

$label linestyle
$if     "%gp_term%" =="aifm"         $goto fontname
$if     "%gp_term%" =="windows"      $goto fontname
$if     setglobal gp_yrotate         put ' %gp_yrotate%',' \'/;
$if     setglobal gp_width           put ' %gp_width%';
$if     setglobal gp_lwidth          put ' %gp_lwidth%';
$goto  fontname

$label fontname
$if not setglobal gp_font            put ' "Times Roman"'
$if     "%gp_font%" == "no"          $setglobal gp_font 'Times Roman'
$if     "%gp_font%" == "0"           $setglobal gp_font 'Times Roman'
$if     setglobal gp_font            put ' "%gp_font%"';

$if not setglobal gp_fntsize         put ' 10';
$if     "%gp_fntsize%" == "no"       $setglobal gp_fntsize '10'
$if     "%gp_fntsize%" == "0"        $setglobal gp_fntsize '10'
$if     setglobal gp_fntsize         put ' %gp_fntsize%';
$goto skipoption

$label skipoption
put /;

$if "%gp_term%" == "windows"         $goto range
$if setglobal gp_output              put "set output '%gp_output%'"/;
$goto range

$label gif
put /;
put "set output '%gp_output%'"/;
$goto range

*  ranges for x-axis and y-axis

$label range

file.nd = 3;
file.nw = 12;


$if not setglobal gp_xrange          $goto yrange
$if  "%gp_xrange%" == "no"           $goto yrange
$if  "%gp_xrange%" == "0"            $goto yrange
$if     setglobal gp_xrange          put 'set xrange [%gp_xrange%]'/;
$goto yrange

$label yrange
$if not setglobal gp_yrange          $goto scale_y2
$if  "%gp_yrange%" == "no"           $goto scale_y2
$if  "%gp_yrange%" == "0"            $goto scale_y2
$if     setglobal gp_yrange          put 'set yrange [%gp_yrange%]'/;
$goto scale_y2

$label scale_y2

* Calculate scalars which are needed to automatically scale the Y2 axis
* The four scalars calculate the maximum and minimum value for
* both the vertical and horizontal axis
* It may only work with gnuplot version 3.7

scalars
gp_ymin, gp_ymax, gp_xmax, gp_xmin, gp_y2low, gp_y2up;
gp_ymin  = smin((%gp_scen%,%gp_obsv%),%1(%gp_scen%,%gp_obsv%,"%gp_vert%"));
gp_ymax  = smax((%gp_scen%,%gp_obsv%),%1(%gp_scen%,%gp_obsv%,"%gp_vert%"));
gp_xmin  = smin((%gp_scen%,%gp_obsv%),%1(%gp_scen%,%gp_obsv%,"%gp_horz%"));
gp_xmax  = smax((%gp_scen%,%gp_obsv%),%1(%gp_scen%,%gp_obsv%,"%gp_horz%"));
gp_y2low = gp_ymin;
gp_y2up  = gp_ymax;

$if not setglobal gp_y2scale         $goto y2range
$if     "%gp_y2scale%" == "no"       $goto y2range
$if     "%gp_y2scale%" == "0"        $goto y2range

$if     "%gp_y2range%" == "no"       $goto y2auto
$if     "%gp_y2range%" == "0"        $goto y2auto
$if not setglobal gp_y2range         $goto y2auto
$if     setglobal gp_y2range         $goto y2range
$goto  y2auto

$label y2auto
$if setglobal gp_y2scale             gp_y2low = %gp_y2scale% * gp_ymin;
$if setglobal gp_y2scale             gp_y2up  = %gp_y2scale% * gp_ymax;
put 'set yrange  [',gp_ymin, ' : ',gp_ymax,']'/;
put 'set y2range [',gp_y2low,' : ',gp_y2up,']'/;
$goto boxwidth

$label y2range
$if not setglobal gp_y2range         $goto boxwidth
$if  "%gp_y2range%" == "no"          $goto boxwidth
$if  "%gp_y2range%" == "0"           $goto boxwidth
$if     setglobal gp_y2range         put 'set y2range [%gp_y2range%]'/;
$goto boxwidth

$label boxwidth
$if setglobal gp_boxwid              put 'set boxwidth %gp_boxwid%'/;
$if setglobal gp_size                put 'set size %gp_size%'/;
$goto y2axis

*       second y axis

$label y2axis
$if setglobal gp_y2scale             $setglobal gp_y2axis  'yes'
$if  "%gp_y2scale%" == "no"          $setglobal gp_y2axis  'no'
$if  "%gp_y2scale%" == "0"           $setglobal gp_y2axis  'no'
$if setglobal gp_y2range             $setglobal gp_y2axis  'yes'
$if not setglobal gp_y2axis          $goto gridline
$if  "%gp_y2axis%" == "0"            $goto gridline
$if  "%gp_y2axis%" == "no"           $goto gridline
$if setglobal gp_y2axis              put 'set y2tics'/;
$goto gridline

*       grid options

$label gridline
$if not setglobal gp_gline           $setglobal gp_gline  '4'
$if "%gp_color%" == "monochrome"     $setglobal gp_gline  '4'
$if "%gp_term%"  == "windows"        $setglobal gp_gline  '13'
$goto grid

$label grid
$if not setglobal gp_zeroax          $setglobal gp_zeroax no
$if %gp_zeroax%    == yes            put 'set zeroaxis'/;
$if %gp_zeroax%    == no             put 'set nozeroaxis'/;
$if %gp_zeroax%    == yes            $goto grid2

$if not setglobal gp_xzeroax         $setglobal gp_xzeroax no
$if %gp_xzeroax%   == yes            put 'set xzeroaxis'/;
$if %gp_xzeroax%   == no             put 'set noxzeroaxis'/;

$if not setglobal gp_yzeroax         $setglobal gp_yzeroax no
$if %gp_yzeroax%   == yes            put 'set yzeroaxis'/;
$if %gp_yzeroax%   == no             put 'set noyzeroaxis'/;
$goto grid2

$label grid2
$if not setglobal gp_grid            $setglobal gp_grid yes
$if  %gp_grid%  == no                put 'set nogrid'/;
$if "%gp_grid%" == "0"               $goto xgrid
$if "%gp_grid%" == "no"              $goto xgrid
$if  %gp_grid%  == yes               put 'set grid' /;
$goto xgrid

$label xgrid
$if "%gp_xgrid%" == "0"              $goto ygrid
$if "%gp_xgrid%" == "no"             $goto ygrid
$if  %gp_xgrid%  == yes              put 'set grid xtics ';
$if  %gp_xgrid%  == yes              put %gp_gline%;
$if  %gp_xgrid%  == yes              put /;
$goto ygrid

$label ygrid
$if "%gp_ygrid%" == "0"              $goto tickers
$if "%gp_ygrid%" == "no"             $goto tickers
$if  %gp_ygrid%  == yes              put 'set grid ytics ';
$if  %gp_ygrid%  == yes              put %gp_gline%;
$if  %gp_ygrid%  == yes              put /;
$goto tickers

*       tick options for major tics

$label tickers
$if not setglobal gp_tics            $setglobal gp_tics 'in'
$if setglobal gp_tics                put 'set tics %gp_tics%'/;
$if     setglobal gp_xlabel          $setglobal gp_xtics yes
$if not setglobal gp_xtics           $setglobal gp_xtics yes
$if    "%gp_xtics%"  == "0"          $setglobal gp_xtics no
$if not %gp_xtics%   == yes          put 'set noxtics'/;
$if not %gp_xtics%   == yes          $goto ytics
put 'set xtics  nomirror';
$if not setglobal gp_xinc            put /;
$if not setglobal gp_xinc            $goto ytics
$if    "%gp_xinc%"   == "0"          put /;
$if    "%gp_xinc%"   == "0"          $goto ytics
$if     setglobal gp_xinc            put ' %gp_xinc%'/;
$goto  ytics

$label ytics
$if     setglobal gp_ylabel          $setglobal gp_ytics yes
$if not setglobal gp_ytics           $setglobal gp_ytics yes
$if    "%gp_ytics%"  == "0"          $setglobal gp_ytics no
$if not %gp_ytics%   == yes          put 'set noytics'/;
$if not %gp_ytics%   == yes          $goto styles
put 'set ytics  nomirror';
$if not setglobal gp_yinc            put /;
$if not setglobal gp_yinc            $goto styles
$if    "%gp_yinc%"   == "0"          put /;
$if    "%gp_yinc%"   == "0"          $goto styles
$if     setglobal gp_yinc            put ' %gp_yinc%'/;
$goto styles

*       Write options for labels, title, style, border, lines, and key

$label styles
$if "%gp_label%"  == "no"            put 'set nolabel'/;
$if "%gp_label%"  == "0"             put 'set nolabel'/;
$if "%gp_label%"  == "no"            $goto plottitle
$if "%gp_label%"  == "0"             $goto plottitle
$if "%gp_label%"  == "yes"           put 'set label'/;
$if not setglobal gp_xlabel          put 'set xlabel  "%gp_horz%"'/;
$if     setglobal gp_xlabel          put 'set xlabel  "%gp_xlabel%"'/;
$if not setglobal gp_ylabel          put 'set ylabel  "%gp_vert%"'/;
$if     setglobal gp_ylabel          put 'set ylabel  "%gp_ylabel%"'/;
$if "%gp_y2label%" == "no"           put 'set y2label'/;
$if "%gp_y2label%" == "0"            put 'set y2label'/;
$if not setglobal gp_y2label         put 'set y2label'/;
$if "%gp_y2label%" == "no"           $goto plottitle
$if "%gp_y2label%" == "0"            $goto plottitle
$if     setglobal gp_y2label         put 'set y2label "%gp_y2label%"'/;
$goto plottitle

$label plottitle
$if not setglobal gp_title           $goto skiptitle
$if "%gp_title%"   == "no"           $goto skiptitle
$if "%gp_title%"   == "0"            $goto skiptitle
$if     setglobal gp_title           put 'set title  "%gp_title%"'/;
$goto  skiptitle

$label skiptitle
$if not setglobal gp_style           $setglobal gp_style lines
$if "%gp_style%"   == "no"           $setglobal gp_style lines
$if "%gp_style%"   == "0"            $setglobal gp_style lines
$if     setglobal gp_style           put 'set data style %gp_style%'/;

$if not setglobal gp_border          $setglobal gp_border yes
$if not setglobal gp_borddim         $setglobal gp_borddim ''
$if "%gp_borddim%" == "all"          $setglobal gp_borddim ''
$if "%gp_borddim%" == "four"         $setglobal gp_borddim ''
$if "%gp_borddim%" == "two"          $setglobal gp_borddim '3'
$if "%gp_borddim%" == "x"            $setglobal gp_borddim '1'
$if "%gp_borddim%" == "y"            $setglobal gp_borddim '2'
$if "%gp_borddim%" == "zero"         $setglobal gp_border no
$if "%gp_borddim%" == "no"           $setglobal gp_border no
$if %gp_border%    == yes            put 'set border',' %gp_borddim%'/;
$if %gp_border%    == no             put 'set noborder'/;

$if     "%gp_key%" == "yes"          $setglobal gp_key 'top left'
$if not setglobal gp_key             put 'set key top left'/;
$if not setglobal gp_key             $goto loop
$if     "%gp_key%" == "no"           put 'set nokey'/;
$if     "%gp_key%" == "0"            put 'set nokey'/;
$if not "%gp_key%" == "no"           put 'set key %gp_key%'/;
$goto  loop

$label loop

file.nd = 0;
file.nw = 6;

$if not declared gp_count            scalar gp_count;
gp_count=1;

put 'plot ';

loop(%gp_scen%,
  if (gp_count gt 1, put ',';);
  file.nw = 0

  put  '\'/' "gnuplot.dat" index ',(gp_count-1):0:0,
        ' using 1:2 "%lf%lf" title "',%gp_scen%.tl,'"';

  file.nw = 6;
  gp_count = gp_count + 1;
); put /;

$if "%gp_term%"=="windows" put '!if exist gnuplot.ini  ';
$if "%gp_term%"=="windows" put 'del gnuplot.ini >nul'/;
$if "%gp_term%"=="gif"     put '!if exist gnuplot.ini  ';
$if "%gp_term%"=="gif"     put 'del gnuplot.ini >nul'/;

putclose;

*_____________________
*
*       Gnuplot.dat
*_____________________
*

$if not declared gp_data             file gp_data /gnuplot.dat/;

*       permit user to specify an alternative value for NA:

$if not declared  gp_na              scalar gp_na /na/;
$if     setglobal gp_na              gp_na = %gp_na%;

*       permit user to suppress (0,0) observations

$if not declared gp_supzer           scalar gp_supzer;
gp_supzer=0;
$if setglobal gp_supzero             gp_supzer=1;
$if "%gp_supzero%"=="yes"            gp_supzer=1;
$if "%gp_supzero%"=="no"             gp_supzer=0;

parameter gp_00(*)                   number of zeros at the end;
parameter gp_xy(*)                   total observations;
parameter gp__0(*)                   total observations minus end zeros;

gp_00(%gp_scen%) = 0;
gp_xy(%gp_scen%) = 0;
gp__0(%gp_scen%) = inf;

gp_data.nw = 16;
gp_data.nd = 8;
gp_data.nr = 2;

loop(%gp_scen%,
  loop(%gp_obsv%,
    if(      ((%1(%gp_scen%,%gp_obsv%,"%gp_horz%") eq 0) and
              (%1(%gp_scen%,%gp_obsv%,"%gp_vert%") eq 0)     ),
          gp_00(%gp_scen%) = gp_00(%gp_scen%) + 1;
    else  gp_00(%gp_scen%) = 0;
    );
  gp_xy(%gp_scen%) = gp_xy(%gp_scen%) + 1;
 );
);

$if not setglobal gp_zeroend         $setglobal gp_zeroend 'no'
$if "%gp_zeroend%"=="yes"            $goto putdata
gp__0(%gp_scen%) = gp_xy(%gp_scen%)- gp_00(%gp_scen%);
$goto  putdata

$label putdata
loop(%gp_scen%,
 gp_count = 0;
  loop(%gp_obsv%,
    gp_count = gp_count + 1;
    if(     ((gp_supzer eq 0) and ((gp_count - gp__0(%gp_scen%)) lt 0)
          or (       %1(%gp_scen%,%gp_obsv%,"%gp_horz%") ne 0 or
              mapval(%1(%gp_scen%,%gp_obsv%,"%gp_horz%")) eq mapval(eps))
          or (  %1(%gp_scen%,%gp_obsv%,"%gp_vert%") ne 0      or
              mapval(%1(%gp_scen%,%gp_obsv%,"%gp_vert%")) eq mapval(eps))
             ),
      if (%1(%gp_scen%,%gp_obsv%,"%gp_horz%") eq gp_na,
         put gp_data, '          ';
        else
         put gp_data, %1(%gp_scen%,%gp_obsv%,"%gp_horz%") ;
      );
      if (%1(%gp_scen%,%gp_obsv%,"%gp_vert%") eq gp_na,
         put gp_data, '          ';
        else
         put gp_data, %1(%gp_scen%,%gp_obsv%,"%gp_vert%") ;
      );
     put /;
    );
  );
  put //;
);

putclose;
$offuni

*_____________________
*
*       Run Gnuplot
*_____________________
*

$if "%gp_version%" =="3.7"   $goto gnuplot37

$if     "%gp_term%"=="gif"   execute 'gnugif gnuplot.inp';
$if     "%gp_term%"=="gif"   $goto alldone

$if     "%gp_term%"=="cgm"   execute 'copy gnuplot.inp gnuplot.ini >nul';
$if     "%gp_term%"=="cgm"   execute 'wgnuplot';
$if     "%gp_term%"=="cgm"   $goto alldone

$if     "%gp_term%"=="windows" execute 'copy gnuplot.inp gnuplot.ini >nul';
$if not "%gp_term%"=="windows" execute 'gp36 gnuplot.inp';
$if     "%gp_term%"=="windows" execute 'wgnuplot';
$goto  alldone

$label gnuplot37
$if     "%gp_term%"=="windows" execute '!if exist gnuplot.ini del gnuplot.ini >nul';
$if     "%gp_term%"=="windows" execute 'copy gnuplot.inp gnuplot.ini >nul';
$if     "%gp_term%"=="windows" execute 'wgnuplot';
$if not "%gp_term%"=="windows" execute 'wgnuplot gnuplot.inp';
$if     "%gp_term%"=="gif"     $goto alldone
$goto  alldone

$label alldone
u___3("%2")=no;
u___3("%3")=no;
u___2(u__2)=no;
u___1(u__1)=no;
$exit

$ontext
#user model library stuff
Main topic  Output
Featured item 1  Graphics
Featured item 2  GNUPLTXY.gms
Featured item 3  Conditional compile
Featured item 4
Description
Source code for gnupltxy
$offtext
