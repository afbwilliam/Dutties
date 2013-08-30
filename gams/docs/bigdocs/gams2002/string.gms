*Illustrate use of ORD and CARD to get string characteristics

$oneolcom
set id namedset /i1 i have explanatory text,ifour,a/;
scalar ii;

ii=Card(id.ts);  !! length of symbol test string
display 'length of text string for symbol', ii;

loop(id,

    ii=Card(id.tl)  !! length of label id   (id must be driving)
    display  'length of set element string', ii;

   ii=Card(id.te)   !! length of label text (id must be driving)
   display 'length of set explanatory text string', ii;
);

   ii= Card('xxx')  !!  length of 'xxx'
   display 'length of string', ii;

parameter rdd abcdefghijklmnopqrstuvwxyz;
scalar j character position, io GAMS ord value,ia ascii code,ie ebcdic code;
for (j=1 to 27 by 1 ,
    io=Ord(rdd.ts,j);  !! length of symbol test string
    ia=Ordascii(rdd.ts,j);  !! length of symbol test string
    ie=Ordebcdic(rdd.ts,j);  !! length of symbol test string
display 'ords of text string for symbol',j, io,ia,ie;);

$ontext
#user model library stuff
Main topic Calculations
Featured item 1 Strings
Featured item 2 Ord
Featured item 3 Card
Featured item 4 Ordascii
Description
Illustrate use of ORD, Ordascii, Ordepcidic and CARD to get string characteristics
$offtext
