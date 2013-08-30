*illustrate use of repeat command

scalar converge indicates convergence /0/;
scalar maxroot current maximum root /10/;
scalar minroot current minimum root/-10/
scalar root   root of an equation that we will solve for /1/;
scalar function_value function value at root /0/;
scalar function_value1 function value at minroot /0/;
scalar function_value2 function value at maxroot/0/;
scalar iter number of binary search tries /0/;
scalar lim max number of binary search tries /20/;
scalar tolerance tolerance for root /0.00000001/;
scalar signswitch indicates if one that sign switch found /0/;
scalar inc increment to try to find sign switch /0/,
       a constant tern in function /6/,
       b number for linear term /5/,
       c number ofr squared tem /1/;
function_value1= a-b*minroot+c*sqr(minroot);
inc=(maxroot-minroot)/37;
root=minroot;
*find a sign switch
repeat(
  root=root+inc;
  function_value2= a-b*root+c*sqr(root);
  if((sign(function_value1) ne sign(function_value2)
    and abs(function_value1) gt 0
    and abs(function_value2) gt tolerance),
      maxroot=root;
      signswitch=1
  else
    if(abs(function_value2) gt tolerance,
      function_value1=function_value2;
      minroot=root;));
  until (signswitch>0 or root > maxroot)) ;
*  display 'inside',minroot,maxroot,function_value1,function_value2;

display 'spanner',minroot,maxroot,function_value1,function_value2;
*do a binary search to narrow root
repeat(
  root=(maxroot+minroot)/2;
  iter=iter+1;
  function_value=a-b*root+c*sqr(root);
  if(abs(function_value) lt tolerance,
    converge=1;
  else
    if(sign(function_value1)=sign(function_value),
      minroot=root;
       function_value1=function_value;
    else
      maxroot=root;
      function_value2=function_value;);
     );
*  display iter,lim,root,minroot,maxroot,
*          function_value,function_value1,function_value2;
  until (converge > 0 or iter gt lim));
  display 'result',iter,lim,root,minroot,maxroot,
          function_value,function_value1,function_value2;

$ontext
#user model library stuff
Main topic Control structures
Featured item 1 Repeat
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate use of a repeat command

$offtext

