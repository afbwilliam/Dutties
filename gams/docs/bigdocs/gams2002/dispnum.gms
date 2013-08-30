*illustrate numerical displays
set index1 /index11*index12/
set index2 /index21*index22/
table data(index1,index2)
          index21   index22
index11   0.00001    10000000
index12     3.72       200.1;
option data:1:1:1;
display data;

parameter data2(index1,index2);
data2( index1,index2)=data(index1,index2);
option decimals=2;
display data2;
data2(index1,index2)$(data2(index1,index2) lt 0.01)=0;
option decimals=1;
display data2;
options decimals=3;
data2( index1,index2)=data(index1,index2);
data2(index1,index2)$(data(index1,index2) gt 10000)=inf;
display data2;
parameter data3(index1,index2);
parameter data4(index1,index2);
data2( index1,index2)=data(index1,index2);
data2(index1,index2)$(data2(index1,index2) lt 0.01)=0;
data3( index1,index2)=3+data2(index1,index2);
data4(index1,index2)$data2(index1,index2)=
  100*(data3(index1,index2)/data2(index1,index2)-1);
data4(index1,index2)$(abs(data4(index1,index2)) lt 0.1)=0;
data4(index1,index2)$(data2(index1,index2) eq 0)= na;
display data3;
option data4:1:1:1;display data4;

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
