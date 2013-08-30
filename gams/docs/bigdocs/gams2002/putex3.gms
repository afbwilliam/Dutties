*Illustrate put file set element output using .te and.tl
*Also uses a zero tolerance via .nz

set j /a1*a3
        a4 this is element 4
        a5 has a crummy name/;
set i /1,2,3,4 this one is 4/
set newnames(j) /a1 Bolts,a2 Nuts,a3 Cars, a4 Trains, a5 /;
file my1;
put my1;
*illustrate use of .te and.tl
put /
   'Set EL        Explanatory Text        Exp. Text from Subset' //;
loop(j,put j.tl:10 ' !! ' j.te(j):20 ' $$ 'newnames.te(j):20 /);
my1.tf=0;
put /
   'Set EL        Explanatory Text        Exp. Text from Subset' //;
loop(j,put j.tl:10 ' !! ' j.te(j):20 ' $$ 'newnames.te(j):20 /);
parameter data(j) /a1 1., a2 1.004, a3 0.0001, a4 100000000000/;
put ///;
my1.tf=1;
loop(j, put newnames.te(j):12,data(j) /);

*suppress small numbers with .nz

put ///;
my1.nz=0.01;
loop(j, put newnames.te(j):12,data(j) /);

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 Nz
Featured item 3 Tl
Featured item 4 Te
Description
Illustrate put file set element output using .te and.tl
Also uses a zero tolerance via .nz
$offtext
