$if not setglobal offlog $offlog

*here i enter html clickable references
display "%1","%2","%3","%4","%5";

$ontext
this is called with 6 arguments
argument 1 can be the word
    file if a reference to a file is to be made
    startlist if one wants to start an indented list for first element
    list if one wants to continue an indented list
    endlist if one wants to end an indented list for last element
argument 2 is 1 for inital reference telling where to go
              2 for identifying the destination ie the place to jump to
argument 3 is unique label for jump that is used internally
argument 4 is text to use in the html file for the jump
argument 5 is Table number if defined
argument 6 is set name if defined


$offtext

$setglobal ref3 "'%3'"
$if not 'a%6'=='a' $setglobal ref3 "'%3' %6.tl"
$setglobal ref4 "'%4'"
$if not 'a%6'=='a' $setglobal ref4 "'%4 for ' %6.tl"

$show

$if not setglobal startjump $libinclude put_htmlcodes.gms
if(%2>1,
    put '%startjump%'  %ref3%
         '%endjump%' /
    put '%startline%'  %ref4% '%endline%' /;
   );

if(%2<=1,
$ ifi     "%1" == "startlist"    put '<ul>' /;
$ ifi     "%1" == "startlist"    put '<li>' /;
$ ifi     "%1" == "endlist"      put '<li>' /;
$ ifi     "%1" == "list"         put '<li>' /;
$ ifi     "%1" == "File"         put '%startref2%' ;
$ ifi not "%1" == "File"         put '%startref1%' ;
    put %ref3%
        '%midref%';
$    if not 'a%5' == 'a' put 'Table %5'
    put %ref4%
        '%endref1%' /;
   put '%endline%' /;
$ ifi     "%1" == "list"         put '</li>' /;
$ ifi     "%1" == "startlist"    put '</li>' /;
$ ifi     "%1" == "endlist"      put '</li>' /;
$ ifi     "%1" == "endlist"      put '</ul>' /;
);


