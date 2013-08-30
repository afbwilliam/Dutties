unit gamsxdcpdef; { Delphi procedure wrapper generated by apiwrapper for GAMS Version 24.0.2 }
{ Function interface using a DLL, pure Delphi }

{$P- no open parameters ==> no maxlen byte}
{$V+ force var strings}
{$H- short only }

interface

uses
   sysutils,
   Windows,
   gmsgen,
   gxdefs;

type
   TErrorCallback = function(ErrCount:Integer; const Msg:ShortString):Integer; stdcall;
   TBrkPCallBack1 = function (const fn: ShortString; linNr: Integer; lstNr: Integer; usrMem: Pointer): Integer; stdcall;
   TBrkPCallBack2 = function (const fn: ShortString; linNr: Integer; lstNr: Integer; userMem1: Pointer; userMem2: Pointer): Integer; stdcall;

//tries to load DLL from OS default location
//name for the DLL is automatic
function  gamsxGetReady(var Msg: ShortString): boolean;
//tries to load DLL from main program directory; if that fails
//loads DLL from OS default location
//name for the DLL is automatic
function  gamsxGetReadyX(var Msg: ShortString): boolean;
//loads DLL from specified directory
//name for the DLL is automatic
function gamsxGetReadyD(const Dir: ShortString; var Msg: ShortString): boolean;
//loads DLL from the full path specified
//no changes are made to the name (platform and file extension)
function gamsxGetReadyL(const LibName: ShortString; var Msg: ShortString): boolean;

//tries to load DLL from OS default location
//name for the DLL is automatic
function gamsxCreate(var pgamsx: pointer; var Msg: ShortString): boolean;
//tries to load DLL from main program directory; if that fails
//loads DLL from OS default location
//name for the DLL is automatic
function gamsxCreateX(var pgamsx: pointer; var Msg: ShortString): boolean;
//loads DLL from specified directory
//name for the DLL is automatic
function gamsxCreateD(var pgamsx: pointer; const Dir: ShortString; var Msg: shortString): boolean;
//loads DLL from the full path specified
function gamsxCreateL(var pgamsx: pointer; const LibName: ShortString; var Msg: shortString): boolean;

//returns a handle
function  gamsxGetHandle(pgamsx: pointer): pointer;

procedure gamsxFree  (var pgamsx: pointer);
procedure gamsxLibraryUnload;
function  gamsxLibraryLoaded: boolean;

function  gamsxGetScreenIndicator: boolean;
procedure gamsxSetScreenIndicator(const ScrInd: boolean);
function  gamsxGetExceptionIndicator: boolean;
procedure gamsxSetExceptionIndicator(const ExcInd: boolean);
function  gamsxGetExitIndicator: boolean;
procedure gamsxSetExitIndicator(const ExtInd: boolean);
function  gamsxGetErrorCount: Integer;
procedure gamsxSetErrorCount(const ecnt: Integer);
function  gamsxGetErrorCallback: TErrorCallback;
procedure gamsxSetErrorCallback(ecb: TErrorCallback);
procedure gamsxErrorHandling(const Msg: ShortString);

function  gamsxFuncLoaded(address: pointer): boolean;

// functions and procedures
var gamsxInitialize : procedure; stdcall;
var gamsxFinalize   : procedure; stdcall;
var gamsxRunExecDLL       : function (pgamsx: pointer; optPtr: Pointer; const sysDir: ShortString; AVerbose: Integer; out Msg: ShortString): Integer; stdcall;
var gamsxAddBreakPoint    : procedure(pgamsx: pointer; const fn: ShortString; lineNr: Integer); stdcall;
var gamsxClearBreakPoints : procedure(pgamsx: pointer); stdcall;
var gamsxSystemInfo       : function (pgamsx: pointer; var NrSy: Integer; var NrUel: Integer): Integer; stdcall;
var gamsxSymbolInfo       : function (pgamsx: pointer; SyNr: Integer; out SyName: ShortString; out SyExplTxt: ShortString; var SyDim: Integer; var SyTyp: Integer; var SyCount: Integer; var SyUserInfo: Integer): Integer; stdcall;
var gamsxFindSymbol       : function (pgamsx: pointer; const SyName: ShortString): Integer; stdcall;
var gamsxDataReadRawStart : function (pgamsx: pointer; SyNr: Integer; var SyCount: Integer): Integer; stdcall;
var gamsxDataReadRaw      : function (pgamsx: pointer; var Elements: TgdxUELIndex; var Vals: TgdxValues; var FDim: Integer): Integer; stdcall;
var gamsxDataReadDone     : function (pgamsx: pointer): Integer; stdcall;
var gamsxDataWriteRaw     : function (pgamsx: pointer; const Elements: TgdxUELIndex; const Vals: TgdxValues): Integer; stdcall;
var gamsxDataWriteDone    : function (pgamsx: pointer): Integer; stdcall;
var gamsxRegisterCB1      : procedure(pgamsx: pointer; CB1: TBrkPCallBack1; userMem: Pointer); stdcall;
var gamsxRegisterCB2      : procedure(pgamsx: pointer; CB2: TBrkPCallBack2; userMem1: Pointer; userMem2: Pointer); stdcall;
var gamsxGetCB1           : function (pgamsx: pointer): TBrkPCallBack1; stdcall;
var gamsxGetCB2           : function (pgamsx: pointer): TBrkPCallBack2; stdcall;
var gamsxGetCB1UM         : function (pgamsx: pointer): Pointer; stdcall;
var gamsxGetCB2UM1        : function (pgamsx: pointer): Pointer; stdcall;
var gamsxGetCB2UM2        : function (pgamsx: pointer): Pointer; stdcall;

// properties as functions and procedures
var gamsxSWSet         : procedure (pgamsx: pointer; const x: Integer); stdcall;

Function  gamsxShowError(pgamsx: pointer; const fNameLog: ShortString; out errorLine: ShortString; out errorTyp: ShortString; out gmsLine: ShortString): Boolean; stdcall;
Function  gamsxUelName(pgamsx: pointer; uel: Integer): ShortString; stdcall;
Function  gamsxDataWriteRawStart(pgamsx: pointer; SyNr: Integer; const DoMerge: Boolean): Integer; stdcall;
Function  gamsxStepThrough(pgamsx: pointer): Boolean; stdcall;
Procedure gamsxStepThroughSet(pgamsx: pointer; const x: Boolean); stdcall;
Function  gamsxRunToEnd(pgamsx: pointer): Boolean; stdcall;
Procedure gamsxRunToEndSet(pgamsx: pointer; const x: Boolean); stdcall;
Function  gamsxCB1Defined(pgamsx: pointer): Boolean; stdcall;
Function  gamsxCB2Defined(pgamsx: pointer): Boolean; stdcall;
implementation

const
   APIVersion     = 1;
   DLLWrapsObject = true;
   Debug          = false;
{$IFDEF VER130}
// From Delphi7 system, sysutils units
   PathDelim  = {$IFDEF MSWINDOWS} '\'; {$ELSE} '/'; {$ENDIF}

type
   IntegerArray  = array[0..$effffff] of Integer;
   PIntegerArray = ^IntegerArray;

function ExcludeTrailingPathDelimiter(const S: string): string;
begin
Result := S;
if IsPathDelimiter(Result, Length(Result))
then
   SetLength(Result, Length(Result)-1);
end;
{$ENDIF}

var
   LibHandle         : THandle;
   LibFileName       : ShortString;
   ScreenIndicator   : Boolean = true;
   ExceptionIndicator: Boolean = false;
   ExitIndicator     : Boolean = true;
   ObjectCount       : Integer = 0;
   APIErrorCount     : Integer = 0;
   ErrorCallback     : TErrorCallback = nil;

var XCreate: procedure (var pgamsx: pointer); stdcall;
var XFree  : procedure (var pgamsx: pointer); stdcall;

var XAPIVersion: function (const api: integer; var msg: ShortString; var comp: Integer): Integer; stdcall;
var XCheck: function (const funcn: shortString; const NrArg: integer; const sign: PIntegerArray; var msg: ShortString): Integer; stdcall;

var bool_gamsxShowError: function (pgamsx: pointer; const fNameLog: ShortString; out errorLine: ShortString; out errorTyp: ShortString; out gmsLine: ShortString): Integer; stdcall;
var sst_gamsxUelName: procedure(pgamsx: pointer; uel: Integer; var sst_result: ShortString); stdcall;
var bool_gamsxDataWriteRawStart: function (pgamsx: pointer; SyNr: Integer; const DoMerge: Integer): Integer; stdcall;
var bool_gamsxStepThrough: function  (pgamsx: pointer): Integer; stdcall;
var bool_gamsxStepThroughSet: procedure  (pgamsx: pointer; const x: Integer); stdcall;
var bool_gamsxRunToEnd: function  (pgamsx: pointer): Integer; stdcall;
var bool_gamsxRunToEndSet: procedure  (pgamsx: pointer; const x: Integer); stdcall;
var bool_gamsxCB1Defined: function  (pgamsx: pointer): Integer; stdcall;
var bool_gamsxCB2Defined: function  (pgamsx: pointer): Integer; stdcall;

Function  d_gamsxRunExecDLL(pgamsx: pointer; optPtr: Pointer; const sysDir: ShortString; AVerbose: Integer; out Msg: ShortString): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..4] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 1;d_sign[2] := 11;d_sign[3] := 3;d_sign[4] := 12;
XCheck('gamsxRunExecDLL', 4, @d_sign, d_Msg);
gamsxErrorHandling('gamsxRunExecDLL could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxShowError(pgamsx: pointer; const fNameLog: ShortString; out errorLine: ShortString; out errorTyp: ShortString; out gmsLine: ShortString): Boolean; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..4] of Integer;
begin
d_sign[0] := 15;d_sign[1] := 11;d_sign[2] := 12;d_sign[3] := 12;d_sign[4] := 12;
XCheck('gamsxShowError', 4, @d_sign, d_Msg);
gamsxErrorHandling('gamsxShowError could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := true;
end;

Procedure d_gamsxAddBreakPoint(pgamsx: pointer; const fn: ShortString; lineNr: Integer); stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..2] of Integer;
begin
d_sign[0] := 0;d_sign[1] := 11;d_sign[2] := 3;
XCheck('gamsxAddBreakPoint', 2, @d_sign, d_Msg);
gamsxErrorHandling('gamsxAddBreakPoint could not be loaded from ' + LibFileName + ': ' + d_Msg);
end;

Procedure d_gamsxClearBreakPoints(pgamsx: pointer); stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 0;
XCheck('gamsxClearBreakPoints', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxClearBreakPoints could not be loaded from ' + LibFileName + ': ' + d_Msg);
end;

Function  d_gamsxSystemInfo(pgamsx: pointer; var NrSy: Integer; var NrUel: Integer): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..2] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 21;d_sign[2] := 21;
XCheck('gamsxSystemInfo', 2, @d_sign, d_Msg);
gamsxErrorHandling('gamsxSystemInfo could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxSymbolInfo(pgamsx: pointer; SyNr: Integer; out SyName: ShortString; out SyExplTxt: ShortString; var SyDim: Integer; var SyTyp: Integer; var SyCount: Integer; var SyUserInfo: Integer): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..7] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 3;d_sign[2] := 12;d_sign[3] := 12;d_sign[4] := 21;d_sign[5] := 21;d_sign[6] := 21;d_sign[7] := 21;
XCheck('gamsxSymbolInfo', 7, @d_sign, d_Msg);
gamsxErrorHandling('gamsxSymbolInfo could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxUelName(pgamsx: pointer; uel: Integer): ShortString; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..1] of Integer;
begin
d_sign[0] := 12;d_sign[1] := 3;
XCheck('gamsxUelName', 1, @d_sign, d_Msg);
gamsxErrorHandling('gamsxUelName could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := ' ';
end;

Function  d_gamsxFindSymbol(pgamsx: pointer; const SyName: ShortString): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..1] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 11;
XCheck('gamsxFindSymbol', 1, @d_sign, d_Msg);
gamsxErrorHandling('gamsxFindSymbol could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxDataReadRawStart(pgamsx: pointer; SyNr: Integer; var SyCount: Integer): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..2] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 3;d_sign[2] := 21;
XCheck('gamsxDataReadRawStart', 2, @d_sign, d_Msg);
gamsxErrorHandling('gamsxDataReadRawStart could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxDataReadRaw(pgamsx: pointer; var Elements: TgdxUELIndex; var Vals: TgdxValues; var FDim: Integer): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..3] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 52;d_sign[2] := 54;d_sign[3] := 21;
XCheck('gamsxDataReadRaw', 3, @d_sign, d_Msg);
gamsxErrorHandling('gamsxDataReadRaw could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxDataReadDone(pgamsx: pointer): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 3;
XCheck('gamsxDataReadDone', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxDataReadDone could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxDataWriteRawStart(pgamsx: pointer; SyNr: Integer; const DoMerge: Boolean): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..2] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 3;d_sign[2] := 15;
XCheck('gamsxDataWriteRawStart', 2, @d_sign, d_Msg);
gamsxErrorHandling('gamsxDataWriteRawStart could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxDataWriteRaw(pgamsx: pointer; const Elements: TgdxUELIndex; const Vals: TgdxValues): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..2] of Integer;
begin
d_sign[0] := 3;d_sign[1] := 51;d_sign[2] := 53;
XCheck('gamsxDataWriteRaw', 2, @d_sign, d_Msg);
gamsxErrorHandling('gamsxDataWriteRaw could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Function  d_gamsxDataWriteDone(pgamsx: pointer): Integer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 3;
XCheck('gamsxDataWriteDone', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxDataWriteDone could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := 0;
end;

Procedure d_gamsxRegisterCB1(pgamsx: pointer; CB1: TBrkPCallBack1; userMem: Pointer); stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..2] of Integer;
begin
d_sign[0] := 0;d_sign[1] := 59;d_sign[2] := 1;
XCheck('gamsxRegisterCB1', 2, @d_sign, d_Msg);
gamsxErrorHandling('gamsxRegisterCB1 could not be loaded from ' + LibFileName + ': ' + d_Msg);
end;

Procedure d_gamsxRegisterCB2(pgamsx: pointer; CB2: TBrkPCallBack2; userMem1: Pointer; userMem2: Pointer); stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..3] of Integer;
begin
d_sign[0] := 0;d_sign[1] := 59;d_sign[2] := 1;d_sign[3] := 1;
XCheck('gamsxRegisterCB2', 3, @d_sign, d_Msg);
gamsxErrorHandling('gamsxRegisterCB2 could not be loaded from ' + LibFileName + ': ' + d_Msg);
end;

Function  d_gamsxGetCB1(pgamsx: pointer):TBrkPCallBack1; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 59;
XCheck('gamsxGetCB1', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxGetCB1 could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := nil;
end;

Function  d_gamsxGetCB2(pgamsx: pointer):TBrkPCallBack2; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 59;
XCheck('gamsxGetCB2', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxGetCB2 could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := nil;
end;

Function  d_gamsxGetCB1UM(pgamsx: pointer): Pointer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 1;
XCheck('gamsxGetCB1UM', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxGetCB1UM could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := nil;
end;

Function  d_gamsxGetCB2UM1(pgamsx: pointer): Pointer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 1;
XCheck('gamsxGetCB2UM1', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxGetCB2UM1 could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := nil;
end;

Function  d_gamsxGetCB2UM2(pgamsx: pointer): Pointer; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 1;
XCheck('gamsxGetCB2UM2', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxGetCB2UM2 could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := nil;
end;

Procedure d_gamsxSWSet(pgamsx: pointer; const x: Integer); stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..1] of Integer;
begin
d_sign[0] := 0; d_sign[1] := 3;
XCheck('gamsxSWSet', 1, @d_sign, d_Msg);
gamsxErrorHandling('gamsxSWSet could not be loaded from ' + LibFileName + ': ' + d_Msg);
end;

Function  d_gamsxStepThrough(pgamsx: pointer): Boolean; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 15;
XCheck('gamsxStepThrough', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxStepThrough could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := true;
end;

Procedure d_gamsxStepThroughSet(pgamsx: pointer; const x: Boolean); stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..1] of Integer;
begin
d_sign[0] := 0; d_sign[1] := 15;
XCheck('gamsxStepThroughSet', 1, @d_sign, d_Msg);
gamsxErrorHandling('gamsxStepThroughSet could not be loaded from ' + LibFileName + ': ' + d_Msg);
end;

Function  d_gamsxRunToEnd(pgamsx: pointer): Boolean; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 15;
XCheck('gamsxRunToEnd', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxRunToEnd could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := true;
end;

Procedure d_gamsxRunToEndSet(pgamsx: pointer; const x: Boolean); stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..1] of Integer;
begin
d_sign[0] := 0; d_sign[1] := 15;
XCheck('gamsxRunToEndSet', 1, @d_sign, d_Msg);
gamsxErrorHandling('gamsxRunToEndSet could not be loaded from ' + LibFileName + ': ' + d_Msg);
end;

Function  d_gamsxCB1Defined(pgamsx: pointer): Boolean; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 15;
XCheck('gamsxCB1Defined', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxCB1Defined could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := true;
end;

Function  d_gamsxCB2Defined(pgamsx: pointer): Boolean; stdcall;
var
   d_Msg: ShortString;
   d_sign : Array[0..0] of Integer;
begin
d_sign[0] := 15;
XCheck('gamsxCB2Defined', 0, @d_sign, d_Msg);
gamsxErrorHandling('gamsxCB2Defined could not be loaded from ' + LibFileName + ': ' + d_Msg);
Result := true;
end;

function  gamsxShowError(pgamsx: pointer; const fNameLog: ShortString; out errorLine: ShortString; out errorTyp: ShortString; out gmsLine: ShortString): Boolean; stdcall;
begin
result := bool_gamsxShowError(pgamsx, fNameLog, errorLine, errorTyp, gmsLine) <> 0;
end;

function  gamsxUelName(pgamsx: pointer; uel: Integer): ShortString; stdcall;
begin
sst_gamsxUelName(pgamsx, uel, result);
end;

function  gamsxDataWriteRawStart(pgamsx: pointer; SyNr: Integer; const DoMerge: Boolean): Integer; stdcall;
begin
result := bool_gamsxDataWriteRawStart(pgamsx, SyNr, Integer(DoMerge));
end;

Function gamsxStepThrough(pgamsx: pointer): Boolean; stdcall;
begin
result := bool_gamsxStepThrough(pgamsx) <> 0;
end;

Procedure gamsxStepThroughSet(pgamsx: pointer; const x: Boolean); stdcall;
begin
bool_gamsxStepThroughSet(pgamsx, Integer(x));
end;

Function gamsxRunToEnd(pgamsx: pointer): Boolean; stdcall;
begin
result := bool_gamsxRunToEnd(pgamsx) <> 0;
end;

Procedure gamsxRunToEndSet(pgamsx: pointer; const x: Boolean); stdcall;
begin
bool_gamsxRunToEndSet(pgamsx, Integer(x));
end;

Function gamsxCB1Defined(pgamsx: pointer): Boolean; stdcall;
begin
result := bool_gamsxCB1Defined(pgamsx) <> 0;
end;

Function gamsxCB2Defined(pgamsx: pointer): Boolean; stdcall;
begin
result := bool_gamsxCB2Defined(pgamsx) <> 0;
end;

function  gamsxGetScreenIndicator: boolean;
begin
Result := ScreenIndicator;
end;

procedure gamsxSetScreenIndicator(const ScrInd: boolean);
begin
ScreenIndicator := ScrInd;
end;

function  gamsxGetExceptionIndicator: boolean;
begin
Result := ExceptionIndicator;
end;

procedure gamsxSetExceptionIndicator(const ExcInd: boolean);
begin
ExceptionIndicator := ExcInd;
end;

function  gamsxGetExitIndicator: boolean;
begin
Result := ExitIndicator;
end;

procedure gamsxSetExitIndicator(const ExtInd: boolean);
begin
ExitIndicator := ExtInd;
end;

function  gamsxGetErrorCount: Integer;
begin
Result := APIErrorCount;
end;

procedure gamsxSetErrorCount(const ecnt: Integer);
begin
APIErrorCount := ecnt;
end;

function  gamsxGetErrorCallback: TErrorCallback;
begin
Result := @ErrorCallback;
end;

procedure gamsxSetErrorCallback(ecb: TErrorCallback);
begin
ErrorCallback := ecb;
end;

Procedure gamsxErrorHandling(const Msg: ShortString);
begin
inc(APIErrorCount);
if ScreenIndicator then begin writeln(Msg); flush(output); end;
assert(not ExceptionIndicator, Msg);
if (@ErrorCallback <> nil) and (ErrorCallback(APIErrorCount, Msg) <> 0) then halt(123);
if ExitIndicator then halt(123);
end;

const NoOfEntryPts = 28;
var AddrOfFuncLoaded: Array[1..NoOfEntryPts] of Pointer;

function gamsxFuncLoaded(address: pointer): boolean;
var
   cnt: Integer;
begin
result := false;
for cnt:=1 to NoOfEntryPts
do if address = AddrOfFuncLoaded[cnt]
   then
      begin
      result := true;
      break;
      end;
end;

function XLibraryLoad(var LoadMsg: ShortString): boolean;
var
   comp: Integer;
   sign: Array[0..7] of Integer;
   funcCount: Integer;

   function LoadEntry(const Name: ShortString; const NoArgs: Integer; const d_x: Pointer): pointer;
   var
      NameX: Ansistring;
   begin
   Result := nil;
   if (comp >= 0) then inc(funcCount);
   if (comp < 0) or (XCheck(Name, NoArgs, @sign, LoadMsg) > 0)
   then
      begin
      NameX := LowerCase(Name);
      Result := GetProcAddress(LibHandle, PAnsiChar(NameX));
      if Result = nil
      then
         begin
         NameX := Name;
         Result := GetProcAddress(LibHandle, PAnsiChar(NameX));
         end;
      if Result = nil
      then
         begin
         NameX := UpperCase(Name);
         Result := GetProcAddress(LibHandle, PAnsiChar(NameX));
         end;
      if Result = nil
      then
         LoadMsg := 'Entry not found: ' + Name + ' in ' + LibFileName;
      end;
   if (comp >= 0) then AddrOfFuncLoaded[funcCount] := Result;
   if Result = nil
   then
      Result := d_x;
   if Debug and (LoadMsg <> '') then gamsxErrorHandling(LoadMsg);
   end;

var
{$IF RTLVersion < 20}      //versions before Delphi2009
   LibFileNameX: AnsiString;
{$ELSE}
   LibFileNameX: WideString;
{$IFEND}
begin
Result  := false;
LoadMsg := '';
if LibHandle <> 0
then
   begin
   Result := true;
   exit;
   end;

LibFileNameX := LibFileName;
{$IF RTLVersion < 20}
LibHandle := LoadLibrary(PAnsiChar(LibFileNameX));
{$ELSE}
LibHandle := LoadLibrary(PWideChar(LibFileNameX));
{$IFEND}
if LibHandle = 0
then
   begin
   LoadMsg := 'Cannot load library ' + LibFileName;
   exit;
   end;

comp := -1;
funcCount := 0;
LoadMsg := '';  //not an error
if DLLWrapsObject
then
   begin
   @XCreate := LoadEntry('XCreate', 0, nil);
   if @XCreate = nil then exit;
   @XFree   := LoadEntry('XFree', 0, nil);
   if @XFree = nil then exit;
   end;
@XCheck := LoadEntry('XCheck', 0, nil);
if @XCheck = nil then exit;
@XAPIVersion := LoadEntry('XAPIVersion', 0, nil);
if @XAPIVersion = nil then exit;

@gamsxInitialize := LoadEntry('gamsxInitialize', 0, nil);
@gamsxFinalize   := LoadEntry('gamsxFinalize', 0, nil);
if @gamsxInitialize <> nil then gamsxInitialize;
if (XAPIVersion(APIversion, LoadMsg, comp) = 0)
then
   exit;

funcCount := 0;
sign[0] := 3;sign[1] := 1;sign[2] := 11;sign[3] := 3;sign[4] := 12;
@gamsxRunExecDLL := LoadEntry('gamsxRunExecDLL', 4, @d_gamsxRunExecDLL);
sign[0] := 15;sign[1] := 11;sign[2] := 12;sign[3] := 12;sign[4] := 12;
@bool_gamsxShowError := LoadEntry('gamsxShowError', 4, @d_gamsxShowError);
sign[0] := 0;sign[1] := 11;sign[2] := 3;
@gamsxAddBreakPoint := LoadEntry('gamsxAddBreakPoint', 2, @d_gamsxAddBreakPoint);
sign[0] := 0;
@gamsxClearBreakPoints := LoadEntry('gamsxClearBreakPoints', 0, @d_gamsxClearBreakPoints);
sign[0] := 3;sign[1] := 21;sign[2] := 21;
@gamsxSystemInfo := LoadEntry('gamsxSystemInfo', 2, @d_gamsxSystemInfo);
sign[0] := 3;sign[1] := 3;sign[2] := 12;sign[3] := 12;sign[4] := 21;sign[5] := 21;sign[6] := 21;sign[7] := 21;
@gamsxSymbolInfo := LoadEntry('gamsxSymbolInfo', 7, @d_gamsxSymbolInfo);
sign[0] := 12;sign[1] := 3;
@sst_gamsxUelName := LoadEntry('gamsxUelName', 1, @d_gamsxUelName);
sign[0] := 3;sign[1] := 11;
@gamsxFindSymbol := LoadEntry('gamsxFindSymbol', 1, @d_gamsxFindSymbol);
sign[0] := 3;sign[1] := 3;sign[2] := 21;
@gamsxDataReadRawStart := LoadEntry('gamsxDataReadRawStart', 2, @d_gamsxDataReadRawStart);
sign[0] := 3;sign[1] := 52;sign[2] := 54;sign[3] := 21;
@gamsxDataReadRaw := LoadEntry('gamsxDataReadRaw', 3, @d_gamsxDataReadRaw);
sign[0] := 3;
@gamsxDataReadDone := LoadEntry('gamsxDataReadDone', 0, @d_gamsxDataReadDone);
sign[0] := 3;sign[1] := 3;sign[2] := 15;
@bool_gamsxDataWriteRawStart := LoadEntry('gamsxDataWriteRawStart', 2, @d_gamsxDataWriteRawStart);
sign[0] := 3;sign[1] := 51;sign[2] := 53;
@gamsxDataWriteRaw := LoadEntry('gamsxDataWriteRaw', 2, @d_gamsxDataWriteRaw);
sign[0] := 3;
@gamsxDataWriteDone := LoadEntry('gamsxDataWriteDone', 0, @d_gamsxDataWriteDone);
sign[0] := 0;sign[1] := 59;sign[2] := 1;
@gamsxRegisterCB1 := LoadEntry('gamsxRegisterCB1', 2, @d_gamsxRegisterCB1);
sign[0] := 0;sign[1] := 59;sign[2] := 1;sign[3] := 1;
@gamsxRegisterCB2 := LoadEntry('gamsxRegisterCB2', 3, @d_gamsxRegisterCB2);
sign[0] := 59;
@gamsxGetCB1 := LoadEntry('gamsxGetCB1', 0, @d_gamsxGetCB1);
sign[0] := 59;
@gamsxGetCB2 := LoadEntry('gamsxGetCB2', 0, @d_gamsxGetCB2);
sign[0] := 1;
@gamsxGetCB1UM := LoadEntry('gamsxGetCB1UM', 0, @d_gamsxGetCB1UM);
sign[0] := 1;
@gamsxGetCB2UM1 := LoadEntry('gamsxGetCB2UM1', 0, @d_gamsxGetCB2UM1);
sign[0] := 1;
@gamsxGetCB2UM2 := LoadEntry('gamsxGetCB2UM2', 0, @d_gamsxGetCB2UM2);
sign[0] := 0; sign[1] := 3;
@gamsxSWSet := LoadEntry('gamsxSWSet', 1, @d_gamsxSWSet);
sign[0] := 15;
@bool_gamsxStepThrough := LoadEntry('gamsxStepThrough', 0, @d_gamsxStepThrough);
sign[0] := 0; sign[1] := 15;
@bool_gamsxStepThroughSet := LoadEntry('gamsxStepThroughSet', 1, @d_gamsxStepThroughSet);
sign[0] := 15;
@bool_gamsxRunToEnd := LoadEntry('gamsxRunToEnd', 0, @d_gamsxRunToEnd);
sign[0] := 0; sign[1] := 15;
@bool_gamsxRunToEndSet := LoadEntry('gamsxRunToEndSet', 1, @d_gamsxRunToEndSet);
sign[0] := 15;
@bool_gamsxCB1Defined := LoadEntry('gamsxCB1Defined', 0, @d_gamsxCB1Defined);
sign[0] := 15;
@bool_gamsxCB2Defined := LoadEntry('gamsxCB2Defined', 0, @d_gamsxCB2Defined);
Result := true;
end;

procedure XLibraryUnload;
begin
if LibHandle <> 0
then
   begin
   if @gamsxFinalize <> nil
   then
      gamsxFinalize;

   FreeLibrary(LibHandle);
   LibHandle := 0;
   end;

@XCreate                     := nil;
@XFree                       := nil;
@gamsxInitialize             := nil;
@gamsxFinalize               := nil;
@gamsxRunExecDLL             := nil;
@bool_gamsxShowError         := nil;
@gamsxAddBreakPoint          := nil;
@gamsxClearBreakPoints       := nil;
@gamsxSystemInfo             := nil;
@gamsxSymbolInfo             := nil;
@sst_gamsxUelName            := nil;
@gamsxFindSymbol             := nil;
@gamsxDataReadRawStart       := nil;
@gamsxDataReadRaw            := nil;
@gamsxDataReadDone           := nil;
@bool_gamsxDataWriteRawStart := nil;
@gamsxDataWriteRaw           := nil;
@gamsxDataWriteDone          := nil;
@gamsxRegisterCB1            := nil;
@gamsxRegisterCB2            := nil;
@gamsxGetCB1                 := nil;
@gamsxGetCB2                 := nil;
@gamsxGetCB1UM               := nil;
@gamsxGetCB2UM1              := nil;
@gamsxGetCB2UM2              := nil;
@gamsxSWSet                     := nil;
@bool_gamsxStepThrough          := nil;
@bool_gamsxStepThroughSet       := nil;
@bool_gamsxRunToEnd             := nil;
@bool_gamsxRunToEndSet          := nil;
@bool_gamsxCB1Defined           := nil;
@bool_gamsxCB2Defined           := nil;
end;

function LibLoader(const Path, Name: ShortString; var Msg: ShortString): boolean;
var
   xName  : ShortString;
   xPath  : ShortString;
begin
if Name <> ''
then
   xName := Name
else
   xName := 'gamsxdclib.dll';
if Path = ''
then
   begin
   xPath       := '';
   LibFileName := xName
   end
else
   begin
   xPath       := ExcludeTrailingPathDelimiter(Path);
   LibFileName := xPath + PathDelim + xName;
   end;

Result := XLibraryLoad(Msg);
end;

function gamsxGetReady(var Msg: ShortString): boolean;
begin
if LibHandle = 0
then
   Result := LibLoader('', '', Msg)
else
   begin
   Msg := '';
   Result := true
   end;
end;

function gamsxGetReadyX(var Msg: ShortString): boolean;
begin
if LibHandle = 0
then
   begin
   Result := LibLoader(ExtractFilePath(ParamStr(0)), '', Msg);
   if LibHandle = 0
   then
      Result := LibLoader('', '', Msg);
   end
else
   begin
   Msg := '';
   Result := true
   end;
end;

function gamsxGetReadyD(const Dir: ShortString; var Msg: ShortString): boolean;
begin
if LibHandle = 0
then
   Result := LibLoader(Dir, '', Msg)
else
   begin
   Msg := '';
   Result := true
   end;
end;

function gamsxGetReadyL(const LibName: ShortString; var Msg: ShortString): boolean;
begin
if LibHandle = 0
then
   Result := LibLoader(ExtractFilePath(LibName), ExtractFileName(LibName), Msg)
else
   begin
   Msg := '';
   Result := true
   end;
end;

function  gamsxGetHandle(pgamsx: pointer): pointer;
begin
Result := pgamsx;
end;

function gamsxCreate(var pgamsx: pointer; var Msg: ShortString): boolean;
begin
Assert(DLLWrapsObject, 'gamsxdcpdef.gamsxCreate without an Object');
Result := gamsxGetReady(Msg);
if Result
then
   begin
   XCreate(pgamsx);
   if pgamsx = nil
   then
      begin
      Result := false;
      Msg := 'Library is loaded but error while creating object';
      end
   else
      inc(ObjectCount);
   end
else
   begin
   pgamsx := nil;
   if Msg = '' then Msg := 'Unknown error';
   end;
end;

function gamsxCreateX(var pgamsx: pointer; var Msg: ShortString): boolean;
begin
Assert(DLLWrapsObject, 'gamsxdcpdef.gamsxCreate without an Object');
Result := gamsxGetReadyX(Msg);
if Result
then
   begin
   XCreate(pgamsx);
   if pgamsx = nil
   then
      begin
      Result := false;
      Msg := 'Library is loaded but error while creating object';
      end
   else
      inc(ObjectCount);
   end
else
   begin
   pgamsx := nil;
   if Msg = '' then Msg := 'Unknown error';
   end;
end;

function gamsxCreateD(var pgamsx: pointer; const Dir: ShortString; var Msg: shortString): boolean;
begin
Assert(DLLWrapsObject, 'gamsxdcpdef.gamsxCreateD without an Object');
Result := gamsxGetReadyD(Dir, Msg);
if Result
then
   begin
   XCreate(pgamsx);
   if pgamsx = nil
   then
      begin
      Result := false;
      Msg := 'Library is loaded but error while creating object';
      end
   else
      inc(ObjectCount);
   end
else
   begin
   pgamsx := nil;
   if Msg = '' then Msg := 'Unknown error';
   end;
end;

function gamsxCreateL(var pgamsx: pointer; const LibName: ShortString; var Msg: shortString): boolean;
begin
Assert(DLLWrapsObject, 'gamsxdcpdef.gamsxCreateL without an Object');
Result := gamsxGetReadyL(LibName, Msg);
if Result
then
   begin
   XCreate(pgamsx);
   if pgamsx = nil
   then
      begin
      Result := false;
      Msg := 'Library is loaded but error while creating object';
      end
   else
      inc(ObjectCount);
   end
else
   begin
   pgamsx := nil;
   if Msg = '' then Msg := 'Unknown error';
   end;
end;

procedure gamsxFree  (var pgamsx: pointer);
begin
if @XFree <> nil
then
   begin
   XFree(pgamsx); pgamsx := nil;
   dec(ObjectCount);
   end;
end;

function gamsxLibraryLoaded: boolean;
begin
Result := LibHandle <> 0;
end;

procedure gamsxLibraryUnload;
begin
if LibHandle <> 0
then
   begin
   if ObjectCount<>0
   then
      begin
      writeln('Could not unload library, object not freed.');
      exit;
      end;
   XLibraryUnload;
   end;
end;

initialization

Libhandle := 0;
XLibraryUnload;

end.