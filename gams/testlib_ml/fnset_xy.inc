$ontext
How is relative accuracy defined?  Given:
  1. a point x,
  2. the computed value f(x), and
  3. the known value fbar,

we can compute the relative accuracy of f vis-a-vis fbar in two ways:
  1. |f-fbar| <= reps * |fbar|
  2. |f-fbar| <= reps * max(1,|x|)

The first case is the most common, but for some functions
the second is more appropriate (e.g. sin(x)).

We can also pass a test if the absolute accuracy is within some
tolerance aeps:
  1. |f-fbar| <= aeps

Contributor: Steven Dirkse, October 2004
$offtext

set V / x, y, d
        f,     f_,     f_a,     f_r
       fx,    fx_,    fx_a,    fx_r
       fy,    fy_,    fy_a,    fy_r
      fxx,   fxx_,   fxx_a,   fxx_r
      fxy,   fxy_,   fxy_a,   fxy_r
      fyx,   fyx_,   fyx_a,   fyx_r
      fyy,   fyy_,   fyy_a,   fyy_r
       rc,    rc_,    rc_e
       ec,    ec_,    ec_e
/;

scalar aeps       'absolute error tolerance';
scalar reps       'relative error tolerance';
scalar relToInput 'reps is relative to input (not output) magnitude';
set T;
parameter data(T,V), tmp(T);
