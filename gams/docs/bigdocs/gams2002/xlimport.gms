*GAMS version of XLIMPORT
*i am in 2
%$dollar $
$ondollar
*$offlisting
$setargs sym xls range more

$if '' ==  '%sym%'     $exit
$if '' ==  '%xls%'     $goto noxls
$if NOT exist  "%xls%" $goto noxlsfile
$if NOT declared %sym% $goto notknown
$if     ParType  %sym% $goto loadepar
$if     SetType  %sym% $goto loadeset

$error cannot xlimport symbol %sym%
$exit
$label noxls
$error no xls file specified
$exit
$label noxlsfile
$error the xls file "%xls%" cannot be found
$exit
$label notknown
$error symbol %sym% not declared
$exit
$label notreadable
$error symbol %sym% is not readable
$exit

$label loadepar
$echo o=xllink.gdx par=%sym% > xllink.txt
$goto dump

$label loadeset
$echo o=xllink.gdx set=%sym% > xllink.txt
$goto dump

$label dump
$if NOT '' == '%range%'   $echo rng=%range% >> xllink.txt
$if dimension 0 %sym% $set r 0
$if dimension 1 %sym% $set r 1
$if dimension 2 %sym% $set r 2
$if dimension 3 %sym% $set r 3
$if dimension 4 %sym% $set r 4
$if dimension 5 %sym% $set r 5
$if dimension 6 %sym% $set r 6
$if dimension 7 %sym% $set r 7
$if dimension 8 %sym% $set r 8
$if dimension 9 %sym% $set r 9
$if dimension 10 %sym% $set r 10
$echo dim=%r% >> xllink.txt
$call gdxxrw "%xls%" @xllink.txt log=xllink.log

* If filtered import, read from GDX
$if %more% == '' $goto unfiltered
$gdxin xllink.gdx
$load %sym%
$gdxin
$goto term

$label unfiltered
$onempty
$if ParType  %sym% parameter %sym% /
$if SetType  %sym% set %sym% /
$call gdxdump xllink.gdx symb=%sym% noheader > xllink.in
$include xllink.in
/;
$offempty
$goto term

$label term

$ontext
#user model library stuff
Main topic Spreadsheet
Featured item 1 XLIMPORT
Featured item 2 Conditional compile
Featured item 3 $Call
Featured item 4
Description
GAMS version of XLIMPORT

$offtext
