* -*- fundamental -*-
$hidden When adding models we need to update this file at a few
$hidden spots. Look for $hidden lines. To check > gams testmod.inc
$hidden   update lib version above and run gams testmod.inc
alias (u,*)
SETS s Model Sequence Numbers / 1*585 /
$hidden                           bump sequences numbers above

$stitle Model Names and Titles
set m model names in alphabetic order /
$hidden  enter the new model here, keep in order
A
ASSIGN1    'Lagged replacements could go wrong'
ASSIGN2    'test for bad assignment with .fx'
ASYNEXEC   'Test asynchronous execution at compile and execution time'
ASYNNTRP   'Start GAMS job asynchronously and send interrupt signal to it'
B
BADPT1     'Test rejection of models with generation errors'
BADPT2     'Test acceptance of models with generation errors'
BADPT3     'Test rejection of models with generation errors'
BADPT4     'Test acceptance of models with generation errors'
BADPT5     'Test acceptance of models with generation errors'
BARON01    'BARON test suite - basic option reading test'
BARON02    'BARON test suite - bar_space_length is case sensitive'
BARON03    'BARON test suite - test all combinations of LP/NLP solvers'
BENCH01    'BENCH test suite - CALL'
BENCH02    'BENCH test suite - LOG'
BENCH03    'BENCH test suite - LST'
BENCH04    'BENCH test suite - basic option reading test'
BINARY1    'Simple tests for binary boolean operations'
BINARY2    'Tests selected binary operations and functions'
BINARY3    'test binary operation: imp'
BLANK      'Runs GAMS with a parameter containing blanks'
C
CALL1
CALL2      'Check return codes for spawns of gams execute'
CALL3      'Check for standard output conflicts'
CALL4      'Check call with long command line'
CARD01     'Test extended card and ord functions'
CERR1      'Cone Equation Errors'
CHOLES01   'Test cholesky utility'
CHOLES02   'Test cholesky utility'
CIRCLEN    'Circle Enclosing Points n dimensional'
CLEAR1     'Test that option clear works like an assign'
CLEAR2     'Test that we cannot option clear a domain'
CLEAR3     '$clear acts like a data statement and knows about alias'
CLEAR4     '$clear cannot clear predefined symbols'
CLEAR5     'option clear cannot clear predefined symbols'
CLEAR6     'option clear cannot clear known predefined symbols'
CLEAR7     '$clear cannot clear known predefined symbols'
COMPILE1   'AB01031: a solve stmt messed up the symbol table'
COMPILE2   'test for data errors caused by C compiler bug'
COMPILE3   'No mixed mode is allowed in equations'
COMPILE4   '$goto back fails'
COMPILE5   'tests $goto, $ife, and $eval'
COMPILE6   'Test that we can read a Mac-formatted file'
COMPILE7   'Test and document some system.XXX macros'
COMPILE8   'Test for a mapping error'
COMPLINK   'Compile and link external equation libraries'
CONDTWIN   'CONOPTD with two solves in a row'
CONOPT01   'CONOPT test suite - basic option reading test'
CONVERT1   'Test the coinfml option of convert'
CONVERT2   'Basic test of convert output'
CONVERT3   'CONVERT test suite - basic option reading test'
CONVERT4   'CONVERT test suite - proper placing of parenthesis'
CONVERT5   'CONVERT test suite - min(max(x1,x2),x3)'
CONVERT6   'CONVERT test suite - hessian.gdx'
CONVERT7   'CONVERT test suite - test hessian info correctness'
CTRLCMIP   'Test interrupt handling'
CNS01      'Test how bounds change the 1-variable CNS model sqr(x)=4'
CNS02      'Test how bounds change a 2-variable CNS model'
CNS03      'CNS test - holdfixed and singular models'
CNS04      'CNS model with globally unique solution'
CNS05      'CNS model with globally unique solution'
CNS06      'CNS model with globally unique solution'
CNS07      'CNS model with globally unique solution'
CNS08      'CNS model - singular, nonsquare'
CNS09      'CNS model - solvable, singular'
CNS10      'CNS model - solvable, singular'
CNS11      'CNS model - solvable, nonsingular start point'
CNS12      'CNS model - unsolvable model, scaling issues'
CNS13      'CNS model - solvable, globally unique'
CPLEX01    'CPLEX test suite - basic option reading test'
CPLEX02    'CPLEX test suite - tuning test'
CPLEX03    'Test the GAMS/CPLEX link for propper handling of long UEL names and domains larger than 10'
D
DATA1      'Bug test: bad message on max dimensions'
DATTIM1    'basic day/time test for Thursday Jul 4, 2002'
DATTIM2    'day of week test starting Monday Jan 7, 2002'
DATTIM3    'Julian time test'
DATTIM4    'Julian date test'
DATTIM5    'test Gxxx functions'
DATTIM6    'time decoding test'
DDLIST1    'Test the double dash option check'
DECIS01    'Test small DECIS Models with DECISC and DECISM'
DECIS02    'Test of correctness for levels & marginals of LP'
DECIS03    'Test of correctness for levels & marginals of LP'
DECLA1     'Incorrect asterisk list generation'
DECLA2     'Test declaration that crashed on CD21.6'
DELIM1     'check element text'
DELIM2     'Test domain checking on columns under $ondelim'
DELIM3     'Bug test: missing elements not reported'
DELIM4     'Drop dummy in column definition under $ondelim'
DICT1      'test new dictionary (starting with cmex 147)'
DUMPSOL    'Gurobi Alternate Solutions for a Simple Facility Location Problem'
DUMP01     'Test loading/dumping of uels from gdx - quoting!'
E
ECHO1      'Test that $echon does not write a new line'
EDCRYPT1   'tests for endecrypt with and without password'
EIGVAL01   'Test eigenvalue utility'
EIGVEC01   'Test eigenvector utility'
EIGVEC02   'Test eigenvector/eigenvalue utilities'
EMBED1     'Test syntax: bad number field in embedded parameter'
EMBED2     'Compare equivalent data statements'
EMBED3     'Test embedded parameter values: multiplication'
EMP01      'Compares EMP results for a simple LP with known results'
EMP02      'Compares EMP results for a simple NLP with known results'
EMP03      'Check correctness of NLP->MCP reform in EMP'
EMP04      'Compare results of EMP runs using different options for nlp problem'
EMP05      'Test handling of constant equations'
EMP06      'Test of EMP based on trnsport model'
EMP07      'Test of EMP based on trnsport model'
EMP08      'Test of EMP based on trnsport model'
EMP09      'Test initial levels for equilibrium EMP models'
EMP10      'Test of EMP equilibrium models and flip operator'
EMP11      'Test EMP formulations of scarfmcp'
EMPADJ01   'Test for EMPs AdjustEqu/NYslp option'
EMPBP01    'Simple bilevel model, inner problem consists of objective only'
EMPBP02    'Simple bilevel model, outer problem consists of objective only'
EMPBP03    'Simple bilevel model, both inner and outer problems have constraints'
EMPBP04    'Bilevel model with and without well-defined inner objective equation'
EMPBP05    'Bilevel model with MIN follower vs. VI follower'
EMPDISJ1   'Test EMP Disjunction - Minimize the makespan'
EMPDISJ2   'Test Disjunctions involving the objective'
EMPDISJ3   'Test Disjunctions using not (equivalence)'
EMPDISJ4   'Test disjunctions with negative bounds on variables'
EMPDISJ5   'Test disjunctions using not on binary variable and constraint'
EMPDISJ6   'Test disjunctions using negated equality equations'
EMPDISJ7   'Test disjunctions using negated variables in disjunctive terms'
EMPECS01   'Test for EMP-Embedded Complementarity System'
EMPECS02   'Test for EMP-Embedded Complementarity System'
EMPLOG1    'Test disjunctions and logical conditions'
EMPLOG2    'Test simple logical conditions'
EMPLP01    'Simple test on one equation with EMP'
EMPLP02    'Simple level and sign test with EMP'
EMPLP03    'Many free variables and restart with EMP'
EMPLP10    'Poorly-scaled model - small matrix entry implies large x using EMP'
EMPLP11    'Simple test on one =n= equation using EMP'
EMPLP12    'Test solution quality with solvelink=3 using EMP'
EMPLP13    'checks +/- INF on =L=, =G=, and =N= equations using EMP'
EMPVI01    'Simple test for variational inequalities through EMP'
EMPVI02    'Compares manual and EMP-VI models'
EMPVI03    'Compares alternative EMP-VI models'
EMPVI04    'Test for EMP Variational Inequalities'
EMPVI05    "Test for EMP's treatment of a odd variables"
EMPTY1     'checks if empty equation are feasible'
EPS1       'EPS in multiplications and divisions'
EVAL01     'constant evaluation with non-stop arithmetic'
EVAL02     '$eval/ife/...  sameas function'
EVAL03     'test constant compile time evaluation functions'
EVAL04     'test constant compile time evaluation operators'
EVAL05     'constant expression test for ceil,floor,trunc,frac'
EVAL06     'matching operators in a column spec'
EVAL07     'test evaluation of real constants - string2Double conversion'
EX1        'External Function - Example 1'
EX1X       'External Function - Example 1x'
EX2        'External Function - Example 2'
EX3        'External Function - Example 3'
EX4        'External Function - Example 4'
EX4X       'External Function - Example 4x'
EX5        'External Function - Example 5'
ER1        'External Function - Error Example 1'
ER2        'External Function - Error Example 2'
ER3        'External Function - Error Example 3'
EXMCP1     'External Function - Example MCP 1'
EXMCP2     'External Function - Example MCP 2'
EXMCP3     'External Function - Example MCP 3'
EXMCP4     'Hansen/Koopmans: External Function - Example MCP 4 (EXMCP4,SEQ=576)'
EXMCP5     'Intermixed External Rows: External Function - Example MCP 5 (EXMCP5,SEQ=577)'
EXAMIN01   'EXAMINER test suite - basic option reading test'
EXAMIN02   'EXAMINER test suite - runs examiner with selected subsolver'
EXAMIN03   'EXAMINER test suite - test returnInitPoint option'
EXAMIN04   'EXAMINER test suite - test returnGamsPoint option and QCP'
F
FITLIB01   'Test the use of FITPACK inside GAMS'
FNACOS     'Test correctness of arccos intrinsic'
FNACOSX    'Test correctness of arccos intrinsic eXceptions'
FNASIN     'Test correctness of arcsin intrinsic'
FNASINX    'Test correctness of arcsin intrinsic eXceptions'
FNATAN     'Test correctness of arctan intrinsic'
FNATAN2    'Test correctness of arctan2 intrinsic'
FNATAN2N   'Test correctness of arctan2 intrinsic'
FNATAN2X   'Test correctness of arctan2 intrinsic eXceptions'
FNCENTR    'Test correctness of centropy intrinsic'
FNCENTR2   'Test correctness of centropy intrinsic'
FNCENTR3   'Test correctness of centropy intrinsic'
FNCENTR4   'Test correctness of centropy intrinsic'
FNCENTR5   'Test centropy intrinsic on nice inputs'
FNCENTR6   'Test centropy intrinsic on small inputs'
FNCENTRX   'Test correctness of centropy intrinsic eXceptions'
FNCENTRY   'Test correctness of centropy(x,y,d) intrinsic exceptions'
FNCOS      'Test correctness of cos intrinsic'
FNCOSH     'Test correctness of cosh intrinsic'
FNCVPOW    'Test correctness of cvpow intrinsic'
FNCVPOW2   'Test correctness of cvpow intrinsic'
FNCVPOW3   'Test correctness of cvpow intrinsic'
FNEDIST    'Test correctness of edist intrinsic'
FNEDIST2   'Test correctness of edist intrinsic'
FNEDIST3   'Test correctness of edist intrinsic'
FNENTRO    'Test correctness of entropy intrinsic'
FNENTRO2   'Test correctness of entropy intrinsic'
FNERRF     'Test correctness of errorf intrinsic'
FNERRF2    'Test correctness of errorf intrinsic'
FNEXP      'Test correctness of exp intrinsic'
FNFACT     'Test correctness of fact intrinsic'
FNGAMMA    'Test correctness of gamma intrinsic'
FNGAMMA2   'Test correctness of gamma intrinsic'
FNLOG      'Test correctness of log intrinsic'
FNLOG10    'Test correctness of log10 intrinsic'
FNLOG2     'Test correctness of log2 intrinsic'
FNNCPCM    'Test correctness of ncpcm intrinsic'
FNNCPCM2   'Test correctness of ncpcm intrinsic'
FNNCPF     'Test correctness of ncpf intrinsic'
FNNCPF2    'Test correctness of ncpf intrinsic'
FNNCPVUP   'Test correctness of NCPVUpow intrinsic'
FNNCPVUS   'Test correctness of NCPVUsin intrinsic'
FNNCPVUx   'Test correctness of NCPVUxxx intrinsics'
FNPI       'Test correctness of pi intrinsic'
FNPOWER    'Test correctness of power intrinsic'
FNRPOW     'Test correctness of rpower intrinsic'
FNRPOW2    'Test correctness of rpower intrinsic'
FNRPOW3    'Test correctness of rpower intrinsic'
FNSIGMO    'Test correctness of sigmoid intrinsic'
FNSIGMO2   'Test correctness of sigmoid intrinsic'
FNSIN      'Test correctness of sin intrinsic'
FNSINH     'Test correctness of sinh intrinsic'
FNSPOWN    'Test correctness of signpower intrinsic'
FNSPOWX    'Test correctness of signpower intrinsic'
FNSQR      'Test correctness of sqr intrinsic'
FNSQRT     'Test correctness of sqrt intrinsic'
FNTAN      'Test correctness of tan intrinsic'
FNTANH     'Test correctness of tanh intrinsic'
FNVCPOW    'Test correctness of vcpower intrinsic'
FNVCPOW2   'Test correctness of vcpower intrinsic'
FORCEERR   'ForceError and ForceErrorCnt Example'
FUNCBACK   'Test function backward compatibility'
FUNCS1     'Test functions in NLP and DNLP'
FUNCS2     'Test functions in linear models'
FUNCS3     'declaration via a table using function names'
FUNCS4     'Rules for getting derivs/intervals of intrinsics'
FUNCS5     'Test correctness of intrinsic functions'
G
GAMSBAS1   'GAMSBAS test suite - basic option reading test'
GAMSCHK1   'GAMSCHK test suite - basic option reading test'
GBIN1      'Checks to see if we have unix utilities in the path'
GDX1       'Checks opening of gdx files for read and write'
GDX2       'Test loading of old GDX files from other platforms'
GDX3       'gdx test sorting with new elements'
GDX4       'Test renaming of GDX files for load/unload operations'
GDX5       'Checks for unreported GDX error'
GDX6       'GDX Test - Unsorted full domains'
GDX7       'Bad acronym loading'
GDX8       'Bad acronym mapping'
GDX9       'Checks unloading and loading a GDX file with variable attributes'
GDXCOMP1   'Compressed GDX - basic operation'
GDXCOMP2   'GDX - compressed and MT operation'
GDXCONV1   'Compare all combinations of GDXCOMPRESS and GDXCONVERT'
GDXCOPY1   'Test GDXCOPY utility with /V5 option'
GDXCOPY2   'Test GDXCOPY utility with -V6C and V6U options'
GDXCOPY3   'Test GDXCOPY utility with -V7C and V7U options'
GDXCOPY4   'Test internal gdxcopy call and its controls'
GDXCOPY5   'Test GDX environment variables with trailing blanks'
GDXDIFF1   'Test GDXDIFF handling of zeros when eps>0'
GDXDUMP1   'Use GdxDump NoData on Transportation Problem'
GDXMERG1   'test gdxmerge - verify that an aliased set can be merged'
GDXMERG2   'Bad acronym merge in gdxmerge'
GDXMRW01   'test the Matlab utility writegdx'
GDXMRW02   'test the Matlab utility readgdx'
GDXMRW03   'test the Matlab utility rgdx'
GDXMRW04   'test the Matlab utility wgdx'
GDXMRW05   'test the Matlab mex-file gams'
GDXRANK1   'Tests some GDXRANK stuff'
GDXXRW1    'Testing the clear option with larger data'
GDXXRW2    'Testing the clear option with fitting data'
GDXXRW3    'Testing gdxxrw with xls or gdx file'
GDXXRW4    'Test for some scalar read problems'
GDXXRW5    'Test for password handling of gdxxrw'
GDXXRW6    'Test for dset reading problem'
GEN_R1     'Generate GDX file for test of GDXMRW'
GEN_R2     'Generate GDX file for test of GDXMRW'
GEN_RBIG   'Generate GDX file for test of GDXMRW'
GENR2      'Generate test data for read2 test of gdxMrw'
GENR3      'Generate test data for read3 test of gdxMrw'
GENR4      'Generate test data for read4 test of gdxMrw'
GENR5      'Generate test data for read5 test of gdxMrw'
GENW2      'Generate test data for write2 test of gdxMrw'
GENW3      'Generate test data for write3 test of gdxMrw'
GENW4      'Generate test data for write4 test of gdxMrw'
GVERSION   'test the Matlab mex-file gams'
GZIP01     'Test gzipped input files'
H
HANDLE01   'Test the m.handle functionality: submit, wait, resubmit'
HANDLE02   'Test handlecollect with save & restart'
HAR1       'gdx2har and har2gdx test from Example 1'
I
IFNOT1     'Better recognition of $if NOT =='
IFSTAT1    'tests of $if statement'
IFSTAT2    '$IF should allow keywords for SET and ENV'
IFSTAT3    'Tests $if exist and $if dexist'
IFSTAT4    'Tests $if gamslevel and related items'
IFSTAT5    'Tests $if/$ifi/$ife statements'
IFSTAT6    'quick syntax test for all $if/$ifi/$ife statements'
IFSTAT7    'tests for $IF declared and defined'
IFTHEN1    'Test $ifthen and $endif'
IFTHEN2    'Test nested $ifthen and $endif'
IFTHEN3    'Test $ifthen $elseif/else $endif'
IFTHEN4    'Tests $ifthen from old release notes'
IFTHEN5    '$ifthen false without sameline'
IFTHEN6    '$ifthen/elseif false without sameline'
INDIC01    'Test of =g= indicator constraints'
INDIC02    'Test of =e= indicator constraints'
INDIC03    'Test of =e= indicator constraints'
INTERVAL   'Test for interval evaluation'
INVERT01   'Test invert utility'
INVERT02   'Test invert utility on rank-deficient inputs'
J
K
KESTREL1   'Kestrel test for lp solvers'
KESTREL2   'Kestrel test for mcp solvers'
KESTREL3   'Kestrel test for nlp solvers'
KESTREL4   'Kestrel test for minlp solvers'
KNITRO01   'KNITRO test suite - basic option reading test'
L
LAGD1      'Lag and Lead operations on Dynamic Sets'
LAGS1      'Tests simple lag and lead operations'
LGO01      'LGO test suite - basic option reading test'
LINDGL01   'LINDOGLOBAL test suite - lingoglobal as subsolver'
LINDGL02   'Check that Lindo(Global) works with SOS variables'
LINDORNG   'Test for LindoGlobals CheckRange Option'
LINDORG2   'Test for LindoGlobals CheckRange Option'
LOAD1      '$load under $onmulti works like data statements'
LOAD2      'test filtered $load'
LOAD3      'Test exec time loading with missing filter'
LOAD4      'Tests various file opening options for GDX files'
LOAD5      'Tests UNDF with $load'
LOAD6      'Tests dynamic error messages during $loaddc'
LOCAL01    'Test .local in different context $on/offlocal'
LOLP       'LP Test for logoption'
LOMCP      'MCP Test for logoption'
LONLP      'NLP Test for logoption'
LOOP1      'Empty loops with and without control  GT00532'
LOOP2      'Resorting inside a loop with a constant in the search record'
LOOP3      'Check GDX output of loop2 (resorting search records in a loop)'
LOOP4      'complex search structures- tremove2 problem'
LOOP5      'complex search structures- tremove2 problem'
LOOP6      'sys11 testcase'
LOOP7      'Test assignment using a map'
LOOP8      'Test optimization of a control set with a single element'
LOOP9      'Test use of set with a single element in a loop'
LP01       'Simple test on one equation'
LP02       'Simple level and sign test'
LP03       'Many free variables and restart'
LP04       'Tests basic modelstat codes'
LP05       'Test iteration interrupt for optimal and infeasible models'
LP06       'Test iteration interrupts and optimal restarts'
LP07       'Test restarts with reslim'
LP08       'Test the proper return of free equations'
LP09       'Many free variables and restart'
LP10       'Poorly-scaled model - small matrix entry implies large x'
LP11       'Simple test on one =n= equation'
LP12       'Test solution quality with solvelink=3'
LP13       'checks +/- INF on =L=, =G=, and =N= equations'
LP14       'Simple test on one equation AFTER reformulation'
LS01       'Test LS (Least Squares) utility - lower difficulty'
LS02       'Test LS (Least Squares) utility - higher difficulty'
LS03       'Test LS (Least Squares) utility - higher dimensions for GDX'
LS04       'Test LS (Least Squares) utility - higher dimensions for GDX'
M
MACRO01    'several macro tests'
MACRO02    'multi-line macro test'
MAP1       'simple mapped assignment'
MATCH01    'Test matching operator: compile and execution time'
MATH1      'Demonstrate an inaccurate calculation'
MAXIMA     'Test several maxima of Cmex'
MCP01      'Illustrate rules for matching =E= equations in MCP'
MCP02      'Illustrate rules for matching =G= equations in MCP'
MCP03      'Illustrate rules for matching =L= equations in MCP'
MCP04      'Illustrate rules for matching =N= equations in MCP'
MCP05      'Test simple 2x2 MCP model where preprocessing solves it'
MCP06      'Test level/marginal correctness and conventions for MCP'
MCP07      'Test level/marginal correctness and conventions for MCP'
MCP08      'Test MCP that turfs up PATH proprocessing error'
MCP09      'Test inequalities with infinite bounds'
MDB2GMS1   'Test database access with MDB2GMS'
MERR1      'Matrix Errors'
MILES01    'MILES test suite - basic option reading test'
MINOS01    'MINOS test suite - anti-cycling via expand frequency'
MIP01      'Test for known XPRESS bug'
MIP02      'Check on MIP solution value'
MIP03      'Test for zero gap when optcr and optca set to zero'
MIP04      'Exercise new XPRESS return code for unbounded MIP'
MIP05      'Maximum queens chess problem'
MIP06      'Cuts and solution enumeration'
MIQCP01    'Test of correctness for levels & marginals of MIQCP'
MIQCP02    'Test of correctness of solvestat'
MOSEK01    'MOSEK test suite - basic option reading test'
MPEC01     'MPEC model to test all types of matches, using =N='
MPEC02     'Run through equreform options for NLPEC solver'
MPEC03     'MPEC model to test all types of matches, using =ELG='
MPECDU01   'MPECDUMP test suite - basic option reading test'
MPSGE01    'Illustrate correct naming in MPSGE - new rules'
MPSGE02    'Illustrate correct naming in MPSGE - old rules'
MPSGE03    'MPSGE naming test: labels cannot contain a space'
MPSGE04    'MPSGE naming test: labels cannot contain a !'
MPSGE05    'MPSGE naming test: labels cannot contain a "'
MPSGE06    "MPSGE naming test: labels cannot contain a '"
MPSGE07    'MPSGE naming test: labels cannot contain a .'
MPSGE08    'MPSGE naming test: labels cannot contain a :'
MPSGE09    'MPSGE naming test: labels cannot be empty'
MPSGE10    'MPSGE scaleopt test - m.scaleopt must be 0'
MPSGE11    'MPSGE test -  multiple fixed income levels'
MPSGE12    'MPSGE test - inter-mixed MPSGE and MCP rows in model'
MPSWRIT1   'MPSWRITE test suite - basic option reading test'
MSNLP01    'Test for MSNLP and external NLP codes'
N
NEST1      'nested If - loop - solve test with alias'
NEST2      'nested if loop solve test with map'
NLCODE1    'test for NL code generation error GT00470'
NLCODE2    'Test limits on nonlinear code length per block'
NLCODE3    'Wrong NL code generation for odd case'
NLCODE4    'more NL testing when code is deleted'
NLCODE5    'Test for NL code bug from Dist 23.6'
NLCODE6    'Test for NL code bug from Dist 23.6'
NLPEC01    'NLPEC test suite - options test'
NLPEC02    'NLPEC test suite - loop over DNLP solvers'
NLPLP02    'Simple level and sign test'
NLP01      'Test of correctness for levels & marginals of NLP'
NLPQCP01   'Test of correctness for levels & marginals of NLP'
NLPQCP02   'Test modsolstat & solution correctness - multiple QCons'
NONNEG     'Check that NonNegative do same as Positive Variables'
O
ONELAB1    'One element dynamic control inside IF'
ONELAB2    'One element dynamic extracted from TSP'
ONMULTI1   'With onmulti we can expand the domain'
ONMULTI2   'Onmulti operates like a replace'
ONMULTI3   'Onmulti may violate the ordered property'
ONMULTI4   'The onmulti merge may destroy the ordered property'
ONMULTI5   'Test set table and onmulti with deletes'
ONMULTI6   'Test merge with $onmulti and $gdxin'
ONMULTI7   'Test merge with $onmulti and empty data statement'
OQNLP01    'OQNLP/MSNLP test suite'
P
PATH01     'PATH test suite - basic option reading test'
PATHNLP1   'PATHNLP test suite - basic option reading test'
PATHNLP2   'PATHNLP test suite - basic option reading test'
PERM1      'Test for various permutations'
PFMAPTST   'Checks files in distribution'
PGAMS01    'Test procdir deletion in pgams'
PGAMS02    'Test procdir deletion in pgams'
PHANTOM1   'Phantoms can only have default values'
PHANTOM2   'Phantoms can only have default values - ondelim'
PIPE1      'piped assignment - permutation for two dimensions'
PIPE2      'piped assignment - permutation for two dimensions'
PIPE3      'piped projections'
PIPE4      'piped sort'
PIPE5      'piped projection and counts to 1,2,3 dimensions'
PIPE6      'piped projection and counts to 1,2,3 dimensions and sorts'
PIPE7      'Test the elemcount on two dim sets'
PIPE8      'Test that projecting to self works OK'
PIPE9      'Test for projecting'
PIPE10     'Test for projecting scalars'
POINT1     'execute_loadpoint is a merge operation'
POINT2     'execute_load is a replacement operation'
POWER1     'compare real and integer power for normal values'
POWER2     'test integer powers from -299 to +299'
PRIVAT01   'Test private workfile behavior'
PUT1       'aliased set and .te'
PUT2       '.nr=2 writes scientific notation'
PUT3       '.nr=2 writes scientific - test for errors'
PUT4       'uses system.f? and compares with full file name'
PUT5       'Test put fallback when writing directory'
PUT6       'Test put utility rename feature'
PUT7       'Test bad $on/offput in if statement'
PUT8       'Test put utility exec feature'
PUT9       'Test empty line at the end of rename'
PUT10      '$on/offput inserted outside the loop'
PWPLIB01   'Test piecewise polynomials in pwpcclib'
Q
QCP01      'Test of correctness for levels & marginals of QCP'
QCP02      'Test modsolstat & solution correctness - multiple QCons'
QCP03      'Test case for cancellation in quadratic terms'
QCP04      'Test modsolstat & solution correctness - multiple QCons'
QCP05      'Test case for poly function'
QCP06      'Nonlinear model cannot be solved as QCP'
QCP07      'Test correctness for QCP with poly function'
QCP08      'Test correctness for QCP with power(*,2) function'
QCP09      'Simplest test for QCP correctness'
QCP10      'Test for QCP correctness'
QUALITY    'Driver for quality tests of all sorts'
R
REST2      'Test restart from new (Rev 142 & later) workfiles'
RESTART1   'Test restart from old workfiles'
RESTART2   'Test restart from new (Rev 142 & later) workfiles'
S
SAMEAS1    'tests different sameas uses'
SAVE2      'Test restart from new (Rev 142 & later) workfiles'
SAVEP1     'execute_loadpoint: save point - clear - loadpoint - reoptimize'
SBB01      'SBB test suite - basic option reading test'
SBB02      'SBB test suite - SOS2 test'
SCEN01     'Compile time test for the scenario facility'
SCEN02     'Execution time test for the scenario facility'
SCEN03     'Multi-dimensional scenario solver test'
SCENSOL1   'Basic Scenario Solver Test'
SCENSOL2   'Test handling of unsorted scenario UELs in GUSS'
SCENSOL3   'NoMatchLimit GUSS Test'
SCNRED01   'Basic Scenred2 test - tree construction'
SCNRED02   'Scenred2 test - tree reduction and zero values'
SEMICON1   'Simple test of SEMICONT variables'
SEMIINT1   'Simple test of SEMIINT variables'
SET1       'test basic $set scopting'
SET2       'more on $set scoping'
SET3       '$set and $drop scoping'
SET4       'set $set with includes'
SET5       'split file name'
SET6       'split a gams name into components'
SET7       'split the file name and recombine'
SET8       'Test the set.id set#id #id data macros'
SET9       'fast shifting of set elements'
SET10      'first entry in set/param data has wrong dimension'
SET11      'test for order when using set.id or set#id or #id'
SL4CNS01   'Test 1-variable CNS model, with solvelink=4'
SL4CNS02   'Test 2-variable CNS model, with solvelink=4'
SL4CNS03   'Test holdfixed and singular models, with solvelink=4'
SL4CNS04   'Test globally unique CNS model, with solvelink=4'
SL4CNS05   'Test globally unique CNS model, with solvelink=4'
SL4CNS06   'Test globally unique CNS model, with solvelink=4'
SL4CNS07   'Test globally unique CNS model, with solvelink=4'
SL4CNS08   'Test singular nonsquare CNS model, with solvelink=4'
SL4CNS09   'Test solvable singular CNS model, with solvelink=4'
SL4CNS10   'Test solvable singular CNS model, with solvelink=4'
SL4CNS11   'Test solvable CNS model, with solvelink=4'
SL4CNS12   'Test unsolvable CNS model, with solvelink=4'
SL4CNS13   'Test solvable CNS model, with solvelink=4'
SL4LP01    'Simple test on one equation, with solvelink=4'
SL4LP02    'Simple level and sign test, with solvelink=4'
SL4LP03    'Many free variables and restart, with solvelink=4'
SL4LP10    'Poorly-scaled model, with solvelink=4'
SL4LP11    'Simple test on one =n= equation, with solvelink=4'
SL4MCP01   'Test matching =E= equations in MCP, with solvelink=4'
SL4MCP02   'Test matching =G= equations in MCP, with solvelink=4'
SL4MCP03   'Test matching =L= equations in MCP, with solvelink=4'
SL4MCP04   'Test matching =N= equations in MCP, with solvelink=4'
SL4MCP06   'Test correctness/conventions for MCP, with solvelink=4'
SL4MIP01   'Test for known XPRESS bug, with solvelink=4'
SL4QCP01   'Test of correctness for levels & marginals of QCP, with solvelink=1,2,4,5'
SL4QCP02   'Test modsolstat & solution correctness - multiple QCons, with solvelink=1,2,4,5'
SL4QCP03   'Test case for cancellation in quadratic terms, with solvelink=1,2,4,5'
SL4SCON1   'Simple test of SEMICONT variables, with solvelink=4'
SL4SOS1A   'Test of SOS1 variables with active upper bounds, with solvelink=4'
SORT1      'Test optimization with lags'
SOS1A      'Test of SOS1 variables with active upper bounds'
SOS2A      'Test of SOS2 variables'
STOLIB01   'Test extrinsic functions in stodclib'
SQL2GMS1   'Test database access with SQL2GMS'
SUFFIX01   'Test suffix options on controlling sets'
SYMXREF1   'Test cross-reference generation problem'
SYSCHK1    'Test impact of sys11 setting'
SYSENV01   'Tests for path and system environment strings'
SYSENV02   'Tests for setenv and dropenv'
T
TABSUBST   'tab and string subsitution for long line'
TESTEXEQ   'Test external equations'
TESTER     'handy way to test at compile time'
TESTHTM    'Generates HTM testlib library files'
TESTINST   'test the Matlab mex-file gams'
TESTUTIL   'Generates some useful files from the Test Model Library'
TITLE1     'My Title'
TRACEUC    'Test if we can get the user and computer name in a trace file'
TRAMP01    'TRAMP test suite - basic option reading test'
TRILIB01   'Test extrinsic functions in tricclib'
TRILIB02   'Test extrinsic functions in tridclib'
TRILIB03   'Test extrinsic functions in trifclib'
TRILIB04   'Demonstrates problems with a stateful function library'
TRYLIN01   'Test model attribute TryLinear'
U
UNARY1     'tests mapval function'
UNARY2     'simple test on unary operations with "crazy" values'
UNDF1      '$onundf/offundf changes the scanner'
UNIV1      'No assignment to universe'
UNLOAD1    'multiple unloads of the same item are OK'
UNLOAD2    'cannot unload different items to same gdx name'
UNLOAD3    'ignore gdx suffix'
UNLOAD4    'commas are optional'
UNLOAD5    'multiple $unloads of the same item are OK'
UNLOAD6    'cannot $unload different items to same gdx name'
UNLOAD7    'ignore gdx suffix'
UNLOAD8    '$unload lines are treated as one for errors'
UNLOAD9    'Test export of defaults for uninitialized scalars'
UTILS01    'test mps2gms - run it and solve the resulting model'
UTILS02    'test MPS2GMS - it had range problems'
UTILS03    'test MPS2GMS for reading the second range entry on a line'
V
VARDAT01   'test scalar var/equ data statements'
VARDAT02   'test indexed var/equ data statements'
VARDAT03   'test var/equ data statements with $onempty'
VARDAT04   'test indexed var/equ data statements with $onmulti'
VARDAT05   'test table var/equ data statements with $onmulti'
VEDA1      'tests that we can execute gdx2veda'
W
WARNING1   'set limit on compilation warnings with WARNING=n'
WARNING2   'compilation warnings are ignored'
X
XA01       'XA test suite - basic option reading test'
XERR1      'External Function Errors: RHS wrong'
XERR2      'External Function Errors: Aij wrong'
XPRESS01   'XPRESS test suite - basic option reading test'
XPRESS02   'XPRESS test suite - check levels and marginals'
XPRESS03   'XPRESS test suite - solution pool example'
XPRESS04   'XPRESS test suite - solution enumerator example'
XPRESS05   'XPRESS test suite - solution enumerator example'
Y
Z
               /

    letters(m) / a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z /

set inc 'list of include files, .inc extension assumed' /
  'testmod'     TESTLIB Model Library
  'exchange'    'simple exchange model in MPSGE format, with post-tests'
  'mcp0x'       'simple MCP model with tests for correct returns'
  'fnset_x'     'intrinsics tests for f(x)'
  'fnset_xy'    'intrinsics tests for f(x,y)'
  'fnset_xyz'   'intrinsics tests for f(x,y,z)'
  'fntest_x'    'intrinsics tests for f(x)'
  'fntest_xy'   'intrinsics tests for f(x,y)'
  'fntest_xyz'  'intrinsics tests for f(x,y,z)'
  'badpt'       'models with bad initial points'
/;

$onempty
set minc(m) 'list of model files $included' /
 'qcp01'
 'qcp02'
 'qcp03'
 'mpec01'
 'lp01'
 'lp02'
 'nlplp02'
 'loop2'
 'rest2'
 'gen_r1', 'gen_r2'
 'genw2', 'genw3', 'genw4'
 'genr2', 'genr3', 'genr4', 'genr5'
 'lp03'
 'lp10'
 'lp11'
 'sos1a'
 'semicon1'
 'mcp01'
 'mcp02'
 'mcp03'
 'mcp04'
 'mip01'
 'cns01'
 'cns02'
 'cns03'
 'cns04'
 'cns05'
 'cns06'
 'cns07'
 'cns08'
 'cns09'
 'cns10'
 'cns11'
 'cns12'
 'cns13'
 'mcp06'
 'lp12'
 'lp13'
 'pgams01'
 'testinst'
 'gversion'
 'complink'
/;
$offempty

set oinc 'list of other files needed and/or $included' /
 'allpfmap.gdx'
 'gdxtest.zip.ignore'
 'restest.zip.ignore'
 'res2test.zip.ignore'
 'validnlpecopts.gdx'
 'fnsqr.gdx'
 'fnexp.gdx'
 'fnlog.gdx'
 'fnlog2.gdx'
 'fnlog10.gdx'
 'fnsqrt.gdx'
 'fncos.gdx'
 'fnsin.gdx'
 'fnpower.gdx'
 'fnpi.gdx'
 'fnncpf.gdx'
 'fnncpvupow.gdx'
 'fnncpvusin.gdx'
 'fnsinh.gdx'
 'fncosh.gdx'
 'fntanh.gdx'
 'fnvcpow.gdx'
 'fngamma.gdx'
 'fnatan.gdx'
 'fnerrf.gdx'
 'fnerrf2.gdx'
 'fnncpcm.gdx'
 'fnncpcm2.gdx'
 'fnentro.gdx'
 'fnsigmo.gdx'
 'fnrpow.gdx'
 'fnrpow2.gdx'
 'math1min.gdx'
 'math1max.gdx'
 'ex1_.gdx'
 'ex1_lab_.gdx'
 'ex2.gdx'
 'exr3.gdx'
 'exr4.gdx'
 'exr5.gdx'
 'exw3_.gdx'
 'exw3_lab_.gdx'
 'rbatch.m'
 'read1.m'
 'read2.m'
 'read3.m'
 'read4.m'
 'read5.m'
 'rtrns.m'
 'trnsport.gdx'
 'wbatch.m'
 'write1.m'
 'write2.m'
 'write2a_.gdx'
 'write2b_.gdx'
 'write3.m'
 'write4.m'
 'write4a_.gdx'
 'write4b_.gdx'
 'fntan.gdx'
 'fnacos.gdx'
 'fnasin.gdx'
 'fnatan2.gdx'
 'fncentr.gdx'
 'fncentr2.gdx'
 'fncentr3.gdx'
 'fncentr5.gdx'
 'fncentr6.gdx'
 'macsource.zip.ignore'
 'querytest.mdb'
 'querytest.gdx'
 'gdx6.gdx'
 'gdxxrw5.xls'
 'x5555.gdx'
 'read1.gdx'
 'read2.gdx'
 'readbig.gdx'
 'r_batch.m'
 'r1.m'
 'r2.m'
 'rsparse.m'
 'rfull.m'
 'writeset_.gdx'
 'writepar_.gdx'
 'w_batch.m'
 'writeset.m'
 'writepar.m'
 'testinst.m'
 'xerr.zip.ignore'
 'mip02_solu.gdx'
 'nlcode5.gdx'
 'Ex1j.h','Ex1j.java','Ex1jwrap.c','geheader.h','ex1c.c','ex1c_cb.c','ex1d.dpr',
 'ex1d_cb.dpr','geheader_d.pas','geheader2_d.pas','ex1f.f90','ex1f_cb.f90','gehelper.f90','msg2_f.f90'
 'ex1xc_cb.c', 'ex1xf.f90'
 'ex2c_cb.c', 'ex2d_cb.dpr', 'ex2f_cb.f90'
 'ex3c_cb.c', 'ex3d.dpr', 'ex3f_cb.f90'
 'ex4c_cb.c', 'ex4d.dpr', 'ex4f_cb.f90', 'deasolu.gdx'
 'ex4xc_cb.c', 'ex4xf_cb.f90'
 'ex5c.c', 'ex5f.f90'
 'er1c_cb.c', 'er1f_cb.f90'
 'er2c_cb.c', 'er2f_cb.f90'
 'er3c_cb.c', 'er3f_cb.f90'
 'exmcp1c.c', 'exmcp1f.f90'
 'exmcp2c.c', 'exmcp2c_cb.c', 'exmcp2f.f90', 'exmcp2f_cb.f90'
 'exmcp3c_cb.c', 'exmcp3f_cb.f90'
 'exmcp4c_cb.c', 'exmcp4f_cb.f90'
 'exmcp5c.c'
/;

set linc 'list of library files needed (these are not in src/testlib_ml)' /
 'ex1c.LIBSTEM'
 'ex1c_cb.LIBSTEM'
 'ex1d.LIBSTEM'
 'ex1d_cb.LIBSTEM'
 'ex1f.LIBSTEM'
 'ex1f_cb.LIBSTEM'
 'ex1xc_cb.LIBSTEM'
 'ex1xf.LIBSTEM'
 'ex2c_cb.LIBSTEM'
 'ex2d_cb.LIBSTEM'
 'ex2f_cb.LIBSTEM'
 'ex3c_cb.LIBSTEM'
 'ex3d.LIBSTEM'
 'ex3f_cb.LIBSTEM'
 'ex4c_cb.LIBSTEM'
 'ex4d.LIBSTEM'
 'ex4f_cb.LIBSTEM'
 'ex4xc_cb.LIBSTEM'
 'ex4xf_cb.LIBSTEM'
 'ex5c.LIBSTEM'
 'ex5f.LIBSTEM'
 'er1c_cb.LIBSTEM'
 'er1f_cb.LIBSTEM'
 'er2c_cb.LIBSTEM'
 'er2f_cb.LIBSTEM'
 'er3c_cb.LIBSTEM'
 'er3f_cb.LIBSTEM'
 'exmcp1c.LIBSTEM'
 'exmcp1f.LIBSTEM'
 'exmcp2c.LIBSTEM'
 'exmcp2c_cb.LIBSTEM'
 'exmcp2f.LIBSTEM'
 'exmcp2f_cb.LIBSTEM'
 'exmcp3c_cb.LIBSTEM'
 'exmcp3f_cb.LIBSTEM'
 'exmcp4c_cb.LIBSTEM'
 'exmcp4f_cb.LIBSTEM'
 'exmcp5c.LIBSTEM'
 'tricclib.LIBSTEM'
 'tridclib.LIBSTEM'
 'trifclib.LIBSTEM'
 'trisource.zip.ignore'
/;
set ainc(*) 'all include files';
* ainc(u) = inc(u) or minc(u);
ainc(u) = inc(u) or sum{minc,sameas(minc,u)} or sum{oinc,sameas(oinc,u)} or sum{linc,sameas(linc,u)};
*display ainc;

$stitle Model Assignments
set sm(s,m) model sequence number assignment /
  1.testutil,  11.clear3  ,  21.load1   ,  31.point2  ,  41.set4
  2.quality ,  12.clear4  ,  22.loop1   ,  32.power1  ,  42.set5
  3.assign1 ,  13.clear5  ,  23.onmulti1,  33.power2  ,  43.set6
  4.binary1 ,  14.clear6  ,  24.onmulti2,  34.put1    ,  44.set7
  5.binary2 ,  15.clear7  ,  25.onmulti3,  35.put2    ,  45.tester
  6.call1   ,  16.dattim1 ,  26.onmulti4,  36.put3    ,  46.title1
  7.call2   ,  17.dattim2 ,  27.onmulti5,  37.put4    ,  47.unary1
  8.call3   ,  18.funcs1  ,  28.phantom1,  38.set1    ,  48.unary2
  9.clear1  ,  19.gdx1    ,  29.phantom2,  39.set2    ,  49.undf1
 10.clear2  ,  20.ifnot1  ,  30.point1  ,  40.set3    ,  50.unload1

 51.unload2 ,  61.gbin1   ,  71.lp06    ,  81.mpsge04 ,  91.cns01
 52.unload3 ,  62.nest1   ,  72.lp07    ,  82.mpsge05 ,  92.cns02
 53.unload4 ,  63.nest2   ,  73.lp08    ,  83.mpsge06 ,  93.cns03
 54.unload5 ,  64.nlcode1 ,  74.qcp01   ,  84.mpsge07 ,  94.cns04
 55.unload6 ,  65.savep1  ,  75.qcp02   ,  85.mpsge08 ,  95.cns05
 56.unload7 ,  66.lp01    ,  76.nlpqcp01,  86.qcp03   ,  96.cns06
 57.unload8 ,  67.lp02    ,  77.nlpqcp02,  87.qcp04   ,  97.cns07
 58.warning1,  68.lp03    ,  78.mpsge01 ,  88.lp09    ,  98.cns08
 59.warning2,  69.lp04    ,  79.mpsge02 ,  89.gdx2    ,  99.cns09
 60.empty1  ,  70.lp05    ,  80.mpsge03 ,  90.restart1, 100.cns10

101.cns11   , 111.pipe1   , 121.dattim5 , 131.nlplp02 , 141.gdxrank1
102.cns12   , 112.pipe2   , 122.dattim6 , 132.oqnlp01 , 142.bench01
103.cns13   , 113.pipe3   , 123.eps1    , 133.sameas1 , 143.bench02
104.mpec01  , 114.pipe4   , 124.funcs2  , 134.loop2   , 144.bench03
105.mpec02  , 115.pipe5   , 125.delim1  , 135.loop3   , 145.nlpec01
106.sos1a   , 116.pipe6   , 126.decla1  , 136.mpec03  , 146.embed1
107.mpsge09 , 117.gdx3    , 127.mcp01   , 137.loop4   , 147.embed2
108.mpsge10 , 118.lp10    , 128.mcp02   , 138.funcs3  , 148.funcs4
109.semicon1, 119.dattim3 , 129.mcp03   , 139.loop5   , 149.funcs5
110.nlcode2 , 120.dattim4 , 130.mcp04   , 140.ifstat1 , 150.fnsqr

151.fnexp   , 161.fnsinh  , 171.onelab2 , 181.fnvcpow , 191.fnentro2
152.fnlog   , 162.fncosh  , 172.gdxxrw1 , 182.fnvcpow2, 192.fnsigmo
153.fnlog2  , 163.fntanh  , 173.gdxxrw2 , 183.fngamma , 193.fnsigmo2
154.fnlog10 , 164.fnfact  , 174.gdxxrw3 , 184.fngamma2, 194.fnrpow
155.fnsqrt  , 165.fnncpf2 , 175.gdxxrw4 , 185.fnatan  , 195.fnrpow2
156.fncos   , 166.lags1   , 176.univ1   , 186.fnerrf  , 196.fnrpow3
157.fnsin   , 167.sort1   , 177.ddlist1 , 187.fnerrf2 , 197.fnedist
158.fnpower , 168.onelab1 , 178.badpt1  , 188.fnncpcm , 198.fnedist2
159.fnpi    , 169.loop6   , 179.badpt2  , 189.fnncpcm2, 199.fnedist3
160.fnncpf  , 170.map1    , 180.badpt3  , 190.fnentro , 200.fncvpow

201.fncvpow2, 211.convert1, 221.load2   , 231.ifstat3 , 241.genr3
202.fncvpow3, 212.convert2, 222.decla2  , 232.pipe10  , 242.genr4
203.badpt4  , 213.loop8   , 223.pipe7   , 233.fnncpvus, 243.genr5
204.badpt5  , 214.dump01  , 224.msnlp01 , 234.fnncpvup, 244.genw2
205.symxref1, 215.mip01   , 225.loop9   , 235.fnncpvux, 245.genw3
206.echo1   , 216.save2   , 226.pipe8   , 236.gdxdiff1, 246.genw4
207.syschk1 , 217.rest2   , 227.pipe9   , 237.embed3  , 247.gdxmrw01
208.unload9 , 218.restart2, 228.math1   , 238.handle01, 248.gdxmrw02
209.loop7   , 219.sysenv01, 229.put5    , 239.ifstat4 , 249.load3
210.ifstat2 , 220.sysenv02, 230.delim2  , 240.genr2   , 250.compile1

251.lp11    , 261.pathnlp1, 271.fnacosx , 281.tramp01 , 291.sl4lp03
252.lp12    , 262.pathnlp2, 272.fnasin  , 282.gdxcomp1, 292.sl4lp10
253.sl4lp01 , 263.cplex01 , 273.fnasinx , 283.knitro01, 293.sl4lp11
254.sl4lp02 , 264.mosek01 , 274.fnatan2 , 284.examin01, 294.sl4sos1a
255.mcp05   , 265.baron01 , 275.fnatan2n, 285.mpecdu01, 295.sl4scon1
256.utils01 , 266.convert3, 276.fnatan2x, 286.xa01    , 296.sl4mcp01
257.gamsbas1, 267.sbb01   , 277.bench04 , 287.xpress01, 297.sl4mcp02
258.gamschk1, 268.lgo01   , 278.miles01 , 288.xpress02, 298.sl4mcp03
259.mpswrit1, 269.fntan   , 279.sbb02   , 289.compile2, 299.sl4mcp04
260.path01  , 270.fnacos  , 280.conopt01, 290.gdxcopy1, 300.sl4cns01

301.sl4cns02, 311.sl4cns12, 321.compile3, 331.ifstat7 , 341.sl4mcp06
302.sl4cns03, 312.sl4cns13, 322.gdx4    , 332.convert4, 342.mdb2gms1
303.sl4cns04, 313.put6    , 323.put8    , 333.convert5, 343.sql2gms1
304.sl4cns05, 314.put7    , 324.compile4, 334.edcrypt1, 344.nlpec02
305.sl4cns06, 315.baron02 , 325.ifstat5 , 335.handle02, 345.sos2a
306.sl4cns07, 316.testhtm , 326.ifstat6 , 336.compile6, 346.semiint1
307.sl4cns08, 317.fncentr , 327.compile5, 337.binary3 , 347.delim3
308.sl4cns09, 318.fncentr2, 328.dict1   , 338.onmulti6, 348.data1
309.sl4cns10, 319.fncentr3, 329.lp13    , 339.lindgl01, 349.gdx5
310.sl4cns11, 320.fncentrx, 330.veda1   , 340.mcp06   , 350.gdxcopy2

351.baron03 , 361.fncentr5, 371.match01 , 381.emplp03 , 391.invert01
352.call4   , 362.fncentr6, 372.vardat01, 382.emplp10 , 392.invert02
353.pfmaptst, 363.gdxmerg1, 373.vardat02, 383.emplp11 , 393.gdxconv1
354.gdxcopy3, 364.ifthen1 , 374.decis02 , 384.emplp12 , 394.ls01
355.har1    , 365.decis01 , 375.decis03 , 385.emplp13 , 395.ls02
356.cplex02 , 366.condtwin, 376.vardat03, 386.emp01   , 396.gdx6
357.nonneg  , 367.examin02, 377.vardat04, 387.emp02   , 397.ls03
358.cplex03 , 368.blank   , 378.vardat05, 388.emp03   , 398.ls04
359.fncentry, 369.put9    , 379.emplp01 , 389.mcp07   , 399.gdxcopy4
360.fncentr4, 370.delim4  , 380.emplp02 , 390.qcp05   , 400.convert6

401.mcp08   , 411.choles01, 421.empbp02 , 431.emp04   , 441.empadj01
402.assign2 , 412.choles02, 422.empbp03 , 432.privat01, 442.emp05
403.macro01 , 413.eigvec02, 423.empvi01 , 433.minos01 , 443.examin03
404.gdx7    , 414.load4   , 424.empvi02 , 434.scnred02, 444.compile8
405.gdx8    , 415.nlp01   , 425.empvi03 , 435.empvi05 , 445.sl4mip01
406.gdxmerg2, 416.suffix01, 426.empvi04 , 436.nlcode3 , 446.macro02
407.scensol1, 417.card01  , 427.empecs01, 437.set8    , 447.put10
408.scnred01, 418.lp14    , 428.empecs02, 438.nlcode4 , 448.set9
409.eigval01, 419.convert7, 429.empdisj1, 439.compile7, 449.set10
410.eigvec01, 420.empbp01 , 430.local01 , 440.mcp09   , 450.set11

451.gdxcopy5, 461.lomcp   , 471.emp08   , 481.mpsge11 , 491.onmulti7
452.ifthen2 , 462.eval03  , 472.pgams01 , 482.trylin01, 492.emp09
453.ifthen3 , 463.eval04  , 473.pgams02 , 483.gen_r1  , 493.xerr1
454.ifthen4 , 464.examin04, 474.tabsubst, 484.gen_r2  , 494.xerr2
455.eval01  , 465.empbp04 , 475.eval07  , 485.gen_rbig, 495.cerr1
456.eval02  , 466.empbp05 , 476.dumpsol , 486.gdxmrw03, 496.merr1
457.forceerr, 467.eval05  , 477.ifthen5 , 487.gdxmrw04, 497.mip02
458.gdxxrw5 , 468.eval06  , 478.ifthen6 , 488.testinst, 498.mip03
459.lolp    , 469.emp06   , 479.utils02 , 489.gversion, 499.emp10
460.lonlp   , 470.emp07   , 480.utils03 , 490.gdxmrw05, 500.emp11

501.empdisj2, 511.qcp07   , 521.trilib01, 531.fnspown , 541.indic01
502.gdxxrw6 , 512.qcp08   , 522.trilib02, 532.nlcode5 , 542.indic02
503.qcp06   , 513.empdisj4, 523.trilib03, 533.scensol2, 543.kestrel1
504.gdxdump1, 514.funcback, 524.lindorg2, 534.nlcode6 , 544.kestrel2
505.lindorng, 515.asynexec, 525.mip04   , 535.scensol3, 545.kestrel3
506.interval, 516.scen01  , 526.load5   , 536.gzip01  , 546.kestrel4
507.empdisj3, 517.empdisj5, 527.pwplib01, 537.sl4qcp01, 547.indic03
508.emplog1 , 518.scen02  , 528.fitlib01, 538.sl4qcp02, 548.xpress03
509.maxima  , 519.scen03  , 529.load6   , 539.sl4qcp03, 549.mip05
510.emplog2 , 520.stolib01, 530.fnspowx , 540.miqcp01 , 550.xpress04

551.circlen , 561.miqcp02,  571.er2,      581.empdisj6
552.trilib04, 562.testexeq, 572.er3,      582.gdx9
553.mip06,    563.ex1,      573.exmcp1,   583.empdisj7
554.xpress05, 564.ex1x,     574.exmcp2,   584.traceuc
555.qcp09,    565.ex2,      575.exmcp3,   585.asynntrp
556.perm1,    566.ex3,      576.exmcp4
557.ctrlcmip, 567.ex4,      577.exmcp5
558.mpsge12,  568.ex4x,     578.complink
559.gdxcomp2, 569.ex5,      579.lindgl02
560.lagd1,    570.er1,      580.qcp10

$hidden seq . name mapping goes here
                                                /

set incmap(*,s) 'list of $included files required for model s' /
$hidden enter new include files and/or new $includes
$hidden testlib will copy $included files according to this mapping
testmod       .(1,2,316)
qcp01         .76
qcp02         .77
exchange      .(80*85,107)
'gdxtest.zip.ignore' .89
'restest.zip.ignore' .90
'validnlpecopts.gdx'.145
mpec01        .(105,145,344)
lp02          .131
nlplp02       .132
mcp0x         .(127*130)
loop2         .135
fnset_x       .(150*157,161*164,183*187,190*193,269*273,317*319)
fnset_xy      .(158,181*182,194*196,274*276,359*362,530,531)
fnset_xyz     .(160,165,188*189,233*235)
fntest_x      .(150*157,161*164,183*187,190*193,269*273,317*319)
fntest_xy     .(158,181*182,194*196,274*276,359*362,530,531)
fntest_xyz    .(160,165,188*189,233*235)
'fnsqr.gdx'   .150
'fnexp.gdx'   .151
'fnlog.gdx'   .152
'fnlog2.gdx'  .153
'fnlog10.gdx' .154
'fnsqrt.gdx'  .155
'fncos.gdx'   .156
'fnsin.gdx'   .157
'fnpower.gdx' .158
'fnpi.gdx'    .159
'fnncpf.gdx'  .160
'fnncpvupow.gdx' .234
'fnncpvusin.gdx' .233
'fnsinh.gdx'  .161
'fncosh.gdx'  .162
'fntanh.gdx'  .163
badpt         .(178*179,203)
'fnvcpow.gdx' .181
'fngamma.gdx' .183
'fnatan.gdx'  .185
'fnerrf.gdx'  .186
'fnerrf2.gdx' .187
'fnncpcm.gdx' .188
'fnncpcm2.gdx'.189
'fnentro.gdx' .190
'fnsigmo.gdx' .192
'fnrpow.gdx'  .194
'fnrpow2.gdx' .195
('res2test.zip.ignore',rest2) .218
('math1min.gdx','math1max.gdx') .228
(genw2,genw3,genw4
 'ex1_.gdx', 'ex1_lab_.gdx', 'exw3_.gdx', 'exw3_lab_.gdx'
 'write2a_.gdx', 'write2b_.gdx', 'write4a_.gdx', 'write4b_.gdx'
 'wbatch.m', 'write1.m', 'write2.m', 'write3.m', 'write4.m')     .247
(genr2,genr3,genr4,genr5
 'ex2.gdx', 'exr3.gdx', 'exr4.gdx', 'exr5.gdx'
 'rbatch.m', 'read1.m', 'read2.m', 'read3.m', 'read4.m', 'read5.m', 'rtrns.m'
 'rw1.m'
 'trnsport.gdx').    248
'lp01'        .(253,379)
'lp02'        .(254,380)
'fntan.gdx'   .269
'fnacos.gdx'  .270
'fnasin.gdx'  .272
'fnatan2.gdx' .274
'lp03'        .(291,381)
'lp10'        .(292,382)
'lp11'        .(293,383)
'sos1a'       .294
'semicon1'    .295
'mcp01'       .296
'mcp02'       .297
'mcp03'       .298
'mcp04'       .299
'cns01'       .300
'cns02'       .301
'cns03'       .302
'cns04'       .303
'cns05'       .304
'cns06'       .305
'cns07'       .306
'cns08'       .307
'cns09'       .308
'cns10'       .309
'cns11'       .310
'cns12'       .311
'cns13'       .312
'fncentr.gdx' .317
'fncentr2.gdx'.318
'fncentr3.gdx'.319
'fncentrx.gdx'.320
'macsource.zip.ignore'.336
'mcp06'       .341
'querytest.mdb'.(342,343)
'querytest.gdx'.(342,343)
'allpfmap.gdx'.353
'fncentr5.gdx'.361
'fncentr6.gdx'.362
'lp12'        .384
'lp13'        .385
'gdx6.gdx'    .396
'mip01'       .445
'gdxxrw5.xls' .458
'pgams01'     .473
'x5555.gdx'   .475
(gen_r1,gen_r2,gen_rbig
 'read1.gdx', 'read2.gdx', 'readbig.gdx'
 'r_batch.m', 'r1.m', 'r2.m', 'rfull.m', 'rsparse.m').    486
('writeset_.gdx', 'writepar_.gdx'
 'w_batch.m', 'writeset.m', 'writepar.m')     .487
('testinst', 'gversion', 'testinst.m')     .490
'xerr.zip.ignore'.(493,494)
'mip02_solu.gdx'.497
('tricclib.LIBSTEM','trisource.zip.ignore').(521,552)
('tridclib.LIBSTEM','trisource.zip.ignore').522
('trifclib.LIBSTEM','trisource.zip.ignore').523
'nlcode5.gdx' .532
'qcp01'       .537
'qcp02'       .538
'qcp03'       .539
'complink'    .562
('Ex1j.h','Ex1j.java','Ex1jwrap.c','ex1c.c','ex1c_cb.c','ex1d.dpr','ex1d_cb.dpr','ex1f.f90',
 'ex1f_cb.f90','geheader.h','geheader_d.pas','geheader2_d.pas','gehelper.f90','msg2_f.f90','complink',
 'ex1c.LIBSTEM','ex1c_cb.LIBSTEM','ex1d.LIBSTEM','ex1d_cb.LIBSTEM','ex1f.LIBSTEM','ex1f_cb.LIBSTEM').563
('ex1xc_cb.c','ex1xf.f90','geheader.h','gehelper.f90','complink','ex1xc_cb.LIBSTEM','ex1xf.LIBSTEM').564
('ex2c_cb.c','ex2d_cb.dpr','ex2f_cb.f90','geheader.h','geheader_d.pas','gehelper.f90','msg2_f.f90','complink',
 'ex2c_cb.LIBSTEM','ex2d_cb.LIBSTEM','ex2f_cb.LIBSTEM').565
('ex3c_cb.c','ex3d.dpr','ex3f_cb.f90','geheader.h','geheader_d.pas','gehelper.f90','msg2_f.f90','complink',
 'ex3c_cb.LIBSTEM','ex3d.LIBSTEM','ex3f_cb.LIBSTEM').566
('ex4c_cb.c','ex4d.dpr','ex4f_cb.f90','deasolu.gdx','geheader.h','geheader_d.pas','gehelper.f90','msg2_f.f90','complink',
 'ex4c_cb.LIBSTEM','ex4d.LIBSTEM','ex4f_cb.LIBSTEM').567
('ex4xc_cb.c', 'ex4xf_cb.f90','deasolu.gdx','geheader.h','gehelper.f90','msg2_f.f90','complink'
 'ex4xc_cb.LIBSTEM','ex4xf_cb.LIBSTEM').568
('ex5c.c','ex5f.f90','geheader.h','gehelper.f90','complink','ex5c.LIBSTEM','ex5f.LIBSTEM').569
('er1c_cb.c','er1f_cb.f90','geheader.h','gehelper.f90','msg2_f.f90','complink','er1c_cb.LIBSTEM','er1f_cb.LIBSTEM').570
('er2c_cb.c','er2f_cb.f90','geheader.h','gehelper.f90','msg2_f.f90','complink','er2c_cb.LIBSTEM','er2f_cb.LIBSTEM').571
('er3c_cb.c','er3f_cb.f90','geheader.h','gehelper.f90','msg2_f.f90','complink','er3c_cb.LIBSTEM','er3f_cb.LIBSTEM').572
('exmcp1c.c','exmcp1f.f90','geheader.h','gehelper.f90','complink','exmcp1c.LIBSTEM','exmcp1f.LIBSTEM').573
('exmcp2c.c','exmcp2c_cb.c','exmcp2f.f90','exmcp2f_cb.f90','geheader.h','gehelper.f90','msg2_f.f90','complink',
 'exmcp2c.LIBSTEM','exmcp2c_cb.LIBSTEM','exmcp2f.LIBSTEM','exmcp2f_cb.LIBSTEM').574
('exmcp3c_cb.c', 'exmcp3f_cb.f90','geheader.h','gehelper.f90','msg2_f.f90','complink',
 'exmcp3c_cb.LIBSTEM','exmcp3f_cb.LIBSTEM').575
('exmcp4c_cb.c', 'exmcp4f_cb.f90','geheader.h','gehelper.f90','msg2_f.f90','complink',
 'exmcp4c_cb.LIBSTEM','exmcp4f_cb.LIBSTEM').576
('exmcp5c.c','geheader.h','complink','exmcp5c.LIBSTEM').577
/;

$hidden tell model type
set t       single model types / DECIS, GAMS, LP, MIP, NLP, MCP, MPSGE, MINLP, RMIP,
                                 RMINLP, CNS, DNLP, OSLSE, MPEC, QCP, MIQCP, RMIQCP /
    ts(t,s) classification by type /
    gams.  (1,2,3*65,89,90,110*117,119*126,133*135,137*144,146*210,
            213*214,216*223,225*237,240*250,256*290,313*328,330*339,342,343,
            347*373,376*388,391*400,402*414,416*417,419*439,441*444,446*458,
            462*480,482*496,499*502,504*510,513*524,526*536,543*546,552,556*557,
            559*560,562*579,581*585)
    lp.    (66*73,88,118,211,212,238,239,251*254,291*293,329,374,375,418,459)
    mip.   (106,109,215,294*295,345,346,445,497*498,525,541*542,547*550,553*554)
    nlp.   (76,77,131,132,224,415,460,551)
    mpsge. (78*85,107*108,481,558)
    cns.   (91*103,300*312)
    mpec.  (104*105,136,145,344)
    qcp.   (74,75,86,87,390,503,511*512,537*539,555,580)
    mcp.   (127*130,255,296*299,340,341,389,401,440,461)
    miqcp. (540,561)
    /

parameter oval ordinal value of model type for slvtest/
    MINLP   1,  DECIS   6,  CNS    11,  MIQCP  16,
    NLP     2,  MCP     7,  DNLP   12,  RMIQCP 17,
    MIP     3,  MPSGE   8,  OSLSE  13,
    LP      4,  RMIP    9,  MPEC   14,
    GAMS    5,  RMINLP 10,  QCP    15
/;

$onempty
set big(s) need full solver license to run  / /
set tiny(s) model that have not more than 10x10 variables and equation / /
$offempty

alias(s,ss); set srev(s,s) reverse set ; srev(s,s+(card(s)+1-2*ord(s))) = yes;


$onempty
set drop(t,s) Additional drop set / /;
$offempty

set tss(t,s) only one type per model used in IDE files;

* quick and dirty dropping of multiple classifications
tss(t,s)                      = ts(t,s) - drop(t,s);
tss('rmip  ',s)$ts('mip  ',s) = no;
tss('lp    ',s)$ts('nlp  ',s) = no;
tss('qcp   ',s)$ts('miqcp',s) = no;
tss('nlp   ',s)$ts('dnlp ',s) = no;
tss('nlp   ',s)$ts('mcp  ',s) = no;
tss('rminlp',s)$ts('minlp',s) = no;
tss('nlp   ',s)$ts('minlp',s) = no;
tss('mcp   ',s)$ts('mpec ',s) = no;
tss(t       ,s)$ts('mpsge',s) = sameas(t,'mpsge');
tss(t       ,s)$ts('decis',s) = sameas(t,'decis');
tss(t       ,s)$ts('oslse',s) = sameas(t,'oslse');

sets
    err2(s)    'model unclassified in TS(T,S)'
    err3(s)    'model unclassified in SM(S,M)'
    err5(s)    'all types dropped in DROP(T,S)'
    err6(s)    'multiple types in TSS(T,S)'
    err7(t,s)  'drops missing in DROP(T,S) for model with multiple types'
    err8(m)    'model and include names cannot have the same name';

err2(s) = not sum(ts(t,s), yes);
err3(s) = not sum(sm(s,m), yes);
err5(s) = sum(t$(ts(t,s)-drop(t,s)), 1) = 0;
err6(s) = sum(tss(t,s), 1) > 1;
err7(t,s)$err6(s) = tss(t,s);
err8(m) = sum(inc, sameas(m,inc));

abort$card(err2) err2;
abort$card(err3) err3;
abort$card(err5) err5;
abort$card(err6) err6,err7;
abort$card(err7) err7;
abort$card(err8) err8;
