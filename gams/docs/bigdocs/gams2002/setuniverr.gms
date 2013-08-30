*Compiler errors when addressing undefined item in universal set

set knownset  /newitem1/;
Parameter dd(*);
Dd(knownset)=4;
Dd("newone")=5;
Dd("newitem4")=dd("newitem1")*dd("newitem2");
variable vv(*);
equation r;
r.. vv("newitem1")+vv("newitem3")=e=1;

$ontext
#user model library stuff
Main topic Compiler error
Featured item 1 Set
Featured item 2
Featured item 3
Featured item 4
Description
Compiler errors when addressing undefined item in universal set

$offtext
