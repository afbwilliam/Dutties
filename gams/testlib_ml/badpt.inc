variable x, z;
equation f, g;

f..     z =e= log(x);
g..     sqr(x) =g= 1;

x.l = 0;
model logzero / f, g /;


variable y;
equation s,t;

s..     z =e= -1/y;
t..     sqr(y) =g= 1;

y.lo = -.1;
y.l = 0;
y.up = 100;
model divzero / s, t /;
