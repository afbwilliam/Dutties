/*  Java code generated by apiwrapper for GAMS Version 24.0.2 */
package com.gams.api;

public class gmom {
   public static final int gmoequ_E = 0; /* gmoEquType */
   public static final int gmoequ_G = 1;
   public static final int gmoequ_L = 2;
   public static final int gmoequ_N = 3;
   public static final int gmoequ_X = 4;
   public static final int gmoequ_C = 5;
   public static final int gmoequ_B = 6;

   public static final int gmovar_X  = 0; /* gmoVarType */
   public static final int gmovar_B  = 1;
   public static final int gmovar_I  = 2;
   public static final int gmovar_S1 = 3;
   public static final int gmovar_S2 = 4;
   public static final int gmovar_SC = 5;
   public static final int gmovar_SI = 6;

   public static final int gmoorder_ERR = 0; /* gmoEquOrder */
   public static final int gmoorder_L   = 1;
   public static final int gmoorder_Q   = 2;
   public static final int gmoorder_NL  = 3;

   public static final int gmovar_X_F = 0; /* gmoVarFreeType */
   public static final int gmovar_X_N = 1;
   public static final int gmovar_X_P = 2;

   public static final int gmoBstat_Lower = 0; /* gmoVarEquBasisStatus */
   public static final int gmoBstat_Upper = 1;
   public static final int gmoBstat_Basic = 2;
   public static final int gmoBstat_Super = 3;

   public static final int gmoCstat_OK     = 0; /* gmoVarEquStatus */
   public static final int gmoCstat_NonOpt = 1;
   public static final int gmoCstat_Infeas = 2;
   public static final int gmoCstat_UnBnd  = 3;

   public static final int gmoObjType_Var = 0; /* gmoObjectiveType */
   public static final int gmoObjType_Fun = 2;

   public static final int gmoIFace_Processed = 0; /* gmoInterfaceType */
   public static final int gmoIFace_Raw       = 1;

   public static final int gmoObj_Min = 0; /* gmoObjectiveSense */
   public static final int gmoObj_Max = 1;

   public static final int gmoSolveStat_Normal      = 1; /* gmoSolverStatus */
   public static final int gmoSolveStat_Iteration   = 2;
   public static final int gmoSolveStat_Resource    = 3;
   public static final int gmoSolveStat_Solver      = 4;
   public static final int gmoSolveStat_EvalError   = 5;
   public static final int gmoSolveStat_Capability  = 6;
   public static final int gmoSolveStat_License     = 7;
   public static final int gmoSolveStat_User        = 8;
   public static final int gmoSolveStat_SetupErr    = 9;
   public static final int gmoSolveStat_SolverErr   = 10;
   public static final int gmoSolveStat_InternalErr = 11;
   public static final int gmoSolveStat_Skipped     = 12;
   public static final int gmoSolveStat_SystemErr   = 13;

   public static final int gmoModelStat_OptimalGlobal        = 1; /* gmoModelStatus */
   public static final int gmoModelStat_OptimalLocal         = 2;
   public static final int gmoModelStat_Unbounded            = 3;
   public static final int gmoModelStat_InfeasibleGlobal     = 4;
   public static final int gmoModelStat_InfeasibleLocal      = 5;
   public static final int gmoModelStat_InfeasibleIntermed   = 6;
   public static final int gmoModelStat_NonOptimalIntermed   = 7;
   public static final int gmoModelStat_Integer              = 8;
   public static final int gmoModelStat_NonIntegerIntermed   = 9;
   public static final int gmoModelStat_IntegerInfeasible    = 10;
   public static final int gmoModelStat_LicenseError         = 11;
   public static final int gmoModelStat_ErrorUnknown         = 12;
   public static final int gmoModelStat_ErrorNoSolution      = 13;
   public static final int gmoModelStat_NoSolutionReturned   = 14;
   public static final int gmoModelStat_SolvedUnique         = 15;
   public static final int gmoModelStat_Solved               = 16;
   public static final int gmoModelStat_SolvedSingular       = 17;
   public static final int gmoModelStat_UnboundedNoSolution  = 18;
   public static final int gmoModelStat_InfeasibleNoSolution = 19;

   public static final int gmoHiterused = 3; /* gmoHeadnTail */
   public static final int gmoHresused  = 4;
   public static final int gmoHobjval   = 5;
   public static final int gmoHdomused  = 6;
   public static final int gmoHetalg    = 10;
   public static final int gmoTmipnod   = 11;
   public static final int gmoTninf     = 12;
   public static final int gmoTnopt     = 13;
   public static final int gmoTmipbest  = 15;
   public static final int gmoTsinf     = 20;
   public static final int gmoTrobj     = 22;

   public static final int gmonumheader = 10; /* gmoHTcard */
   public static final int gmonumtail   = 12;

   public static final int gmoProc_none           = 0; /* gmoProcType */
   public static final int gmoProc_lp             = 1;
   public static final int gmoProc_mip            = 2;
   public static final int gmoProc_rmip           = 3;
   public static final int gmoProc_nlp            = 4;
   public static final int gmoProc_mcp            = 5;
   public static final int gmoProc_mpec           = 6;
   public static final int gmoProc_rmpec          = 7;
   public static final int gmoProc_cns            = 8;
   public static final int gmoProc_dnlp           = 9;
   public static final int gmoProc_rminlp         = 10;
   public static final int gmoProc_minlp          = 11;
   public static final int gmoProc_qcp            = 12;
   public static final int gmoProc_miqcp          = 13;
   public static final int gmoProc_rmiqcp         = 14;
   public static final int gmoProc_emp            = 15;
   public static final int gmoProc_nrofmodeltypes = 16;

   public static final int gmoEVALERRORMETHOD_KEEPGOING = 0; /* gmoEvalErrorMethodNum */
   public static final int gmoEVALERRORMETHOD_FASTSTOP  = 1;

   private long gmoPtr = 0;
   public native static int    GetReady (String[] msg);
   public native static int    GetReadyD(String dirName, String[] msg);
   public native static int    GetReadyL(String libName, String[] msg);
   public native int    Create   (String[] msg);
   public native int    CreateD  (String dirName, String[] msg);
   public native int    CreateDD (String dirName, String[] msg);
   public native int    CreateL  (String libName, String[] msg);
   public native int    Free     ();
   public native int    InitData(int rows, int cols, int codelen);
   public native int    AddRow(int etyp, int ematch, double eslack, double escale, double erhs, double emarg, int ebas, int enz, int []colidx, double []jacval, int []nlflag);
   public native int    AddCol(int vtyp, double vlo, double vl, double vup, double vmarg, int vbas, int vsos, double vprior, double vscale, int vnz, int []rowidx, double []jacval, int []nlflag);
   public native int    CompleteData(String []msg);
   public native int    LoadDataLegacy(String []msg);
   public native int    RegisterEnvironment(long gevptr, String []msg);
   public native long    Environment();
   public native long    ViewStore();
   public native void    ViewRestore(long []viewptr);
   public native void    ViewDump();
   public native int    GetiSolver(int mi);
   public native int    GetjSolver(int mj);
   public native int    GetiModel(int si);
   public native int    GetjModel(int sj);
   public native int    SetEquPermutation(int []permut);
   public native int    SetRvEquPermutation(int []rvpermut, int len);
   public native int    SetVarPermutation(int []permut);
   public native int    SetRvVarPermutation(int []rvpermut, int len);
   public native int    SetNRowPerm();
   public native int    GetVarTypeCnt(int vtyp);
   public native int    GetEquTypeCnt(int etyp);
   public native int    GetObjStat(int []nz, int []qnz, int []nlnz);
   public native int    GetRowStat(int si, int []nz, int []qnz, int []nlnz);
   public native int    GetColStat(int sj, int []nz, int []qnz, int []nlnz, int []objnz);
   public native int    GetRowQNZOne(int si);
   public native int    GetRowQDiagNZOne(int si);
   public native void    GetSosCounts(int []numsos1, int []numsos2, int []nzsos);
   public native void    GetXLibCounts(int []rows, int []cols, int []nz, int []orgcolind);
   public native int    GetActiveModelType(int []checkv, int []actModelType);
   public native int    GetMatrixRow(int []rowstart, int []colidx, double []jacval, int []nlflag);
   public native int    GetMatrixCol(int []colstart, int []rowidx, double []jacval, int []nlflag);
   public native int    GetMatrixCplex(int []colstart, int []collength, int []rowidx, double []jacval);
   public native int    GetObjVector(double []jacval, int []nlflag);
   public native int    GetObjSparse(int []colidx, double []jacval, int []nlflag, int []nz, int []nlnz);
   public native int    GetObjQ(int []colidx, int []rowidx, double []jacval);
   public native int    GetEquL(double []e);
   public native double    GetEquLOne(int si);
   public native int    SetEquL(double []el);
   public native void    SetEquLOne(int si, double el);
   public native int    GetEquM(double []pi);
   public native double    GetEquMOne(int si);
   public native int    SetEquM(double []emarg);
   public native int    GetRhs(double []mdblvec);
   public native double    GetRhsOne(int si);
   public native int    SetAltRHS(double []mdblvec);
   public native void    SetAltRHSOne(int si, double erhs);
   public native int    GetEquSlack(double []mdblvec);
   public native double    GetEquSlackOne(int si);
   public native int    SetEquSlack(double []mdblvec);
   public native int    GetEquType(int []mintvec);
   public native int    GetEquTypeOne(int si);
   public native void    GetEquStat(int []mintvec);
   public native int    GetEquStatOne(int si);
   public native void    SetEquStat(int []mintvec);
   public native void    GetEquCStat(int []mintvec);
   public native int    GetEquCStatOne(int si);
   public native void    SetEquCStat(int []mintvec);
   public native int    GetEquMatch(int []mintvec);
   public native int    GetEquMatchOne(int si);
   public native int    GetEquScale(double []mdblvec);
   public native double    GetEquScaleOne(int si);
   public native double    GetEquStageOne(int si);
   public native int    GetEquOrderOne(int si);
   public native int    GetRowSparse(int si, int []colidx, double []jacval, int []nlflag, int []nz, int []nlnz);
   public native void    GetRowJacInfoOne(int si, long []jacptr, double []jacval, int []colidx, int []nlflag);
   public native int    GetRowQ(int si, int []colidx, int []rowidx, double []jacval);
   public native int    GetEquIntDotOpt(long optptr, String dotopt, int []optvals);
   public native int    GetEquDblDotOpt(long optptr, String dotopt, double []optvals);
   public native int    GetVarL(double []x);
   public native double    GetVarLOne(int sj);
   public native int    SetVarL(double []x);
   public native void    SetVarLOne(int sj, double vl);
   public native int    GetVarM(double []dj);
   public native double    GetVarMOne(int sj);
   public native int    SetVarM(double []dj);
   public native int    GetVarLower(double []lovec);
   public native double    GetVarLowerOne(int sj);
   public native int    GetVarUpper(double []upvec);
   public native double    GetVarUpperOne(int sj);
   public native int    SetAltVarBounds(double []lovec, double []upvec);
   public native void    SetAltVarLowerOne(int sj, double vlo);
   public native void    SetAltVarUpperOne(int sj, double vup);
   public native int    GetVarType(int []nintvec);
   public native int    GetVarTypeOne(int sj);
   public native int    SetAltVarType(int []nintvec);
   public native void    SetAltVarTypeOne(int sj, int vtyp);
   public native void    GetVarStat(int []nintvec);
   public native int    GetVarStatOne(int sj);
   public native void    SetVarStat(int []nintvec);
   public native void    SetVarStatOne(int sj, int vstat);
   public native void    GetVarCStat(int []nintvec);
   public native int    GetVarCStatOne(int sj);
   public native void    SetVarCStat(int []nintvec);
   public native int    GetVarPrior(double []ndblvec);
   public native double    GetVarPriorOne(int sj);
   public native int    GetVarScale(double []ndblvec);
   public native double    GetVarScaleOne(int sj);
   public native double    GetVarStageOne(int sj);
   public native int    GetSosConstraints(int []sostype, int []sosbeg, int []sosind, double []soswt);
   public native int    GetVarSosSetOne(int sj);
   public native int    GetColSparse(int sj, int []rowidx, double []jacval, int []nlflag, int []nz, int []nlnz);
   public native void    GetColJacInfoOne(int sj, long []jacptr, double []jacval, int []rowidx, int []nlflag);
   public native int    GetVarIntDotOpt(long optptr, String dotopt, int []optvals);
   public native int    GetVarDblDotOpt(long optptr, String dotopt, double []optvals);
   public native void    EvalErrorMsg(boolean domsg);
   public native void    EvalErrorMsg_MT(boolean domsg, int tidx);
   public native void    EvalErrorMaskLevel(int MaskLevel);
   public native void    EvalErrorMaskLevel_MT(int MaskLevel, int tidx);
   public native int    EvalNewPoint(double []x);
   public native void    SetExtFuncs(long extfunmgr);
   public native int    EvalFunc(int si, double []x, double []f, int []numerr);
   public native int    EvalFunc_MT(int si, double []x, double []f, int []numerr, int tidx);
   public native int    EvalFuncInt(int si, double []f, int []numerr);
   public native int    EvalFuncInt_MT(int si, double []f, int []numerr, int tidx);
   public native int    EvalFuncNL(int si, double []x, double []fnl, int []numerr);
   public native int    EvalFuncNL_MT(int si, double []x, double []fnl, int []numerr, int tidx);
   public native int    EvalFuncObj(double []x, double []f, int []numerr);
   public native int    EvalFuncNLObj(double []x, double []fnl, int []numerr);
   public native int    EvalFuncInterval(int si, double []xmin, double []xmax, double []fmin, double []fmax, int []numerr);
   public native int    EvalFuncInterval_MT(int si, double []xmin, double []xmax, double []fmin, double []fmax, int []numerr, int tidx);
   public native int    EvalFuncNLCluster(int si, double []x, int []cluster, int ncluster, double []fnl, int []numerr);
   public native int    EvalFuncNLCluster_MT(int si, double []x, int []cluster, int ncluster, double []fnl, int []numerr, int tidx);
   public native int    EvalGrad(int si, double []x, double []f, double []g, double []gx, int []numerr);
   public native int    EvalGrad_MT(int si, double []x, double []f, double []g, double []gx, int []numerr, int tidx);
   public native int    EvalGradNL(int si, double []x, double []fnl, double []g, double []gxnl, int []numerr);
   public native int    EvalGradNL_MT(int si, double []x, double []fnl, double []g, double []gxnl, int []numerr, int tidx);
   public native int    EvalGradObj(double []x, double []f, double []g, double []gx, int []numerr);
   public native int    EvalGradNLObj(double []x, double []fnl, double []g, double []gxnl, int []numerr);
   public native int    EvalGradInterval(int si, double []xmin, double []xmax, double []fmin, double []fmax, double []gmin, double []gmax, int []numerr);
   public native int    EvalGradInterval_MT(int si, double []xmin, double []xmax, double []fmin, double []fmax, double []gmin, double []gmax, int []numerr, int tidx);
   public native int    EvalGradNLUpdate(double []rhsdelta, boolean dojacupd, int []numerr);
   public native int    GetJacUpdate(int []rowidx, int []colidx, double []jacval, int []len);
   public native int    HessLoad(int maxJacMult, int []do2dir, int []doHess);
   public native int    HessUnload();
   public native int    HessDim(int si);
   public native int    HessNz(int si);
   public native int    HessStruct(int si, int []hridx, int []hcidx, int []hessdim, int []hessnz);
   public native int    HessValue(int si, int []hridx, int []hcidx, int []hessdim, int []hessnz, double []x, double []hessval, int []numerr);
   public native int    HessVec(int si, double []x, double []dx, double []Wdx, int []numerr);
   public native int    HessLagStruct(int []WRindex, int []WCindex);
   public native int    HessLagValue(double []x, double []pi, double []w, double objweight, double conweight, int []numerr);
   public native int    HessLagVec(double []x, double []pi, double []dx, double []Wdx, double objweight, double conweight, int []numerr);
   public native double    GetHeadnTail(int htrec);
   public native void    SetHeadnTail(int htrec, double dval);
   public native int    SetSolution2(double []x, double []pi);
   public native int    SetSolution(double []x, double []dj, double []pi, double []e);
   public native int    SetSolution8(double []x, double []dj, double []pi, double []e, int []xb, int []xs, int []yb, int []ys);
   public native int    SetSolutionFixer(int modelstathint, double []x, double []pi, int []xb, int []yb, double infTol, double optTol);
   public native int    GetSolutionVarRec(int sj, double []vl, double []vmarg, int []vstat, int []vcstat);
   public native int    SetSolutionVarRec(int sj, double vl, double vmarg, int vstat, int vcstat);
   public native int    GetSolutionEquRec(int si, double []el, double []emarg, int []estat, int []ecstat);
   public native int    SetSolutionEquRec(int si, double el, double emarg, int estat, int ecstat);
   public native int    SetSolutionStatus(int []xb, int []xs, int []yb, int []ys);
   public native void    CompleteObjective(double locobjval);
   public native int    CompleteSolution();
   public native int    LoadSolutionLegacy();
   public native int    UnloadSolutionLegacy();
   public native int    LoadSolutionGDX(String gdxfname, boolean dorows, boolean docols, boolean doht);
   public native int    UnloadSolutionGDX(String gdxfname, boolean dorows, boolean docols, boolean doht);
   public native int    PrepareAllSolToGDX(String gdxfname, long scengdx, int dictid);
   public native int    AddSolutionToGDX(String []scenuel);
   public native int    WriteSolDone(String []msg);
   public native int    GetVarTypeTxt(int sj, String []s);
   public native int    GetEquTypeTxt(int si, String []s);
   public native int    GetSolveStatusTxt(int solvestat, String []s);
   public native int    GetModelStatusTxt(int modelstat, String []s);
   public native int    GetModelTypeTxt(String []s);
   public native int    GetHeadNTailTxt(int htrec, String []s);
   public native double    MemUsed();
   public native double    PeakMemUsed();
   public native int    SetNLObject(long nlobject, long nlpool);
   public native int    DumpQMakerGDX(String gdxfname);
   public native int    GetVarEquMap(int maptype, long optptr, int strict, int []nmappings, int []rowindex, int []colindex, int []mapval);
   public native int    GetIndicatorMap(long optptr, int indicstrict, int []numindic, int []rowindic, int []colindic, int []indiconval);
   public native int    Crudeness();
   public native int    DirtyExtractDefVar(int []rowpiv, int []rowfree, int []colfix, int []colno, int []rowno, double []defpiv);
   public native int    DirtyGetRowFNLInstr(int si, int []len, int []opcode, int []field);
   public native int    DirtyGetObjFNLInstr(int []len, int []opcode, int []field);
   public native int    DirtySetRowFNLInstr(int si, int len, int []opcode, int []field, long nlpool, double []nlpoolvec, int len2);
   public native long    Dict();
   public native void    DictSet(long x);
   public native void    NameModelSet(String x);
   public native int    ModelSeqNr();
   public native void    ModelSeqNrSet(int x);
   public native int    ModelType();
   public native void    ModelTypeSet(int x);
   public native int    Sense();
   public native void    SenseSet(int x);
   public native boolean    IsQP();
   public native int    OptFile();
   public native void    OptFileSet(int x);
   public native int    Dictionary();
   public native void    DictionarySet(int x);
   public native int    ScaleOpt();
   public native void    ScaleOptSet(int x);
   public native int    PriorOpt();
   public native void    PriorOptSet(int x);
   public native int    HaveBasis();
   public native void    HaveBasisSet(int x);
   public native int    ModelStat();
   public native void    ModelStatSet(int x);
   public native int    SolveStat();
   public native void    SolveStatSet(int x);
   public native int    ObjStyle();
   public native void    ObjStyleSet(int x);
   public native int    Interface();
   public native void    InterfaceSet(int x);
   public native int    IndexBase();
   public native void    IndexBaseSet(int x);
   public native boolean    ObjReform();
   public native void    ObjReformSet(boolean x);
   public native boolean    EmptyOut();
   public native void    EmptyOutSet(boolean x);
   public native boolean    IgnXCDeriv();
   public native void    IgnXCDerivSet(boolean x);
   public native boolean    UseQ();
   public native void    UseQSet(boolean x);
   public native boolean    AltBounds();
   public native void    AltBoundsSet(boolean x);
   public native boolean    AltRHS();
   public native void    AltRHSSet(boolean x);
   public native boolean    AltVarTypes();
   public native void    AltVarTypesSet(boolean x);
   public native boolean    ForceLinear();
   public native void    ForceLinearSet(boolean x);
   public native boolean    ForceCont();
   public native void    ForceContSet(boolean x);
   public native boolean    PermuteCols();
   public native void    PermuteColsSet(boolean x);
   public native boolean    PermuteRows();
   public native void    PermuteRowsSet(boolean x);
   public native double    Pinf();
   public native void    PinfSet(double x);
   public native double    Minf();
   public native void    MinfSet(double x);
   public native double    QNaN();
   public native double    ValNA();
   public native int    ValNAInt();
   public native double    ValUndf();
   public native int    M();
   public native int    QM();
   public native int    NLM();
   public native int    N();
   public native int    NLN();
   public native int    NDisc();
   public native int    NFixed();
   public native int    NZ();
   public native int    NLNZ();
   public native int    LNZ();
   public native int    QNZ();
   public native int    GNLNZ();
   public native int    MaxQNZ();
   public native int    ObjNZ();
   public native int    ObjNLNZ();
   public native int    ObjQNZ();
   public native int    ObjQDiagNZ();
   public native int    NLConst();
   public native void    NLConstSet(int x);
   public native int    NLCodeSize();
   public native void    NLCodeSizeSet(int x);
   public native int    NLCodeSizeMaxRow();
   public native int    ObjVar();
   public native void    ObjVarSet(int x);
   public native int    ObjRow();
   public native int    GetObjOrder();
   public native double    ObjConst();
   public native double    ObjJacVal();
   public native int    EvalErrorMethod();
   public native void    EvalErrorMethodSet(int x);
   public native int    EvalMaxThreads();
   public native void    EvalMaxThreadsSet(int x);
   public native int    EvalFuncCount();
   public native double    EvalFuncTimeUsed();
   public native int    EvalGradCount();
   public native double    EvalGradTimeUsed();
   public native int    HessMaxDim();
   public native int    HessMaxNz();
   public native int    HessLagDim();
   public native int    HessLagNz();
   public native int    HessLagDiagNz();
   public native void    NameOptFileSet(String x);
   public native void    NameSolFileSet(String x);
   public native void    NameXLibSet(String x);
   public native void    NameDictSet(String x);
   public native long    PPool();
   public native long    IOMutex();
   private native String    GetObjName(String []sst_result);
   public String    GetObjName() {
       String[] sst_result = new String[1];
       return    GetObjName(sst_result);
   }
   private native String    GetObjNameCustom(String suffix, String []sst_result);
   public String    GetObjNameCustom(String suffix) {
       String[] sst_result = new String[1];
       return    GetObjNameCustom(suffix, sst_result);
   }
   private native String    GetEquNameOne(int si, String []sst_result);
   public String    GetEquNameOne(int si) {
       String[] sst_result = new String[1];
       return    GetEquNameOne(si, sst_result);
   }
   private native String    GetEquNameCustomOne(int si, String suffix, String []sst_result);
   public String    GetEquNameCustomOne(int si, String suffix) {
       String[] sst_result = new String[1];
       return    GetEquNameCustomOne(si, suffix, sst_result);
   }
   private native String    GetVarNameOne(int sj, String []sst_result);
   public String    GetVarNameOne(int sj) {
       String[] sst_result = new String[1];
       return    GetVarNameOne(sj, sst_result);
   }
   private native String    GetVarNameCustomOne(int sj, String suffix, String []sst_result);
   public String    GetVarNameCustomOne(int sj, String suffix) {
       String[] sst_result = new String[1];
       return    GetVarNameCustomOne(sj, suffix, sst_result);
   }
   private native String    NameModel(String []sst_result);
   public  String    NameModel() {
       String[] sst_result = new String[1];
       return    NameModel(sst_result);
   }
   private native String    NameOptFile(String []sst_result);
   public  String    NameOptFile() {
       String[] sst_result = new String[1];
       return    NameOptFile(sst_result);
   }
   private native String    NameSolFile(String []sst_result);
   public  String    NameSolFile() {
       String[] sst_result = new String[1];
       return    NameSolFile(sst_result);
   }
   private native String    NameXLib(String []sst_result);
   public  String    NameXLib() {
       String[] sst_result = new String[1];
       return    NameXLib(sst_result);
   }
   private native String    NameDict(String []sst_result);
   public  String    NameDict() {
       String[] sst_result = new String[1];
       return    NameDict(sst_result);
   }
   private native String    NameInput(String []sst_result);
   public  String    NameInput() {
       String[] sst_result = new String[1];
       return    NameInput(sst_result);
   }
   public        long    GetgmoPtr(){ return gmoPtr;}
   public gmom () { }
   public gmom (long gmoPtr) {
      this.gmoPtr = gmoPtr;
   }
   static
   {
      try
      {
         if (System.getProperty("os.arch").toLowerCase().indexOf("64") >= 0 || System.getProperty("os.arch").toLowerCase().indexOf("sparcv9") >= 0)
         {
            System.loadLibrary("gmomjni64");
         }
         else
         {
            System.loadLibrary("gmomjni");
         }
      }
      catch (UnsatisfiedLinkError ex)
      {
         ex.printStackTrace();
         throw (ex);
      }
   }
}