*Illustrate put formatting for pages
* newpage, title, header, width, length and margins

file my1;
put my1;

*header experiments

PUTTL "File written on" system.date /;
PUThd "Page " system.page /;
my1.ps=65;
my1.pw=81;
my1.pc=3;
set i /1*9,0/;
set j /1*9/;
set kk kname /A AA,b bb,c cc, d /;
putpage;

*width experiments

put 'start too wide wide width trials'/;
put @10
loop((j), put j.tl:<10);
put /;
loop((j,i), put i.tl:1);
put /
putpage;

*multiple page experiments

put 'start multipage trials'/;
scalar line /3/,ic /0/,jc /0/;
for (ic=1 to 400,
  put 'line number' ic /;
   jc=jc+1;
         if(jc>100,putpage;jc=0;);
    if(jc>5,my1.ps=1111);
    );
put /;
set k /1*100/ ;
my1.pw=5000;
putpage;

*more width experiments

put 'start width trials'/;
put @10
loop((k,j), put j.tl:<10);
put /;
loop((k,j,i), put i.tl:1);
put /;
putpage;

*bm , tm and pc trials

put 'start page  and bm/tm trials with pc=3'/;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.bm=13;
my1.pc=3;
for (ic= 1 to my1.ps*2,
loop((j,i)$(ord(j)*10+ord(i) le my1.pw), put i.tl:1);
put /;);

put 'start page and bm/tm trials with pc=0'/;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.bm=13;
my1.pc=0;
for (ic= 1 to my1.ps*2,
loop((j,i)$(ord(j)*10+ord(i) le my1.pw), put i.tl:1);
put /;);

putpage;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.bm=13;
my1.pc=1;
put 'start page and bm/tm trials with pc=1'/;
for (ic= 1 to my1.ps*2,
loop((j,i)$(ord(j)*10+ord(i) le my1.pw), put i.tl:1);
put /;);

putpage;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.bm=13;
my1.pc=2;
put 'start page and bm/tm trials with pc=2'/;
for (ic= 1 to my1.ps*2,
loop((j,i)$(ord(j)*10+ord(i) le my1.pw), put i.tl:1);
put /;);


putpage;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.bm=13;
my1.pc=4;
put 'start page and bm/tm trials with pc=4'/;
for (ic= 1 to my1.ps*2,
loop((j,i)$(ord(j)*10+ord(i) le my1.pw), put i.tl:1);
put /;);


putpage;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.bm=13;
my1.pc=5;
put 'start page and bm/tm trials with pc=5'/;
for (ic= 1 to my1.ps*2,
loop((j,i)$(ord(j)*10+ord(i) le my1.pw), put i.tl:1);
put /;);


putpage;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.bm=13;
my1.pc=6;
put 'start page and bm/tm trials with pc=6'/;
for (ic= 1 to my1.ps*2,
loop((j,i)$(ord(j)*10+ord(i) le my1.pw), put i.tl:1);
put /;);

putpage;
my1.pc=0;

*lcase  trials

put 'start lcase trials with pc=0'/;
scalar kvar;
for (kvar = 0 to 2,
my1.lcase=kvar;
put /'start lcase trials with lcase=' kvar:2/;
loop(kk, put 'lcase = ' my1.lcase:2:0   ' ts char - '
             kk.ts       ' tl char - '
             kk.tl       ' te char - '
             kk.te(kk);
          put /;);
);

*nr trials


scalar km,kl;

for (kvar = 0 to 3,
my1.nr=kvar;
km=1.39428;
kl=200.99;
put /'start trials with nr=' kvar:2/;
put 'nr = ' my1.nr:2:0 ' '  kvar ' ' kl ' ' km ;
          put /;);

*page and margin trials

put 'start page  and lm trials with pc=3'/;
my1.ps=65;
my1.pw=81;
my1.tm=3;
my1.lm=13;
my1.pc=3;
put 'lcase = ' my1.lm:2:0 ' '  kvar ' ' kl ' ' km ;

my1.tw=10;
set kk1 /a aa,d/;
set mytuple(kk1,kk1)
   /a.a   I have text 1
    a.d
    d.d/;
set kk3(kk1) /a my new label/;

alias (kk1,kk2);

*examine action of tf

*first trial with tf

for (kvar = 0 to 6,
my1.tf=kvar;
put /'start trials with tf=' kvar:2/;
loop(kk, put 'tf = ' my1.tf:2:0   ' ts char - '
             kk.ts                ' tl char - '
             kk.tl                ' te char - '
             kk.te(kk)' ' kk.te(kk);
          put /;);
);

*tf trials including tuple

my1.pc=0;
set icount /1*6/;
put /// "tf experiments" //;
loop(icount,
my1.tf=ord(icount)-1;
put / 'tf = ', my1.tf /;
loop(   (kk1,kk2),
    put "tl line" kk1.tl,kk2.tl /;
    put "te line" kk1.te(kk1),kk2.te(kk2), kk3.te(kk1):15 ,mytuple.te(kk1,kk2):0;
    put /;
    ));

*examine action of putclear

putpage;
put /// "before putclear":20 //;
scalar myline /0/;
scalar ii2 /0/;
for (ii2=130 downto 1,
    myline=myline+1;
    put "line on page before":30 myline /;
    );
putclear;
myline=0;
put /// "after putclear":20 //;
for (ii2=130 downto 1,
    myline=myline+1;
    put "line on page after":30 myline /;
    );

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 Puttl
Featured item 3 Puthd
Featured item 4 Putpage
Description
Illustrate put formatting for pages
newpage, title, header, width, length and margins
$offtext
