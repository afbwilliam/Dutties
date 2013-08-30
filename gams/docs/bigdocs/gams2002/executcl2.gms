*here we illustrate numerical errors but reset the exerr function
*allowing normal termination

$offsymlist offsymxref
sets elements /s1*s25/
parameter data1(elements)   data to be exponentiated
          datadiv(elements) divisors;
data1(elements)=1;
data1("s20")=-1;
datadiv(elements)=1;
datadiv("s21")=0;
parameter result(elements);
result(elements)=data1(elements)**2.1/datadiv(elements);
display result;

*cause z to be undefined
scalar z;
z=1/0;
if(execerror gt 0,
   result(elements)$(result(elements) = z)=0;);
display result;
execerror=0;

$ontext
#user model library stuff
Main topic Execution errors
Featured item 1 Error
Featured item 2 Execerror
Featured item 3 Numerical problems
Featured item 4
Description
*here we illustrate numerical errors but reset the exerr function
*allowing normal termination

$offtext
