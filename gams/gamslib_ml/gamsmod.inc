$hidden When adding models we need to update this file at a few
$hidden spots. Look for $hidden lines. To check > gams gamsmod.inc
$setglobal version
$hidden   update lib version above and run gams gamsmod.inc
SETS s Model Sequence Numbers / 1*386 /
$hidden                           bump sequence numbers above

     a Application Areas /

       AGECON   Agricultural Economics
       AGE      Applied General Equilibrium
       BCH      Branch and Cut and Heuristic
       CHEME    Chemical Engineering
       CT       Contract Theory
       ECON     Econometrics
       DEV      Economic Development
       DISJ     Disjunctive Programming
       ENER     Energy Economics
       ENG      Engineering
       FIN      Finance
       FOREST   Forestry
       TRA      International Trade
       MACRO    Macro Economics
       MS       Management Science and OR
       MATH     Mathematics
       MICRO    Micro Economics
       SP       Stochastic Programming
       STAT     Statistics
       REC      Recreational Models
       SPEC     Special Integer Models
       GAMSL    GAMS Language Features
       GAMST    GAMS Tools /

$stitle Model Names and Titles
set m model names in alphabetic order /
$hidden  enter the new model here, keep in order
A
ABEL     Linear Quadratic Control Problem
ABSMIP   Discontinous functions abs() min() max() sign() as MIPs
AGRESTE  Agricultural Farm Level Model of NE Brazil
AIRCRAFT Aircraft Allocation Under Uncertain Demand
AIRSP    Aircraft Allocation
AIRSP2   Aircraft Allocation - stochastic optimization with DECIS
AJAX     Ajax Paper Company Production Schedule
ALAN     A Quadratic Programming Model for Portfolio Analysis
ALKYL    Simplified Alkylation Process
ALPHAMET Alphametics - a Mathematical Puzzle
ALUM     World Aluminum Model
AMPL     AMPL Sample Problem
ANDEAN   Andean Fertilizer Model
APL1P    Stochastic Programming Example for DECIS
APL1PCA  Stochastic Programming Example for DECIS
AWKQAP   Input file generation with AWK for the Quadratic Assignment Problem
AWKTSP   Traveling Salesman Problem Instance prepared with AWK
B
BADMIP   Rounding Problems in MIPs
BATCHDES Optimal Design for Chemical Batch Processing
BCHFCNET Fixed Cost Network Flow Problem with Cuts using BCH Facility
BCHMKNAP Multi knapsack problem using BCH Facility
BCHOIL   Oil Pipeline Design Problem using BCH Facility
BCHSTOCK Cutting Stock - A Column Generation Approach with BCH
BCHTLBAS Trim Loss Minimization with Heuristic using BCH Facility
BCHTSP   Traveling Salesman Problem Instance with BCH
BEARING  Hydrostatic Thrust Bearing Design for a Turbogenerator
BID      Bid Evaluation
BIDPWL   Bid Evaluation with Piecewise Linear Functions
BIDSOS   Bid Evaluation with SOS2 Sets
BILINEAR Convexification of bilinear term binary times x
BLEND    Blending Problem I
C
CAFEMGE  Corporate average fuel economy standards
CALENDAR Calendar Function Examples
CAMCGE   Cameroon General Equilibrium Model Using NLP
CAMCNS   Cameroon General Equilibrium Model Using CNS
CAMMCP   Cameroon General Equilibrium Model Using MCP
CAMMGE   Cameroon General Equilibrium Model Using MPSGE
CAMSHAPE Shape optimization of a cam COPS 2.0 #4
CATMIX   Catalyst Mixing COPS 2.0 #14
CCLINPTS Finding Optimal Breakpoints when linearizing a power utility function
CCOIL    Oil Pipeline Design Problem using concurrent MIP solves
CEFILES  Compressed Input Files
CESAM    Cross Entropy SAM Estimation
CHAIN    Hanging Chain COPS 2.0 #3
CHAKRA   Optimal Growth Model
CHANCE   Chance Constrained Feed Mix Problem
CHARTDAT Create an example GDX file for the IDE Charting facility
CHEM     Chemical Equilibrium Problem
CHENERY  Substitution and Structural Change
CHINA    Organic Fertilizer Use in Intensive Farming
CIRCLE   Circle Enclosing Points - SNOPT Example
CIRIMGE  Increasing returns in intermediate inputs
CLEARLAK Scenario Reduction: ClearLake exercise
CMO      Financial Optimization: Financial Engineering
COEX     Peacefully Coexisting Armies of Queens
COEXX    Peacefully Coexisting Armies of Queens - tight
COPPER   Modeling Investment in the World Copper Industry
CO2MGE   Carbon-related trade model (static)
CRAZY    Examples of Extended Arithmetic
CROSS    Alcuin's River Crossing
CSCHED   Cyclic Scheduling of Continuous Parallel Units
CSP      Closest String Problem
CTA      Controlled Tabular Adjustments
CUBE     Three-Dimensional Noughts and Crosses
CUBESOLN Three-Dimensional Noughts and Crosses Multiple Solutions
CUTSTOCK Cutting Stock - A Column Generation Approach
D
DANWOLFE Dantzig Wolfe Decomposition and Grid Computing
DEA      Data  Envelopment Analysis - DEA
DECOMP   Decomposition Principle - Animated
DECOMPHH A Successive Recalibration Algorithm for GE Models with Many Households
DEMO1    Simple Farm Level Model
DEMO7    Nonlinear Simple Agricultural Sector Model
DEPLOY   GAMS Deployment Model
DICE     Non-transitive Dice Design
DICEGRID MIP Decomposition and Parallel Grid Submission - DICE Example
DICEX    Non-transitive Dice Design - Enhanced
DIET     Stigler's Nutrition Model
DINAM    DINAMICO  A Dynamic Multi-Sectoral  Multi-Skill Model
DISPATCH Economic Load Dispatch Including Transmission Losses
DMCMGE   Accounting for economic growth with new inputs
DPLYTEST A Deployment Test Model
E
EGYPT    Egypt Agricultural Model
ELEC     Distribution of electrons on a sphere COPS 2.0 #2
EMFL     Existing Multi Facility Location Problem - Cone Format
ENCRYPT  Input file encyption demo
EPSCM    eps-Constraint Method for Multiobjective Optimization
EPSCMMIP Improved version of eps-Constraint Method for Multiobjective Optimization
ERS82MCP USDA-ERS CGE Model of the US
ETAMAC   ETA-MACRO Energy Model for the USA
ETAMGE   ETA-MACRO  Energy Model for the USA - MPSGE Format
F
FARM     The Farmer's Problem formulated for DECIS
FAWLEY   Platoform Example Refinery
FCT      LGO Interface Example
FEASOPT1 An Infeasible Transportation Problem analyzed with Cplex option FeasOpt
FEEDTRAY Optimum Feed Plate Location
FERTD    Egypt - Dynamic Fertilizer Model
FERTS    Egypt - Static Fertilizer Model
FINMGE   A General Equilibrium Model for Finland
FDESIGN  Linear Phase Lowpass Filter Design
FIVELEAP The Five Leaper Tour Problem
FLOWCHAN Flow in a channel COPS 2.0 #7
FLOWSHOP Flow shop scheduling
FOOD     Food Manufacturing Problem - Blending of oils
FUEL     Fuel Scheduling and Unit Commitment Problem
G
GAMSREP  The GAMS Model Library
GAMSHTM  HTML generation of model library
GAMSUTIL Generates some useful files from the Model Library
GANCNS   Macro-Economic Framework for India - CNS
GANCNSX  Macro-Economic Framework for India - Tracking CNS
GANGES   Macroeconomic Framework for India
GANGESX  Economic Framework for India - Tracking
GAPMIN   Lagrangian Relaxation of Assignment Problem
GASNET   Optimal Design of a Gas Transmission Network
GASTRANS Gas Transmission Problem - Belgium
GASOIL   Catalytic cracking of gas oil COPS 2.0 #12
GAUSS    Matrix Inversion with Full Pivoting
GEAR     Gear Train Design
GEMMCP   GEMTAP: A general equilibrium model for tax policy
GEMMGE   GEMTAP: A general equilibrium model for tax policy
GLIDER   Hang glider COPS 2.0 #11
GMSTEST  Test sript for library models
GQAPSDP  SDP Convexifications of the Generalized Quadratic Assignment Problem
GREAT    Great Circle Distances
GSOLVER  Compare the actual system with the original solver database
GTM      International Gas Trade Model
H
HANSMCP  Hansen's Activity Analysis Example - MCP
HANSMGE  Hansen's Activity Analysis Example - MPSGE
HARKER   Models of Spatial Competition
HARKMCP  Models of Spatial Competition in MCP Form
HARMGE   Increasing returns with average cost pricing
HAVERLY  Haverly's pooling problem example
HERVES   Herves (Transposable Element) Activity Calculations
HDA      Synthesis: Hydrodealkylation of Toluene
HHFAIR   Household Optimization Problem by Fair
HHMAX    A Household Maximization Problem
HIMMEL11 Himmelblau Test Problem Number 11
HIMMEL16 Area of Hexagon Test Problem
HOLIDAY  US Holiday and Leave Chart
HOUSE    House Plan Design
HS62     Hock - Schittkowski Problem 62
HYDRO    Hydrothermal Scheduling Problem
I
IBM1      Aluminum Alloy Smelter Sample Problem
ICUT      Integer Cut Example
IMMUN     Financial Optimization: Risk Management
IMSL      Piecewise Linear Approximation
INDUS     Indus Agricultural Model
INDUS89   Indus Basin Water Resource Model
IOBALANCE Updating and Projecting Coefficients: The RAS Approach
IRSCGE    A CGE Model with Scale Economy
ISWNM     Indus Surface Water Network Submodule
J
JACOBI   Asynchronous Jacobi Methods
JBEARING Journal bearing COPS 2.0 #16
JDATE    Julian date test
JIT      Design of Just-in-Time Flowshops
JOBT     On-the-Job Training
K
KAND     Stochastic Programming
KEHOMGE  Multiple equilibria in a simple GE model
KNIGHTS  Maximum Knights Problem
KORCGE   General Equilibrium Model for Korea - NLP
KORCNS   General Equilibrium Model for Korea - CNS
KORMCP   General Equilibrium Model for Korea - MCP
KORPET   Investment Planning in the Korean Oil-Petro Industry
KNP      Kissing Number Problem using Variable Neighborhood Search
KPORT    Product Portfolio Optimization
KQKPSDP  SDP Convexifications of the Cardinality constraint Quadratic Knapsack Problem
L  
LANDS    Optimal Investment
LAUNCH   Launch Vehicle Design and Costing
LATIN    The Orthogonal Latin-Square Problem
LEAST    Nonlinear Regression Problem
LICEMEMO License Memorandum
LIKE     Maximum Likelihood Estimation
LINEAR   Linear Regression with Various Criteria
LINEARNE Linearization techniques for extremal-Nash equilibria
LMP1     Linear Multiplicative Model - Type 1
LMP2     Linear Multiplicative Model - Type 2
LMP3     Linear Multiplicative Model - Type 3
LNTS     Particle steering COPS 2.0 #9
LOGMIP1A LogMIP User's Manual Example 1a - Job Scheduling
LOGMIP1B LogMIP User's Manual Example 1b - Job Scheduling
LOGMIP1C LogMIP User's Manual Example 1c - Job Scheduling
LOGMIP2  LogMIP User's Manual Example 2 - Example to illustrate disjunctions
LOGMIP3  LogMIP User's Manual Example 3 - Synthesis of 8 Processes
LOGMIP4  LogMIP User's Manual Example 4 - Job Shop Scheduling
LOP      Line Optimization
LRGCGE   A Large Country CGE Model
LRS      Linear Recursive Sequence Optimization Model
M
MAGIC    Magic Power Scheduling Problem
MARCO    Mini Oil Refining Model
MARILYN  Numerical Puzzle
MARKOV   Strategic Petroleum Reserve
MATHOPT1 MathOptimizer Example 1
MATHOPT2 MathOptimizer Example 2
MATHOPT3 MathOptimizer Example 3
MATHOPT4 MathOptimizer Example 4
MATHOPT5 MathOptimizer Example 5
MATHOPT6 MathOptimizer Example 6
MAXCUT   'Goemans/Williamson Randomized Approximation Algorithm for MaxCut'
MAXMIN   Max Min Location of Points in Unit Square
MEANVAR  Financial Optimization: Risk Management
MEANVARX Financial Optimization: Risk Management
METHANOL Methanol to hydrocarbons COPS 2.0 #13
MEXLS    Mexico Steel - Large Static
MEXSD    Mexico Steel - Small Dynamic
MEXSS    Mexico Steel - Small Static
MHW4D    Nonlinear Test Problem
MHW4DX   MHW4D with additional Tests
MHW4DXX  MHW4DX with multiple solutions
MINGAMMA Minimal y of GAMMA(x)
MINE     Opencast Mining
MINLPHI  Heat Integrated Distillation Sequences
MINLPHIX Heat Integrated Distillation Sequences
MINSURF  Minimal surface with obstacle COPS 2.0 #17
MLBETA   Fitting of beta distribution through maximum likelihood
MLGAMMA  Maximum Likelihood estimation of parameters of the gamma distribution
MONCGE   A Monopoly CGE Model
MPSTRANS MPS file for transportation problem
MR5MCP   Multi-Region Growth Model Based on Global 2100
MRP2     Materials Requirement Planning (MRP) Formulations
MSM      Morocco Fertilizer Distribution - Mode Selection
MST      Minimum Spanning Tree
MWS      "Computation of Horowitz's work-trip mode choice model estimates"
N
NASH     A non-cooperative game: Nash and Stackelberg versions
NEBRAZIL North-East Brazil Regional Agricultural Model
NEMHAUS  Scheduling to Minimize Interaction Cost
NETGEN   Min Cost Flow with an Instance generated by NETGEN
NONSHARP Synthesis of General Distillation Sequences
NSHARPX  Synthesis of General Distillation Sequences
NSMGE    North-South trade and capital flows
O
OLIGOMCP Oligopolistic Competition - Examples from MP
OPENPIT  Dynamic open pit mining extraction
ORANI    A Miniature Version of Orani 78
OTPOP    OPEC Trade and Production
P
PAK       Optimal Patterns of Growth and Aid
PAKLIVE   Pakistan Punjab Livestock Model
PAPERCO   Vertically Integrated Company
PENTIUM   Pentium Error Test
PDI       ARCNET - Production Distribution and Inventory
PHOSDIS   Sea Distances for World Phosphate Model
PINDYCK   Optimal Pricing and Extraction for OPEC
PINENE    Isometrization of alpha-pinene COPS 2.0 #5
PIVOT     Simple Gaussian Elimination
PMEANVAR  Mean-Variance models with variable upper and lower bounds 
PMELODY   Choose notes for melodic lines and chords with permutations
POLLUT    Industrial Pollution Control
POLYGON   Largest small polygon COPS 2.0 #1
POOL      Pooling problem
POPDYNM   Marine population dynamics COPS 2.0 #6
PORT      Simple Portfolio Model
POUTIL    Portfolio Optimization for Electric Utilities
POWERSET  PowerSetLeft and PowerSetRight examples
PRIME     Prime Number Generation
PROCESS   Alkylation Process Optimization
PROCMEAN  Optimal Process Mean
PROCSEL   Structural Optimization of Process Flowsheets
PRODMIX   A Production Mix Problem
PRODPLAN  A Production Planning Example
PRODSCH   APEX - Production Scheduling Model
PRODSCHX  Production Scheduling Model using SOS1 and SOS2
PRODSP    Stochastic Programming Example
PRODSP2   Stochastic Programming Example - reformulated for DECIS
PROLOG    Market Equilibrium and Activity Analysis
PS10_S    'Parts Supply Problem w/ 10 Types & w/ Asymmetric Information'
PS10_S_MN 'Parts Supply Problem w/ 10 Types w/ Random p(i)'
PS2_F_S   'Parts Supply Problem w/ 2 Types w/o and w/ Asymmetric Information'
PS2_F     'Parts Supply Problem w/ 2 Types w/o Asymmetric Information'
PS2_F_eff 'Parts Supply Problem w/ Efficient Type w/o Asymmetric Information'
PS2_F_inf 'Parts Supply Problem w/ Inefficient Type w/o Asymmetric Information'
PS2_S     'Parts Supply Problem w/ 2 Types w/ Asymmetric Information'
PS3_F     'Parts Supply Problem w/ 3 Types w/o Asymmetric Information'
PS3_S     'Parts Supply Problem w/ 3 Types w/ Asymmetric Information'
PS3_S_GIC 'Parts Supply Problem w/ 3 Types w/ Global Incentive Comp. Const.'
PS3_S_MN  'Parts Supply Problem w/ 3 Types w/ Monotonicity Constraint'
PS3_S_SCP 'Parts Supply Problem w/ 3 Types w/o & w/ SCP'
PS5_S_MN  'Parts Supply Problem w/ 5 Types w/ Random p(i)'
PTSP      Traveling Salesman Problem Instance solved with explicit Permutation Enumeration
PUMP      Pump Network Synthesis
Q
QABEL    Linear Quadratic Control Problem
QALAN    A Quadratic Programming Model for Portfolio Analysis QCP
QCP1     Standard QP Model QCP
QDEMO7   Nonlinear Simple Agricultural Sector Model QCP
QMEANVAR Financial Optimization: Risk Management using MIQCP
QMEANVAG Portfolio Modeling with Parallel Solutions
QUANTUM  An application from quantum mechanics
QSAMBAL  Social Accounting Matrix Balancing Problem QCP
QP1      Standard QP Model
QP1X     Standard QP Model with GDX data input
QP2      Standard QP Model - symmetry exploitations
QP3      Standard QP Model - intermediate variables
QP4      Standard QP Model - no covariance matrix
QP5      Standard QP Model - linear approximation
QP6      Standard QP Model - LCP formulation of QP4
QP7      Standard QP Model - conic programming formulation
QUEENS   Maximum Queens Chess Problem
QUOCGE   A CGE Model with Quotas
R
RAILCIRC Minimum Circulation of Railway Stock
RAMSEY   Savings Model by Ramsey
RBROCK   Rosenbrock Test Function
RDATA    Sample Database of the US Economy
REACTION Logical Inference for Reaction path synthesis
RELIEF   Relief Mission
REPAY    Repayment Factors for Loans
ROBERT   Elementary Production and Inventory Model
ROBOT    Robot arm COPS 2.0 #8
ROCKET   Goddard rocket COPS 2.0 #10
ROTDK    Robust Optimization
S
SAMBAL   Social Accounting Matrix Balancing Problem
SAMMGE   Carbon taxes with exemptions for heavy industry
SAMPLE   Stratified Sample Design
SARAS   'South African Regionalised Farm-level Resource Use & Output Supply Response (SARAS) model'
SARF     Farm Credit and Income Distribution Model
SCARFMCP Scarf's Activity Analysis Example
SCARFMGE Tax distortions in a small activity analysis model
SCHULZ   Termination routine to ensure solvers stay with resource limit
SDDP     Multi-stage Stochastic Water Reservoir Model solved with SDDP
SECURE   Secure Work Files - Example 2
SEDERS   ERS Data Manipulations with SED
SENSTRAN Sensitivity analysis using LOOPS
SHALE    Investment Planning in the Oil Shale Industry
SHIP     Structural Optimization
SHOVMGE  The economic effects of UK membership in the EC
SIPRES   Global optimization of semi-infinite programs via restriction of the right-hand side
SLVTEST  Solver combination test
SOLNPOOL Cplex Solution Pool for a Simple Facility Location Problem
SOLVEOPT Option solveopt explained
SPARTA   Military Manpower Planning from Wagner
SPATEQU  Spatial Equilibrium
SPLCGE   A Simple CGE Model
SPRING   Coil Compression String Design
SRCPM    Single-Region Contingency Planning Model
SRKANDW  Stochastic Programming Scenario Reduction
SROUTE   The Shortest Route Problem
SROUTEX  Shortest Route Algorithm
SRPCHASE Scenario Tree Construction Example
STDCGE   A Standard CGE Model
STOCKCC  Minimizing Total Average Cycle Stock
SWATH    Mission Planning for Synthetic Aperture Radar Surveillance
SYNHEAT  Simultaneous Optimization for Hen Synthesis
T
T1000    LGO Test t1000_10
TABORA   Tabora Rural Development - Fuelwood Production
TANKSIZE Tank Size Design Problem
TBA      Financial Optimization: Financial Engineering
TFORDY   Antalya Forestry Model - Dynamic
TFORSS   Antalya Forestry Model - Steady State
THAI     Thai Navy Problem
THAIX    Thai Navy Problem Extended
THREEMGE Three Approaches to Differential Tax Policy Analysis
TORSION  Elastic-plastic torsion COPS 2.0 #15
TRAFFIC  Traffic Equilibrium Problem
TRANSMCP Transportation Model as Equilibrium Problem
TRIG     Simple Trigonometric Example
TRIMLOSS Trim Loss Minimization
TRNSGRID Grid Transportation Problem
TRNSPORT A Transportation Problem
TRNSPWL  A Transportation Problem with discretized economies of scale
TRNSPWLX A Transportation Problem with Piecewise Linear Functions
TRNSSDP  Solving the Transportation LP Problem using SDP
TSP1     Traveling Salesman Problem - One
TSP2     Traveling Salesman Problem - Two
TSP2LTX  TSP tour plotting with LaTeX xy-pic environment
TSP3     Traveling Salesman Problem - Three
TSP4     Traveling Salesman Problem - Four
TSP42    TSP solution with subtour elimination
TSP5     TSP solution with Miller et al subtour elimination
TURKEY   Turkey Agricultural Model with Risk
TURKPOW  Turkey Power Planning Model
TVCSCHED Flow Formulation of the ISCI Rotator Problem
TWOCGE   A Two Country CGE Model
TWO3MAC  Simple 2 x 2 x 2 General Equilibrium Model Using Macros
TWO3MCP  Simple 2 x 2 x 2 General Equilibrium Model
U
UIMP     UIMP - Production Scheduling Problem
UNSTMGE  Globally Unstable Equilibria
V
VERSION1 How to test for a GAMS version
VIETMAN  Vietoriscz Manne Fertilizer Model 1961
VONTHMCP General Equilibrium Variant of the von Thunen Model
VONTHMGE A General Equilibrium Version of the von Thunen Model
W
WALL     Chemical Equilibrium Problem
WALLMCP  Chemical Equilibrium Problem as MCP
WATER    Design of a Water Distribution Network
WATERX   Design of a Water Distribution Network (MINLP)
WEAPONS  Weapons Assignment
WESTMIP  Economies of Scale and Investment over Time
WINDFAC  Winding Factor of Electrical Machines
WHOUSE   Simple Warehouse Problem
WORST    Financial Optimization: Risk Management
X
Y
YEMCEM   Yemen Cement Model
Z
ZLOOF    Relational Database Example
               /

    letters(m) / a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z /

set inc list of include files with explicit extensions /
'QPDATA.INC'   StockMaster - closing values for 170 stocks and 100 days
'BR17.INC'     17 City TSP Data
'COPSPART.INC' COPS collocation method
'CSCHED1.INC'  data set 1 for model csched
'CSCHED2.INC'  data set 2 for model csched
'GAMSMOD.INC'  GAMS Model Library
'SLVDATA.INC'  Solver test data
'GAMSREF.INC'  GAMS Reference Database
'POOLMOD.INC'  model equations for model pool
'T1000D.INC'   Data for T1000
'BCHTLHEU.INC' Heuristic for trimloss minimization
'BCHDICUT.INC' Cut generator for Steiner tree problem
'BERLIN2.INC'  Data set for BCHFCNET
'BCHOIL_C.INC' Cut generator for Oil pipeline problem
'BCHOIL_D.INC' Data for Oil pipeline problem
'BCHOIL_H.INC' Heuristic for Oil pipeline problem
'BCHCOVER.INC' Simple cover inequalities for the multi-knapsack problem with integer data
'TAI7A.INC'    Include file for AWKQAP
'F001.INC'     Include file for SEDERS
'P43.INC'      Include file for AWKTSP
'HERVESIO.XLS' Excel input file for HERVES
'COX3.XLS'     Excel input file for CTA
'NETGN099.INC' NETGEN generated input file for NETGEN
'GNETGN99.INC' GNETGEN generated input file for GNETGEN
'SWATHDAT.GDX' Length of arcs for SWATH
'WATER.GDX'    Data for SDDP
'WATER.XLS'    Data for SDDP stored in Excel
'WORKTRIP.INC' sample of 842 household for work-trip mode decision (automobile or other)
'RUNCSDP.INC'  A wrapper for the COIN-OR Semidefinite Programming Solver CSDP
'TG207777.INC' MaxCut instance from Biq Mac Library
'PB16X7.INC'   GQAP instance pb16x7
'50_25.INC'    KQKP instance 50_25
'SCARFDATA.INC' data for scarfmcp and related models
'MVDATA.GDX'   Data for mean variance problem
'PWLFUNC.INC'  Generic macros for piecewise linear functions 
                                     /
set bininc(inc) binary include files /
  'HERVESIO.XLS'
  'COX3.XLS'
  'SWATHDAT.GDX'
  'WATER.GDX'
  'WATER.XLS'
  'MVDATA.GDX'
                                     /

$stitle Model Assignments
set sm(s,m) model sequence number assignment /
  1.TRNSPORT ,  11.UIMP     ,  21.CHEM     ,  31.ALUM     ,  41.PROLOG
  2.BLEND    ,  12.MAGIC    ,  22.SHIP     ,  32.MARCO    ,  42.CUBE
  3.PRODMIX  ,  13.FERTS    ,  23.LINEAR   ,  33.CHENERY  ,  43.CHAKRA
  4.WHOUSE   ,  14.FERTD    ,  24.LEAST    ,  34.PAK      ,  44.ANDEAN
  5.JOBT     ,  15.MEXSS    ,  25.LIKE     ,  35.DINAM    ,  45.COPPER
  6.SROUTE   ,  16.MEXSD    ,  26.CHANCE   ,  36.HIMMEL16 ,  46.SHALE
  7.DIET     ,  17.MEXLS    ,  27.SAMPLE   ,  37.ROBERT   ,  47.OTPOP
  8.AIRCRAFT ,  18.WEAPONS  ,  28.PINDYCK  ,  38.RDATA    ,  48.KORPET
  9.PRODSCH  ,  19.BID      ,  29.ZLOOF    ,  39.MINE     ,  49.SARF
 10.PDI      ,  20.PROCESS  ,  30.VIETMAN  ,  40.ORANI    ,  50.PORT
                                                          
 51.YEMCEM   ,  61.TFORSS   ,  71.GAUSS    ,  81.CAMCGE   ,  91.DEMO1
 52.SRCPM    ,  62.TFORDY   ,  72.REPAY    ,  82.MARKOV   ,  92.DEMO7
 53.GTM      ,  63.RAMSEY   ,  73.GREAT    ,  83.RBROCK   ,  93.SROUTEX
 54.TURKPOW  ,  64.ABEL     ,  74.AMPL     ,  84.MHW4D    ,  94.MST
 55.PAKLIVE  ,  65.FAWLEY   ,  75.EGYPT    ,  85.HARKER   ,  95.HIMMEL11
 56.CHINA    ,  66.MSM      ,  76.WALL     ,  86.TURKEY   ,  96.POLLUT
 57.TABORA   ,  67.CRAZY    ,  77.SAMBAL   ,  87.NEBRAZIL ,  97.GANGES
 58.WESTMIP  ,  68.WATER    ,  78.PHOSDIS  ,  88.AGRESTE  ,  98.THAI
 59.IMSL     ,  69.HHFAIR   ,  79.IBM1     ,  89.ISWNM    ,  99.HOUSE
 60.AJAX     ,  70.PIVOT    ,  80.ETAMAC   ,  90.INDUS    , 100.KORCGE
                                                          
101.GAMSREP  , 102.PAPERCO  , 103.QUEENS   , 104.MPSTRANS , 105.THAIX
106.SENSTRAN , 107.GANGESX  , 108.SPARTA   , 109.PRODSCHX , 110.IMMUN
111.WORST    , 112.MEANVAR  , 113.MEANVARX , 114.CMO      , 115.TBA
116.PROCSEL  , 117.SYNHEAT  , 118.MINLPHI  , 119.BATCHDES , 120.NONSHARP
121.REACTION , 122.FEEDTRAY , 123.HDA      , 124.ALAN     , 125.WATERX
126.TRANSMCP , 127.WALLMCP  , 128.HARKMCP  , 129.CAMMCP   , 130.KORMCP
131.TWO3MCP  , 132.SCARFMCP , 133.OLIGOMCP , 134.MR5MCP   , 135.HANSMCP
136.VONTHMCP , 137.GEMMCP   , 138.ERS82MCP , 139.CAFEMGE  , 140.CAMMGE
141.CIRIMGE  , 142.CO2MGE   , 143.DMCMGE   , 144.ETAMGE   , 145.FINMGE
146.GEMMGE   , 147.HANSMGE  , 148.HARMGE   , 149.KEHOMGE  , 150.NSMGE
                                                          
151.SAMMGE   , 152.SCARFMGE , 153.SHOVMGE  , 154.THREEMGE , 155.UNSTMGE
156.VONTHMGE , 157.PRIME    , 158.KNIGHTS  , 159.LATIN    , 160.ICUT
161.LAUNCH   , 162.PENTIUM  , 163.BIDSOS   , 164.DECOMP   , 165.ALKYL
166.DISPATCH , 167.HYDRO    , 168.FUEL     , 169.TRAFFIC  , 170.ALPHAMET
171.QP1      , 172.QP2      , 173.QP3      , 174.QP4      , 175.QP5
176.DICE     , 177.TSP1     , 178.TSP2     , 179.TSP3     , 180.TSP4
181.INDUS89  , 182.GAPMIN   , 183.CALENDAR , 184.QP6      , 185.ROTDK
186.PRODSP   , 187.KAND     , 188.LANDS    , 189.AIRSP    , 190.GAMSUTIL
191.CROSS    , 192.DEA      , 193.MARILYN  , 194.NEMHAUS  , 195.GMSTEST
196.AIRSP2   , 197.APL1P    , 198.APL1PCA  , 199.FARM     , 200.PRODSP2
                                                          
201.CIRCLE   , 202.BEARING  , 203.GEAR     , 204.TRIMLOSS , 205.PUMP
206.SPRING   , 207.MRP2     , 208.ABSMIP   , 209.CAMCNS   , 210.GANCNS
211.GANCNSX  , 212.KORCNS   , 213.TSP42    , 214.HAVERLY  , 215.GAMSHTM
216.SLVTEST  , 217.GASTRANS , 218.COEXX    , 219.COEX     , 220.RAILCIRC
221.LOP      , 222.CSCHED   , 223.GASNET   , 224.WINDFAC  , 225.STOCKCC
226.NSHARPX  , 227.MINLPHIX , 228.CESAM    , 229.POLYGON  , 230.ELEC
231.CHAIN    , 232.CAMSHAPE , 233.PINENE   , 234.POPDYNM  , 235.FLOWCHAN
236.ROBOT    , 237.LNTS     , 238.ROCKET   , 239.GLIDER   , 240.GASOIL
241.METHANOL , 242.CATMIX   , 243.TORSION  , 244.JBEARING , 245.MINSURF
246.QP1X     , 247.TVCSCHED , 248.SRKANDW  , 249.CLEARLAK , 250.JIT
                                                          
251.LMP1     , 252.LMP2     , 253.LMP3     , 254.POOL     , 255.MATHOPT1
256.MATHOPT2 , 257.MATHOPT3 , 258.MATHOPT4 , 259.MATHOPT5 , 260.MATHOPT6
261.TRIG     , 262.HOLIDAY  , 263.MAXMIN   , 264.HS62     , 265.FCT
266.T1000    , 267.MHW4DX   , 268.FIVELEAP , 269.NASH     , 270.KPORT
271.QP7      , 272.DICEX    , 273.EMFL     , 274.HHMAX    , 275.SPLCGE
276.STDCGE   , 277.LRGCGE   , 278.TWOCGE   , 279.MONCGE   , 280.QUOCGE
281.IRSCGE   , 282.QALAN    , 283.QCP1     , 284.QDEMO7   , 285.QSAMBAL
286.BCHTLBAS , 287.BCHFCNET , 288.BCHOIL   , 289.BCHMKNAP , 290.BADMIP
291.QMEANVAR , 292.JDATE    , 293.QABEL    , 294.CUTSTOCK , 295.MHW4DXX
296.AWKQAP   , 297.SEDERS   , 298.AWKTSP   , 299.MINGAMMA , 300.QUANTUM
                                                          
301.PROCMEAN , 302.MLBETA   , 303.MLGAMMA  , 304.DECOMPHH , 305.HERVES
306.CSP      , 307.LICEMEMO , 308.DEPLOY   , 309.OPENPIT  , 310.CTA
311.GSOLVER  , 312.LRS      , 313.CHARTDAT , 314.FEASOPT1 , 315.TRNSGRID
316.DPLYTEST , 317.CEFILES  , 318.ENCRYPT  , 319.EPSCM    , 320.VERSION1
321.KNP      , 322.SCHULZ   , 323.NETGEN   , 324.TSP2LTX  , 325.SWATH
326.SOLNPOOL , 327.QMEANVAG , 328.DANWOLFE , 329.JACOBI   , 330.DICEGRID
331.MWS      , 332.LOGMIP1A , 333.LOGMIP1B , 334.LOGMIP1C , 335.LOGMIP2
336.LOGMIP3  , 337.LOGMIP4  , 338.MAXCUT   , 339.GQAPSDP  , 340.TRNSSDP
341.TWO3MAC  , 342.POUTIL   , 343.SECURE   , 344.SRPCHASE , 345.TSP5
346.BILINEAR , 347.SOLVEOPT , 348.BCHTSP   , 349.BCHSTOCK , 350.TANKSIZE
                                                          
351.TRNSPWL  , 352.FOOD     , 353.RELIEF   , 354.SPATEQU  , 355.KQKPSDP
356.PRODPLAN , 357.SDDP     , 358.PS2_F_S  , 359.PS2_F    , 360.PS2_F_eff
361.PS2_F_inf, 362.PS2_S    , 363.PS3_F    , 364.PS3_S    , 365.PS3_S_GIC
366.PS3_S_MN , 367.PS3_S_SCP, 368.PS10_S   , 369.PS10_S_MN, 370.CCOIL
371.CUBESOLN , 372.SIPRES   , 373.CCLINPTS , 374.PTSP     , 375.PMELODY
376.FLOWSHOP , 377.PS5_S_MN , 378.IOBALANCE, 379.FDESIGN  , 380.PMEANVAR
381.POWERSET , 382.LINEARNE , 383.SARAS    , 384.EPSCMMIP , 385.BIDPWL
386.TRNSPWLX
$hidden seq . name mapping goes here
                                                /

set incmap(inc,s) list of include files required /
$hidden enter new include files and/or new $includes
$hidden gamslib will copy include files according to this mapping
'br17.inc'      .(177*180,345,374)
'copspart.inc'  .(233,234,240,241)
'csched1.inc'   .(222)
'csched2.inc'   .(222)
('gamsmod.inc',
 'gamsref.inc') .(101,190,195,215,216)
'qpdata.inc'    .(171*175,184,246,271,283)
'slvdata.inc'   .(216)
'poolmod.inc'   .(254)
't1000d.inc'    .(266)
'bchtlheu.inc'  .(286)
('bchdicut.inc', 'berlin2.inc').287
('bchoil_c.inc', 'bchoil_d.inc', 'bchoil_h.inc').288
'bchcover.inc'  .289
'tai7a.inc'     .296
'f001.inc'      .297
'p43.inc'       .(298,348)
'hervesio.xls'  .305
'cox3.xls'      .310
'netgn099.inc'  .323
'gnetgn99.inc'  .323
'swathdat.gdx'  .325
'worktrip.inc'  .331
'runcsdp.inc'   .(338*340,355)
'tg207777.inc'  .338
'pb16x7.inc'    .339
'scarfdata.inc' .132
'50_25.inc'     .355
'water.gdx'     .357
'water.xls'     .357
'mvdata.gdx'    .380
'pwlfunc.inc'   .(385,386)
                                         /

set as (a,s) model classification /
$hidden do not forget to classify the model at least once

 agecon.(26,49,55,56,75,86*92,181,284,383)
 age   .(81,97,100,107,129*141,145*149,151*156,209*212,269,274*281,304,341,354)
 bch   .(286*289,348,349)
 cheme .(20,21,76,116*123,127,165,214,222,226,227,233,240*242,254,270,350)
 ct    .(358*369,377)
 econ  .(23*25,331)
 dev   .(33*35,41,63,143)
 disj  .(332*337)
 ener  .(28,46*48,52*54,57,80,82,96,144,161,342,382)
 eng   .(22,68,125,166,167,168,202*206,217,223,224,230*232,235*239,243*245,305,379)
 fin   .(50,72,110,111,112,113,114,115,124,171*175,184,246,271,282,283,291,327,373,380)
 forest.(61,62)
 tra   .(31,45,142,150)
 macro .(40,43,64,69,293)
 ms    .(1*6,8*12,18,29,37,39,60,65,74,79,93,94,98,101*106,108,109,126
         128,164,169,182,185,194,207,220,221,225,247,250,268,273,290,294
         306,309,310,312,314,315,325,326,328,330,339,340,351,352,355*357,370
         376,385,386)
 math  .(36,42,59,67,70,71,73,83,84,95,99,157*160,162,176,184,201,208,229,234,
         251,252,253,255*261,263*267,272,295,319,321,329,338,346,371,372,384)
 micro .(7,13*17,19,30,32,38,44,51,58,66,78,85,163,228)
 stat  .(27,77,192,285,299*303,378)
 rec   .(42,103,158,159,170,176,177*180,191,193,213,218,219,272,353)
 sp    .(186*189,196*200,248,249,344)
 spec  .(105,109,160,177*180,332*337,345)
 gamsl .(101,104,183,190,195,215,216,262,292,307,308,311,313,316*318,320,322,343,347,374,375,381)
 gamst .(296*298,323,324)   /

$hidden tell model type
set t       single model types / system.modeltypes, DECIS, GAMS, MPSGE, OSLSE /
    ts(t,s) classification by type /
    cns.   (58,209*212)
    decis. (196*200)
    dnlp.  (23,68,217,259,260,263,265,299,300,305)
    gams.  (29,67,70*73,93,94,101,103,104,157,162,183,190,195,215,216,
            262,292,297,307,308,311,313,316*318,320,322,340,343,347,374,375,381)
    emp.   (332*337,382)
    lp.    (1*8,10,11,13,15,17,23,26,32,34,35,37,39,40,44,46,49,50,
            52,54*57,59*62,65,66,74,75,78,79,82,87*92,102,106,108,110,
            164,175,181,186*189,192,196,199,200,207,248,249,314,
            315,319,323,328,344,357)
    mip.   (9,12,14,16,19,30,31,38,42,44,45,48,51,58,98,103,105,109,114,115,
            118,120,121,158*160,163,170,176*180,182,185,191,193,194,207,208,
            213,218*221,225,247,268,272,287,288*290,294,298,306,309,310,312,
            324*326,330*331,338,342,345,348,349,351*353,356,370,371,376,384*386)
    nlp.   (18,20*28,33,36,41,43,47,52,53,63,64,69,76,77,80,81,
            83*86,92,95*97,99,100,107,111,112,118,120,124,161,165,166,167,
            169,171*174,194,201,202,214,217,228,229*245,246,251,252,253,254,
            255*258,261,264,266,267,274*281,295,301*303,321,358*369,372,373,377,378,383)
    mcp.   (126*156,169,184,228,269,329,341,354)
    mpsge. (139*156,304)
    minlp. (113,116,117,119,122*125,168,203*206,217,222*224,226,227,250,270,286,346,350)
    miqcp. (282,291,296,327,380)
    oslse. (186*189)
    qcp.   (110,282*285,293,271,273,379)
    rminlp.(124)
    rmiqcp.(339,355)
    rmip.  (30,182)
    mpec.  (269)   /

parameter oval ordinal value of model type for slvtest/
    MINLP   1, LP      6,  RMIP   11,  MPEC   16,
    MIQCP   2, GAMS    7,  RMINLP 12,  RMPEC  17,
    NLP     3, DECIS   8,  CNS    13,  RMIQCP 18,
    QCP     4, MCP     9,  DNLP   14,  EMP 19,
    MIP     5, MPSGE  10,  OSLSE  15
/;

set big(s) need full solver license to run  /
           6,13,14,16,17,30,31,34,35,44,45,48,49,51,54,57,62,66,75,78,86
           87,89,90,97,103,107,114,115,122,123,134,137,139*146,150,153,156
           158,159,169,170,173,176,178,180,181,184,185,186,189,193,
           196,200,210,211,213,218,219,220,221,222,225,229*245,247,251*253,
           254,266,268,270,272,273,286*288,304,309,310,312,321,323*325,328*331,
           338*339,342,345,346,353,357,370,372,379,382,386/;

set gbig(s) "cannot be solved with global solvers with 2000x3000 limit (lgo, lindoglobal)" /
           31,44,181,185,233,247,273,309,325,342 /;

set tiny(s) model that have not more than 10x10 variables and equation /
           1*3,24,26,27,50,76,83,84,95,99,106,112,124,127,131,133,149,
           155,166,201,203,208,255*261,264,267,274,282,295,311,341 /;

set notest(s) / 190,195,215,216,290,292,307,308,313,322 /;

$if not exist gams.bib $goto nobib
$onecho > %gams.scrdir%r2g.%gams.scrext%
 76 197  75  74  73  72  71  70  69 178  56 167 166 153 165
164 100  90  98  97 185  96  95  94  93  92 163 162 203 194
159 206 157 184 155 154 202  53 205 151 182 204 150 148 147
146 145 144 180  57  68 200 143 142 199 140 198 133 181 139
138 196 137 177 176 121   8   6 135 134 132 116 131  99 192
187 130 129 128 193 175 127 174 126 125 124 122 186 118 158
120 119  54  25  31 195  18   1  30  26 117  28   9  33 115
102 113 114 112 172 173 482 111 110 109 189 108 170 106 105
103 169 101  86 207  91 168  66  88  16  87  85  79 190  83
 62  82  80 217 136 107  77  63  81 188  59  11  60  58  41
 17  27  55  51  49  50  12  48  47  44  45  46  84 160 212
213  21  13  19 214 215 216 179   7  10  15  24  52  61  64
 89 104 123 141 149 152 156 161 183 191 201 211  20 320 310
315 302 303 308 314 309 297 298 304 312 301 313 311 319 305
307 299 318 300 317 306 316 376 377 378 379 380 381 382 383
 78 397 398 404 405 406 407 408 409 441 440 241 442 439 328
446 447 448 449 450 451 452 453 454 242 456 457 458 466 467
469 470 472 471 473 476 477 478 479 484 485 486 487 488 489
490 491 492 493 494 495 496 497 498 499 500 503 505 507 509
510 511 512 515 516 517 518 519 520 521 522 523 524 527 528
529 530 532 533 534 535 536 537 538 539 540 541 542 543 544
545 546 547 551 459 552 556 557 558 559
$offecho
* r1-r325
$echo { for(i=1; i<=NF; i++) print "r" ++j, $i } > "%gams.scrdir%x.awk"
$call awk -f "%gams.scrdir%x.awk" "%gams.scrdir%r2g.%gams.scrext%" > r2g.txt
$call rm -f "%gams.scrdir%x.awk"

$call "bib2gms gams.bib r=r2g.txt i=gamsmod"
$echo set ath author /                            > gamsref.inc
$call cat gamsmod.a                              >> gamsref.inc
$echo                /                           >> gamsref.inc
$echo set r references /                         >> gamsref.inc
$call cat gamsmod.r                              >> gamsref.inc
$echo                  /                         >> gamsref.inc
$echo $onempty                                   >> gamsref.inc
$echo set ro(r) overflow references /            >> gamsref.inc
$call cat gamsmod.ro                             >> gamsref.inc
$echo                  /                         >> gamsref.inc
$echo $offempty                                  >> gamsref.inc
$echo set cr(r,r) cross references /             >> gamsref.inc
$call cat gamsmod.crr                            >> gamsref.inc
$echo                              /             >> gamsref.inc
$echo set cath(ath) credit authors /             >> gamsref.inc
$call cat gamsmod.ca                             >> gamsref.inc
$echo                              /             >> gamsref.inc
$echo set athf(ath,r) first author /             >> gamsref.inc
$call cat gamsmod.far                            >> gamsref.inc
$echo                              /             >> gamsref.inc
$echo set athr(ath,r) author reference mapping / >> gamsref.inc
$call cat gamsmod.ar                             >> gamsref.inc
$echo                                          / >> gamsref.inc

$label nobib

$include gamsref.inc

set sr(s,r) sequence reference mapping /
       1.(r1,r2),         2.r3,               3.r4,
       4.r5,              5.r6,               6.r7,
       7.r8,              8.r9,               9.r10,
      10.r11,             11.r12,            12.(r13,r14,r284),
      13.r15,             14.r15,            15.r16,
      16.r16,             17.r16,            18.r17,
      19.r18,             20.r19,            21.r20,
      22.r21,             23.r22,            24.r23,
      25.r24,             26.r25,            27.r26,
      28.r27,             29.r28,            30.r29,
      31.r30,             32.(r31,r164),     33.r32,
      34.r33,             35.r34,            36.r35,
      37.r36,             38.r37,            39.r14,
      40.r39,             41.r40,            42.r41,
      43.(r42,r43),       44.r44,            45.r45,
      46.r46,             47.r47,            48.r48,
      49.r49,             50.r50,            51.r51,
      52.r52,             53.r53,            54.r54,
      55.r55,             56.r56,            57.r57,
      58.r173,            59.r58,            60.r59,
      61.r60,             62.r60,            63.(r61,r62),
      (64,293).r63,       65.r64,            66.r65,
      67.r222,            68.(r67,r68),      69.r69,
      70.r222,            71.r222,           72.r222,
      73.r66,             74.r70,            75.r71,
      76.r72,       (77,285).r73,            78.r65,
      79.r74,             80.r75,            81.r76,
      82.r77,             83.r78,            84.r79,
      85.r80,             86.r81,            87.r82,
      88.r82,             89.r83,            90.r83,
      91.r84,             (92,284).r84,      93.r7,
      94.r85,             95.r86,            96.r87,
      97.r88,             98.r89,            99.r90,
     100.r38,            101.r222,          102.r91,
     103.(r92,r220),     104.r1,            105.r89,
     106.r1,             107.r93,           108.r165,
     109.r10,            110.r94,           111.r94,
     112.r94,            113.r94,           114.r94,
     115.r94,            116.(r95,r96),     117.r97,
     118.(r98,r96),      119.(r99,r96),     120.(r100,r96),
     121.(r101,r96),     122.(r102,r96),    123.r103,
     (124,282).r104,     125.(r67,r68),     126.r1,
     127.r72,            128.r80,           129.r76,
     130.r38,            131.r105,          132.r106,
     133.(r107,r108),    134.r109,          135.r106,
     136.r166,           137.r172,          138.r110,
     139.r111,           140.r76,           141.r113,
     142.r114,           143.r115,          144.r75,
     145.r116,           146.r117,          147.r106,
     148.r118,           149.r119,          150.r120,
     151.r112,           152.r106,          153.r121,
     154.r122,           155.r123,          156.r124,
     157.r222,           158.r220,          159.r125,
     160.r222,           161.r126,          162.r127,
     163.r18,            164.r128,          165.r129,
     166.r130,           167.r131,          168.r130,
     169.r132,           170.(r223,r224),   (171,283).r223,
     172.r223,           173.r223,          174.r223,
     175.r223,           176.(r225,r254,r290), 177.r223,
     178.r223,           179.(r223,r163),   180.r223,
     181.r134,           182.(r218,r219),   183.r222,
     184.r223,           185.r135,          186.r136,
     187.r137,           188.r138,          189.r9,
     190.r221,           191.r139,          192.r140,
     193.r141,           194.r142,          195.r221,
     196.r9,             197.r143,          198.r143,
     199.r144,           200.r136,          201.r145,
     202.(r146,r147,r148), 203.r147,        (204,286).(r149, r150, r193),
     205.(r151, r150),   206.r152,          207.r153,
     208.r222,           209.r76,           210.r88,
     211.r93,            212.r38,           213.r154,
     214.(r155, r156),   215.r221,          216.r221,
     217.r157,           218.r158,          219.r158,
     220.r159,           221.(r160, r161, r162), 222.r167,
     223.r168,           224.r133,          225.r169,
     226.r100,           227.(r98, r96),    228.(r170, r171)
     229.(r194,r195,r196), 230.(r194,r197,r198), 231.(r194,r199),
     232.(r194,r200),    233.(r194,r201,r202,r203,r204), 234.(r194,r205),
     235.(r194,r204),    236.(r194,r207),   237.(r194,r208,r209),
     238.(r194,r210),    239.(r194,r216,r211),   240.(r194,r202,r203,r204),
     241.(r194,r202,r203,r212,r204,r150), 242.(r194,r213), 243.(r194,r214,r203),
     244.(r194,r215,r203), 245.(r194,r206), 246.r223,
     247.(r227,r228),    248.r137,          249.r144
     250.(r229,r230),    251.(r231,r232),   252.(r232,r233)
     253.(r232,r234),    254.(r232,r155,r235,r236,r237,r238,r239)
     (255*260).(r243*r245), 260.r246, (261,263,265,266).r242, 263.r247
     262.r222,           264.r250,          267.r79,
     268.(r248,r249),    269.(r107,r240,r241), 270.(r251,r252)
     271.(r253,r223),    272.(r225,r254,r290),   273.r255
     274*281.r256,       287.(r257,r258),   288.(r259,r260)
     289.(r261*r263),    290.r264,          291.r94
     292.r222,           294.(r265,r266),   295.r79
     296.r267,           297.(r268,r269),   298.r270
     299.r271,           300.r272,          301.(r273,r274)
     302.r275,           303.(r276,r277),   304.r278
     305.(r279,r280,r281),306.r282,         307.r222
     308.r222,           309.r222,          310.r283
     311.r222,           312.r222,          313.r222
     314.r1,             315.r1,            316.r222
     317.r222,           318.r222,          319.r285
     320.r222,           321.r286,          322.r222
     323.(r287,r288),    324.r222,          325.r289
     326.r291,           327.r94,           328.r292
     329.r293,           330.(r225,r254,r290), 331.(r294,r295)
     332.(r296,r297),    333.(r296,r297),   334.(r296,r297)
     335.r296,           336.(r297,r298),   337.(r296,r297)
     338.(r299,r300),    339.(r301,r302),   340.(r1,r2)
     341.r105,           342.r303,          343.r221
     344.r304,           345.r305,          346.r306
     347.r221,           348.(r261*r263),   349.(r265,r266)
     350.r307,           351.(r1),          352.r14
     353.r308,           354.(r309,r310,r318),   355.(r301,r302)
     356.r311,           357.(r312,r313),   358.(r314,r315)
     359.(r314,r315),    360.(r314,r315),   361.(r314,r315)
     362.(r314,r315),    363.(r314,r315),   364.(r314,r315)
     365.(r314,r315),    366.(r314,r315),   367.(r314,r315)
     368.(r314,r315),    369.(r314,r315),   370.r259
     371.r41,            372.r316,          373.r317
     374.r222,           375.r222,          376.r249
     377.r314,           378.r319,          379.r320
     380.r321,           381.r222,          382.r322
     383.(r323,r324),    384.(r285,r325),   385.r18
     386.r1
/

set sath(s,ath) main model author /
    12."Garver, L L"
   121."Raman, R"
   122."Viswanathan, J"
   269."Murphy, F H"
   270."Kallrath, J"
   297."Somwaru, A"
   305."Meeraus, W H"
   315."Ferris, M C"
   321."Liberti, L"
   354."Hieu, P S"
/;

* If not explicitely assigned, assign the first author of the
* first reference to be the main model author
scalar fmma;
loop(s$(sum(sath(s,ath),1)=0),
 fmma=1;
 loop(athf(ath,r)$(sr(s,r) and fmma), sath(s,ath) = yes; fmma=0);
);

alias(s,ss); set srev(s,s) reverse set ; srev(s,s+(card(s)+1-2*ord(s))) = yes;


$onempty
set drop(t,s) Additional drop set /
    cns.   (58)
*   decis. ( )
    dnlp.  (217)
    gams.  (103)
    lp.    (44,207)
    mip.   (118)
    nlp.   (120,194,228)
*   mcp.   ( )
*   mpsge. ( )
*   minlp. ( )
*   oslse. ( )
*   rminlp.( )
*   rmip.  ( )
                                  /;

set tss(t,s) only one type per model used in IDE files;

* quick and dirty dropping of multiple classifications
tss(t,s)                       = ts(t,s) - drop(t,s);
tss('rmip  ',s)$ts('mip  ',s)  = no;
tss('lp    ',s)$ts('nlp  ',s)  = no;
tss('lp    ',s)$ts('qcp  ',s)  = no;
tss('qcp   ',s)$ts('miqcp',s)  = no;
tss('nlp   ',s)$ts('dnlp ',s)  = no;
tss('nlp   ',s)$ts('mcp  ',s)  = no;
tss('rminlp',s)$ts('minlp',s)  = no;
tss('nlp   ',s)$ts('minlp',s)  = no;
tss('mcp   ',s)$ts('mpec ',s)  = no;
tss('mcp   ',s)$ts('rmpec',s)  = no;
tss(t       ,s)$ts('mpsge',s)  = sameas(t,'mpsge');
tss(t       ,s)$ts('decis',s)  = sameas(t,'decis');
tss(t       ,s)$ts('oslse',s)  = sameas(t,'oslse');
tss(t       ,s)$ts('emp'  ,s)  = sameas(t,'emp');

alias (r,rr);

set err1(s)    'model unclassified in AS(A,S)'
    err2(s)    'model unclassified in TS(T,S)'
    err3(s)    'model unclassified in SM(S,M)'
    err4(s)    'model unclassified in SATH(S,ATH)'
    err5(s)    'all types dropped in DROP(T,S)'
    err6(s)    'multiple types in TSS(T,S)'
    err7(t,s)  'drops missing in DROP(T,S) for model with multiple types'
    err8(m)    'model and include names cannot have the same name'
    err9(s)    'model unclassified in SR(S,R)'
    err10(r)   'reference unclassified in SR(S,R) and not crossref'
    err11(r)   'reference unclassified in ATHR(ATH,R)'
    err12(ath) 'author unclassified in ATHR(ATH,R)';

err1(s) = not sum(as(a,s), yes);
err2(s) = not sum(ts(t,s), yes);
err3(s) = not sum(sm(s,m), yes);
err4(s) = not sum(sath(s,ath), yes);
err5(s) = sum(t$(ts(t,s)-drop(t,s)), 1) = 0;
err6(s) = sum(tss(t,s), 1) > 1;
err7(t,s)$err6(s) = tss(t,s);
err8(m) = sum(inc, sameas(m,inc));
err9(s) = not sum(sr(s,r),yes);
err10(r) = not sum(sr(s,r),yes) and not sum(cr(r,rr),yes);
err11(r) = not sum(athr(ath,r),yes);
err12(ath) = not sum(athr(ath,r),yes);

abort$card(err1) err1;
abort$card(err2) err2;
abort$card(err3) err3;
abort$card(err4) err4;
abort$card(err5) err5;
abort$card(err6) err6,err7;
abort$card(err8) err8;
abort$card(err9) err9;
abort$card(err10) err10;
abort$card(err11) err11;
abort$card(err12) err12;
