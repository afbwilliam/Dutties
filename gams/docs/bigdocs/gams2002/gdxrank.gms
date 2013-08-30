set I /i1 * i6/;
parameter A(I) /i1=+Inf, i2=-Inf, i3=Eps, i4= 10, i5=30, i6=20/;
display A;

* write symbol Array to sort to gdx file
execute_unload "rank_in.gdx", A;

* sort symbol; permutation index will be named A also
execute 'gdxrank rank_in.gdx rank_out.gdx';

* load the permutation index
parameter AIndex(i);
execute_load "rank_out.gdx", AIndex=A;
display AIndex;

* create a sorted version
parameter ASorted(i);
   ASorted(i + (AIndex(i)- Ord(i))) = A(i);
display ASorted;


* check that the result is sorted
set C(i);
C(i)=Yes$(Ord(i) < Card(i)) and (ASorted(i) > ASorted(i+1));
display C;

Abort$(Card(C) <> 0) 'sort failed';


