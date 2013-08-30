*Illustrate Option dmpsym usage for memory detection

option profile=1;
set i /1*1000/
set j /1*1000/
parameter dist(i,j);
parameter cost(i,j);
dist(i,j)=100+ord(i)+ord(j);
cost(i,j)=4+8*dist(i,j);
option dmpsym;
option clear=dist;
*dist(i,j)=0;
cost(i,j)=cost(i,j)*2;
option dmpsym;
*option kill=dist;
option clear=dist;
*option dmpsym;


$ontext
#user model library stuff
Main topic Memory
Featured item 1 Dmpsym
Featured item 2 Memory detection
Featured item 3
Featured item 4
Description
Illustrate Option dmpsym usage for memory detection
$offtext
