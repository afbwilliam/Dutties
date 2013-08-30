// gdxco.hpp
// Header file for C++-style (object) interface to the GDX library
// generated by apiwrapper for GAMS Version 24.0.2

#if ! defined(_GDXCO_HPP_)
#     define  _GDXCO_HPP_

#define GDXAPIVERSION 7

#if defined(UNICODE) || defined (_UNICODE)
#error Cannot run when UNICODE is defined
#endif

#include "gdxcc.h"
/* standard includes */
#include <string>
#include <cstring>

namespace GAMS {
class GDX
{
public:
  GDX ();                  // default constructor with out init call
  GDX (std::string &msg);  // New object with library loading
  GDX (const std::string &dirname, std::string &msg); // New object with library loading from dirname
  GDX (const std::string &dirname, const std::string &libname, std::string &msg); // New object with library loading from dirname and libraryname
  GDX (gdxHandle_t gdxHandle, std::string &msg); // constructor if we already have a gdxHandle
  GDX (gdxHandle_t gdxHandle, const std::string &dirname, std::string &msg); // constructor if we already have a gdxHandle
  ~GDX ();                 // destructor

  int Init (std::string &msg);
  int Init (const std::string &dirname, std::string &msg);
  int Init (const std::string &dirname, const std::string &libname, std::string &msg);
  int Init (gdxHandle_t gdxHandle, std::string &msg);
  int Init (gdxHandle_t gdxHandle, const std::string &dirname, std::string &msg);
  gdxHandle_t GetHandle ();
  inline int     AcronymAdd (const std::string &AName, const std::string &Txt, int AIndx)
  {  return gdxAcronymAdd (gdxHandle_, AName.c_str(), Txt.c_str(), AIndx);}
  inline int     AcronymCount ()
  {  return gdxAcronymCount (gdxHandle_);}
  inline int     AcronymGetInfo (int N, std::string &AName, std::string &Txt, int &AIndx)
  { int rc=gdxAcronymGetInfo (gdxHandle_, N, tmpS0, tmpS1, &AIndx); AName=tmpS0; Txt=tmpS1; return rc; }
  inline int     AcronymGetMapping (int N, int &orgIndx, int &newIndx, int &autoIndex)
  {  return gdxAcronymGetMapping (gdxHandle_, N, &orgIndx, &newIndx, &autoIndex);}
  inline int     AcronymIndex (double V)
  {  return gdxAcronymIndex (gdxHandle_, V);}
  inline int     AcronymName (double V, std::string &AName)
  { int rc=gdxAcronymName (gdxHandle_, V, tmpS0); AName=tmpS0; return rc; }
  inline int     AcronymNextNr (int NV)
  {  return gdxAcronymNextNr (gdxHandle_, NV);}
  inline int     AcronymSetInfo (int N, const std::string &AName, const std::string &Txt, int AIndx)
  {  return gdxAcronymSetInfo (gdxHandle_, N, AName.c_str(), Txt.c_str(), AIndx);}
  inline double     AcronymValue (int AIndx)
  {  return gdxAcronymValue (gdxHandle_, AIndx);}
  inline int     AddAlias (const std::string &Id1, const std::string &Id2)
  {  return gdxAddAlias (gdxHandle_, Id1.c_str(), Id2.c_str());}
  inline int     AddSetText (const std::string &Txt, int &TxtNr)
  {  return gdxAddSetText (gdxHandle_, Txt.c_str(), &TxtNr);}
  inline int     AutoConvert (int NV)
  {  return gdxAutoConvert (gdxHandle_, NV);}
  inline int     Close ()
  {  return gdxClose (gdxHandle_);}
  inline int     DataErrorCount ()
  {  return gdxDataErrorCount (gdxHandle_);}
  inline int     DataErrorRecord (int RecNr, int KeyInt[], double Values[])
  {  return gdxDataErrorRecord (gdxHandle_, RecNr, KeyInt, Values);}
  inline int     DataReadDone ()
  {  return gdxDataReadDone (gdxHandle_);}
  inline int     DataReadFilteredStart (int SyNr, const int FilterAction[], int &NrRecs)
  {  return gdxDataReadFilteredStart (gdxHandle_, SyNr, FilterAction, &NrRecs);}
  inline int     DataReadMap (int RecNr, int KeyInt[], double Values[], int &DimFrst)
  {  return gdxDataReadMap (gdxHandle_, RecNr, KeyInt, Values, &DimFrst);}
  inline int     DataReadMapStart (int SyNr, int &NrRecs)
  {  return gdxDataReadMapStart (gdxHandle_, SyNr, &NrRecs);}
  inline int     DataReadRaw (int KeyInt[], double Values[], int &DimFrst)
  {  return gdxDataReadRaw (gdxHandle_, KeyInt, Values, &DimFrst);}
  inline int     DataReadRawFast (int SyNr, TDataStoreProc_t DP, int &NrRecs)
  {  return gdxDataReadRawFast (gdxHandle_, SyNr, DP, &NrRecs);}
  inline int     DataReadRawStart (int SyNr, int &NrRecs)
  {  return gdxDataReadRawStart (gdxHandle_, SyNr, &NrRecs);}
  inline int     DataReadSlice (const std::string UelFilterStr[], int &Dimen, TDataStoreProc_t DP)
  {  int sidim = gdxCurrentDim(gdxHandle_); for (int i=0; i<sidim; i++) DP0[i]=UelFilterStr[i].c_str();int rc=gdxDataReadSlice (gdxHandle_, DP0, &Dimen, DP); return rc; }
  inline int     DataReadSliceStart (int SyNr, int ElemCounts[])
  {  return gdxDataReadSliceStart (gdxHandle_, SyNr, ElemCounts);}
  inline int     DataReadStr (std::string KeyStr[], double Values[], int &DimFrst)
  { int rc=gdxDataReadStr (gdxHandle_, DPout, Values, &DimFrst); int sidim = gdxCurrentDim(gdxHandle_);  for (int i=0; i<sidim; i++) KeyStr[i]=DPout[i]; return rc; }
  inline int     DataReadStrStart (int SyNr, int &NrRecs)
  {  return gdxDataReadStrStart (gdxHandle_, SyNr, &NrRecs);}
  inline int     DataSliceUELS (const int SliceKeyInt[], std::string KeyStr[])
  { int rc=gdxDataSliceUELS (gdxHandle_, SliceKeyInt, DPout); int sidim = gdxCurrentDim(gdxHandle_);  for (int i=0; i<sidim; i++) KeyStr[i]=DPout[i]; return rc; }
  inline int     DataWriteDone ()
  {  return gdxDataWriteDone (gdxHandle_);}
  inline int     DataWriteMap (const int KeyInt[], const double Values[])
  {  return gdxDataWriteMap (gdxHandle_, KeyInt, Values);}
  inline int     DataWriteMapStart (const std::string &SyId, const std::string &ExplTxt, int Dimen, int Typ, int UserInfo)
  {  return gdxDataWriteMapStart (gdxHandle_, SyId.c_str(), ExplTxt.c_str(), Dimen, Typ, UserInfo);}
  inline int     DataWriteRaw (const int KeyInt[], const double Values[])
  {  return gdxDataWriteRaw (gdxHandle_, KeyInt, Values);}
  inline int     DataWriteRawStart (const std::string &SyId, const std::string &ExplTxt, int Dimen, int Typ, int UserInfo)
  {  return gdxDataWriteRawStart (gdxHandle_, SyId.c_str(), ExplTxt.c_str(), Dimen, Typ, UserInfo);}
  inline int     DataWriteStr (const std::string KeyStr[], const double Values[])
  {  int sidim = gdxCurrentDim(gdxHandle_); for (int i=0; i<sidim; i++) DP0[i]=KeyStr[i].c_str();int rc=gdxDataWriteStr (gdxHandle_, DP0, Values); return rc; }
  inline int     DataWriteStrStart (const std::string &SyId, const std::string &ExplTxt, int Dimen, int Typ, int UserInfo)
  {  return gdxDataWriteStrStart (gdxHandle_, SyId.c_str(), ExplTxt.c_str(), Dimen, Typ, UserInfo);}
  inline int     GetDLLVersion (std::string &V)
  { int rc=gdxGetDLLVersion (gdxHandle_, tmpS0); V=tmpS0; return rc; }
  inline int     ErrorCount ()
  {  return gdxErrorCount (gdxHandle_);}
  inline int     ErrorStr (int ErrNr, std::string &ErrMsg)
  { int rc=gdxErrorStr (gdxHandle_, ErrNr, tmpS0); ErrMsg=tmpS0; return rc; }
  inline int     FileInfo (int &FileVer, int &ComprLev)
  {  return gdxFileInfo (gdxHandle_, &FileVer, &ComprLev);}
  inline int     FileVersion (std::string &FileStr, std::string &ProduceStr)
  { int rc=gdxFileVersion (gdxHandle_, tmpS0, tmpS1); FileStr=tmpS0; ProduceStr=tmpS1; return rc; }
  inline int     FilterExists (int FilterNr)
  {  return gdxFilterExists (gdxHandle_, FilterNr);}
  inline int     FilterRegister (int UelMap)
  {  return gdxFilterRegister (gdxHandle_, UelMap);}
  inline int     FilterRegisterDone ()
  {  return gdxFilterRegisterDone (gdxHandle_);}
  inline int     FilterRegisterStart (int FilterNr)
  {  return gdxFilterRegisterStart (gdxHandle_, FilterNr);}
  inline int     FindSymbol (const std::string &SyId, int &SyNr)
  {  return gdxFindSymbol (gdxHandle_, SyId.c_str(), &SyNr);}
  inline int     GetElemText (int TxtNr, std::string &Txt, int &Node)
  { int rc=gdxGetElemText (gdxHandle_, TxtNr, tmpS0, &Node); Txt=tmpS0; return rc; }
  inline int     GetLastError ()
  {  return gdxGetLastError (gdxHandle_);}
  inline INT64     GetMemoryUsed ()
  {  return gdxGetMemoryUsed (gdxHandle_);}
  inline int     GetSpecialValues (double AVals[])
  {  return gdxGetSpecialValues (gdxHandle_, AVals);}
  inline int     GetUEL (int UelNr, std::string &Uel)
  { int rc=gdxGetUEL (gdxHandle_, UelNr, tmpS0); Uel=tmpS0; return rc; }
  inline int     MapValue (double D, int &sv)
  {  return gdxMapValue (gdxHandle_, D, &sv);}
  inline int     OpenAppend (const std::string &FileName, const std::string &Producer, int &ErrNr)
  {  return gdxOpenAppend (gdxHandle_, FileName.c_str(), Producer.c_str(), &ErrNr);}
  inline int     OpenRead (const std::string &FileName, int &ErrNr)
  {  return gdxOpenRead (gdxHandle_, FileName.c_str(), &ErrNr);}
  inline int     OpenWrite (const std::string &FileName, const std::string &Producer, int &ErrNr)
  {  return gdxOpenWrite (gdxHandle_, FileName.c_str(), Producer.c_str(), &ErrNr);}
  inline int     OpenWriteEx (const std::string &FileName, const std::string &Producer, int Compr, int &ErrNr)
  {  return gdxOpenWriteEx (gdxHandle_, FileName.c_str(), Producer.c_str(), Compr, &ErrNr);}
  inline int     ResetSpecialValues ()
  {  return gdxResetSpecialValues (gdxHandle_);}
  inline int     SetHasText (int SyNr)
  {  return gdxSetHasText (gdxHandle_, SyNr);}
  inline int     SetReadSpecialValues (const double AVals[])
  {  return gdxSetReadSpecialValues (gdxHandle_, AVals);}
  inline int     SetSpecialValues (const double AVals[])
  {  return gdxSetSpecialValues (gdxHandle_, AVals);}
  inline int     SetTextNodeNr (int TxtNr, int Node)
  {  return gdxSetTextNodeNr (gdxHandle_, TxtNr, Node);}
  inline int     SetTraceLevel (int N, const std::string &s)
  {  return gdxSetTraceLevel (gdxHandle_, N, s.c_str());}
  inline int     SymbIndxMaxLength (int SyNr, int LengthInfo[])
  {  return gdxSymbIndxMaxLength (gdxHandle_, SyNr, LengthInfo);}
  inline int     SymbMaxLength ()
  {  return gdxSymbMaxLength (gdxHandle_);}
  inline int     SymbolAddComment (int SyNr, const std::string &Txt)
  {  return gdxSymbolAddComment (gdxHandle_, SyNr, Txt.c_str());}
  inline int     SymbolGetComment (int SyNr, int N, std::string &Txt)
  { int rc=gdxSymbolGetComment (gdxHandle_, SyNr, N, tmpS0); Txt=tmpS0; return rc; }
  inline int     SymbolGetDomain (int SyNr, int DomainSyNrs[])
  {  return gdxSymbolGetDomain (gdxHandle_, SyNr, DomainSyNrs);}
  inline int     SymbolGetDomainX (int SyNr, std::string DomainIDs[])
  { int rc=gdxSymbolGetDomainX (gdxHandle_, SyNr, DPout); int sidim = gdxSymbolDim(gdxHandle_, SyNr);  for (int i=0; i<sidim; i++) DomainIDs[i]=DPout[i]; return rc; }
  inline int     SymbolDim (int SyNr)
  {  return gdxSymbolDim (gdxHandle_, SyNr);}
  inline int     SymbolInfo (int SyNr, std::string &SyId, int &Dimen, int &Typ)
  { int rc=gdxSymbolInfo (gdxHandle_, SyNr, tmpS0, &Dimen, &Typ); SyId=tmpS0; return rc; }
  inline int     SymbolInfoX (int SyNr, int &RecCnt, int &UserInfo, std::string &ExplTxt)
  { int rc=gdxSymbolInfoX (gdxHandle_, SyNr, &RecCnt, &UserInfo, tmpS0); ExplTxt=tmpS0; return rc; }
  inline int     SymbolSetDomain (const std::string DomainIDs[])
  {  int sidim = gdxCurrentDim(gdxHandle_); for (int i=0; i<sidim; i++) DP0[i]=DomainIDs[i].c_str();int rc=gdxSymbolSetDomain (gdxHandle_, DP0); return rc; }
  inline int     SymbolSetDomainX (int SyNr, const std::string DomainIDs[])
  {  int sidim = gdxSymbolDim(gdxHandle_, SyNr); for (int i=0; i<sidim; i++) DP0[i]=DomainIDs[i].c_str();int rc=gdxSymbolSetDomainX (gdxHandle_, SyNr, DP0); return rc; }
  inline int     SystemInfo (int &SyCnt, int &UelCnt)
  {  return gdxSystemInfo (gdxHandle_, &SyCnt, &UelCnt);}
  inline int     UELMaxLength ()
  {  return gdxUELMaxLength (gdxHandle_);}
  inline int     UELRegisterDone ()
  {  return gdxUELRegisterDone (gdxHandle_);}
  inline int     UELRegisterMap (int UMap, const std::string &Uel)
  {  return gdxUELRegisterMap (gdxHandle_, UMap, Uel.c_str());}
  inline int     UELRegisterMapStart ()
  {  return gdxUELRegisterMapStart (gdxHandle_);}
  inline int     UELRegisterRaw (const std::string &Uel)
  {  return gdxUELRegisterRaw (gdxHandle_, Uel.c_str());}
  inline int     UELRegisterRawStart ()
  {  return gdxUELRegisterRawStart (gdxHandle_);}
  inline int     UELRegisterStr (const std::string &Uel, int &UelNr)
  {  return gdxUELRegisterStr (gdxHandle_, Uel.c_str(), &UelNr);}
  inline int     UELRegisterStrStart ()
  {  return gdxUELRegisterStrStart (gdxHandle_);}
  inline int     UMFindUEL (const std::string &Uel, int &UelNr, int &UelMap)
  {  return gdxUMFindUEL (gdxHandle_, Uel.c_str(), &UelNr, &UelMap);}
  inline int     UMUelGet (int UelNr, std::string &Uel, int &UelMap)
  { int rc=gdxUMUelGet (gdxHandle_, UelNr, tmpS0, &UelMap); Uel=tmpS0; return rc; }
  inline int     UMUelInfo (int &UelCnt, int &HighMap)
  {  return gdxUMUelInfo (gdxHandle_, &UelCnt, &HighMap);}
  inline int     CurrentDim ()
  {  return gdxCurrentDim (gdxHandle_);}
  static int libraryLoad(char *errBuf, int errBufLen);

 private:
  gdxHandle_t gdxHandle_;
  int extHandle;
  static int numInst;
  static int isLoaded;
  static int gdxGetReady (std::string& msg);
  static int gdxGetReady (const std::string& dir, std::string& msg);
  void create();
  void destroy();
  char *DPout[GMS_MAX_INDEX_DIM];
  const char *DP0[GMS_MAX_INDEX_DIM];
  char tmpS0[256], tmpS1[256];
};
};
#endif /* #if ! defined(_GDXCO_HPP_) */