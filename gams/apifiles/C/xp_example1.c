/*
  Use this command to compile the example:
  cl xp_example1.c api/gdxcc.c -Iapi
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "gclgms.h"
#include "gdxcc.h"

static gdxStrIndexPtrs_t Indx;
static gdxStrIndex_t     IndxXXX; 
static gdxValues_t       Values;

void ReportGDXError(gdxHandle_t PGX) {
  char S[GMS_SSSIZE];

  printf("**** Fatal GDX Error\n");
  gdxErrorStr(PGX, gdxGetLastError(PGX), S);
  printf("**** %s\n", S);
  exit(1);
}

void ReportIOError(int N, const char *msg ) {
  printf("**** Fatal I/O Error = %d when calling %s\n",N,msg);
  exit(1);
}

void WriteData(gdxHandle_t PGX, const char *s, const double V) {
  strcpy(Indx[0],s);
  Values[GMS_VAL_LEVEL] = V;
  gdxDataWriteStr(PGX,Indx,Values);
}

int main (int argc, char *argv[]) {

  gdxHandle_t PGX=NULL;
  char        Msg[GMS_SSSIZE];
  char        Producer[GMS_SSSIZE];
  char        Sysdir[GMS_SSSIZE];
  int         ErrNr;
  int         VarNr;
  int         NrRecs;
  int         N;
  int         Dim;
  char        VarName[GMS_SSSIZE];
  int         VarTyp;
  int         D;
  
  if (argc < 2 || argc > 3) {
    printf("**** xp_Example1: incorrect number of parameters\n");
    exit(1);
  }

  if(strlen(argv[1]) >= GMS_SSSIZE) {
    printf("*** Your system directory (argument 1) cannot exceed 255 characters\n");
    exit(1);
  }
  
  strcpy(Sysdir, argv[1]);
  printf("xp_Example1 using GAMS system directory: %s\n", Sysdir);

  if (!gdxCreateD(&PGX, Sysdir, Msg, sizeof(Msg))) {
    printf("**** Could not load GDX library\n");
    printf("**** %s\n", Msg);
    exit(1);
  }

  gdxGetDLLVersion(PGX, Msg);
  printf("Using GDX DLL version: %s\n", Msg);

  GDXSTRINDEXPTRS_INIT(IndxXXX,Indx);

  if (2 == argc) {
    /* Write demand data */
    gdxOpenWrite(PGX, "demanddata.gdx", "xp_example1", &ErrNr);
    if (ErrNr) ReportIOError(ErrNr,"gdxOpenWrite");
    if (!gdxDataWriteStrStart(PGX,"Demand","Demand data",1,GMS_DT_PAR ,0))
      ReportGDXError(PGX);
    WriteData(PGX,"New-York",324.0);
    WriteData(PGX,"Chicago" ,299.0);
    WriteData(PGX,"Topeka"  ,274.0);
    if (!gdxDataWriteDone(PGX)) ReportGDXError(PGX);
    printf("Demand data written by xp_example1\n");
  } else {
    gdxOpenRead(PGX, argv[2], &ErrNr);
    if (ErrNr) ReportIOError(ErrNr,"gdxOpenRead");
    gdxFileVersion(PGX,Msg,Producer);
    printf("GDX file written using version: %s\n",Msg);
    printf("GDX file written by: %s\n",Producer);

    if (!gdxFindSymbol(PGX,"x",&VarNr)) {
      printf("**** Could not find variable X\n");
      exit(1);
    }

    gdxSymbolInfo(PGX,VarNr,VarName,&Dim,&VarTyp);
    if (Dim != 2 || GMS_DT_VAR != VarTyp) {
      printf("**** X is not a two dimensional variable: %d:%d\n",Dim,VarTyp);
      exit(1);
    }

    if (!gdxDataReadStrStart(PGX,VarNr,&NrRecs)) ReportGDXError(PGX);
    printf("Variable X has %d records\n", NrRecs);
    while (gdxDataReadStr(PGX,Indx,Values,&N)) {
      if (0 == Values[GMS_VAL_LEVEL]) continue; /* skip level 0.0 is default */
      for (D=0; D<Dim; D++) printf("%c%s", D? '.':' ', Indx[D]);
      printf(" = %7.2f\n", Values[GMS_VAL_LEVEL]);
    }
    printf("All solution values shown\n");
    gdxDataReadDone(PGX);
  }

  if (ErrNr = gdxClose(PGX)) ReportIOError(ErrNr,"gdxClose");

  if (!gdxFree(&PGX)) {
    printf("Problems unloading the GDX DLL\n");
    exit(1);
  }

  return 0;
} /* main */
