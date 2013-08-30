Set I / t1*t6:s3*s5 /
Set j / t1.s3,t2.s4,t3.s5 /
sets h /h1*h5/, d /d1*d20/, dh(d,h) /#d.#h/;
sets t /t1*t100/, tdh(t,d,h) /#t:#dh/, dht/#dh:#t/;
set i1 /el1*el5/,j1/jel1*jel10/,k/ka,kb,kc/,l/l1*l200/;
Set ijk(I1,j1,k), x(I1,j1,k,l);
Option ijk(i1:j1,k), x(ijk:l);

display I,j ,h , d , dh,tdh,dht,i1,j1,k,ijk,x;



