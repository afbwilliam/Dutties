$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$call =ask T=integer M="Enter number of cities" o=n.inc
scalar n 'number of cities' /
$include n.inc
/;
display n;
