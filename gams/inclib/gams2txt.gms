$offlisting

$hidden  gams2txt.gms    Data export routine.
$hidden
$hidden  $...include gams2txt id
$hidden
$hidden  works for parameters and variables
$hidden
$hidden  First invocation must be outside of a loop or if block.
$hidden
$hidden  Use a blank invocation (without an id) to initialize.
$hidden

*       Skip compilation is there is a pre-existing program error:

$if not errorfree $exit

*       If we are already initialized, skip declarations:

$if setglobal gams2txt $goto start

*       Install an environment variable indicating that the
*       gams2txt subsystem is in operation:

$setglobal gams2txt='yes'

*       Declare temporary variables used for data transfer.

alias(u__1,u__2,u__3,u__4, u__5,u__6,u__7,u__8,u__9,u__10,*);
alias(u__11,u__12,u__13,u__14, u__15,u__16,u__17,u__18,u__19,u__20,*);
set gms2txt1
    gms2txt2
    gms2txt3
    gms2txt4
    gms2txt5
    gms2txt6
    gms2txt7
    gms2txt8
    gms2txt9
    gms2txt10
    gms2txt11
    gms2txt12
    gms2txt13
    gms2txt14
    gms2txt15
    gms2txt16
    gms2txt17
    gms2txt18
    gms2txt19
    gms2txt20;

$if errorfree $goto start
$onlisting

*       An error has occured during the initial invocation of
*       gams2txt. There are two reasons than an error may have
*       been generated here:

*       (i) The first invocation of gams2txt is inside an if or loop.
*       The simple solution for this problem is to use initialize with
*       "$libinclude gams2txt" before entering the loop or if.

*       (ii) User program has used one of the gams2txt reserved names,
*       u__n and gams2txtn for n = 0,1,2,...,20.

$abort 'Error on initial $libinclude gams2txt.'

$label start

*       Blank invocation -- nothing to do:

$if %1a == a $exit

*       See that the item is declared and defined:

$if declared %1    $goto declared
$error Error in gams2txt: identfier %1 is undeclared.
$exit

$label declared
$if defined %1     $goto defined
$error Error in gams2txt: identfier %1 is undefined.
$exit

$label defined

*       Set up temporary sets for processing:

$if dimension 0  %1 $goto scalar
$if dimension 1  %1 $set dim 1 
$if dimension 2  %1 $set dim 2  
$if dimension 3  %1 $set dim 3  
$if dimension 4  %1 $set dim 4  
$if dimension 5  %1 $set dim 5  
$if dimension 6  %1 $set dim 6  
$if dimension 7  %1 $set dim 7  
$if dimension 8  %1 $set dim 8  
$if dimension 9  %1 $set dim 9  
$if dimension 10 %1 $set dim 10 
$if dimension 11 %1 $set dim 11 
$if dimension 12 %1 $set dim 12 
$if dimension 13 %1 $set dim 13 
$if dimension 14 %1 $set dim 14 
$if dimension 15 %1 $set dim 15 
$if dimension 16 %1 $set dim 16 
$if dimension 17 %1 $set dim 17 
$if dimension 18 %1 $set dim 18 
$if dimension 19 %1 $set dim 19 
$if dimension 20 %1 $set dim 20 

$set r u__1
$set cnt 1
$label xloop
$eval cnt %cnt%+1
$ife %cnt%>%dim% $goto xdone
$set r %r%,u__%cnt%
$goto xloop
$label xdone
$set r '%r%'
$set s gms2txt%dim%


$onuni
file.lw =  0;
file.nr =  2;
file.nw = 22;
file.nd = 13;
file.tf =  3;

%s%(%r%)$%1(%r%) = yes;
$if not setglobal prefix $goto default
loop(%s%, put %prefix%,%s%.te(%s%),%1(%s%)/;);
$goto cleanup

$label default
loop(%s%, put %s%.te(%s%),%1(%s%)/;);

$label cleanup
$offuni
option clear=%s%;
$exit

$label scalar
file.nr =  2;
file.nw = 22;
file.nd = 13;
file.tf =  3;
$if not setglobal prefix $goto single
put %prefix%,%1/;
$exit

$label single
put %1/;
