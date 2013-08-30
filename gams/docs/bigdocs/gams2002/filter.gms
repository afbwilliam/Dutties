$ontext
The following example creates a small gdx file; the gdx file is used to write
the symbol A to a spreadsheet with the filter enabled
$offtext

set i /i1*i2/
j /j1*j2/
k /k1*k2/;
parameter A(i,j,k);
A(i,j,k)=uniform(0,1);
execute_unload 'test.gdx', A;
execute 'gdxxrw.exe test.gdx filter=1 par=A rdim=1 cdim=2 rng=sheet1!a1';

execute 'gdxxrw.exe test.gdx filter=2 par=A rdim=1 cdim=2 rng=sheet2!a1';

execute 'gdxxrw.exe test.gdx filter=0 par=A rdim=1 cdim=2 rng=sheet3!a2';
