*binary root finder that illustrates use of while statement

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
while(signswitch=0 and root le maxroot,
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
      minroot=root;);
    );
*  display 'inside',minroot,maxroot,function_value1,function_value2;
);
scalar saveminroot,savemaxroot;
saveminroot=minroot;
savemaxroot=maxroot;
display 'spanner',minroot,maxroot,function_value1,function_value2;
*do a binary search to narrow root
while(converge = 0 and iter lt lim,
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
);
  display 'result',iter,lim,root,minroot,maxroot,
          function_value,function_value1,function_value2;

$ontext
#user model library stuff
Main topic Control structures
Featured item 1 While
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate use of a While statement

$offtext

minroot=saveminroot;
maxroot=savemaxroot;
iter=0;
converge=0;

$onend
While converge = 0 and iter lt lim do
    root=(maxroot+minroot)/2;
    iter=iter+1;
    function_value=a-b*root+c*sqr(root);
    function_value=function_value;
    If(abs(function_value)) lt tolerance then
        converge=1;
    else
       if(sign(function_value1)=sign(function_value)) then
          minroot=root;
          function_value1=function_value;
       else
          maxroot=root;
          function_value2=function_value;
       endif;
    endif;
endwhile;
display root,function_value,minroot,maxroot;
