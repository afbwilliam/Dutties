*illustrate displays conditional on data

scalar x /0/,y /10/;

*implement conditional display with $
    display$(x+y le 0) "display when sum of x and y le 0",x,y;

    x=2;

*implement conditional display with if
    if(x gt 0,
        display "X and y here if x is positive",x,y;
      );

*implement another conditional display with $
    display$(x > -1) "display with display$ at second place",x;

*implement conditional display with if
*note will not get to next line
    if((x+y > 2),
        display "X and y at first place if x+y is greater than 2",x,y;
      );

$ontext
#user model library stuff
Main topic Conditionals
Featured item 1 Display
Featured item 2 If
Featured item 3
Description
illustrate displays conditional on data

$offtext
