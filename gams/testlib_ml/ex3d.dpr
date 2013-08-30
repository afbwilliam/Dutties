library ex3d;
{$H- use short strings!!!!}

{ Delphi implementation of example 3 }

uses
   geheader_d;

const
   ni = 15;

type
   tex3	= 1..ni;

var
   neq, nvar, nz : integer;
   f2i,f2j	 : array[tex3] of integer;

Function GeFunc(var Icntr : ticntr;
		var x	  : tarray;
                var F	  : double;
                var D	  : tarray;
                MsgFunc	  : tMsgCallBack): integer; stdcall;

var
   findex,i,j,i1 : integer;

begin

result := 2;

case Icntr[I_Mode] of

DoInit:
   begin {initialization}

   GEstat( Icntr, ' ');
   GEstat( Icntr,'**** Using External Function in ex3d.dpr.');
   GElog ( Icntr,'--- Function ex3d.dpr being initialized.');

   { Test the sizes and return 0 if OK }
   neq   := 21;
   nvar  := 33;
   nz    := 5*15 + 5*6;
   if (neq<>Icntr[I_Neq]) or (nvar<>Icntr[I_Nvar]) or (nz<>Icntr[I_Nz])
   then
      begin
      GElog ( Icntr,'--- Model has the wrong size.');
      exit;
      end;


   { Create a mapping from linear fIndex for the Maxdist equations
   to the individual i and j indices }

   findex := 0;
   for i := 1 to 6
   do for j := i+1 to 6
      do begin
         findex := findex + 1;
         f2i[findex] := i;
         f2j[findex] := j;
         end;

   result := 0;

   end;

DoTerm:
   begin {termination mode, close possible debugfile}
   GeClose;
   result := 0;
   end;

DoEval:
   begin { function and derivative mode }

   findex := Icntr[I_Eqno];

   if (findex < 1) or (findex > 21 )
   then
      begin
      GeBoth(Icntr,'*** fIndex has unexpected value.');
      exit;
      end;

   if findex <= 15    { maxdist(i,j) }
   then
      {
      This is one of the Maxdist equations that in GAMS looks like
      maxdist(i,j)$(ord(i) lt ord(j)).. sqr(x(i)-x(j))+sqr(y(i)-y(j)) =l= 1;
      We must add an explicit slack and move the right hand side to the left
      }
      begin
      i := f2i[findex];
      j := f2j[findex];
      if Icntr[I_Dofunc] <> 0 { function value needed }
      then
         f := sqr(x[i]-x[j]) + sqr(x[6+i]-x[6+j]) + x[18+findex] - 1.0;

      if Icntr[I_Dodrv] <> 0 { derivatives are needed }
      then
         begin
         d[i]         := 2.0*(x[i]-x[j]);
         d[j]         := -d[i];
         d[6+i]       := 2.0*(x[6+i]-x[6+j]);
         d[6+j]       := -d[6+i];
         d[18+findex] := 1.0;
         end;
      end

   else  { areadef(i) }
      {
      This was one of the Areadef equations that in GAMS looked
      as follows:
      areadef(i)..  area(i) =e= 0.5*(x(i)*y(i++1)-y(i)*x(i++1)) ;
      We must remember to move the right hand side to the left.
      }
      begin
      i := findex - 15;
      if i = 6
      then
         i1 := 1
      else
         i1 := i + 1;

      if ICntr[I_Dofunc] <> 0
      then
         f := x[12+i] - 0.5*(x[i]*x[6+i1]-x[6+i]*x[i1]);

      if Icntr[I_Dodrv] <> 0
      then
         begin
         d[12+i] := 1.0;
         d[i]    := -0.5*x[6+i1];
         d[i1]   := +0.5*x[6+i];
         d[6+i]  := +0.5*x[i1];
         d[6+i1] := -0.5*x[i];
         end;
      end;

   result := 0;

   end;

else { unexpected mode }
   begin
   GeBoth(Icntr,'*** Function Mode has an unexpected value');
   end;

end { case } ;

end;

exports
   GeFunc name 'gefunc';
end.

