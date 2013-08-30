*illustrate NLP effect on output

variables x,y;
equations eq1;
Eq1.. 2*sqr(x)*power(y,3) + 5*x - 1.5/y =e= 2;
x.up=10;
y.up=10;
x.l = 2;
y.l = 3 ;
model try /all/;
option nlp=baron;
solve try using nlp maxinmizing x;
scalar a1,a2,a3,a4;

a1= %Solprint.Summary%;
a2=  %Solprint.Report%;
a3=  %Solprint.Quiet%;
a4=  %gams.Solprint%;

display a1,a2,a3,a4;
if(%gams.solprint%= %Solprint.Report%,display 'Normal output present');
display 'gams.solprint =','%gams.solprint%';

$ontext
#user model library stuff
Main topic Output
Featured item 1 NLP
Featured item 2 Limrow
Featured item 3 Limcol
Featured item 4
Description
Illustrate NLP effect on output
$offtext
