/* gmdcc.h
 * Header file for C-style interface to the GMD library
 * generated by apiwrapper for GAMS Version 24.0.2
 */

#if ! defined(_GMDCC_H_)
#     define  _GMDCC_H_

#define GMDAPIVERSION 1


enum gmdActionType {
  GMD_PARAM  = 0,
  GMD_UPPER  = 1,
  GMD_LOWER  = 2,
  GMD_FIXED  = 3,
  GMD_PRIMAL = 4,
  GMD_DUAL   = 5  };

enum gmdUpdateType {
  GMD_DEFAULT    = 0,
  GMD_BASECASE   = 1,
  GMD_ACCUMULATE = 2  };

enum gmdInfoX {
  GMD_NRSYMBOLS = 0,
  GMD_NRUELS    = 1  };

enum gmdSymInfo {
  GMD_NAME      = 0,
  GMD_DIM       = 1,
  GMD_TYPE      = 2,
  GMD_NRRECORDS = 3,
  GMD_USERINFO  = 4,
  GMD_EXPLTEXT  = 5  };

#include "gclgms.h"

#if defined(_WIN32)
# define GMD_CALLCONV __stdcall
#else
# define GMD_CALLCONV
#endif

#if defined(__cplusplus)
extern "C" {
#endif

struct gmdRec;
typedef struct gmdRec *gmdHandle_t;

typedef int (*gmdErrorCallback_t) (int ErrCount, const char *msg);

/* headers for "wrapper" routines implemented in C */
int gmdGetReady  (char *msgBuf, int msgBufLen);
int gmdGetReadyD (const char *dirName, char *msgBuf, int msgBufLen);
int gmdGetReadyL (const char *libName, char *msgBuf, int msgBufLen);
int gmdCreate    (gmdHandle_t *pgmd, char *msgBuf, int msgBufLen);
int gmdCreateD   (gmdHandle_t *pgmd, const char *dirName, char *msgBuf, int msgBufLen);
int gmdCreateDD  (gmdHandle_t *pgmd, const char *dirName, char *msgBuf, int msgBufLen);
int gmdCreateL   (gmdHandle_t *pgmd, const char *libName, char *msgBuf, int msgBufLen);
int gmdFree      (gmdHandle_t *pgmd);

int gmdLibraryLoaded(void);
int gmdLibraryUnload(void);

int  gmdGetScreenIndicator   (void);
void gmdSetScreenIndicator   (int scrind);
int  gmdGetExceptionIndicator(void);
void gmdSetExceptionIndicator(int excind);
int  gmdGetExitIndicator     (void);
void gmdSetExitIndicator     (int extind);
gmdErrorCallback_t gmdGetErrorCallback(void);
void gmdSetErrorCallback(gmdErrorCallback_t func);
int  gmdGetAPIErrorCount     (void);
void gmdSetAPIErrorCount     (int ecnt);

void gmdErrorHandling(const char *msg);
void gmdInitMutexes(void);
void gmdFiniMutexes(void);


#if defined(GMD_MAIN)    /* we must define some things only once */
# define GMD_FUNCPTR(NAME)  NAME##_t NAME = NULL
#else
# define GMD_FUNCPTR(NAME)  extern NAME##_t NAME
#endif


/* Prototypes for Dummy Functions */
int  GMD_CALLCONV d_gmdInitFromGDX (gmdHandle_t pgmd, const char *fileName);
int  GMD_CALLCONV d_gmdInitFromDict (gmdHandle_t pgmd, void *gmoPtr, char *msg);
int  GMD_CALLCONV d_gmdCloseGDX (gmdHandle_t pgmd, int loadRemain);
void * GMD_CALLCONV d_gmdAddSymbol (gmdHandle_t pgmd, const char *symName, int aDim, int type, int userInfo, const char *explText);
void * GMD_CALLCONV d_gmdFindSymbol (gmdHandle_t pgmd, const char *symName);
void * GMD_CALLCONV d_gmdGetSymbolByIndex (gmdHandle_t pgmd, int idx);
int  GMD_CALLCONV d_gmdClearSymbol (gmdHandle_t pgmd, void *symPtr);
int  GMD_CALLCONV d_gmdCopySymbol (gmdHandle_t pgmd, void *tarSymPtr, void *srcSymPtr, char *msg);
void * GMD_CALLCONV d_gmdFindRecord (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
void * GMD_CALLCONV d_gmdFindFirstRecord (gmdHandle_t pgmd, void *symPtr);
void * GMD_CALLCONV d_gmdFindFirstRecordSlice (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
void * GMD_CALLCONV d_gmdFindLastRecord (gmdHandle_t pgmd, void *symPtr);
void * GMD_CALLCONV d_gmdFindLastRecordSlice (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
int  GMD_CALLCONV d_gmdRecordMoveNext (gmdHandle_t pgmd, void *symIterPtr);
int  GMD_CALLCONV d_gmdRecordMovePrev (gmdHandle_t pgmd, void *symIterPtr);
void  GMD_CALLCONV d_gmdGetElemText (gmdHandle_t pgmd, void *symIterPtr, char *txt);
double  GMD_CALLCONV d_gmdGetLevel (gmdHandle_t pgmd, void *symIterPtr);
double  GMD_CALLCONV d_gmdGetLower (gmdHandle_t pgmd, void *symIterPtr);
double  GMD_CALLCONV d_gmdGetUpper (gmdHandle_t pgmd, void *symIterPtr);
double  GMD_CALLCONV d_gmdGetMarginal (gmdHandle_t pgmd, void *symIterPtr);
double  GMD_CALLCONV d_gmdGetScale (gmdHandle_t pgmd, void *symIterPtr);
void  GMD_CALLCONV d_gmdSetElemText (gmdHandle_t pgmd, void *symIterPtr, const char *txt);
void  GMD_CALLCONV d_gmdSetLevel (gmdHandle_t pgmd, void *symIterPtr, double value);
void  GMD_CALLCONV d_gmdSetLower (gmdHandle_t pgmd, void *symIterPtr, double value);
void  GMD_CALLCONV d_gmdSetUpper (gmdHandle_t pgmd, void *symIterPtr, double value);
void  GMD_CALLCONV d_gmdSetMarginal (gmdHandle_t pgmd, void *symIterPtr, double value);
void  GMD_CALLCONV d_gmdSetScale (gmdHandle_t pgmd, void *symIterPtr, double value);
void * GMD_CALLCONV d_gmdAddRecord (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
int  GMD_CALLCONV d_gmdDeleteRecord (gmdHandle_t pgmd, void *symIterPtr);
int  GMD_CALLCONV d_gmdGetKeys (gmdHandle_t pgmd, void *symIterPtr, int aDim, char *keyStr[]);
void * GMD_CALLCONV d_gmdCopySymbolIterator (gmdHandle_t pgmd, void *symIterPtr);
void  GMD_CALLCONV d_gmdFreeSymbolIterator (gmdHandle_t pgmd, void *symIterPtr);
void  GMD_CALLCONV d_gmdFreeAllSymbolIterators (gmdHandle_t pgmd);
int  GMD_CALLCONV d_gmdInfo (gmdHandle_t pgmd, int infoKey, int *ival, double *dval, char *sval);
int  GMD_CALLCONV d_gmdSymbolInfo (gmdHandle_t pgmd, void *symPtr, int infoKey, int *ival, double *dval, char *sval);
int  GMD_CALLCONV d_gmdSymbolType (gmdHandle_t pgmd, void *symPtr);
int  GMD_CALLCONV d_gmdWriteGDX (gmdHandle_t pgmd, const char *fileName);
void  GMD_CALLCONV d_gmdSetSpecialValues (gmdHandle_t pgmd, const double specVal[]);
void  GMD_CALLCONV d_gmdSetDebug (gmdHandle_t pgmd, int debugLevel);
int  GMD_CALLCONV d_gmdInitUpdate (gmdHandle_t pgmd, void *gmoPtr);
int  GMD_CALLCONV d_gmdUpdateModelSymbol (gmdHandle_t pgmd, void *gamsSymPtr, int actionType, void *dataSymPtr, int updateType, int *noMatchCnt);
int  GMD_CALLCONV d_gmdCallSolver (gmdHandle_t pgmd, const char *solvername);

typedef int  (GMD_CALLCONV *gmdInitFromGDX_t) (gmdHandle_t pgmd, const char *fileName);
GMD_FUNCPTR(gmdInitFromGDX);
typedef int  (GMD_CALLCONV *gmdInitFromDict_t) (gmdHandle_t pgmd, void *gmoPtr, char *msg);
GMD_FUNCPTR(gmdInitFromDict);
typedef int  (GMD_CALLCONV *gmdCloseGDX_t) (gmdHandle_t pgmd, int loadRemain);
GMD_FUNCPTR(gmdCloseGDX);
typedef void * (GMD_CALLCONV *gmdAddSymbol_t) (gmdHandle_t pgmd, const char *symName, int aDim, int type, int userInfo, const char *explText);
GMD_FUNCPTR(gmdAddSymbol);
typedef void * (GMD_CALLCONV *gmdFindSymbol_t) (gmdHandle_t pgmd, const char *symName);
GMD_FUNCPTR(gmdFindSymbol);
typedef void * (GMD_CALLCONV *gmdGetSymbolByIndex_t) (gmdHandle_t pgmd, int idx);
GMD_FUNCPTR(gmdGetSymbolByIndex);
typedef int  (GMD_CALLCONV *gmdClearSymbol_t) (gmdHandle_t pgmd, void *symPtr);
GMD_FUNCPTR(gmdClearSymbol);
typedef int  (GMD_CALLCONV *gmdCopySymbol_t) (gmdHandle_t pgmd, void *tarSymPtr, void *srcSymPtr, char *msg);
GMD_FUNCPTR(gmdCopySymbol);
typedef void * (GMD_CALLCONV *gmdFindRecord_t) (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
GMD_FUNCPTR(gmdFindRecord);
typedef void * (GMD_CALLCONV *gmdFindFirstRecord_t) (gmdHandle_t pgmd, void *symPtr);
GMD_FUNCPTR(gmdFindFirstRecord);
typedef void * (GMD_CALLCONV *gmdFindFirstRecordSlice_t) (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
GMD_FUNCPTR(gmdFindFirstRecordSlice);
typedef void * (GMD_CALLCONV *gmdFindLastRecord_t) (gmdHandle_t pgmd, void *symPtr);
GMD_FUNCPTR(gmdFindLastRecord);
typedef void * (GMD_CALLCONV *gmdFindLastRecordSlice_t) (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
GMD_FUNCPTR(gmdFindLastRecordSlice);
typedef int  (GMD_CALLCONV *gmdRecordMoveNext_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdRecordMoveNext);
typedef int  (GMD_CALLCONV *gmdRecordMovePrev_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdRecordMovePrev);
typedef void  (GMD_CALLCONV *gmdGetElemText_t) (gmdHandle_t pgmd, void *symIterPtr, char *txt);
GMD_FUNCPTR(gmdGetElemText);
typedef double  (GMD_CALLCONV *gmdGetLevel_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdGetLevel);
typedef double  (GMD_CALLCONV *gmdGetLower_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdGetLower);
typedef double  (GMD_CALLCONV *gmdGetUpper_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdGetUpper);
typedef double  (GMD_CALLCONV *gmdGetMarginal_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdGetMarginal);
typedef double  (GMD_CALLCONV *gmdGetScale_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdGetScale);
typedef void  (GMD_CALLCONV *gmdSetElemText_t) (gmdHandle_t pgmd, void *symIterPtr, const char *txt);
GMD_FUNCPTR(gmdSetElemText);
typedef void  (GMD_CALLCONV *gmdSetLevel_t) (gmdHandle_t pgmd, void *symIterPtr, double value);
GMD_FUNCPTR(gmdSetLevel);
typedef void  (GMD_CALLCONV *gmdSetLower_t) (gmdHandle_t pgmd, void *symIterPtr, double value);
GMD_FUNCPTR(gmdSetLower);
typedef void  (GMD_CALLCONV *gmdSetUpper_t) (gmdHandle_t pgmd, void *symIterPtr, double value);
GMD_FUNCPTR(gmdSetUpper);
typedef void  (GMD_CALLCONV *gmdSetMarginal_t) (gmdHandle_t pgmd, void *symIterPtr, double value);
GMD_FUNCPTR(gmdSetMarginal);
typedef void  (GMD_CALLCONV *gmdSetScale_t) (gmdHandle_t pgmd, void *symIterPtr, double value);
GMD_FUNCPTR(gmdSetScale);
typedef void * (GMD_CALLCONV *gmdAddRecord_t) (gmdHandle_t pgmd, void *symPtr, int aDim, const char *keyStr[]);
GMD_FUNCPTR(gmdAddRecord);
typedef int  (GMD_CALLCONV *gmdDeleteRecord_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdDeleteRecord);
typedef int  (GMD_CALLCONV *gmdGetKeys_t) (gmdHandle_t pgmd, void *symIterPtr, int aDim, char *keyStr[]);
GMD_FUNCPTR(gmdGetKeys);
typedef void * (GMD_CALLCONV *gmdCopySymbolIterator_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdCopySymbolIterator);
typedef void  (GMD_CALLCONV *gmdFreeSymbolIterator_t) (gmdHandle_t pgmd, void *symIterPtr);
GMD_FUNCPTR(gmdFreeSymbolIterator);
typedef void  (GMD_CALLCONV *gmdFreeAllSymbolIterators_t) (gmdHandle_t pgmd);
GMD_FUNCPTR(gmdFreeAllSymbolIterators);
typedef int  (GMD_CALLCONV *gmdInfo_t) (gmdHandle_t pgmd, int infoKey, int *ival, double *dval, char *sval);
GMD_FUNCPTR(gmdInfo);
typedef int  (GMD_CALLCONV *gmdSymbolInfo_t) (gmdHandle_t pgmd, void *symPtr, int infoKey, int *ival, double *dval, char *sval);
GMD_FUNCPTR(gmdSymbolInfo);
typedef int  (GMD_CALLCONV *gmdSymbolType_t) (gmdHandle_t pgmd, void *symPtr);
GMD_FUNCPTR(gmdSymbolType);
typedef int  (GMD_CALLCONV *gmdWriteGDX_t) (gmdHandle_t pgmd, const char *fileName);
GMD_FUNCPTR(gmdWriteGDX);
typedef void  (GMD_CALLCONV *gmdSetSpecialValues_t) (gmdHandle_t pgmd, const double specVal[]);
GMD_FUNCPTR(gmdSetSpecialValues);
typedef void  (GMD_CALLCONV *gmdSetDebug_t) (gmdHandle_t pgmd, int debugLevel);
GMD_FUNCPTR(gmdSetDebug);
typedef int  (GMD_CALLCONV *gmdInitUpdate_t) (gmdHandle_t pgmd, void *gmoPtr);
GMD_FUNCPTR(gmdInitUpdate);
typedef int  (GMD_CALLCONV *gmdUpdateModelSymbol_t) (gmdHandle_t pgmd, void *gamsSymPtr, int actionType, void *dataSymPtr, int updateType, int *noMatchCnt);
GMD_FUNCPTR(gmdUpdateModelSymbol);
typedef int  (GMD_CALLCONV *gmdCallSolver_t) (gmdHandle_t pgmd, const char *solvername);
GMD_FUNCPTR(gmdCallSolver);
#if defined(__cplusplus)
}
#endif
#endif /* #if ! defined(_GMDCC_H_) */