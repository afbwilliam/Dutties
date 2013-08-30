*illustrate acronym use

set i /i1*i3/
equation aa(i);
variables x(i);
parameter zz(i),rr(i);

*defining acronyms
    acronyms nameforit,nextone;
    acronym  acronym3 the third one
    acronym  doit any old acronym
    parameter textstrings(i)
        /i1 nameforit
          i2 nextone
         i3 acronym3/ ;
    parameter textstring(i)
        /i1 doit
          i2 1
         i3 doit/ ;
    table acks(i,i)
             i1      i2     i3
       i1                  doit
       i2           doit
       i3   doit;


*display an acronym
    display textstrings;
    display acks;

*use in defining put files
    file putacronym;
    put putacronym;
    put nameforit:31 //

*conditionals on acronyms
    loop(i,
       if(textstrings(i) = nameforit, put 'Something special ');
       put textstrings(i) /
    );
aa(i)$(textstring(i)=doit).. 3*x(i)=e=1;

*acronym aritmetic
    scalar flagtome;
    flagtome=doit;
    display flagtome,textstring;
    zz(i)=textstring(i)  ;
    display zz;

$ontext
#user model library stuff
Main topic Acronyn
Featured item 1 Acronym
Featured item 2
Featured item 3
Description
Illustrates use of acronyms
$offtext
