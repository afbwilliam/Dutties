unit gxdefs;
// Description:
//  used by gxfile.pas and any program needing
//  the constants and types for using the gdxio.dll

{$A+ use aligned records}
{$H- short strings}

interface

uses
   gmsspecs;

const
   DOMC_UNMAPPED = -2;        // Indicator for an unmapped index position
   DOMC_EXPAND   = -1;        // Indicator for a growing index position
   DOMC_STRICT   =  0;        // Indicator for a mapped index position

type
   PGXFile = pointer;  // Pointer to a GDX data structure

   TgdxUELIndex    = gmsspecs.TIndex   ; // Array type for an index using integers
   TgdxStrIndex    = gmsspecs.TStrIndex; // Array type for an index using strings

   TgdxValues      = gmsspecs.tvarreca; // Array type for passing values

   TgdxSVals       = array[TgdxSpecialValue] of double; // Array type for passing special values

   TDataStoreProc  = procedure (const Indx: TgdxUELIndex; const Vals: TgdxValues); stdcall; // call back function
   // for reading data slice

const

   gdxDataTypStr : array[TgdxDataType] of string[5] = (
      'Set','Par','Var','Equ', 'Alias');

   gdxDataTypStrL : array[TgdxDataType] of string[9] = (
      'Set','Parameter','Variable','Equation', 'Alias');

   DataTypSize: array[TgdxDataType] of integer = (1,1,5,5, 0);

   gdxSpecialValuesStr: array[TgdxSpecialValue] of string[5] = (
     'Undef' {sv_valund },
     'NA'    {sv_valna  },
     '+Inf'  {sv_valpin },
     '-Inf'  {sv_valmin },
     'Eps'   {sv_valeps },
     '0'     {sv_normal },
     'AcroN' {acronym   });


implementation

end.
