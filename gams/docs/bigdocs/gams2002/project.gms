set i /1*3/
    j /1*3/
    k /1*3/;

Parameter Q(I,J,K) / 1.1.1 1, 1.2.3 3, 2.1.1 4/   ;
Parameter Elementcount(I) ;
option elementcount< Q  ;
Parameter Elcount(j,k) ;
option elcount< Q  ;
display elementcount,elcount

Set  fromto(i,i)/1.2,3.3/, tofrom(i,i);
alias(i,ii);
parameter in(i),out(i);
option tofrom < fromto, in < fromto, out <= fromto;
display in,out,tofrom;

