library ex2d_cb;
{$H- use short strings!!!!}

{ Delphi implementation of example 2 }

uses
   geheader_d;

const
   maxi = 10;

type
   tex2 = 1..maxi;

var
   ni, neq, nvar, nz : integer;
   x0: array[tex2] of double;
   Q:  array[tex2,tex2] of double;

Function GeFunc(var Icntr: ticntr;
                var x:     tarray;
                var F:     double;
                var D:     tarray;
                MsgFunc:   tMsgCallBack): integer; stdcall;

var
   i,j: integer;

   Ex2Data: text;
   rc: integer;
   ts,
   Ex2Name: shortstring;

begin

result := 2;

case Icntr[I_Mode] of

DoInit:
   begin {initialization}

   MsgStat( MsgFunc,' ');
   MsgStat( MsgFunc,'**** Using External Function in ex2d_cb.dpr.');
   MsgLog ( MsgFunc,'--- GEFUNC in ex2d_cb.dpr is being initialized.');

   {  Read the put file created by the GAMS model. We must do this as
   the very first thing because it holds the size of the model. }

   EX2Name := 'ex2.put';
   assign(EX2Data,EX2NAME);
   {$I-}
   reset(EX2Data);
   rc := IOResult;
   if rc <> 0
   then  { could not open file }
      begin
      str(rc,ts);
      MsgBoth(MsgFunc,'*** Could not open data file ' + EX2Name);
      MsgBoth(MsgFunc,'*** Rc=' + ts);
      exit;
      end;
   readln(EX2Data,ni);
   if IOResult <> 0
   then
      begin
      str(rc,ts);
      MsgBoth(MsgFunc,'*** Bad Data in first line RC=' + ts);
      close(EX2Data);
      exit;
      end;

   if ni > maxi
   then
      begin
      MsgBoth(MsgFunc,'***');
      MsgBoth(MsgFunc,'*** Card(I) too large for DLL');
      MsgBoth(MsgFunc,'*** You must recompile with a larger Maxi value');
      MsgBoth(MsgFunc,'***');
      close(EX2Data);
      exit;
      end;

   { Check the model size compared to the information passed from GAMS }
   neq   := 1;
   nvar  := ni+1;
   nz    := ni+1;
   if (neq<>Icntr[I_Neq]) or (nvar<>Icntr[I_Nvar]) or (nz<>Icntr[I_Nz])
   then
      begin
      MsgBoth( MsgFunc,'--- Model has the wrong size.');
      close(EX2Data);
      exit;
      end;


   { The size was OK. Now read the target and covariance data: }
   for i := 1 to ni
   do begin
      readln(EX2Data,x0[i]);
      if IOResult <> 0
      then
         begin
         str(i,ts);
         MsgBoth(MsgFunc,'*** Bad data for x0[' + ts + ']');
         close(EX2Data);
         exit;
         end;
      for J := 1 to ni
      do begin
         readln(EX2Data,Q[i,j]);
         if IOResult <> 0
         then
            begin
            MsgBoth(MsgFunc,'*** Bad data for Q');
            close(EX2Data);
            exit;
            end;
         end;
      end;
   close(EX2Data);
   {$I+}
   result := 0;

   end;

DoTerm:
   begin {termination mode, close possible debugfile}
   GeClose;
   result := 0;
   end;

DoEval:
   begin { function and derivative mode }

   { Function index: there is only one so we do not have to test it
   but we do it just to show the principle. }

   if Icntr[I_Eqno] <> 1
   then
      begin
      MsgStat( MsgFunc,' ** fIndex has an unexpected value.');
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
   MsgBoth(MsgFunc,'*** Function Mode has an unexpected value');
   end;

end { case } ;

end;

exports
   GeFunc name 'gefunc';
end.
