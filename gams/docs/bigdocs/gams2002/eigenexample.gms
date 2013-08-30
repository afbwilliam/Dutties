
Set index /i1*i2/;
Table a(index,index) matrix to find eigenvalues for
             i1   i2
    i1       2     1
    i2       1     3;
parameter eigenvalues(index) vector of eigenvalues of A;
execute_unload 'gdxforutility.gdx' index,A;
execute 'eigenvalue gdxforutility.gdx index A gdxfromutility.gdx eigenvalues';
execute_load 'gdxfromutility.gdx'  eigenvalues;
display a, eigenvalues;

parameter eigenvectors(index,index) vector of eigenvectors of A;
execute_unload 'gdxforutility.gdx' index,A;
execute 'eigenvector gdxforutility.gdx index A gdxfromutility.gdx eigenvalues eigenvectors';
execute_load 'gdxfromutility.gdx' ,eigenvalues,eigenvectors;
display 'vectors',a, eigenvalues,eigenvectors;
