library ex1d;
{$H- use short strings!!!!}

{ Delphi implementation of example 1 }

uses
   geheader2_d;

const
   ni = 4;

type
   tex1 = 1..ni;

var
   neq, nvar, nz : integer;
   x0: array[tex1] of double;
   Q:  array[tex1,tex1] of double;

Function GeFuncX(cbinfo:    tcbrecptr;
                 var Icntr: ticntr;
                 var x:     tarray;
                 var F:     double;
                 var D:     tarray): integer;

var
   i,j: integer;

begin

result := 2;

case Icntr[I_Mode] of

DoInit:
   begin {initialization}

   MsgStat(cbinfo, ' ');
   MsgStat(cbinfo,'**** Using External Function in ex1d_cb.dpr.');
   MsgLog(cbinfo,'--- GEFUNC in ex1d_cb.dpr is being initialized.');

   { Test the sizes and return 0 if OK }
   neq   := 1;
   nvar  := ni+1;
   nz    := ni+1;
   if (neq<>Icntr[I_Neq]) or (nvar<>Icntr[I_Nvar]) or (nz<>Icntr[I_Nz])
   then
      begin
      MsgLog(cbinfo,'--- Model has the wrong size.');
      exit;
      end;

   { Define the model data using statements similar to those in GAMS.
   Note that any changes in the GAMS model must be changed here also,
   so syncronization can be a problem with this methodology.}

   for i := 1 to ni
   do begin
      x0[i] := i;
      for j := 1 to ni
      do Q[i,j] := exp(ln(0.5)*abs(i-j));
      end;

   result := 0;

   end;

DoTerm:
   begin {termination mode, close possible debugfile}
   result := 0;
   end;

DoEval:
   begin { function and derivative mode }

   { Function index: there is only one so we do not have to test it
   but we do it just to show the principle. }

   if Icntr[I_Eqno] <> 1
   then
      begin
      Msgstat(cbinfo,' ** fIndex has an unexpected value.');
      exit;
      end;

   { Function value is needed. Note that the linear term corresponding
   to -Z must be included. }

   if Icntr[I_Dofunc] <> 0
   then
      begin
      f := -x[ni+1];
      for i := 1 to ni
      do for j := 1 to ni
         do f := f + (x[i]-x0[i]) * Q[i,j] * (x[j]-x0[j]);
      end;

   { The vector of derivatives is needed. The derivative with respect
   to variable x(i) must be returned in d(i). The derivatives of the
   linear terms, here -Z, must be defined each time. }

   if Icntr[I_Dodrv] <> 0
   then
      begin
      d[ni+1] := -1.0;
      for i := 1 to ni
      do begin
         d[i] := 0.0;
         for j := 1 to ni
         do d[i] := d[i] + Q[i,j] * ( x[j]-x0[j] ) ;
         d[i] := d[i] * 2.0;
         end;
      end;

   result := 0;

   end;

else { unexpected mode }
   begin
   MsgBoth(cbinfo,'*** Function Mode has an unexpected value');
   end;

end { case } ;

end;

Function GeFunc( var Icntr: ticntr;
                 var x:     tarray;
                 var F:     double;
                 var D:     tarray;
                 MsgFunc:   pointer): integer; stdcall;
var cbinfo: tcbrec;
begin
cbinfo.msgcb  := MsgFunc;
cbinfo.cbtype := 1;
result := GeFuncX(@cbinfo, Icntr, x, F, D);
end;

Function GeFunc2(var Icntr: ticntr;
                 var x:     tarray;
                 var F:     double;
                 var D:     tarray;
                 MsgFunc:   pointer;
                 Usrmem:    pointer): integer; stdcall;
var cbinfo: tcbrec;
begin
cbinfo.msgcb  := MsgFunc;
cbinfo.usrmem := Usrmem;
cbinfo.cbtype := 2;
result := GeFuncX(@cbinfo, Icntr, x, F, D);
end;

exports
   GeFunc  name 'gefunc',
   GeFunc2 name 'gefunc2';
end.
