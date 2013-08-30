*illustrate names and explanatory text

Variable       A6item;
Set            shoes                    /tennis,dress/;
Parameter      here_is_a_long_name      /1/;
Equation       Wheredidiputmy(shoes);
Acronym        Monday, a6data, a7_it;
Set mshoes more shoes                / tennis
                                        has+special-characters
                                        an_underscore
                                        3
                                        3number                /;
Set shoes2 "characters '*&% in text" / "variable"
                                        "*starts_with_*"
                                        "has a space"
                                        'has "quotes" in it'
                                        'contains,a comma'        /;
Set shoes3  whatever                /   tennis
                                        "has spaces"                /;

parameter x(mshoes),y(mshoes);
x("Tennis")=3;
y('an_underscore')=1;

Set           shoess     "my test"
                         /tennis         here i can tell you what this is
                          dress  'special characters if needed /*+-'/
Set           kshoes     with underscore_;
Set           kshoes3    "with special characters * / ? , ";
Set           kshoes4    "with 'quotes' like in can't and won't "
Parameter     data3      THIS IS explanatory text       /1/;
Variable      A6item     "***** look at this one";
Equation      Wh(shoes)  Model equation;
Model         notexthere /all/;

$ontext
#user model library stuff
Main topic Name rules
Featured item 1 Capitalization
Featured item 2 Ordering
Featured item 3
Featured item 4
Description
Illustrate names and explanatory text
$offtext
