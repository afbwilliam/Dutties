
Set index /i1*i2/;
Table a(index,index) matrix to decompose
             i1   i2
    i1       2     1
    i2       1     3;
parameter LforA(index,index) L matrix that is a decomposition of A;
execute_unload 'gdxforutility.gdx' index,A;
execute 'cholesky gdxforutility.gdx index A gdxfromutility.gdx LforA';
execute_load 'gdxfromutility.gdx' , LforA;
display a, LforA;
