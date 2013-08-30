unit gmsspecs;

{$h- short string sonly  }

interface

const
   MaxNameLen        = 63;   //starting version 149
   MaxDim            = 20;

   MaxNameLenV148    = 31;   //values before they changed in Ver149
   MaxDimV148        = 10;

   BigIndex          = 10000000;  //BigIndex  = (Maxint div 16 - 1);    too large for some Unix compilers
   MAXALGO           = 150;       // maximum number of solver that can be stored
   MAXEVALTHREADS    = 16;

type
   tdimension    = 0..MaxDim;
   TgdxDimension = 1..MaxDim;
   TIndex        = array[TgdxDimension] of integer;
   TStrIndex     = array[TgdxDimension] of shortstring;
   PTIndex       = ^TIndex;

const

// old values up to 133
old_valund: double =  1.0E30;   // undefined
old_valna : double =  2.0E30;   // not available/applicable
old_valpin: double =  3.0E30;   // plus infinity
old_valmin: double =  4.0E30;   // minus infinity
old_valeps: double =  5.0E30;   // epsilon
old_valacr: double = 10.0E30;   // potential/real acronym

// new values starting with 134
valund: double =  1.0E300;   // undefined
valna : double =  2.0E300;   // not available/applicable
valpin: double =  3.0E300;   // plus infinity
valmin: double =  4.0E300;   // minus infinity
valeps: double =  5.0E300;   // epsilon
valacr: double = 10.0E300;   // potential/real acronym

valnaint : integer =  2100000000;  // not available/applicable

// we go slow, once everything works with valiup = +inf
// we can remove valiup
valiup  : double =   3.0E300;   // upper bound for integers
valbig  : double =   1.0E299;   // big positive number
valsmall: double =  -1.0E299;   // big negative number
valtiny : double =   1.0E-250;  // everything smaller could be zero

defiterlim: double = 2.0E9;   //default iterlim

type
   TgdxSpecialValue = (
      sv_valund,       // 0: Undefined
      sv_valna,        // 1: Not Available
      sv_valpin,       // 2: Positive Infinity
      sv_valmin,       // 3: Negative Infinity
      sv_valeps,       // 4: Epsilon
      sv_normal,       // 5: Normal Value
      sv_acronym       // 6: Acronym base value
      );
// Brief:
//   Enumerated type for special values
// Description:
//   This enumerated type can be used in a Delphi program directly;
//   Programs using the DLL should use the integer values instead
//   This avoids passing enums

   TgdxDataType = (
      dt_set,          // 0: Set
      dt_par,          // 1: Parameter
      dt_var,          // 2: Variable
      dt_equ,          // 3: Equation
      dt_alias         // 4: Aliased set
      );
// Brief:
//  Enumerated type for GAMS data types
// Description:
//  This enumerated type can be used in a Delphi program directly;
//  Programs using the DLL should use the integer values instead
//  This avoids passing enums

const gms_sv_valund  = 0;  { TgdxSpecialValue }
      gms_sv_valna   = 1;
      gms_sv_valpin  = 2;
      gms_sv_valmin  = 3;
      gms_sv_valeps  = 4;
      gms_sv_normal  = 5;
      gms_sv_acronym = 6;

const gms_dt_set   = 0;  { TgdxDataType }
      gms_dt_par   = 1;
      gms_dt_var   = 2;
      gms_dt_equ   = 3;
      gms_dt_alias = 4;

type

   tgmsvalue  = (xvreal,          xvund,xvna,xvpin,xvmin,xveps,xvacr);
   txgmsvalue = (vneg,vzero,vpos ,vund ,vna ,vpin ,vmin ,veps ,vacr );

function mapval (x: double): tgmsvalue;
function xmapval(x: double): txgmsvalue;


type
   tvarstyp = (stypunknwn,                 stypbin   ,stypint   ,styppos   , stypneg  , stypfre ,stypsos1   ,stypsos2  ,stypsemi  , stypsemiint);

const
   varstypX: set of tvarstyp = [                                 styppos   , stypneg  , stypfre                                                ];
   varstypI: set of tvarstyp = [           stypbin   ,stypint                                   ,stypsos1   ,stypsos2  ,stypsemi  , stypsemiint];

const
   varstyptxt: array[tvarstyp] of string[8]
            = ('unknown ','binary  ','integer ','positive','negative','free    ','sos1    ','sos2    ','semicont','semiint ');

type

   tequstyp   = (styeque   ,styequg   ,styequl    ,styequn   ,styequx, styequc, styequb );

var
   equstypInfo: array[tequstyp] of integer;  // initialized in gmsglob.pas using tssymbol

type
//                   1        2          3       4         5
   tvarvaltype= (vallevel,valmarginal,vallower,valupper,valscale);

   tvarreca   = array[tvarvaltype] of double;

const
   sufftxt: array[tvarvaltype] of string[5] =('L', 'M', 'LO', 'UP', 'SCALE');


const

   nlconst_one       =  1;
   nlconst_ten       =  2;
   nlconst_tenth     =  3;
   nlconst_quarter   =  4;
   nlconst_half      =  5;
   nlconst_two       =  6;
   nlconst_four      =  7;
   nlconst_zero      =  8;
   nlconst_oosqrt2pi =  9;   // 1/sqrt(2*pi)
   nlconst_ooln10    = 10;   // 1/ln(10)
   nlconst_ooln2     = 11;   // 1/ln(2)
   nlconst_pi        = 12;   // pi
   nlconst_pihalf    = 13;   // pi/2
   nlconst_Sqrt2     = 14;   // sqrt(2)
   nlconst_three     = 15;
   nlconst_five      = 16;

// use constants for now, should be global type

const equ_E = 0;
      equ_G = 1;
      equ_L = 2;
      equ_N = 3;
      equ_X = 4;
      equ_C = 5;
      equ_B = 6;

const equstyp : array[0..6] of string[5] = ( ' =E= ',
                                             ' =G= ',
                                             ' =L= ',
                                             ' =N= ',
                                             ' =X= ',
                                             ' =C= ',
                                             ' =B= ');

const equctyp: array[0..6] of Char = ( 'E','G','L','N','X','C','B');

const var_X  = 0;
      var_B  = 1;
      var_I  = 2;
      var_S1 = 3;
      var_S2 = 4;
      var_SC = 5;
      var_SI = 6;

const varstyp : array[0..6] of string[3] = ( 'x'  ,
                                             'b'  ,
                                             'i'  ,
                                             's1s',
                                             's2s',
                                             'sc' ,
                                             'si' );

const var_X_F = 0;  // free
      var_X_N = 1;  // negative
      var_X_P = 2;  // positive

const Bstat_Lower = 0;
      Bstat_Upper = 1;
      Bstat_Basic = 2;
      Bstat_Super = 3;

const Cstat_OK     = 0;
      Cstat_NonOpt = 1;
      Cstat_Infeas = 2;
      Cstat_UnBnd  = 3;

// matches gcgetgamsopt
const  gamsopt_Cheat      =  1;
       gamsopt_CutOff     =  2;
       gamsopt_IterLim    =  3;
       gamsopt_NodLim     =  4;
       gamsopt_OptCA      =  5;
       gamsopt_OptCR      =  6;
       gamsopt_ResLim     =  7;
       gamsopt_Reform     =  8;
       gamsopt_TryInt     =  9;
       gamsopt_Integer1   = 10;
       gamsopt_Integer2   = 11;
       gamsopt_Integer3   = 12;
       gamsopt_Integer4   = 13;
       gamsopt_Integer5   = 14;
       gamsopt_Real1      = 15;
       gamsopt_Real2      = 16;
       gamsopt_Real3      = 17;
       gamsopt_Real4      = 18;
       gamsopt_Real5      = 19;
       gamsopt_Workfactor = 20;
       gamsopt_Workspace  = 21;

{  solver and modelstatus and triggers }

const
numsolm    = 13; (* number of solver status messages *)
nummodm    = 19; (* number of model status messages *)

// one more ugly stuff 4/09 AM
numsolprint  = 2; // followoing three from 0..numxxxx
numhandlestat= 3;
numsolvelink = 5;

solprinttxt: array[0..numsolprint] of string [9] = (
                 '0 Summary',
                 '1 Report',
                 '2 Quiet' );

handlestattxt: array[0..numhandlestat] of string [9] = (
                 '0 Unknown',
                 '1 Running',
                 '2 Ready',
                 '3 Failure');

solvelinktxt: array[0..numsolvelink] of string [16] = (
                 '0 Chain Script',
                 '1 Call Script',
                 '2 Call Module',
                 '3 Async Grid',
                 '4 Async Simulate',
                 '5 Load Library');

solvestatustxt: array[1..numsolm] of string[28] = (
                 '1 Normal Completion         ',
                 '2 Iteration Interrupt       ',
                 '3 Resource Interrupt        ',
                 '4 Terminated By Solver      ',
                 '5 Evaluation Interrupt      ',
                 '6 Capability Problems       ',
                 '7 Licensing Problems        ',
                 '8 User Interrupt            ',
                 '9 Setup Failure             ',
                 '10 Solver Failure           ',
                 '11 Internal Solver Failure  ',
                 '12 Solve Processing Skipped ',
                 '13 System Failure           ');

modelstatustxt: array[1..nummodm] of string[28] = (
                 '1 Optimal                   ',
                 '2 Locally Optimal           ',
                 '3 Unbounded                 ',
                 '4 Infeasible                ',
                 '5 Locally Infeasible        ',
                 '6 Intermediate Infeasible   ',
                 '7 Intermediate Nonoptimal   ',
                 '8 Integer Solution          ',
                 '9 Intermediate Non-Integer  ',
                 '10 Integer Infeasible       ',
                 '11 Licensing Problem        ',
                 '12 Error Unknown            ',
                 '13 Error No Solution        ',
                 '14 No Solution Returned     ',
                 '15 Solved Unique            ',
                 '16 Solved                   ',
                 '17 Solved Singular          ',
                 '18 Unbounded - No Solution  ',
                 '19 Infeasible - No Solution ');

// *trigger will cause the status file to be listed vernatim
solvetrigger: array[1..numsolm] of integer = (0,0,0,0,0,0,0,0,0,1,1,0,1);
                                             {1 2 3 4 5 6 7 8 9 0 1 2 3}

modeltrigger: array[1..nummodm] of integer = (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0);
                                             {1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9}

// expect complete solutuion
modelsolution:array[1..nummodm] of integer = (1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,0,0);
                                             {1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9}

type

tjac    = ^tjacrec;   { Jacobian element - row/col chain }
tjacrec = record
          coef    : double;
          nextrow : tjac;
          nextNLrow : tjac;
          nextcol : tjac;
          row     : longint;
          col     : longint;
          NL      : boolean;
          end;

tjacPtr    = array[1..BigIndex] of tjac;         tptrjacPtr    = ^tjacPtr;

bndset = (bndF  // -inf +inf
         ,bndB  //  lo   up
         ,bndL  //  lo  +inf
         ,bndU  // -inf  up
         ,bndE  //   lo=up
         );

{ M length arrays }

tequtype    = array[1..BigIndex] of longint;   tptrequtype    = ^tequtype   ;
trhs        = array[1..BigIndex] of double ;   tptrrhs        = ^trhs       ;
tequm       = array[1..BigIndex] of double ;   tptrequm       = ^tequm      ;
tequbas     = array[1..BigIndex] of boolean;   tptrequbas     = ^tequbas    ;
tequl       = array[1..BigIndex] of double ;   tptrequl       = ^tequl      ;
tequstat    = array[1..BigIndex] of integer;   tptrequstat    = ^tequstat   ;
tequcstat   = array[1..BigIndex] of integer;   tptrequctat    = ^tequstat   ;
tequmatch   = array[1..BigIndex] of longint;   tptrequmatch   = ^tequmatch  ;
tnlstart    = array[1..BigIndex] of longint;   tptrnlstart    = ^tnlstart   ;
tnlend      = array[1..BigIndex] of longint;   tptrnlend      = ^tnlend     ;
tnlfstart   = array[1..BigIndex] of longint;   tptrnlfstart   = ^tnlfstart  ;
tnlfend     = array[1..BigIndex] of longint;   tptrnlfend     = ^tnlfend    ;
tequnz      = array[1..BigIndex] of longint;   tptrequnz      = ^tequnz     ;
tequnlnz    = array[1..BigIndex] of longint;   tptrequnlnz    = ^tequnlnz   ;
tequnextNL  = array[1..BigIndex] of longint;   tptrequnextNL  = ^tequnextNL ;
tequfirst   = array[1..BigIndex] of tjac   ;   tptrequfirst   = ^tequfirst  ;
tequfirstNL = array[1..BigIndex] of tjac   ;   tptrequfirstNL = ^tequfirstNL;
tequlast    = array[1..BigIndex] of tjac   ;   tptrequlast    = ^tequlast   ;
tequlastNL  = array[1..BigIndex] of tjac   ;   tptrequlastNL  = ^tequlastNL ;
tequscale   = array[1..BigIndex] of double ;   tptrequscale   = ^tequscale  ;
tequperm    = array[1..BigIndex] of longint;   tptrequperm    = ^tequperm   ;

{ N length arrays }

tvartype    = array[1..BigIndex] of longint;   tptrvartype    = ^tvartype   ;
tvarlo      = array[1..BigIndex] of double ;   tptrvarlo      = ^tvarlo     ;
tvarl       = array[1..BigIndex] of double ;   tptrvarl       = ^tvarl      ;
tvarup      = array[1..BigIndex] of double ;   tptrvarup      = ^tvarup     ;
tvarm       = array[1..BigIndex] of double ;   tptrvarm       = ^tvarm      ;
tvarbas     = array[1..BigIndex] of boolean;   tptrvarbas     = ^tvarbas    ;
tvarbnd     = array[1..BigIndex] of bndset ;   tptrvarbnd     = ^tvarbnd    ;
tvarstat    = array[1..BigIndex] of integer;   tptrvarstat    = ^tvarstat   ;
tvarcstat   = array[1..BigIndex] of integer;   tptrvarcstat   = ^tvarstat   ;
tvarsos     = array[1..BigIndex] of longint;   tptrvarsos     = ^tvarsos    ;
tprior      = array[1..BigIndex] of double ;   tptrprior      = ^tprior     ;
tvarfirst   = array[1..BigIndex] of tjac   ;   tptrvarfirst   = ^tvarfirst  ;
tvarlast    = array[1..BigIndex] of tjac   ;   tptrvarlast    = ^tvarlast   ;
tvarscale   = array[1..BigIndex] of double ;   tptrvarscale   = ^tvarscale  ;
tvarperm    = array[1..BigIndex] of longint;   tptrvarperm    = ^tvarperm   ;
tvarnz      = array[1..BigIndex] of longint;   tptrvarnz      = ^tvarnz     ;
tvarnlnz    = array[1..BigIndex] of longint;   tptrvarnlnz    = ^tvarnlnz   ;
tvarmatch   = array[1..BigIndex] of longint;   tptrvarmatch   = ^tvarmatch  ;
tvarcluster = array[1..BigIndex] of longint;   tptrvarcluster = ^tvarcluster;

function old_new_val(x: double): double;

implementation

function mapval (x: double): tgmsvalue;

var
  k: longint;
begin

if x < valund
then
   begin
   result := xvreal;
   exit;
   end;

if x >= valacr
then
   result := xvacr
else
   begin
   x := x/valund;
   k := round(x);
   if abs(k - x) > 1.0e-5
   then
      result := xvund
   else
      case k of
      1:   result := xvund;
      2:   result := xvna ;
      3:   result := xvpin;
      4:   result := xvmin;
      5:   result := xveps;
      else result := xvacr;
      end;
   end;
end;

function xmapval(x: double): txgmsvalue;
begin
if x < valund
then
   if x < 0
   then
      result := vneg
   else
      if x = 0
      then
         result := vzero
      else
         result := vpos
else
   result :=  txgmsvalue(ord(mapval(x)) + 2);
end;


function old_new_val(x: double): double;
var
  k: longint;
begin

if x < old_valund
then
   begin
   result := x;
   exit;
   end;

if x >= old_valacr
then
   begin
   k := round(x/old_valacr);
   result := valacr*k;
   exit;
   end;

x := x/old_valund;
k := round(x);
if abs(k - x) > 1.0e-5
then
   result := valund
else
   case k of
   1:   result := valund;
   2:   result := valna ;
   3:   result := valpin;
   4:   result := valmin;
   5:   result := valeps;
   else result := valund;
   end;

end;

begin

end.
