*illustrate use of a for statement

scalar converge indicates convergence /0/;
scalar maxroot current maximum root /10/;
scalar minroot current minimum root/-10/
scalar root   root of an equation that we will solve for /1/;
scalar function_value function value at root /0/;
scalar function_value1 function value at minroot /0/;
scalar function_value2 function value at maxroot/0/;
scalar iter number of binary search tries /0/;
scalar iterlim max number of binary search tries /20/;
scalar tolerance tolerance for root /0.00000001/;
scalar signswitch indicates if one that sign switch found /0/;
scalar inc increment to try to find sign switch /0/,
       a constant tern in function /6/,
       b number for linear term /5/,
       c number ofr squared tem /1/;
for (iter = 1 to iterlim,
  root=(maxroot+minroot)/2;
  function_value=a-b*root+c*sqr(root);
  if(abs(function_value) lt tolerance,
          iter=iterlim;
  else
            if(sign(function_value1)=
         sign(function_value),
         minroot=root;
         function_value1=function_value;
            else
         maxroot=root;
         function_value2=function_value;);
             );
  );
  display 'result',iter,iterlim,root,minroot,maxroot,
          function_value,function_value1,function_value2;


$ontext
#user model library stuff
Main topic Control structures
Featured item 1 For
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate use of a for statement

$offtext
