*Illustrate temporary zeroing

set     origin                 /o1*o100/
        destinat        /d1*d100/;
parameter distance(origin,destinat);
        distance(origin,destinat)=120+50*ord(destinat)-10*ord(origin);
set     smallorig(origin) small set of origins for testing /o4,o47,o91/
        smalldest(destinat) small set of destinations /d3,d44,d99/;
distance(origin,destinat)
     $(not (smallorig(origin) and smalldest(destinat)))=0;
parameter cost(origin,destinat);
Cost(origin,destinat)$distance(origin,destinat)
       =3+2*distance(origin,destinat);
display cost,distance;

$ontext
#user model library stuff
Main topic Small to large
Featured item 1 Debugging
Featured item 2 Zeroing
Featured item 3
Featured item 4
Description
Illustrate temporary zeroing for model size reduction in debugging


$offtext
