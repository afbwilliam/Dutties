Sets
  n     nodes    / one, two, three, four, five, six /
  L(n)  regions  / one, two, three /
  NL(n) 'complement of L'
  ;
NL(n) = not(L(n));
Alias (n,i,j);
Alias (L,Q,QQ,Qi);
Set Q1(Q);

Table coefs(L,*)  demand and supply data
         alpha   beta    rho      eta
one       1.0     .5      19      .2
two       2.0     .4      27      .01
three     1.5     .3      30      .3    ;

Table pairs(i,j,*)  transport data
           kappa     nu
one.four     1       .5
one.five     2       .2
two.six      3       .3
three.six    1       .4
four.one     2       .3
four.five    1       .1
four.six     1       .1
five.one     3       .5
five.four    2       .2
five.six     1      1.0
six.two      2       .25
six.three    2       .2
six.four     1       .9
six.five     3       .8    ;

parameter
  alpha(L), beta(L), rho(L), eta(L)
  kappa(i,j), nu(i,j);

alpha(L) = coefs(L,'alpha');
 beta(L) = coefs(L,'beta');
  rho(L) = coefs(L,'rho');
  eta(L) = coefs(L,'eta');
kappa(i,j) = pairs(i,j,'kappa');
   nu(i,j) = pairs(i,j,'nu');

Set arc(i,j);
arc(i,j) = yes$kappa(i,j);

$macro repMonop(style) rep1(i,j,"style") = t.l(i,j); rep2("supply",L,"style") = s.l(L); rep2("demand",L,"style") = d.l(L); rep2("price ",L,"style") = price.l(L); tab6("totProfit","style") = obj.l; tab6("totSupply","style") = sum{L, s.l(L)}; tab6("theta1","style") = price.l('one'); tab6("theta2","style") = price.l('two'); tab6("theta3","style") = price.l('three');
