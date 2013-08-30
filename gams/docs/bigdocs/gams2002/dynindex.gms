*use of sets in dynamic setting

set t /t1*t4/;
variable endstock(t)
         beginstock(t)
         Beginstorage(t)
         Endstorage(t)
         z;
equation zspec
         Stockeq(t)
         Stockbal(t)
         Stockbal2(t)
         Stockbal3(t)
         Stockbal4(t)
         Storecarry(t)
         Termstore(t);

zspec.. z=e=sum(t$(ord(t)=card(t)),endstock(t));
Stockbal(t).. endstock(t-1)=e=beginstock(t);
Stockbal2(t).. endstock(t)=e=beginstock(t+1);
Stockbal3(t).. endstock(t--1)=e=beginstock(t);
Stockbal4(t).. endstock(t)=e=beginstock(t++1);
stockeq(t).. endstock(t)=e=beginstock(t);

scalar initial /1/, finalstore /4/;

Storecarry(t)..                        Beginstorage(t) =e= initial$(ord(t) eq 1) +endstorage(t-1);
Termstore(t)$(ord(t)=card(t))..        Endstorage(t)=e=finalstore;

beginstock.fx("t1")=11;
model stock /all/;
solve stock using lp maximizing z;

$ontext
#user model library stuff
Main topic  Set
Featured item 1 Ord
Featured item 2 Card
Featured item 3 Time
Featured item 4
Description
Use of sets in dynamic setting

$offtext
