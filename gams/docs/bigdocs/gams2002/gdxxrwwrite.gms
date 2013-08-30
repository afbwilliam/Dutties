*puts files of differnt dimensions into spreadsheet
*varies rdim and cdim

set i /i1 element 1
       i2 element 2
       i3 elemnnt 3/
    j /j1*j3/
    k /k1*k3/;
set ii(i,j)/i1.j1 my text,i2.j2 other text/
parameter threedim(i,j,k);
threedim(i,j,k)=10000*ord(i)+100*ord(j)+ord(k);
display threedim
parameter twodim(i,j);
twodim(i,j)=100*ord(i)+ord(j)
parameter fourdim(i,j,k,k);
fourdim(i,j,k,k)=10000*ord(i)+100*ord(j)+ord(k);
parameter tendim(i,j,k,k,k,k,k,k,k,k);
tendim(i,j,k,k,k,k,k,k,k,k)=10000*ord(i)+100*ord(j)+ord(k);
execute_unload 'gdxxrwwrite.gdx' twodim,threedim,i,j,k,ii,fourdim,tendim;
variable x(j);
x.lo(j)=1;
x.m(j)=1;
x.up(j)=10000;
x.scale(j)=1;
x.l(j)=9999;
execute_unload 'gdxxsol' x;
*execute "gdxxrw gdxxsol.gdx o=gdxxrwss.xls var=x rng=solution!a1"


execute 'gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls text="This is the link disctionary" rng=linkdictionary!a1  '
execute 'gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls text="This is the twodim parameter" rng=output!a1  '
execute 'gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=twodim rng=output!b2 text="Link to twodim" rng=linkdictionary!a2 linkid=twodim  '

execute 'gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls text="This is the threedim parameter" rng=output!a10  '
execute 'gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=threedim rng=output!a12 text="Link to threedim" rng=linkdictionary!a3 linkid=threedim'

execute 'gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls text="Link to threedim second variant" rng=linkdictionary!a4 link=output!a33'
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=threedim rng=output!a33  cdim=3 rdim=0"
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=threedim rng=output!a45 cdim=2 rdim=1"
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=threedim rng=output!a55 cdim=1 rdim=2"
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=threedim rng=output!a62 cdim=0 rdim=3"
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=fourdim rng=output!a120"
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls par=tendim rng=output!a160"
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls set=i rng=output2!a1  cdim=1 "
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls set=j rng=output2!a5  rdim=1"
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls set=ii rng=output2!a10  rdim=2 "
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls set=ii rng=output2!a20  cdim=2 "
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls set=i rng=output2!a13:c13  cdim=1 "
execute "gdxxrw gdxxrwwrite.gdx o=gdxxrwss.xls set=i rng=output2!a16:d16  cdim=1 values=yn"


$ontext
#user model library stuff
Main topic GDXXRW
Featured item 1 Spreadsheet
Featured item 2 GDXXRW
Featured item 3 Rdim
Featured item 4 Cdim
include gdxxrwss.xls
Description
Unloads data and Puts items of differnt dimensions into spreadsheet
Varies rdim and cdim

$offtext
