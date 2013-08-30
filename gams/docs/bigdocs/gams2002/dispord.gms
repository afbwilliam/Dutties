*illustrate display formatting with option command
set index1 /index11*index12/
set index2 /index21*index22/
set index3 /index31*index32/
set index4 /index41*index42/
parameter data(index1,index2,index3,index4);
data(index1,index2,index3,index4)=2;
display data;
option data:0:1:3;display data;
option data:0:3:1;display data;
option data:0:0:4;display data;
option data:0:2:2;display data;
option data:0:2:1;display data;
parameter data2(index2,index4,index1,index3);
data2(index2,index4,index1,index3)
       = data(index1,index2,index3,index4);
option data2:0:2:2;display data2

$ontext
#user model library stuff
Main topic Output
Featured item 1 Display
Featured item 2 Decimals
Featured item 3 Option:
Featured item 4 Special values
Description
illustrate numerical displays

$offtext

