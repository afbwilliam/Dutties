*file Makedata.gms
set i /i1*i4/
j /j1*j4/
k /k1*k4/;
parameter v(i,j,k);
v(i,j,k)$(uniform(0,1) < 0.30) = uniform(0,1);
