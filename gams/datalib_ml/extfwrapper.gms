$if NOT set extflib $abort missing ...   --extflib=fname

$set amax 10

alias (*,NAME,ARGNAME);

Set CD   continuous derivatives  /0,1/
    EQ   no equation use         /0,1/
    AMIN minimum numbers of args /0*%amax%/
    AMAX maximum numbers of args /0*%amax%/
    ARG  argument                /0*%amax%/
    ARGT argument type           /E endogenous, X exogenous/;

$include %extflib%

$if not set Clib    $setglobal Clib 0
$if not set LibCred $setGlobal LibCred GAMS Development Corporation

$onempty
$if not defined ZeroRipple set ZeroRipple(NAME) / /;
$offempty


set fName(NAME)      function name
    fName2(NAME)     function name
    fAMin(NAME,AMIN) function argmin
    fAMax(NAME,AMAX) function argmax;

option fName<f, fName2<f, fAMin<f, fAMax<f;
Scalar cardf; cardf = card(fName);

* Ensure that zero ripple are one arg functions
set errorZR(NAME)  ZR function is not a one arg function
    errorARG(NAME) minarg larger than maxarg;

errorZR (ZeroRipple) = not famin(ZeroRipple,'1') or not famax(ZeroRipple,'1');              abort$card(errorZR)  errorZR;
errorARG(fName)      = sum(fAMin(fName,AMIN), ord(AMIN))>sum(fAMax(fName,AMAX), ord(AMAX)); abort$card(errorARG) errorARG;

alias (AMIN, a);

option fName<f;
* Create "doc" file
file fd / '%LibName%.txt' /; put fd 'Scalar Function Library %LibName%' / '%LibDesc% ' / '%LibCred%' /
put / 'Mod. Function' @40 'Description'
    / 'Type' /;
loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
  if (fName(NAME),
    put$(sameas('1',CD) and sameas('0',EQ)) / ' NLP ';
    put$(sameas('0',CD) and sameas('0',EQ)) / 'DNLP ';
    put$(sameas('1',EQ))                    / 'none ';
    put NAME.tl:0);
  fName(NAME) = no;
  if (not fAMax(NAME,'0'),
    put$sameas('1',ARG)  '('
    put$(ord(ARG)=ord(AMIN)+1) '['
    if (sameas(ARGT,'E'), fd.lcase=1; else fd.lcase=2);
    put$sameas('1',ARG) ARGNAME.tl:0;
    put$(not sameas('1',ARG)) ',' ARGNAME.tl:0;
    fd.lcase=0;
    put$(ord(AMAX)>ord(AMIN) and sameas(AMAX,ARG)) '])';
    put$(ord(AMAX)=ord(AMIN) and sameas(AMAX,ARG)) ')');
  put$sameas(AMAX,ARG) @40 f.te(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT):0;
);
put / / 'Arguments in capital letters need to be exogenous.'

option fName<f;
alias(arg,arg2);

$if %Clib%==1 $goto ClibUse
$if %Flib%==1 $goto FlibUse

* Create QueryLibrary function for Delphi based library
scalar MaxFuncNameLen;

option fName<f;
MaxFuncNameLen = smax(fname(NAME),card(NAME.tl));

file fqld / '%LibName%ql.inc' /; put fqld '// QueryLibrary for %LibName%' /;
$onPut
var
   ws: shortstring;

function QueryLibrary(funcnr, query: integer; var iv: integer; var pv: pchar): integer; stdcall;
const
$offput
put '   NoFunc = ' cardf:0:0 ';' /;
put '   funcSData: array[1..NoFunc, 1..2] of string = (';
loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
  put$fName(NAME) / "      ('" NAME.tl:0 "'," @(MaxFuncNameLen+11) "'" f.te(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT):0 "')," ;
  fName(NAME) = no;
);
put @(fqld.cc-1) ' ';
put / '   );' /;
option fName<f;
put '   FuncData: array[1..NoFunc, 3..7] of integer = (';
loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
  put$fName(NAME) / "      (" EQ.tl:0 ',' CD.tl:0 ',' (1$ZeroRipple(NAME)):0:0 ',' AMIN.tl:0 ',' AMAX.tl:0 "),";
  fName(NAME) = no;
);
put @(fqld.cc-1) ' ';
put / '   );' /;
option fName<f;
put '   EndogData: array[1..NoFunc, 1..' %amax%:0:0 '] of integer = ('
loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
  put$fName(NAME) / "      ("
  if (not fAMax(NAME,'0'),
     put (1$sameas('E',ARGT)):0:0 ',');
  if (sameas(ARG,AMAX), loop(a$(ord(a)>ord(ARG)), put '0,'));
  put$sameas(ARG,AMAX) @(fqld.cc-1) '),';
  fName(NAME) = no;
);
put @(fqld.cc-1) ' ';
put / '   );' /;
option fName<f;
put '   ArgSData: array[1..NoFunc, 1..' %amax%:0:0 '] of string = (';
loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
  put$fName(NAME) / "      ("
  if (not fAMax(NAME,'0'),
    if (sameas(ARGT,'E'), fqld.lcase=1; else fqld.lcase=2);
    put "'" ARGNAME.tl:0 "',";
    fqld.lcase=0;
  );
  if (sameas(ARG,AMAX), loop(a$(ord(a)>ord(ARG)), put "'',"));
  put$sameas(ARG,AMAX) @(fqld.cc-1) '),';
  fName(NAME) = no;
);
put @(fqld.cc-1) ' ';
put / '   );' / /;
$onPutS
   function SReturn(const s: shortstring): PChar;
   begin
   ws := s + #0;
   Result := @ws[1];
   end;

begin
Result := 1; //good return

if funcnr <= 0
then
   begin
   iv := -1;
   pv := SReturn('Bad parameter(s)');
   case query of
      0: begin
         iv := APIVER;
         end;
      1: begin
         iv := LIBVER;
         pv := SReturn('%LibCred%');
         end;
      2: begin
$offPut
put '         iv := NoFunc;' /
put "         pv := SReturn('%LibDesc%');" /
$onPut
         end;
      end;
   exit;
   end;
$offput
put / 'if funcnr in [1..NoFunc]' /
$onPut
then
   begin
   case query of
      1..2: begin
            pv := SReturn(FuncSData[funcnr, query]);
            iv := 0;
            exit;
            end;
      3..7: begin
            iv := FuncData[funcnr, query];
            pv := nil;
            exit;
            end;
$offPut
put '      1001..' (1000+%amax%):0:0 ':' /
$onPut
            begin
            if query-1000 <= FuncData[funcnr,7]        //check against maxargs
            then
               begin
               iv := EndogData[funcnr, query - 1000];
               pv := SReturn(ArgSData[funcnr, query - 1000]);
               end
            else
               Result := 0; // bad return
            exit;
            end;
      end;
   end;

Result := 0; // bad return
end;
$offPut
putclose;

$exit
$label ClibUse

* Create QueryLibrary function for C based library
scalar i;
file fqlc / '%LibName%ql.h' /; put fqlc '/* QueryLibrary for %LibName% */' /;
put '#define NoFunc ' cardf:0:0 /;
$onPutS
%PreU%_API int %PreU%_CALLCONV QueryLibrary(const int funcnr, const int query, int *iv, char **pv)
{
  struct qdrec {
    char *FuncName,
         *FuncExp;
    int  FuncData[5],
         EndoData[%amax%];
    char *ArgSData[%amax%];
$offput
put '  } qd[] = {';

loop(fname2(NAME),
  loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
    put$fName(NAME) / '            "' NAME.tl:0 '", "' f.te(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT):0 '",' EQ.tl:0 ',' CD.tl:0 ',' (1$ZeroRipple(NAME)):0:0 ',' AMIN.tl:0 ',' AMAX.tl:0 ',';
    fName(NAME) = no;
    put$(not sameas(ARG,'0')) (1$sameas('E',ARGT)):0:0 ',';
    if(sameas(AMAX,ARG),
      loop(arg2$(ord(arg2)>ord(amax)),
        put '0,';
      );
    );
  );
  loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
    if (not fAMax(NAME,'0'),
      if (sameas(ARGT,'E'), fqlc.lcase=1; else fqlc.lcase=2);
      put '"' ARGNAME.tl:0 '",';
      fqlc.lcase=0;
    );
    if(sameas(AMAX,ARG),
      loop(arg2$(ord(arg2)>ord(amax)),
        put '"",';
      );
    );
  );
);
put @(fqlc.cc-1) ' '/;
$onPutS
           };

  if(funcnr<=0) {
    *iv = -1;
    *pv = "Bad parameter(s)";
    switch(query) {
      case 0:
        *iv = APIVER;
      break;
      case 1:
        *iv = LIBVER;
        *pv = "%LibCred%";
      break;
      case 2:
$offPut
put '        *iv = NoFunc;' /;
put '        *pv = "%LibDesc%";'/;
$onPut
      break;
    }
  }
$offput
put / '  if(funcnr>=1 && funcnr<=NoFunc) {' /
$onPut
    switch(query) {
      case 1:
        *pv = qd[funcnr-1].FuncName;
        *iv = 0;
      break;
      case 2:
        *pv = qd[funcnr-1].FuncExp;
        *iv = 0;
      break;
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        *pv = NULL;
        *iv = qd[funcnr-1].FuncData[query-3];
      break;
$offPut
for(i=1001 to 1000 + %amax%,
  put '      case ' i:0:0 ':' /;
);
$onPut
        if(query-1001<=qd[funcnr-1].FuncData[4]) {    /* check against maxargs */
          *iv = qd[funcnr-1].EndoData[query - 1001];
          *pv = qd[funcnr-1].ArgSData[query - 1001];
        } else
          return 0;
        break;
    }
  }
  return 1;
};
$offPut
putclose;

$exit
$label FlibUse

* Create QueryLibrary function for (Intel) Fortran based library
file fqlf / '%LibName%ql.f90' /; put fqlf '! QueryLibrary for %LibName%' /;
put '! -----------------------------------------------------------------------------' /
    '      INTEGER FUNCTION QueryLibrary(FUNCNR, QUERY, IV, PV)' /
    '! -----------------------------------------------------------------------------' /
    '        !DEC$ ATTRIBUTES DLLEXPORT              :: QueryLibrary' /
    '        !DEC$ ATTRIBUTES STDCALL                :: QueryLibrary' /
    "        !DEC$ ATTRIBUTES ALIAS : 'querylibrary' :: QueryLibrary" /
    '        !DEC$ ATTRIBUTES REFERENCE              :: IV' /
    '        !DEC$ ATTRIBUTES REFERENCE              :: PV' / /
    '        USE Constants' /
    '        IMPLICIT NONE' / /
    '        INTEGER                     , INTENT(IN)  :: FUNCNR' /
    '        INTEGER                     , INTENT(IN)  :: QUERY' /
    '        INTEGER(KIND=4)             , INTENT(OUT) :: IV' /
    '        CHARACTER(256)              , INTENT(OUT) :: PV' / /
    '        INTEGER NoFunc' /
    '        PARAMETER (NoFunc = ' cardf:0:0 ')' / /
    '        TYPE :: qdrec' /
    '          CHARACTER(LEN=255) :: FuncName' /
    '          CHARACTER(LEN=255) :: FuncExp' /
    '          INTEGER            :: FuncData(5)' /
    '          INTEGER            :: EndoData(%amax%)' /
    '          CHARACTER(LEN=255) :: ArgSData(%amax%)' /
    '        END TYPE qdrec' / /
    '        TYPE(qdrec), DIMENSION(NoFunc) :: qd = &' /
    '                 (/ &';
loop(fname2(NAME),
  loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
    put$fName(NAME) / "                    qdrec('" NAME.tl:0 "', '" f.te(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT):0 "',(/" EQ.tl:0 "," CD.tl:0 "," (1$ZeroRipple(NAME)):0:0 "," AMIN.tl:0 "," AMAX.tl:0 "/),(/";
    fName(NAME) = no;
    put$(not sameas(ARG,'0')) (1$sameas('E',ARGT)):0:0 ",";
    if(sameas(AMAX,ARG),
      loop(arg2$(ord(arg2)>ord(amax)),
        put "0,";
      );
    fqlf.cc = fqlf.cc-1;
    put "/),(/";
    );
  );
  loop(f(NAME,CD,EQ,AMIN,AMAX,ARG,ARGNAME,ARGT),
    if (not fAMax(NAME,'0'),
      if (sameas(ARGT,'E'), fqlf.lcase=1; else fqlf.lcase=2);
      put "'" ARGNAME.tl:0 "',";
      fqlf.lcase=0;
    );
    if(sameas(AMAX,ARG),
      loop(arg2$(ord(arg2)>ord(amax)),
        put "'',";
      );
    fqlf.cc = fqlf.cc-1;
    put "/)), &";
    );
  );
);
fqlf.cc = fqlf.cc-3;
put '  &' /
    '                 /)' / /
    '        IF (FUNCNR <= 0) THEN' /
    '          IV = -1' /
    "          pv = 'Bad parameter(s)'" /
    '          SELECT CASE (QUERY)' /
    '            CASE (0)' /
    '              IV = APIVER' /
    '            CASE (1)' /
    '              IV = LIBVER' /
    "              PV = '%LibCred%'" /
    '            CASE (2)' /
    '              IV = NoFunc' /
    "              PV = '%LibDesc%'" /
    '          END SELECT' /
    '        ENDIF' / /
    '        IF (FUNCNR>=1 .AND. FUNCNR<=NoFunc) THEN' /
    '          SELECT CASE (QUERY)' /
    '            CASE (1)' /
    '              PV = qd(funcnr)%FuncName' /
    '              IV = 0' /
    '            CASE (2)' /
    '              PV = qd(funcnr)%FuncExp' /
    '              IV = 0' /
    '            CASE (3:7)' /
    "              PV = ''" /
    '              IV = qd(funcnr)%FuncData(query-2)' /
    '            CASE (1001:' (1000+%amax%):0:0 ')' /
    '              IF(QUERY-1000<=qd(funcnr)%FuncData(5))  THEN' /
    '                IV = qd(funcnr)%EndoData(query - 1000)' /
    '                PV = qd(funcnr)%ArgSData(query - 1000)' /
    '              ELSE' /
    '                QueryLibrary = 0' /
    '              END IF' /
    '          END SELECT' /
    '        END IF' / /
    '        PV = trim(PV) // char(0)' /
    '        QueryLibrary = 1' /
    '      END FUNCTION' /
    '! -----------------------------------------------------------------------------' / /
    '! -----------------------------------------------------------------------------' /
    '      SUBROUTINE FortranStyle()' /
    '! -----------------------------------------------------------------------------' /
    '!     Dummy function, needs to be exported so that GAMS knows that Fortran' /
    '!     calling convention is required' /
    '        !DEC$ ATTRIBUTES DLLEXPORT              :: FortranStyle' /
    '        !DEC$ ATTRIBUTES STDCALL                :: FortranStyle' /
    "        !DEC$ ATTRIBUTES ALIAS : 'fortranstyle' :: FortranStyle" / /
    '        IMPLICIT NONE' / /
    '      END SUBROUTINE' /
    '! -----------------------------------------------------------------------------' / /
    '! -----------------------------------------------------------------------------' /
    '      INTEGER FUNCTION locCB (RETCODE, EXCCODE, MSG, CB, USERMEM)' /
    '! -----------------------------------------------------------------------------' / /
    '        USE triRec' /
    '        IMPLICIT NONE' / /
    '        INTEGER                     , INTENT(IN)     :: RETCODE' /
    '        INTEGER                     , INTENT(IN)     :: EXCCODE' /
    '        CHARACTER(LEN=*)            , INTENT(IN)     :: MSG' /
    '        INTEGER(KIND=4), EXTERNAL                    :: CB' /
    '        INTEGER(KIND=INT_PTR_KIND()), INTENT(IN)     :: USERMEM' /
    '        CHARACTER(LEN=256)                           :: MSGX' / /
    '        MSGX(1:1) = achar(len(MSG))' /
    '        MSGX(2:len(MSG)+1) = MSG' / /
    '        locCB = CB(%val(RETCODE), %val(EXCCODE), MSGX, %val(USERMEM))' /
    '      END FUNCTION' /
    '! -----------------------------------------------------------------------------' /;

putclose;
