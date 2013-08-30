*illustrate timing of execution of call and execute

set i /i1,i2/
$onmulti
parameter a(i) /i1 22, i2 33/;
display a;
$gdxout ss
$unload a
$GDXOUT
execute 'gdxxrw ss.gdx par=a rng=sheet1!a1'
$CALL gdxxrw ss.gdx par=a rng=sheet2!a1
parameter a/i1 44/;
display a;
a(i)=a(i)*2;
display a;
$gdxout ss
$unload a
$GDXOUT
$CALL gdxxrw ss.gdx par=a rng=sheet3!a1
execute_unload 'ss.gdx' , a
execute 'gdxxrw ss.gdx par=a rng=sheet4!a1'

$ontext
#user model library stuff
Main topic Linking to other programs
Featured item 1 Call
Featured item 2 Execute
Featured item 3 $ load and unload
Featured item 3 Executre load and unload
Description
illustrate timing of execution of call and execute

$offtext
