library ex4d;
{$H- use short strings!!!!}

uses
   geheader_d;

const
   nmax = 950;

type
   tdea = 1..nmax;

var
   n:      integer;
   fudge:  double;
   objval: array[tdea] of double;

Function GeFunc(var Icntr: ticntr;
                var x:     tarray;
                var F:     double;
                var D:     tarray;
                    MsgFunc: tMsgCallBack): integer; stdcall;


var
   i,ii: integer;

   cv,c,
   h,hm2,
   dh,
   a1,a2,e1,e2: double;
   logarg,
   chain: array[tdea] of double;

   DEAData: text;
   rc: integer;
   ts,
   DEAName: shortstring;

begin

result := 2;

case Icntr[I_Mode] of

DoInit:
   begin {initialization}

   GeStat(Icntr,'');
   GeStat(Icntr,'*** Using external function ex4d.dll');
   GeLog (Icntr,'--- GeFunc in ex4d.dll initialization');

   if Icntr[I_Neq] <> 1
   then
      begin
      GeBoth(Icntr,'*** Illegal number of Equations');
      exit;
      end;
   if Icntr[I_Nvar] <> 2
   then
      begin
      GeBoth(Icntr,'*** Illegal number of Variables');
      exit;
      end;

   DEAName := 'ex4.put';
   assign(DEAData,DEANAME);
   {$I-}
   reset(DEAData);
   {$I+}
   rc := IOResult;
   if rc <> 0
   then  { could not open file }
      begin
      str(rc,ts);
      GeBoth(Icntr,'*** Could not open data file ' + DEAName);
      GeBoth(Icntr,'*** Rc=' + ts);
      exit;
      end;
   {$I-}
   read(DEAData,n,fudge);
   {$I+}
   if IOResult <> 0
   then
      begin
      str(rc,ts);
      GeBoth(Icntr,'*** Bad Data in first line RC=' + ts);
      close(DEAData);
      exit;
      end;
   if n > nmax
   then
      begin
      GeBoth(Icntr,'*** N > Nmax');
      close(DEAData);
      exit;
      end;
   if n < 1
   then
      begin
      GeBoth(Icntr,'*** N < 1');
      close(DEAData);
      exit;
      end;
   if fudge < 1e-10
   then
      begin
      GeBoth(Icntr,'*** fudge < 1e-10');
      close(DEAData);
      exit;
      end;
   for i := 1 to n
   do begin
      {$I-}
      read(DEAData,objval[i]);
      {$I+}
      if IOResult <> 0
      then
         begin
         str(i,ts);
         GeBoth(Icntr,'Bad data at record number ' + ts);
         close(DEAData);
         exit;
         end;
      end;
   close(DEAData);
   result := 0;
   end;

DoTerm:
   begin {termination mode, close possible debugfile}
   GeClose;
   result := 0;
   end;

DoEval:
   begin { function and derivative mode }

   h  := x[1];
   cv := x[2];
   if abs(h) < 1e-20
   then
      begin
      result := 1;
      exit;
      end;

   hm2 := 1.0/h/h;
   for i := 1 to n
   do begin
      logarg[i] := fudge;
      chain[i]  := 0.0;
      end;
   for i := 1 to n
   do for ii := i+1 to n
      do begin
         a1 := -sqr(objval[i]  -objval[ii])/2.0*hm2;
         e1 := exp(a1);
         a2 := -sqr(objval[i]-2+objval[ii])/2.0*hm2;
         e2 := exp(a2);
         logarg[i]  := logarg[i]  + e1 + e2;
         logarg[ii] := logarg[ii] + e1 + e2;
         if Icntr[I_DoDrv] <> 0
         then
            begin
            chain[i]   := chain[i]  + e1*a1 + e2*a2;
            chain[ii]  := chain[ii] + e1*a1 + e2*a2;
            end;
         end;

   if Icntr[I_DoFunc] <> 0
   then
      begin
      c  := 0.0;
      for i := 1 to n
      do c  := c + ln(logarg[i]);
      c  := c - n*ln(h);
      f := cv - c;
      end;

   if Icntr[I_DoDrv] <> 0
   then
      begin
      dh := 0.0;
      for i := 1 to n
      do dh := dh + chain[i]/logarg[i];
      dh := -dh*2.0/h - n/h;
      d[1] := -dh;
      d[2] := 1.0
      end;

   result := 0;
   end;

else { unexpected mode }
   begin
   str(Icntr[I_Mode],ts);
   GeBoth(Icntr,'*** Function Mode has an unexpected value of '+ ts);
   end;

end { case } ;

end;

exports
   GeFunc name 'gefunc';
end.

