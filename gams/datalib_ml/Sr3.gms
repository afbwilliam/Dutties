$ontext
step 3: model solution
execute as: > gams sr3 restart=s2 save=s3
$offtext
option lp=cplex;
Model transport /all/ ;
Solve transport using lp minimizing z ;