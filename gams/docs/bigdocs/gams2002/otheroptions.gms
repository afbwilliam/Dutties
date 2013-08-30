*illustrate use of a bunch of options

OPTION FORLIM=152;
scalar i;
Option measure;
for (i=1 to 151,
display 'for ', i);
Option measure;
i=1;
while(i>0 and i < 150 ,i=i+1;display 'while', i);
Option measure;
i=0;
repeat(i=i+1;display 'repeat', i; until i>150);
option subsystems;
set k /thisnameistoolong/;
option reform =1;
option dispwidth =5;
OPTION DUALCHECK=1
*option oldname

option integer1 =3;
option real1=3;
OPTION SPARSEVAL=1;
OPTION SPARSEVAL=2;
Option sparseopt=safe;
Option sparseopt=fast;
Option sparserun=on;
Option sparserun=off;

$ontext
 #user model library stuff
Main topic Options
Featured item 1 Misc options
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate use of a bunch of options
$offtext
