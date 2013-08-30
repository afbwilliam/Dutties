unit gmsgen;

interface
//The following types are not defined in Delphi
//but are used in various units

uses
   gmsspecs;

type
   TCharSet        = set of char;
   TBigIndex       = 0..BigIndex;
   TCharArray      = array[TBigIndex] of char;
   PCharArray      = ^TCharArray;
   DoubleArray     = array[TBigIndex] of double;
   PDoubleArray    = ^DoubleArray;
   DoubleArrayOne  = array[1..BigIndex] of double;
   PDoubleArrayOne = ^DoubleArrayOne;
   PTextFile       = ^TextFile;

   LongIntArray    = array[TBigIndex] of longint;
   PLongIntArray   = ^LongIntArray;

   LongIntArrayOne  = array[1..BIGINDEX] of longint;
   PLongIntArrayOne = ^LongIntArrayOne;


   TBooleanArrayOne = array[1..BigIndex] of boolean;
   PBooleanArrayOne = ^TBooleanArrayOne;

   TByteArrayOne = array[1..BigIndex] of byte;
   PByteArrayOne = ^TByteArrayOne;

   tfileaction = (forRead,forWrite,forAppend);

   TIntegerArrayOne = array[1..BIGINDEX] of integer;
   PIntegerArrayOne = ^TIntegerArrayOne;

implementation

end.
