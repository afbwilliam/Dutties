$ontext
step 1: data manipulation step
execute as: > gams sr1 restart=s0 save=s1
$offtext
Scalar f 'freight in dollars per case per thousand miles' /90/ ;
Parameter c(i,j) 'transport cost in thousands of dollars per case';
c(i,j) = f * dist(i,j) / 1000 ;