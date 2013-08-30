$if not defined reps reps = 0;
$if not defined aeps aeps = 0;
$if not defined relToInput relToInput = 0;

* option zeroRes = 2.0e-299;
set TT(T);

data(T,  'f_a') = abs(data(T,  'f')-data(T,  'f_'));
data(T, 'fx_a') = abs(data(T, 'fx')-data(T, 'fx_'));
data(T, 'fy_a') = abs(data(T, 'fy')-data(T, 'fy_'));
data(T, 'fz_a') = abs(data(T, 'fz')-data(T, 'fz_'));
data(T,'fxx_a') = abs(data(T,'fxx')-data(T,'fxx_'));
data(T,'fxy_a') = abs(data(T,'fxy')-data(T,'fxy_'));
data(T,'fxz_a') = abs(data(T,'fxz')-data(T,'fxz_'));
data(T,'fyx_a') = abs(data(T,'fyx')-data(T,'fyx_'));
data(T,'fyy_a') = abs(data(T,'fyy')-data(T,'fyy_'));
data(T,'fyz_a') = abs(data(T,'fyz')-data(T,'fyz_'));
data(T,'fzx_a') = abs(data(T,'fzx')-data(T,'fzx_'));
data(T,'fzy_a') = abs(data(T,'fzy')-data(T,'fzy_'));
data(T,'fzz_a') = abs(data(T,'fzz')-data(T,'fzz_'));
if {relToInput,
  tmp(T) = max[1,abs(data(T,'x')),abs(data(T,'y')),abs(data(T,'z'))];
  data(T,  'f_r') = data(T,  'f_a') / tmp(T);
  data(T, 'fx_r') = data(T, 'fx_a') / tmp(T);
  data(T, 'fy_r') = data(T, 'fy_a') / tmp(T);
  data(T, 'fz_r') = data(T, 'fz_a') / tmp(T);
  data(T,'fxx_r') = data(T,'fxx_a') / tmp(T);
  data(T,'fxy_r') = data(T,'fxy_a') / tmp(T);
  data(T,'fxz_r') = data(T,'fxz_a') / tmp(T);
  data(T,'fyx_r') = data(T,'fyx_a') / tmp(T);
  data(T,'fyy_r') = data(T,'fyy_a') / tmp(T);
  data(T,'fyz_r') = data(T,'fyz_a') / tmp(T);
  data(T,'fzx_r') = data(T,'fzx_a') / tmp(T);
  data(T,'fzy_r') = data(T,'fzy_a') / tmp(T);
  data(T,'fzz_r') = data(T,'fzz_a') / tmp(T);
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
  tmp(T) = abs(data(T,'fy_'));
  TT(T) = tmp(T) > 0;
  data(T,  'fy_r') = INF;
  data(T , 'fy_r')$(data(T, 'fy_a') eq 0) = 0;
  data(TT, 'fy_r') = data(TT,  'fy_a') / tmp(TT);
  tmp(T) = abs(data(T,'fz_'));
  TT(T) = tmp(T) > 0;
  data(T,  'fz_r') = INF;
  data(T , 'fz_r')$(data(T, 'fz_a') eq 0) = 0;
  data(TT, 'fz_r') = data(TT,  'fz_a') / tmp(TT);

  tmp(T) = abs(data(T,'fxx_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fxx_r') = INF;
  data(T ,'fxx_r')$(data(T,'fxx_a') eq 0) = 0;
  data(TT,'fxx_r') = data(TT, 'fxx_a') / tmp(TT);
  tmp(T) = abs(data(T,'fxy_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fxy_r') = INF;
  data(T ,'fxy_r')$(data(T,'fxy_a') eq 0) = 0;
  data(TT,'fxy_r') = data(TT, 'fxy_a') / tmp(TT);
  tmp(T) = abs(data(T,'fxz_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fxz_r') = INF;
  data(T ,'fxz_r')$(data(T,'fxz_a') eq 0) = 0;
  data(TT,'fxz_r') = data(TT, 'fxz_a') / tmp(TT);
  tmp(T) = abs(data(T,'fyx_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fyx_r') = INF;
  data(T ,'fyx_r')$(data(T,'fyx_a') eq 0) = 0;
  data(TT,'fyx_r') = data(TT, 'fyx_a') / tmp(TT);
  tmp(T) = abs(data(T,'fyy_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fyy_r') = INF;
  data(T ,'fyy_r')$(data(T,'fyy_a') eq 0) = 0;
  data(TT,'fyy_r') = data(TT, 'fyy_a') / tmp(TT);
  tmp(T) = abs(data(T,'fyz_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fyz_r') = INF;
  data(T ,'fyz_r')$(data(T,'fyz_a') eq 0) = 0;
  data(TT,'fyz_r') = data(TT, 'fyz_a') / tmp(TT);
  tmp(T) = abs(data(T,'fzx_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fzx_r') = INF;
  data(T ,'fzx_r')$(data(T,'fzx_a') eq 0) = 0;
  data(TT,'fzx_r') = data(TT, 'fzx_a') / tmp(TT);
  tmp(T) = abs(data(T,'fzy_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fzy_r') = INF;
  data(T ,'fzy_r')$(data(T,'fzy_a') eq 0) = 0;
  data(TT,'fzy_r') = data(TT, 'fzy_a') / tmp(TT);
  tmp(T) = abs(data(T,'fzz_'));
  TT(T) = tmp(T) > 0;
  data(T, 'fzz_r') = INF;
  data(T ,'fzz_r')$(data(T,'fzz_a') eq 0) = 0;
  data(TT,'fzz_r') = data(TT, 'fzz_a') / tmp(TT);
};
data(T,'rc_e') = abs(data(T,'rc')-data(T,'rc_'));
data(T,'ec_e') = abs(data(T,'ec')-data(T,'ec_'));

set badT(T);
parameter failures(T,V);

badT(T) = ((data(T,  'f_a') > aeps) and (data(T,  'f_r') > reps))
      OR  ((data(T, 'fx_a') > aeps) and (data(T, 'fx_r') > reps))
      OR  ((data(T, 'fy_a') > aeps) and (data(T, 'fy_r') > reps))
      OR  ((data(T, 'fz_a') > aeps) and (data(T, 'fz_r') > reps))
      OR  ((data(T,'fxx_a') > aeps) and (data(T,'fxx_r') > reps))
      OR  ((data(T,'fxy_a') > aeps) and (data(T,'fxy_r') > reps))
      OR  ((data(T,'fxz_a') > aeps) and (data(T,'fxz_r') > reps))
      OR  ((data(T,'fyx_a') > aeps) and (data(T,'fyx_r') > reps))
      OR  ((data(T,'fyy_a') > aeps) and (data(T,'fyy_r') > reps))
      OR  ((data(T,'fyz_a') > aeps) and (data(T,'fyz_r') > reps))
      OR  ((data(T,'fzx_a') > aeps) and (data(T,'fzx_r') > reps))
      OR  ((data(T,'fzy_a') > aeps) and (data(T,'fzy_r') > reps))
      OR  ((data(T,'fzz_a') > aeps) and (data(T,'fzz_r') > reps))
      OR  data(T,'rc_e')
      OR  data(T,'ec_e');
failures(badT,V) = data(badT,V);
display 'failed tests', failures;
* display data;
scalar nTests, nErrors;
nTests = card(T);
nErrors = card(badT);
display 'absolute tolerance: ', aeps;
display 'relative tolerance: ', reps;
display 'data points tested: ', nTests;
display '            errors: ', nErrors;
abort$(nErrors) 'There were errors';
