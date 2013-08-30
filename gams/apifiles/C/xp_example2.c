/*
  Use this command to compile the example:
  cl xp_example2.c api/gdxcc.c api/optcc.c api/gamsxcc.c -Iapi
*/

/*
 This program performs the following steps:
    1. Generate a gdx file with demand data
    2. Calls GAMS to solve a simple transportation model
       (The GAMS model writes the solution to a gdx file)
    3. The solution is read from the gdx file
*/

#include "gclgms.h"
#include "gamsxcc.h"
#include "gdxcc.h"
#include "optcc.h"

#include <stdio.h>
#include <string.h>
#include <assert.h>

/* Handles to the GAMSX, GDX, and Option objects */
gamsxHandle_t Gptr=NULL;
gdxHandle_t   Xptr=NULL;
optHandle_t   Optr=NULL;

#define optSetStrS(o,os,ov) if (optFindStr(Optr,os,&optNr,&optRef)) \
                                    optSetValuesNr(Optr,optNr,0,0.0,ov)

#define gdxerror(i, s) { gdxErrorStr(Xptr, i, msg); \
                         printf("%s failed: %s\n",s,msg); return 1; }

int WriteModelData(const char *fngdxfile)
{
  int                status;
  char               msg[GMS_SSSIZE];
  gdxStrIndex_t      strIndex;
  gdxStrIndexPtrs_t  sp;
  gdxValues_t        v;

  assert(Xptr);
  gdxOpenWrite(Xptr, fngdxfile, "xp_Example2", &status);
  if (status)
    gdxerror(status, "gdxOpenWrite");

  if (0==gdxDataWriteStrStart(Xptr, "Demand", "Demand Data", 1, GMS_DT_PAR, 0))
    gdxerror(gdxGetLastError(Xptr), "gdxDataWriteStrStart");

  /* Initalize some GDX data structure */
  GDXSTRINDEXPTRS_INIT(strIndex,sp);
  strcpy(sp[0], "New-York"); v[GMS_VAL_LEVEL] = 324.0; gdxDataWriteStr(Xptr, (const char **)sp, v);
  strcpy(sp[0], "Chicago" ); v[GMS_VAL_LEVEL] = 299.0; gdxDataWriteStr(Xptr, (const char **)sp, v);
  strcpy(sp[0], "Topeka"  ); v[GMS_VAL_LEVEL] = 274.0; gdxDataWriteStr(Xptr, (const char **)sp, v);

  if (0==gdxDataWriteDone(Xptr))
    gdxerror(gdxGetLastError(Xptr), "gdxDataWriteDone");

  if (gdxClose(Xptr))
    gdxerror(gdxGetLastError(Xptr), "gdxClose");

  return 0;
}

int CallGams(const char *sysdir)
{
  char msg[GMS_SSSIZE], deffile[GMS_SSSIZE];
  int saveEOLOnly, optNr, optRef;

  assert(Gptr); assert(Optr);
  strncpy(deffile, sysdir, sizeof(deffile));
  strncat(deffile, "/optgams.def", sizeof(deffile));

  if (optReadDefinition(Optr,deffile)) {
    int i, itype;
    for (i=1; i<=optMessageCount(Optr); i++) {
      optGetMessage(Optr, i, msg, &itype);
      printf("%s\n", msg);
    }
    return 1;
  }

  saveEOLOnly = optEOLOnlySet(Optr,0);
  optReadFromPChar(Optr, "I=../GAMS/model2.gms lo=2");
  optEOLOnlySet(Optr,saveEOLOnly);
  optSetStrS(Optr,"sysdir", sysdir);

  if (gamsxRunExecDLL(Gptr, Optr, sysdir, 1, msg)) {
    printf ("Could not execute RunExecDLL: %s", msg);
    return 1;
  }

  return 0;
}

int ReadSolutionData(const char *fngdxfile)
{
  int                status, VarNr, NrRecs, FDim, dim, vartype;
  char               msg[GMS_SSSIZE], VarName[GMS_SSSIZE];
  gdxStrIndex_t      strIndex;
  gdxStrIndexPtrs_t  sp;
  gdxValues_t        v;

  assert(Xptr);
  gdxOpenRead(Xptr, fngdxfile, &status);
  if (status)
    gdxerror(status, "gdxOpenRead");

  strcpy(VarName, "result");
  if (0==gdxFindSymbol(Xptr, VarName, &VarNr)) {
    printf("Could not find variable >%s<\n", VarName);
    return 1;
  }

  gdxSymbolInfo(Xptr, VarNr, VarName, &dim, &vartype);
  if (2 != dim || GMS_DT_VAR != vartype) {
    printf("%s is not a two dimensional variable\n", VarName);
    return 1;
  }

  if (0==gdxDataReadStrStart(Xptr, VarNr, &NrRecs))
    gdxerror(gdxGetLastError(Xptr), "gdxDataReadStrStart");

  /* Initalize some GDX data structure */
  GDXSTRINDEXPTRS_INIT(strIndex,sp);

  while (gdxDataReadStr(Xptr, sp, v, &FDim)) {
    int i;

    if (0.0==v[GMS_VAL_LEVEL]) continue; /* skip level = 0.0 is default */
    for (i=0; i<dim; i++)
      printf("%s%s", sp[i],(i<dim-1)? ".":"");
    printf(" = %g\n",v[GMS_VAL_LEVEL]);
  }
  printf("All solution values shown\n");

  gdxDataReadDone(Xptr);

  if ((status=gdxGetLastError(Xptr)))
    gdxerror(status, "GDX");

  if (gdxClose(Xptr))
    gdxerror(gdxGetLastError(Xptr), "gdxClose");

  return 0;
}

int main (int argc, char *argv[])
{

  int        status;
  char       sysdir[GMS_SSSIZE], msg[GMS_SSSIZE];
  const char defsysdir[] = "c:\\Program Files\\GAMS23.5";


  if (argc > 1) {
    if(strlen(argv[1]) >= GMS_SSSIZE) {
      printf("*** Your system directory (argument 1) cannot exceed 255 characters\n");
      exit(1);
    }
    strncpy(sysdir, argv[1], sizeof(sysdir));
  }  
  else
    strncpy(sysdir, defsysdir, sizeof(sysdir));

  printf("Loading objects from GAMS system directory: %s\n", sysdir);

  /* Create objects */
  if (! gamsxCreateD (&Gptr, sysdir, msg, sizeof(msg))) {
    printf("Could not create gamsx object: %s\n", msg);
    return 1;
  }

  if (! gdxCreateD (&Xptr, sysdir, msg, sizeof(msg))) {
    printf("Could not create gdx object: %s\n", msg);
    return 1;
  }

  if (! optCreateD (&Optr, sysdir, msg, sizeof(msg))) {
    printf("Could not create opt object: %s\n", msg);
    return 1;
  }

  if ((status=WriteModelData("demanddata.gdx"))) {
    printf("Model data not written\n");
    goto TERMINATE;
  }

  if ((status=CallGams(sysdir))) {
    printf("Call to GAMS failed\n");
    goto TERMINATE;
  }

  if ((status=ReadSolutionData("results.gdx"))) {
    printf("Could not read solution back\n");
    goto TERMINATE;
  }

 TERMINATE:
  optFree(&Optr);
  gdxFree(&Xptr);
  gamsxFree(&Gptr);

  return status;
}
