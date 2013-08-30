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

set V / x,       c,       d,
        f,      f_,     f_r,     f_a
       fx,     fx_,    fx_r,    fx_a
      fxx,    fxx_,   fxx_r,   fxx_a
       rc,     rc_,    rc_e
       ec,     ec_,    ec_e
/;

scalar aeps       'absolute error tolerance';
scalar aeps0      'absolute error tolerance, function';
scalar aeps1      'absolute error tolerance, first derivative';
scalar aeps2      'absolute error tolerance, second derivative';
scalar reps       'relative error tolerance';
scalar reps0      'relative error tolerance, function';
scalar reps1      'relative error tolerance, first derivative';
scalar reps2      'relative error tolerance, second derivative';
scalar relToInput 'reps is relative to input (not output) magnitude';
set T;
parameter data(T,V), tmp(T);
