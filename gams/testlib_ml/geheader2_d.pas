unit geheader2_d;
{$H- use short strings!!!!}
{
   Delphi unit for GAMS external function interface
}

interface

const

   I_Length  = 1;  // length of Icntr array
   I_Neq     = 2;
   I_Nvar    = 3;
   I_Nz      = 4;
   I_Mode    = 5;
   I_Eqno    = 6;
   I_Dofunc  = 7;
   I_Dodrv   = 8;
   I_Newpt   = 9;
   I_Debug   =28;   // debugflag


   DoInit = 1;
   DoTerm = 2;
   DoEval = 3;

   big = 10000000;

type
   ticntr = array[1..big] of integer;
   tarray = array[1..big] of double;

   tcbrec  = record
            usrmem: pointer;
            msgcb : pointer;
            cbtype: integer;
            end;
   tcbrecptr = ^tcbrec;

   TMsgCallBack = procedure (var mode  : integer;
                             var nchars: integer;
                                 PMsg  : pointer;
                                 BufLen: integer); stdcall;

   TMsgCallBack2= procedure (    usrmem: pointer;
                             var mode  : integer;
                             var nchars: integer;
                                 PMsg  : pointer;
                                 BufLen: integer); stdcall;
{ message buffer }
Procedure GeStat(var icntr: ticntr; const s: shortstring);
Procedure GeLog (var icntr: ticntr; const s: shortstring);
Procedure GeBoth(var icntr: ticntr; const s: shortstring);

Procedure GeClose;

{ call back messages }
Procedure MsgStat(cbinfo: tcbrecptr; const s: shortstring);
Procedure MsgLog (cbinfo: tcbrecptr; const s: shortstring);
Procedure MsgBoth(cbinfo: tcbrecptr; const s: shortstring);


implementation


const

   I_Start   =26;   // text start
   I_Used    =27;   // text words used

   TOSTAT = 1;
   TOLOG  = 2;

   DOSTAT = 2;
   DOLOG  = 1;
   DOBOTH = 3;

{ text record    1: length in characters
                 2: TOSTAT go to status
                    TOLOG  go to log
                 3+ string                 }

var
   debugfile: text;
   debugopen: boolean;
   debugname: shortstring;

procedure GeClose;
begin
if debugopen
then
   begin
   close(debugfile);
   debugopen := false;
   end;
end;

procedure debugcheck(const id,s: shortstring);
var
   rc : integer;

begin
if NOT debugopen
then
   begin
   assign(debugfile,debugname);
   {$I-}
   rewrite(debugfile);
   {$I+}
   rc := IOResult;
   if rc <> 0
   then  { could not open file }
      begin
      writeln('Could not open ',debugname,' RC=',rc);
      writeln(id,s);
      exit;
      end
   else
      debugopen := true;
   end;
{$I-}
writeln(debugfile,id,s);
{$I+}
if IOResult <> 0
then
   begin
   writeln('Could not write to ',debugname);
   writeln(id,s);
   end
else
   flush(debugfile);
end;

procedure gestore(var icntr: ticntr; typ: integer; const s: shortstring);
{ do same ugly stuff as we do for fortran }
type
   ta = array[1..4] of char;

   tfudge = record
   case integer of
   1: (i1: integer);
   2: (ca: ta);
   end;

var
  i,j,k,
  len,
  start: integer;
  fudge: tfudge;


begin
start := Icntr[I_Start] + Icntr[I_Used];
if (Icntr[I_Length] - Start) < 4
then
   exit; // not enough space
len := length(s);
if (((len+sizeof(integer)-1) div sizeof(integer))*sizeof(integer)) >
   (Icntr[I_Length] - Start  - 2)
then  // truncate
   len := (Icntr[I_Length]-Start-2)*sizeof(integer);

if len > 0
then
   begin
   k := start+2;
   i := 1;
   for j:= 1 to len
   do begin
      fudge.ca[i] := s[j];
      i := i + 1;
      if i > 4
      then
         begin
         i := 1;
         icntr[k] := fudge.i1;
         k := k + 1;
         end;
      end;
   if i <= 4
   then
      icntr[k] := fudge.i1;
   end;

icntr[start]   := len;
icntr[start+1] := typ;
icntr[I_Used]  := icntr[I_Used] + 2 + (len+sizeof(integer)-1) div sizeof(integer);
end;


Procedure GeStat(var icntr: ticntr; const s: shortstring);
begin
gestore(icntr,TOSTAT,s);
debugcheck('GeStat : ',s);
end;

Procedure GeLog (var icntr: ticntr; const s: shortstring);
begin
gestore(icntr,TOLOG,s);
debugcheck('GeLog  : ',s);
end;

Procedure GeBoth(var icntr: ticntr; const s: shortstring);
begin
gestore(icntr,TOSTAT,s);
gestore(icntr,TOLOG ,s);
debugcheck('GeBoth : ',s);
end;


Procedure MsgStat(cbinfo: tcbrecptr; const s: shortstring);
var
   Mode,
   NChar: integer;
begin
NChar := Length(s);
Mode  := DOSTAT;
if cbinfo^.cbtype=1
then
  TMsgCallBack(cbinfo^.msgcb)(Mode,NChar,@s[1],NChar)
else 
  if cbinfo^.cbtype=2
  then
    TMsgCallBack2(cbinfo^.msgcb)(cbinfo^.usrmem,Mode,NChar,@s[1],NChar);
debugcheck('MsgStat : ',s);
end;

Procedure MsgLog (cbinfo: tcbrecptr; const s: shortstring);
var
   Mode,
   NChar: integer;
begin
Mode  := DOLOG;
NChar := Length(s);
if cbinfo^.cbtype=1
then
  TMsgCallBack(cbinfo^.msgcb)(Mode,NChar,@s[1],NChar)
else 
  if cbinfo^.cbtype=2
  then
    TMsgCallBack2(cbinfo^.msgcb)(cbinfo^.usrmem,Mode,NChar,@s[1],NChar);
debugcheck('MsgLog  : ',s);
end;

Procedure MsgBoth(cbinfo: tcbrecptr; const s: shortstring);
var
   Mode,
   NChar: integer;
begin
Mode  := DOBOTH;
NChar := Length(s);
if cbinfo^.cbtype=1
then
  TMsgCallBack(cbinfo^.msgcb)(Mode,NChar,@s[1],NChar)
else 
  if cbinfo^.cbtype=2
  then
    TMsgCallBack2(cbinfo^.msgcb)(cbinfo^.usrmem,Mode,NChar,@s[1],NChar);
debugcheck('MsgBoth : ',s);
end;

begin
debugname := 'debugext.txt';
debugopen := false;
end.

