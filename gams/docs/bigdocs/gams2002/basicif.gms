*illustrate $if tests of control variables

scalar x /1/;
*$ondollar
scalar y /1/;
$setglobal gg
$setglobal tt doit
$if setglobal gg display x;
$if not setglobal gg display y;
$if "%tt%" == "doit" x=x*2;
$eval a sameas(%tt%,"doit")
$if "%a%"=="1" x=x*4;
$ifi "%tt%" == "DOIT" x=y**2;
$if "%tt%" == "DOIT" x=x*100;
$if not "%tt%" == "doit" y=y/4;

$setlocal  alocal yes
$set       aset yes
$setglobal aglobal yes
acronyms local,global,plainset
scalar type;
*set item
$if set       aset   type=plainset;
$if setglobal aset   type=global;
$if setlocal  aset   type=local;
*setglobal
$if set       aglobal type=plainset;
$if setglobal aglobal type=global;
$if setlocal  aglobal type=local;
*setlocal
$ifi set       alocal type=plainset;
$ifi setglobal alocal type=global;
$ifi setlocal  alocal type=local;
*not set
$if set       qq type=plainset;
$if setglobal qq type=global;
$if setlocal  qq type=local;

$if not set       qq display "No qq around";

acronym ok;
scalar type1,type2,type3,type4;

*texttocompare
$setglobal controlvariablename comparethistext
$if  %controlvariablename% == "comparethistext" type1=ok;
$if  %controlvariablename% == comparethistext type2=ok;
$if  "%controlvariablename%" == "comparethistext" type3=ok;
$if  "%controlvariablename%" == comparethistext type4=ok;

*add spaces
$setglobal controlvariablename   compare this text
$if  "%controlvariablename%" == "compare this text" type1=ok;
$if  "%controlvariablename%" ==  compare this text  type2=ok;
$if  "%controlvariablename%" == texttocompare type4=ok;

*is the text blank?
$if       "%controlvariablename%a"  == "a" display "blank it is";
$if not      "%controlvariablename%a"  == "a" display "it is not blank";

$show

set aaa;
scalar bbb /1/;

*check declaration and definition status
$if not declared aaa display 'aaa is not declared';
$if not declared bbb display 'bbb is not declared';
$if not declared ccc display 'ccc is not declared';
$if not defined  aaa display 'aaa is not defined';
$if not defined  bbb display 'bbb is not defined';
$if not defined  ccc display 'ccc is not defined';


scalar eee /1/;
set set1 /a,b/;
set set2 /d,e/;
set set3 /1,2/;
set set4 /g,h/;
parameter fff(set1);
fff(set1)=1;
set ggg(set1,set2,set3,set4);
ggg(set1,set2,set3,set4)=yes;
parameter hhh(set1,set2,set3,set4,set4);
hhh(set1,set2,set3,set4,set4)=ord(set1)+ord(set4);
$batinclude dimdisp eee
$batinclude dimdisp set1
$batinclude dimdisp fff
$batinclude dimdisp ggg
$batinclude dimdisp hhh

$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 $If
Featured item 2 Declared
Featured item 3 $If ==
Featured item 4 $If set
Description
illustrate $if ==, declared, defined, dimension and other
tests of control variables

$offtext
