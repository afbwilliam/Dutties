scalar z,x1/2/,x2/3/;

$macro oneoverit(y) 1/y
z = oneoverit(x1)+oneoverit(x2);

display z;

$macro ratio(a,b) a/b
z = ratio(x1,x2);
display z;

set j /j1*j3/;
parameter a1(j) /j1 1,j2 2,j3 3/;
$macro product(a,b) a*b
$macro addup(i,x,z) sum(i,product(x(i),z))
z = addup(j,a1,x1);

set i /i1*i4/;
set k(i) /i1*i2/;
variable x(i,j);
variable r(k,j);

$macro  f(i)  sum(j, x(i,j))
$macro equh(q)  equation equ_q(i); equ_q(i).. q =e= 0;

equh(f(i))

$macro  f2(r,i)  sum(j, r(i,j))
* a multiline macro using the continuation string \
$macro equ2(z,d,q)  equation equ2_&z&d; \
                     equ2_&z&d.. z*q =e= 0;


$macro d(q) display &&q;
$macro ss(q) &&q);
d('"hereit is" , i,k')
d('"(zz"')
z=ss('sum(j,a1(j)');
z=ss('prod(j,a1(j)');


