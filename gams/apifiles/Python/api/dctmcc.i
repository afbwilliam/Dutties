/*  SWIG interface code generated by apiwrapper for GAMS Version 24.0.2 */
%module dctmcc
%include cpointer.i
%include typemaps.i
%include carrays.i
%include cstring.i

%{
/* Put header files here or function declarations like below */
#define SWIG_FILE_WITH_INIT
#include "dctmcc.h"
#include "gclgms.h"
#define dctHandleToPtr
#define ptrTodctHandle
%}



enum dcttypes {
  dctunknownSymType = 0,
  dctfuncSymType    = 1,
  dctsetSymType     = 2,
  dctacrSymType     = 3,
  dctparmSymType    = 4,
  dctvarSymType     = 5,
  dcteqnSymType     = 6,
  dctaliasSymType   = 127  };

// special treatment for out int arrays
%typemap(in, numinputs=0) int uelIndices_out[]{
  static gdxUelIndex_t uelIndices;
  $1 = uelIndices;
}

%typemap(argout) int uelIndices_out[]{
    int loc_i = 0;
    PyObject *list;
    int loc_dim = GLOBAL_MAX_INDEX_DIM;
    list = PyList_New(loc_dim);
    for(loc_i=0; loc_i<loc_dim; loc_i++){
      PyList_SetItem(list, loc_i, PyInt_FromLong($1[loc_i]));
    }
    $result = SWIG_Python_AppendOutput($result, list);
}

%array_class(int, intArray);
%array_class(double, doubleArray);
%pointer_functions(int, intp);
%pointer_functions(double, doublep);
%pointer_functions(dctHandle_t, dctHandle_tp);

%typemap(in) void *{
    int res = SWIG_ConvertPtr($input,SWIG_as_voidptrptr(&$1), SWIGTYPE_p_void, 0);
    if (!SWIG_IsOK(res)) {
    SWIG_exception_fail(SWIG_ArgError(res), "in method '" "$symname" "', argument " " of type '" "void *""'");
  }
}

%typemap(in) void **{
    void *$1__p;
    int res = SWIG_ConvertPtr($input,SWIG_as_voidptrptr(&$1__p), SWIGTYPE_p_void, 0);
    if (!SWIG_IsOK(res)) {
    SWIG_exception_fail(SWIG_ArgError(res), "in method '" "$symname" "', argument " " of type '" "void *""'");
    }
    $1 = &$1__p;
}

%typemap(out) dctHandle_t {
  resultobj = SWIG_NewPointerObj((dctHandle_t *)memcpy((dctHandle_t *)malloc(sizeof(dctHandle_t)),&result,sizeof(dctHandle_t)), SWIGTYPE_p_dctHandle_t, 0 |  0 );
}


%cstring_bounded_output(char *msgBuf_out, GMS_SSSIZE);
%cstring_bounded_output(char *Msg_out, GMS_SSSIZE);
%cstring_bounded_output(char *uelLabel_out, GMS_SSSIZE);
%cstring_bounded_output(char *symName_out, GMS_SSSIZE);
%cstring_bounded_output(char *symTxt_out, GMS_SSSIZE);
%cstring_mutable(char *q_mut, GMS_SSSIZE);

%feature("autodoc", "0");

extern void *dctHandleToPtr (dctHandle_t pdct);
extern dctHandle_t ptrTodctHandle (void *vptr);
extern int dctGetReady (char *msgBuf_out, int msgBufSize);
extern int dctGetReadyD (const char *dirName, char *msgBuf_out, int msgBufSize);
extern int dctGetReadyL (const char *libName, char *msgBuf_out, int msgBufSize);
extern int dctCreate (dctHandle_t *pdct, char *msgBuf_out, int msgBufSize);
extern int dctCreateD (dctHandle_t *pdct, const char *dirName, char *msgBuf_out, int msgBufSize);
extern int dctCreateDD (dctHandle_t *pdct, const char *dirName, char *msgBuf_out, int msgBufSize);
extern int dctCreateL (dctHandle_t *pdct, const char *libName, char *msgBuf_out, int msgBufSize);
extern int dctFree (dctHandle_t *pdct);
extern int dctLibraryLoaded(void);
extern int dctLibraryUnload(void);
extern int dctGetScreenIndicator(void);
extern void dctSetScreenIndicator(int scrind);
extern int dctGetExceptionIndicator(void);
extern void dctSetExceptionIndicator(int excind);
extern int dctGetExitIndicator(void);
extern void dctSetExitIndicator(int extind);
extern dctErrorCallback_t dctGetErrorCallback(void);
extern void dctSetErrorCallback(dctErrorCallback_t func);
extern int dctGetAPIErrorCount(void);
extern void dctSetAPIErrorCount(int ecnt);
extern void dctErrorHandling(const char *msg);
extern int  dctLoadEx (dctHandle_t pdct, const char *fName, char *Msg_out, int Msg_i);
extern int  dctLoadWithHandle (dctHandle_t pdct, void *gdxptr, char *Msg_out, int Msg_i);
extern int  dctNUels (dctHandle_t pdct);
extern int  dctUelIndex (dctHandle_t pdct, const char *uelLabel);
extern int  dctUelLabel (dctHandle_t pdct, int uelIndex, char *q_mut, char *uelLabel_out, int uelLabel_i);
extern int  dctNLSyms (dctHandle_t pdct);
extern int  dctSymDim (dctHandle_t pdct, int symIndex);
extern int  dctSymIndex (dctHandle_t pdct, const char *symName);
extern int  dctSymName (dctHandle_t pdct, int symIndex, char *symName_out, int symName_i);
extern int  dctSymText (dctHandle_t pdct, int symIndex, char *q_mut, char *symTxt_out, int symTxt_i);
extern int  dctSymType (dctHandle_t pdct, int symIndex);
extern int  dctSymUserInfo (dctHandle_t pdct, int symIndex);
extern int  dctSymEntries (dctHandle_t pdct, int symIndex);
extern int  dctSymOffset (dctHandle_t pdct, int symIndex);
extern int  dctColIndex (dctHandle_t pdct, int symIndex, const int uelIndices[]);
extern int  dctRowIndex (dctHandle_t pdct, int symIndex, const int uelIndices[]);
extern int  dctColUels (dctHandle_t pdct, int j, int *OUTPUT, int uelIndices_out[], int *OUTPUT);
extern int  dctRowUels (dctHandle_t pdct, int i, int *OUTPUT, int uelIndices_out[], int *OUTPUT);
extern void * dctFindFirstRowCol (dctHandle_t pdct, int symIndex, const int uelIndices[], int *OUTPUT);
extern int  dctFindNextRowCol (dctHandle_t pdct, void *findHandle, int *OUTPUT);
extern void  dctFindClose (dctHandle_t pdct, void *findHandle);
extern double  dctMemUsed (dctHandle_t pdct);
extern void  dctSetBasicCounts (dctHandle_t pdct, int NRows, int NCols, int NBlocks);
extern void  dctAddUel (dctHandle_t pdct, const char *uelLabel, const char q);
extern void  dctAddSymbol (dctHandle_t pdct, const char *symName, int symTyp, int symDim, int userInfo, const char *symTxt);
extern void  dctAddSymbolData (dctHandle_t pdct, const int uelIndices[]);
extern void  dctWriteGDX (dctHandle_t pdct, const char *fName, char *Msg_out);
extern void  dctWriteGDXWithHandle (dctHandle_t pdct, void *gdxptr, char *Msg_out);
extern int  dctNRows (dctHandle_t pdct);
extern int  dctNCols (dctHandle_t pdct);
extern int  dctLrgDim (dctHandle_t pdct);

%include "gclgms_swig.h"