$ontext
step 2: model definition
execute as: > gams sr2 restart=s1 save=s2
$offtext
Variables
x(i,j) 'shipment quantities in cases'
z 'total transportation costs in thousands of dollars' ;
Positive Variable x ;
Equations
ecost 'define objective function'
esupply(i) 'observe supply limit at plant i'
edemand(j) 'satisfy demand at market j' ;
ecost .. z =e= sum((i,j), c(i,j)*x(i,j)) ;
esupply(i) .. sum(j, x(i,j)) =l= supply(i) ;
edemand(j) .. sum(i, x(i,j)) =g= demand(j) ;