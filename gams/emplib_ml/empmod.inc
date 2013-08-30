* -*- fundamental -*-
$hidden When adding models we need to update this file at a few
$hidden spots. Look for $hidden lines. To check > gams empmod.inc
$hidden   update lib version above and run gams empmod.inc
alias (u,*)
SETS s Model Sequence Numbers / 1*95 /
$hidden                           bump sequences numbers above

$stitle Model Names and Titles
set m model names in alphabetic order /
$hidden  enter the new model here, keep in order
A
AFFINEVI   'Affine Variational Inequality'
AIRLIFT    'Airlift operations schedule'
AIRSP3     'Aircraft allocation - stochastic optimization'
APL1PSP    'Stochastic Electric Power Expansion Planning Problem'
APL1PCASP  'Stochastic Electric Power Expansion Planning Problem'
B
BATCHSP    'Design of batch chemical plants with stcohastic demand and price'
BARD511    'Practical Bilevel Optimization Example 5.1.1'
BARD721    'Practical Bilevel Optimization Example 7.2.1'
BARD722    'Practical Bilevel Optimization Example 7.2.2'
BARD851    'Practical Bilevel Optimization Example 8.5.1'
BARD871    'Practical Bilevel Optimization Example 8.7.1'
C
CARGONET   'Cargo network scheduling with stochastic transportation demand'
CCMG153    'Bilevel Programs in Engineering Example 1.5.3'
CCMG71     'Bilevel Programs in Engineering Example 7.1'
CCMG74     'Bilevel Programs in Engineering Example 7.4'
CIRCLESP   'Circle Enclosing Points - Stochastic Example'
CLEARLAKSP 'Scenario Reduction: ClearLake exercise'
D
E
EMPHTM     'Generates HTM emplib library files'
EMPUTIL    'Generates the EMP Model Library files'
EXC2X2EMP  'pure exchange model (ie no production)'
EXC2X2EMP-DEM 'pure exchange model (ie no production)'
F
FARMSP     "The Farmer's Problem - Stochastic"
FERRIS43   'Educational embedded complemenarity system model'
FLDS911    'Princeton Bilevel Optimization Example 9.1.1'
FLDS912    'Princeton Bilevel Optimization Example 9.1.2'
FLDS913    'Princeton Bilevel Optimization Example 9.1.3'
FLDS914    'Princeton Bilevel Optimization Example 9.1.4'
FLDS915    'Princeton Bilevel Optimization Example 9.1.5'
FLDS916    'Princeton Bilevel Optimization Example 9.1.6'
FLDS917    'Princeton Bilevel Optimization Example 9.1.7'
FLDS918    'Princeton Bilevel Optimization Example 9.1.8'
FLDS919    'Princeton Bilevel Optimization Example 9.1.9'
FLDS921    'Princeton Bilevel Optimization Example 9.2.1'
FLDS922    'Princeton Bilevel Optimization Example 9.2.2'
FLDS923    'Princeton Bilevel Optimization Example 9.2.3'
FLDS924    'Princeton Bilevel Optimization Example 9.2.4'
FLDS925    'Princeton Bilevel Optimization Example 9.2.5'
FLDS926    'Princeton Bilevel Optimization Example 9.2.6'
FLDS927    'Princeton Bilevel Optimization Example 9.2.7'
FLDS928    'Princeton Bilevel Optimization Example 9.2.8'
FLDS929    'Princeton Bilevel Optimization Example 9.2.9'
FLIPPER    'Test of flipping equations'
FOODEMP    'Food Manufacturing Problem - Blending of oils'
G
GEN2S      'Two stage stochastic program in the generic form'
GOEMPGO    'EMP Quality Assurance Test'
H
HARK-MONOP      'SPE model from Harker - monopolist and competetive versions'
HARK-STACK      'SPE model from Harker - Stackelberg version'
HARK-OLIGOP     'SPE model from Harker - oligopoly version'
HARK-OLIGOP-IND 'SPE model from Harker - oligopoly version'
I
J
JOINTC1    'Educational bilevel model'
JOINTC2    'Educational bilevel model'
K
KILOSAFARM 'Kilosa farm problem'
L
LANDSSP    'Optimal Investment'
M
MAKESPAN   'Job scheduling with three datasets - Minimize the makespan'
MIRRLEES   'Simple Nonconvex Bilevel Programming Example'
MULTMPEC   'Educational bilevel model with VI followers'
N
NBCONTINDEP 'Newsboy problem, continuous and independent distribution'
NBCONTJOINT 'Newsboy problem, continuous and joint distribution'
NBDISCINDEP 'Newsboy problem, discrete and independent distribution'
NBDISCJOINT 'Newsboy problem, discrete and joint distribution'
NBSIMPLE    'Simple newsboy problem, discrete'
NEGISHI    'Pure exchange model solved with EMP, SJM, and CGE'
NLP2MCP    'nlp2mcp: Form the KKT conditions of an NLP as an MCP'
O
OA         'Outer Approximation with GAMS'
P
PIES       'PIES Energy Equilibrium'
PORTFOLIO  'Stochastic portfolio model'
PRODSP3    'Stochastic Programming Example'
Q
R
S
SEQUENCE   'Sequencing on a single machine'
SCARFEMP-ALTDEM  "Scarf's Activity Analysis Example - non-closed form demand function"
SCARFEMP-DEM  "Scarf's Activity Analysis Example"
SCARFEMP-DUAL  "Scarf's Activity Analysis Example"
SCARFEMP-PRIMAL  "Scarf's Activity Analysis Example"
SCARFEXPEND  "Scarf's Activity Analysis Example"
SIMPENLP   'Simple example of ENLP'
SIMPEQUIL  'Simple Equilibrium'
SIMPEQUIL2 'Simple Equilibrium with external constraint'
SIMPLECHANCE 'Simple chance constraint model'
SIMPLEVI   'Simple Variational Inequality'
SIMPLEVI2  'Simple Nonlinear Variational Inequality'
SIMPLEVI3  'Another simple VI example'
SIMPLEVI4  'A simple example for 2 VIs'
SKU1SP     'Multi-product assemble model with discrete and Poisson demand distribution'
SP3X2      'Simple stochatic model'
STOCFOR3   'Long Range Forest Planning'
T
TARGET     'State Variable Targetting in EMPs ECS Framework'
TRAFFIC    'Traffic Assignment Model'
TRAFFIC2   'Traffic Assignment Model'
TRANSBP    'Transportation model with variable demand function using bilevel programming'
TRANSECS   'Transportation model as equilibrium problem using embedded complementarity'
TRANSEQL   'Transportation model as equilibrium problem'
TRANSSP    'A Stochastic Transportation Problem'
TRANSVI    'VI version of the transport model'
TR20       'Extended transport model with stochastic demand and costs'
TWO3EMP    'EMP Formulation of Simple 2 x 2 x 2 General Equilibrium Model'
U
V
W
X
Y
Z
ZEROFUNC 'Match unmatched vars with zero functions in VI'

/;

set letters(m) / a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z /;

set inc 'list of include files, .inc extension assumed' /
  'empmod'      EMP Model Library
  'hark-data'  'data for Harker SPE model'
/;

$onempty
set minc(m) 'list of model files $included' /
  'hark-oligop'
/;
$offempty

set oinc 'list of other files needed and/or $included' /
  'tr20_scen.gdx'
/;

set ainc(*) 'all include files';
ainc(u) = inc(u) or sum{minc,sameas(minc,u)};
* or sum{oinc,sameas(oinc,u)};

$stitle Model Assignments
set sm(s,m) model sequence number assignment /
  1.emputil,     11.ccmg74  ,     21.negishi ,     31.flds915 ,     41.flds926 ,
  2.transvi,     12.mirrlees,     22.jointc1 ,     32.flds916 ,     42.flds927 ,
  3.traffic,     13.target  ,     23.jointc2 ,     33.flds917 ,     43.flds928 ,
  4.bard511,     14.transecs,     24.ferris43,     34.flds918 ,     44.flds929 ,
  5.bard721,     15.makespan,     25.multmpec,     35.flds919 ,     45.transeql,
  6.bard722,     16.goempgo ,     26.transbp ,     36.flds921 ,     46.simplevi,
  7.bard851,     17.emphtm  ,     27.flds911 ,     37.flds922 ,     47.simplevi2,
  8.bard871,     18.zerofunc,     28.flds912 ,     38.flds923 ,     48.affinevi,
  9.ccmg153,     19.traffic2,     29.flds913 ,     39.flds924 ,     49.simpequil,
 10.ccmg71 ,     20.sequence,     30.flds914 ,     40.flds925 ,     50.flipper,

 51.scarfemp-dem,    61.nlp2mcp,         71.apl1pcasp,   81.prodsp3,        91.GEN2S
 52.scarfemp-altdem, 62.simplevi3,       72.clearlaksp,  82.simplechance,   92.SKU1SP
 53.scarfemp-primal, 63.simpequil2,      73.farmsp,      83.sp3x2,          93.simplevi4
 54.scarfemp-dual,   64.hark-monop,      74.kilosafarm,  84.tr20,           94.transsp
 55.scarfexpend,     65.hark-oligop,     75.landssp,     85.nbsimple,       95.oa       
 56.pies,            66.hark-oligop-ind, 76.nbcontindep, 86.airlift
 57.exc2x2emp,       67.hark-stack,      77.nbcontjoint, 87.stocfor3
 58.exc2x2emp-dem,   68.two3emp,         78.nbdiscindep, 88.circlesp
 59.foodemp,         69.airsp3,          79.nbdiscjoint, 89.batchsp
 60.simpenlp,        70.apl1psp,         80.portfolio,   90.cargonet


$hidden seq . name mapping goes here
/;

set incmap(*,s) 'list of $included files required for model s' /
$hidden enter new include files and/or new $includes
$hidden emplib will copy $included files according to this mapping
    empmod.(1,16*17)
    hark-data.(64*65)
    'hark-oligop'.(66*67)
    'tr20_scen.gdx'.84
/;

$hidden tell model type
set t       single model types / BP, LOGICAL, ECS, ENLP, EQUIL, GAMS, SP, VI /
    ts(t,s) classification by type /
    BP  .(4*12,22*23,25*44,67)
    LOGICAL.(15,20,59)
    ECS .(13*14,21,24,45)
    ENLP.(60)
    EQUIL.(49*58,63*66,68)
    GAMS.(1,16*17,61,95)
    SP  .(69*92,94)
    VI  .(2*3,18*19,46*48,62,93)
/;

$onempty
set big(s) need full solver license to run  /
  74, 84, 87, 90
/;

set drop(t,s) Additional drop set / /;
$offempty

set tss(t,s) only one type per model used in IDE files;

* quick and dirty dropping of multiple classifications
tss(t,s) = ts(t,s) - drop(t,s);


alias(s,ss); set srev(s,s) reverse set ; srev(s,s+(card(s)+1-2*ord(s))) = yes;

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
