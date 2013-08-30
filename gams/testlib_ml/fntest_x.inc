$if not defined reps  reps  = 0;
$if not defined reps0 reps0 = reps;
$if not defined reps1 reps1 = reps;
$if not defined reps2 reps2 = reps;
$if not defined aeps  aeps  = 0;
$if not defined aeps0 aeps0 = aeps;
$if not defined aeps1 aeps1 = aeps;
$if not defined aeps2 aeps2 = aeps;
$if not defined relToInput relToInput = 0;

* option zeroRes = 2.0e-299;
set TT(T);

data(T,  'f_a') = abs(data(T,  'f')-data(T,  'f_'));
data(T, 'fx_a') = abs(data(T, 'fx')-data(T, 'fx_'));
data(T,'fxx_a') = abs(data(T,'fxx')-data(T,'fxx_'));
if {relToInput,
  tmp(T) = max(1,abs(data(T,'x')));
  data(T,  'f_r') = data(T,  'f_a') / tmp(T);
  data(T, 'fx_r') = data(T, 'fx_a') / tmp(T);
  data(T,'fxx_r') = data(T,'fxx_a') / tmp(T);
else
  tmp(T) = abs(data(T,'f_'));
  TT(T) = tmp(T) > 0;
  data(T,   'f_r') = INF;
  data(T ,  'f_r')$(data(T,  'f_a') eq 0) = 0;
  data(TT,  'f_r') = data(TT,   'f_a') / tmp(TT);

  tmp(T) = abs(data(T,'fx_'));
  TT(T) = tmp(T) > 0;
  data(T,  'fx_r') = INF;
  data(T , 'fx_r')$(data(T, 'fx_a') eq 0) = 0;
  data(TT, 'fx_r') = data(TT,  'fx_a') / tmp(TT);

  tmp(T) = abs(data(T,'fxx_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fxx_r') = INF;
  data(T ,'fxx_r')$(data(T,'fxx_a') eq 0) = 0;
  data(TT,'fxx_r') = data(TT, 'fxx_a') / tmp(TT);
};
data(T,'rc_e') = abs(data(T,'rc')-data(T,'rc_'));
data(T,'ec_e') = abs(data(T,'ec')-data(T,'ec_'));

set badT(T);
parameter failures(T,V);

badT(T) = ((data(T,  'f_a') > aeps0) and (data(T,  'f_r') > reps0))
      OR  ((data(T, 'fx_a') > aeps1) and (data(T, 'fx_r') > reps1))
      OR  ((data(T,'fxx_a') > aeps2) and (data(T,'fxx_r') > reps2))
      OR  data(T,'rc_e')
      OR  data(T,'ec_e');
failures(badT,V) = data(badT,V);
display 'failed tests', failures;
* display data;
scalar nTests, nErrors;
nTests = card(T);
nErrors = card(badT);
display 'absolute tolerance: ', aeps0, aeps1, aeps2;
display 'relative tolerance: ', reps0, reps1, reps2;
display 'data points tested: ', nTests;
display '            errors: ', nErrors;
abort$(nErrors) 'There were errors';
