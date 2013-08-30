*test settings of gams parameters using $if

option lp=cplex;
$If NOT '%gams.lp%'     == '' $set lp     %gams.lp%
$if NOT '%gams.rmip%'   == '' $set rmip   %gams.rmip%
$if NOT '%gams.mip%'    == '' $set mip    %gams.mip%
$if NOT '%gams.nlp%'    == '' $set nlp    %gams.nlp%
$if NOT '%gams.dnlp%'   == '' $set dnlp   %gams.dnlp%
$if NOT '%gams.cns%'    == '' $set cns    %gams.cns%
$if NOT '%gams.mcp%'    == '' $set mcp    %gams.mcp%
$if NOT '%gams.rminlp%' == '' $set rminlp %gams.rminlp%
$if NOT '%gams.minlp%'  == '' $set minlp  %gams.minlp%
$If NOT '%gams.lp%'     == '' display 'lp     command line argument used %gams.lp%';
$if NOT '%gams.rmip%'   == '' display 'rmip   command line argument used %gams.rmip%';
$if NOT '%gams.mip%'    == '' display 'mip    command line argument used %gams.mip%';
$if NOT '%gams.nlp%'    == '' display 'nlp    command line argument used %gams.nlp%';
$if NOT '%gams.dnlp%'   == '' display 'dnlp   command line argument used %gams.dnlp%';
$if NOT '%gams.cns%'    == '' display 'cns    command line argument used %gams.cns%';
$if NOT '%gams.mcp%'    == '' display 'mcp    command line argument used %gams.mcp%';
$if NOT '%gams.rminlp%' == '' display 'rminlp command line argument used %gams.rminlp%';
$if NOT '%gams.minlp%'  == '' display 'minlp  command line argument used %gams.minlp%';
$If NOT '%gams.ps%'     == '' display 'Page size  command line argument used %gams.ps%';
$if NOT '%gams.pw%'     == '' display 'Page width command line argument used %gams.pw%';

$show


$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 Command line
Featured item 2 GAMS.xxx
Featured item 3 $If
Featured item 4
Description
test settings of gams parameters using $if
$offtext
