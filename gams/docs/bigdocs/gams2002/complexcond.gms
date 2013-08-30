*illustrate nested and complex conditionals

set k /k1,k2,k3/;
parameter s(k) /k1 6,k3 -2/;
parameter a(k) /k1 2, k2 -9, k3 4/;
set t(k) /k2,k3/;
parameter u(k);

*link conditionals using and
    u(k)$(s(k) and t(k)) = a(k);
    u(k)$(s(k) and u(k) and t(k)) = a(k);
    loop(k,if(s(k) lt 0 and t(k), u(k) = a(k)));

*link conditionals using or
    u(k)$(s(k) or t(k)) = a(k);
    u(k)$(s(k) or u(k) or t(k)) = a(k);
    loop(k,if(s(k) lt 0 or t(k), u(k) = a(k)) );

*link conditionals using xor
    u(k)$(s(k) xor t(k)) = a(k);
    u(k)$(s(k) xor u(k) xor t(k)) = a(k);
    loop(k,if(s(k) lt 0 xor t(k), u(k) = a(k)) );


*deal with not case
    u(k)$(not s(k)) = a(k);
    loop(k,if(not (s(k) lt 0), u(k) = a(k)) );

*nest multiple $ conditions
    u(k)$(s(k)$t(k)) = a(k) ;
    u(k)$(s(k) and t(k)) = a(k) ;

*some more complex nesting with alternative parantheses forms
    u(k)$(s(k) and {u(k) xor t(k)}) = a(k);
    u(k)$(s(k) and {u(k) or t(k)}) = a(k);
    u(k)$([not s(k)] and {u(k) or t(k)}) = a(k);
    u(k)$(s(k) xor {u(k) and t(k)}) = a(k);
    u(k)$(s(k) xor [not {u(k) and t(k)}]) = a(k);

$ontext
#user model library stuff
Main topic Conditionals
Featured item 1 $ conditionals
Featured item 2 Or Xor
Featured item 3 And
Featured item 4 Not
Description
illustrate nested and complex conditionals

$offtext
