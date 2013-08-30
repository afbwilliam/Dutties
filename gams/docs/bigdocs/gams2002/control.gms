*illustrate contol structures for while loop If

set i / i2,i3 /;
parameter data(i);
scalar x /1/;
loop (i,
  DATA(I)=12 ;
) ;
if (x ne 0,
     DATA(I)=12 ;
  );
for(x=1 downto 12 by 2,
    data(i)=x;
   );
x=1;
while(x<10,
    x=x+0.01;
     );

$onend
loop i do
     DATA(I)=12 ;
endloop;
if x ne 0 then
     DATA(I)=12 ;
endif;
for x=1 downto 12 by 2 do
    data(i)=x;
   endfor;
x=1;
while x<10 do
    x=x+0.01;
    endwhile;

$ontext
#user model library stuff
Main topic Control structures
Featured item 1 While
Featured item 2 Loop
Featured item 3 If
Featured item 4 $Onend
Description
 illustrate contol structures for while loop If along with
 $onend and endloop, endwhile, endif

$offtext
