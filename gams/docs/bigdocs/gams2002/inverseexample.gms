*Matrix inversion examplea

Set index /i1*i2/;
Table a(index,index) matrix to invert
             i1   i2
    i1       2     1
    i2       1     3;
parameter ainverse(index,index) matrix that was inverted;
execute_unload 'gdxforinverse.gdx' index,a;
execute 'invert gdxforinverse.gdx index a gdxfrominverse.gdx ainverse';
execute_load 'gdxfrominverse.gdx' , ainverse;
display a, ainverse;



*and now for something more general
Set j /j1*j2/;
Table a2(index,j) second matrix to invert
             j1   j2
    i1       4     2
    i2       1     7;

Parameter a2inverse(j,index) inverse of second matrix

$batinclude arealinverter a2 index j a2inverse

display a2,a2inverse;

