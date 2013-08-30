program xp_example2;
///////////////////////////////////////////////////////////////
// This program performs the following steps:                //
//    1. Generate a gdx file with demand data                //
//    2. Calls GAMS to solve a simple transportation model   //
//       (The GAMS model writes the solution to a gdx file)  //
//    3. The solution is read from the gdx file              //
//                                                           //
// Paul van der Eijk Apr-14, 2008                            //
///////////////////////////////////////////////////////////////

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  Registry,
  gmsspecs,
  gxdefs,
  gdxdocpdef,
  optdcpdef,
  gopdopdef;

function GetSysDir: string;
// Use the registry to find the GAMS system directory
var
   Reg : TRegistry;
   s   : string;
   k : integer;
begin
Result := '';
Reg := TRegistry.Create;
try
   Reg.Access := KEY_READ;
   Reg.RootKey := HKEY_CLASSES_ROOT;
   if Reg.OpenKey('\gamside.project\Shell\Open\Command', False)
   then
      begin
      S := Reg.ReadString('');
      if (S <> '') and (s[1] = '"')
      then
         begin
         System.Delete(s, 1, 1);
         k := Pos('"', s);
         if k > 0
         then
            System.Delete(s, k, maxint);
         end;
      if (s <> '') and FileExists(s)
      then
         Result := ExcludeTrailingBackslash(ExtractFilePath(s));
      end;
finally
   Reg.Free;
end;
end;

function ErrorMessage(const s, Msg: string): boolean;
begin
Result := Msg <> '';
if Result
then
   WriteLn('*** Error ', s, ' :', Msg);
end;

procedure ReportgdxError(PGX: TGXFile; const S: string);
var
   Msg: ShortString;
begin
PGX.gdxErrorStr(PGX.gdxGetLastError, Msg);
ErrorMessage(S, Msg);
end;


function WriteModelData(const fngdxfile: string): boolean;
label
   AllDone;
var
   PGX: TGXFile;

   procedure WriteData(const s: string; V: double);
   var
      Indx  : TgdxStrIndex;
      Values: TgdxValues;
   begin
   Indx[1] := s;
   Values[vallevel] := V;
   PGX.gdxDataWriteStr(Indx, Values);
   end;

var
   Msg: shortstring;
   ErrNr: integer;
begin
Result := false;
PGX := TGXFile.Create(Msg);
if ErrorMessage('Create PGX', Msg)
then
   goto AllDone;
PGX.gdxOpenWrite(fngdxfile, 'xp_example2', ErrNr);
if ErrNr <> 0
then
   begin
   PGX.gdxErrorStr(ErrNr, Msg);
   ErrorMessage('gdxOpenWrite', Msg);
   goto AllDone;
   end;
if PGX.gdxDataWriteStrStart('Demand', 'Demand data', 1, gms_dt_par, 0) = 0
then
   begin
   ReportGDXError(PGX, 'gdxDataWriteStrStart');
   goto AllDone;
   end;

WriteData('New-York',324.0);
WriteData('Chicago' ,299.0);
WriteData('Topeka'  ,274.0);

if PGX.gdxDataWriteDone <> 0
then
   Result := true
else
   ReportgdxError(PGX, 'WriteData');

ErrNr := PGX.gdxClose;
if ErrNr <> 0
then
   begin
   PGX.gdxErrorStr(ErrNr, Msg);
   ErrorMessage('gdxClose', Msg);
   goto AllDone;
   end;

//EXIT
AllDone:
PGX.Free;
end;

function CallGams(const SysDir, fnModel: string): boolean;
Label
   AllDone;
var
   GXO  : TGamsOptions;
   Msg  : shortstring;
   ErrNr: integer;
begin
Result := false;

GXO := TGamsOptions.Create(SysDir, Msg);
if ErrorMessage('Create TGamsOptions', Msg)
then
   goto AllDone;

GXO.Input := fnModel;
GXO.LogOption := 2;  //write .log and .lst files
ErrNr := GXO.RunExec(Msg, 1);
Result := ErrNr = 0;
if not Result
then
   ErrorMessage('RunExec', 'Error in GAMS call = ' + IntToStr(ErrNr));
AllDone:
GXO.Free;
end;

function ReadSolutionData(const fngdxfile: string): boolean;
label
   AllDone;
var
   PGX: TGXFile;
   Dim: integer;

   procedure ReadData;
   var
      Indx  : TgdxStrIndex;
      Values: TgdxValues;
      N     : integer;
      D     : integer;
   begin
   while PGX.gdxDataReadStr(Indx, Values, N) <> 0
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
   end;

var
   Msg    : shortstring;
   ErrNr  : integer;
   VarNr  : integer;
   VarName: shortstring;
   VarTyp : integer;
   NrRecs : integer;
begin
Result := false;
PGX := TGXFile.Create(Msg);
if ErrorMessage('Create PGX', Msg)
then
   goto AllDone;
PGX.gdxOpenRead(fngdxfile, ErrNr);
if ErrNr <> 0
then
   begin
   PGX.gdxErrorStr(ErrNr, Msg);
   ErrorMessage('gdxOpenRead', Msg);
   goto AllDone;
   end;
VarName := 'result';
if PGX.gdxFindSymbol(VarName, VarNr) = 0
then
   begin
   ErrorMessage('gdxFindSymbol', 'Could not find variable ' + VarName);
   goto AllDone
   end;

PGX.gdxSymbolInfo(VarNr, VarName, Dim, VarTyp);
if (Dim <> 2) or (VarTyp <> gms_dt_var)
then
   begin
   ErrorMessage('gdxSymbolInfo', VarName + ' is not a two dimensional variable');
   goto AllDone;
   end;

if PGX.gdxDataReadStrStart(VarNr, NrRecs) = 0
then
   begin
   ReportGDXError(PGX, 'gdxDataReadStrStart');
   goto AllDone;
   end;

ReadData;
PGX.gdxDataReadDone;
PGX.gdxClose;
Result := true;
//EXIT
AllDone:
PGX.Free;
end;

label
   AllDone;

const
   fngdxinp = 'demanddata.gdx';

var
   SysDir: string;
   Msg: shortstring;
begin
//GAMS sysdir as the first parameter or use the registry
SysDir := '';
if (ParamCount > 0) and DirectoryExists(ParamStr(1))
then
   SysDir := ParamStr(1);
if SysDir = ''
then
   SysDir := GetSysDir;
if SysDir = ''
then
   SysDir := 'C:\GAMS\win32\24.0';
WriteLn('Sysdir = ', SysDir);

ExitCode := 1; //assume there is a problem loading a library
//Load the GDX library
gdxGetReadyD(SysDir, Msg);
if Msg <> ''
then
   begin
   WriteLn('Cannot load gdx library: ', Msg);
   exit;
   end;

//Load Option processing library
optGetReadyD(SysDir, Msg);
if Msg <> ''
then
   begin
   WriteLn('Cannot load option library: ', Msg);
   exit;
   end;

if not WriteModelData(fngdxinp)
then
   begin
   WriteLn('Model data not written');
   ExitCode := 2;
   goto AllDone;
   end;

if not CallGams(SysDir, '../GAMS/model2.gms')
then
   begin
   WriteLn('Call to GAMS failed');
   ExitCode := 3;
   goto AllDone;
   end;

if not ReadSolutionData('results.gdx')
then
   begin
   WriteLn('Could not read solution back');
   ExitCode := 4;
   goto AllDone;
   end;
ExitCode := 0; //all went well

AllDone:
gdxLibraryUnload;
optLibraryUnload;
//ReadLn;
end.

