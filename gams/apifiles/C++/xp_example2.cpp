/*
  Use this command to compile the example:
  cl xp_example2.cpp api/gdxco.cpp ../C/api/gdxcc.c api/optco.cpp ../C/api/optcc.c api/gamsxco.cpp ../C/api/gamsxcc.c -Iapi -I../C/api
*/

/*
 This program performs the following steps:
    1. Generate a gdx file with demand data
    2. Calls GAMS to solve a simple transportation model
       (The GAMS model writes the solution to a gdx file)
    3. The solution is read from the gdx file
*/

#include "gclgms.h"
#include "gamsxco.hpp"
#include "gdxco.hpp"
#include "optco.hpp"

#include <stdio.h>
#include <cstring>
#include <cassert>
#include <iostream>

using namespace std;
using namespace GAMS;

/* GAMSX, GDX, and Option objects */
GAMSX gamsx;
GDX   gdx;
OPT   opt;

#define optSetStrS(os,ov) if (opt.FindStr(os,optNr,optRef)) \
                                    opt.SetValuesNr(optNr,0,0.0,ov)

#define gdxerror(i, s) { gdx.ErrorStr(i, msg); \
                         cout << s << "% failed: " << msg << endl; return 1; }

int WriteModelData(const std::string fngdxfile)
{
  int                status;
  std::string        msg;
  std::string        sp[GMS_MAX_INDEX_DIM];
  gdxValues_t        v;
  
  gdx.OpenWrite(fngdxfile, "xp_Example2", status);
  if (status) 
    gdxerror(status, "gdxOpenWrite");

  if (0==gdx.DataWriteStrStart("Demand", "Demand Data", 1, GMS_DT_PAR, 0)) 
    gdxerror(gdx.GetLastError(), "gdxDataWriteStrStart");
  
  sp[0] = "New-York"; v[GMS_VAL_LEVEL] = 324.0; gdx.DataWriteStr(sp, v);
  sp[0] = "Chicago" ; v[GMS_VAL_LEVEL] = 299.0; gdx.DataWriteStr(sp, v);
  sp[0] = "Topeka"  ; v[GMS_VAL_LEVEL] = 274.0; gdx.DataWriteStr(sp, v);
  
  if (0==gdx.DataWriteDone()) 
    gdxerror(gdx.GetLastError(), "gdxDataWriteDone");

  if (gdx.Close()) 
    gdxerror(gdx.GetLastError(), "gdxClose");
  
  return 0;
}

int CallGams(const std::string sysdir) 
{
  std::string msg, deffile;
  int saveEOLOnly, optNr, optRef;

  deffile = sysdir + "/optgams.def";

  if (opt.ReadDefinition(deffile)) {
    int i, itype;
    for (i=1; i<=opt.MessageCount(); i++) {
      opt.GetMessage(i, msg, itype);
      cout << msg << endl;
    }
    return 1;
  }

  saveEOLOnly = opt.EOLOnlySet(0);  
  opt.ReadFromPChar("I=../GAMS/model2.gms lo=2");
  opt.EOLOnlySet(saveEOLOnly);
  optSetStrS("sysdir", sysdir); 

  if (gamsx.RunExecDLL(opt.GetHandle(), sysdir, 1, msg)) {
    cout << "Could not execute RunExecDLL: " <<  msg << endl;
    return 1;
  }
  
  return 0;
}

int ReadSolutionData(const std::string fngdxfile)
{
  int                status, VarNr, NrRecs, FDim, dim, vartype;
  std::string        msg, VarName;
  std::string        sp[GMS_MAX_INDEX_DIM];
  double             v[GMS_MAX_INDEX_DIM];

  gdx.OpenRead(fngdxfile, status);
  if (status) 
    gdxerror(status, "gdxOpenRead");

  VarName = "result";
  if (0==gdx.FindSymbol(VarName, VarNr)) {
    cout << "Could not find variable >" << VarName << "<" << endl;
    return 1;
  }

  gdx.SymbolInfo(VarNr, VarName, dim, vartype);
  if (2 != dim || GMS_DT_VAR != vartype) {
    cout << VarName << " is not a two dimensional variable" << endl;
    return 1;
  }

  if (0==gdx.DataReadStrStart(VarNr, NrRecs)) 
    gdxerror(gdx.GetLastError(), "gdxDataReadStrStart");

  while (gdx.DataReadStr(sp, v, FDim)) {
    int i;

    if (0.0==v[GMS_VAL_LEVEL]) continue; /* skip level = 0.0 is default */
    for (i=0; i<dim; i++)
      cout << sp[i] << ((i<dim-1)? ".":"");
    cout << " = " << v[GMS_VAL_LEVEL] << endl;
  }
  cout <<  "All solution values shown" << endl;

  gdx.DataReadDone();

  if ((status=gdx.GetLastError())) 
    gdxerror(status, "GDX");
    
  if (gdx.Close()) 
    gdxerror(gdx.GetLastError(), "gdxClose");
  
  return 0;
}

int main (int argc, char *argv[])
{

  int status;
  std::string sysdir, msg; 
  const char defsysdir[] = "c:\\Program Files\\GAMS23.5";

  if (argc > 1) 
    sysdir = argv[1];
  else
    sysdir = defsysdir;

  cout <<  "Loading objects from GAMS system directory: " <<  sysdir << endl;

  /* Create objects */
  if (! gamsx.Init(sysdir, msg)) {
    cout << "Could not create gamsx object: " << msg << endl;
    return 1;
  }

  if (! gdx.Init(sysdir, msg)) {
    cout << "Could not create gdx object: " << msg << endl;
    return 1;
  }

  if (! opt.Init(sysdir, msg)) {
    cout << "Could not create opt object: " << msg << endl;
    return 1;
  }

  if ((status=WriteModelData("demanddata.gdx"))) {
    cout << "Model data not written" << endl;
    goto TERMINATE;
  }

  if ((status=CallGams(sysdir))) {
    cout <<  "Call to GAMS failed" << endl;
    goto TERMINATE;
  }

  if ((status=ReadSolutionData("results.gdx"))) {
    cout << "Could not read solution back" << endl;
    goto TERMINATE;
  }

 TERMINATE:
  return status;
}
