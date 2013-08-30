program xp_example1dp;

///////////////////////////////////////////////////////////////
// This program generates demand data for a modified version //
// of the trnsport model or reads the solution back from a   //
// GDX file.                                                 //
//                                                           //
// Calling convention:                                       //
// Case 1:                                                   //
//    Parameter 1: GAMS system directory                     //
// The program creates a GDX file with demand data           //
// Case 2:                                                   //
//    Parameter 1: GAMS system directory                     //
//    Parameter 2: gdxfile                                   //
// The program reads the solution from the GDX file          //
// Paul van der Eijk Jun-12, 2002                            //
// Updated Dec-20, 2007 (changes in API                      //
///////////////////////////////////////////////////////////////

{$APPTYPE CONSOLE}
{$H- short strings}

uses
  sysutils,
  gxdefs,
  gmsspecs,
  gdxdpdef;

procedure ReportgdxError(PGX: PGXFile);
var
   S: ShortString;
begin
WriteLn('**** Fatal GDX Error');
gdxErrorStr(nil, gdxGetLastError(PGX),S);
WriteLn('**** ',S);
Halt(1);
end;

procedure ReportIOError(N: integer);
begin
WriteLn('**** Fatal I/O Error = ',N);
Halt(1);
end;

var
   PGX  : PGXFile;

procedure WriteData(const s: string; V: double);
var
   Indx  : TgdxStrIndex;
   Values: TgdxValues;
begin
Indx[1] := s;
Values[vallevel] := V;
gdxDataWriteStr(PGX,Indx,Values);
end;


var
   Msg     : string;
   Sysdir  : string;
   Producer: string;
   ErrNr   : integer;
   Indx    : TgdxStrIndex;
   Values  : TgdxValues;
   VarNr   : integer;
   NrRecs  : integer;
   N       : integer;
   Dim     : integer;
   VarName : shortstring;
   VarTyp  : integer;
   D       : integer;

begin
if not(ParamCount in [1,2])
then
   begin
   WriteLn('**** XP_Example1: incorrect number of parameters');
   Halt(1);
   end;

sysdir := ParamStr(1);
WriteLn('XP_Example1 using GAMS system directory: ',sysdir);

if not gdxCreateD(PGX,sysdir,Msg)
then
   begin
   WriteLn('**** Could not load GDX library');
   WriteLn('**** ', Msg);
   exit;
   end;

gdxGetDLLVersion(nil, Msg);
WriteLn('Using GDX DLL version: ',Msg);

if ParamCount = 1
then
   begin
   //write demand data
   gdxOpenWrite(PGX,'demanddata.gdx','xp_example1', ErrNr);
   if ErrNr <> 0
   then
      ReportIOError(ErrNr);

   if gdxDataWriteStrStart(PGX,'Demand','Demand data',1,gms_dt_par,0) = 0
   then
      ReportgdxError(PGX);
   WriteData('New-York',324.0);
   WriteData('Chicago' ,299.0);
   WriteData('Topeka'  ,274.0);
   if gdxDataWriteDone(PGX) = 0
   then
      ReportgdxError(PGX);

   WriteLn('Demand data written by xp_example1');
   end
else
   begin
   //read x variable back (non-default level values only)
   gdxOpenRead(PGX,ParamStr(2), ErrNr);
   if ErrNr <> 0
   then
      ReportIOError(ErrNr);

   gdxFileVersion(PGX,Msg,Producer);
   WriteLn('GDX file written using version: ',Msg);
   WriteLn('GDX file written by: ',Producer);

   if gdxFindSymbol(PGX,'x',VarNr) = 0
   then
      begin
      WriteLn('**** Could not find variable X');
      Halt(1);
      end;

   gdxSymbolInfo(PGX,VarNr,VarName,Dim,VarTyp);
   if (Dim <> 2) or (VarTyp <> gms_dt_var)
   then
      begin
      WriteLn('**** X is not a two dimensional variable');
      Halt(1);
      end;

   if gdxDataReadStrStart(PGX,VarNr,NrRecs) = 0
   then
      ReportgdxError(PGX);

   WriteLn('Variable X has ',NrRecs,' records');
   while gdxDataReadStr(PGX,Indx,Values,N) <> 0
   do begin
      if Values[vallevel] = 0.0       //skip level = 0.0 is default
      then
         continue;
      for D := 1 to Dim
      do begin
         Write(Indx[D]);
         if D < Dim
         then
            Write('.');
         end;
      WriteLn(' = ',Values[vallevel]:7:2);
      end;
   WriteLn('All solution values shown');
   gdxDataReadDone(PGX);
   end;

ErrNr := gdxClose(PGX);
if ErrNr <> 0
then
   ReportIOError(ErrNr);

end.
