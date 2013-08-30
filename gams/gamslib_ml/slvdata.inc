$ONTEXT

   Data file for running slvtest. Option --runall=yes will include
   models in the skip lists (sets exsmw, exsml).

$OFFTEXT

$offlisting
$include gamsmod.inc
$onlisting

$eolcom //
$ondollar

$set slvcreate slvcreate.gms
$set trace slvtest.txt       // trace file  (will be appended to)

$set SLASH \
$if %system.filesys% == UNIX $set SLASH /

$if not set weaktl   $set weaktl 3
$if not set PREFIX   $set PREFIX %system.buildcode%
$if not set fail     $set fail failures_slv.gms
$if not set keepfail $set keepfail 0
$setnames %fail% v1 v2 v3
$set fail2 %v2%I%v3%

$if %keepfail%==0 $call rm -f %fail% %fail2%
$if not exist %fail% $echo "$call rm -f %fail2%" >> %fail%
$echo * Failures of slvtest run started at %system.date% %system.time% >> %fail%

$set cond %gams.u1%
$if  '%cond%' == ''        $set cond 'ord(s) <= card(s)'
$ifi '%cond%' == 'test'    $set cond 'ord(s) = 23'
$ifi '%cond%' == 'initial' $set cond '(ord(s)=1 or ord(s)=27 or ord(s)=99 or ord(s)=124 or ord(s)=131 or ord(s)=149 or ord(s)=208 or ord(s)=212 or ord(s)=248 or ord(s)=269 or ord(s)=284 or ord(s)=291 or ord(s)=311)'
$ifi '%cond%' == 'big'     $set cond 'big(s)'

$ifi '%cond%' == 'small'   $set cond 'not big(s)'
$ifi '%cond%' == 'small_1' $set cond '(not big(s)                  and ord(s) <= 150)'
$ifi '%cond%' == 'small_2' $set cond '(not big(s) and ord(s) > 150 and ord(s) <= 300)'
$ifi '%cond%' == 'small_3' $set cond '(not big(s) and ord(s) > 300                  )'

$ifi '%cond%' == 'lic'     $set licensed 1
$ifi '%cond%' == 'lic_1'   $set licensed 1
$ifi '%cond%' == 'lic_2'   $set licensed 1
$ifi '%cond%' == 'lic_3'   $set licensed 1

$ifi '%cond%' == 'lic'     $set cond 'ord(s) <= card(s)'
$ifi '%cond%' == 'lic_1'   $set cond '(                 ord(s) <= 150)'
$ifi '%cond%' == 'lic_2'   $set cond '(ord(s) > 150 and ord(s) <= 300)'
$ifi '%cond%' == 'lic_3'   $set cond '(ord(s) > 300                  )'

$ontext
initial includes:
'ord(s)=1'       lp trnsport   'ord(s)=212'     cns korcns
'ord(s)=27'     nlp sample     'ord(s)=248' scenred srkandw
'ord(s)=124'  minlp alan       'ord(s)=269'    mpec nash
'ord(s)=131'    mcp two3mcp    'ord(s)=284'     qcp qdemo7
'ord(s)=149'  mpsge kehomge    'ord(s)=291'   miqcp qmeanvar
'ord(s)=208'    mip absmip     'ord(s)=311'         gsolver
$offtext

$set cond1 1
$set cond2 1
$set cond3 1
$set cond4 1
$set cond5 1

$if set c1 $set cond1 sameas(s1,'%c1%')
$if set c2 $set cond2 sameas(s2,'%c2%')
$if set c3 $set cond3 sameas(s3,'%c3%')
$if set c4 $set cond4 sameas(s4,'%c4%')
$if set c5 $set cond5 sameas(s5,'%c5%')


$set TESTLIM 2000
$set MYWORKSPACE 500
$ifi %sysenv.COMPUTERNAME% == XPTESTER $set MYWORKSPACE 300  // XP tester has only 500 MB RAM

$set MINLPSpecial    skip = ((sameas('MINLP',t1) or sameas('MIQCP',t1)) and minlpskip(s1,s2,s3)) or (sameas('MIQCP',t1) and miqcpskip(s1,s2,s3))

* s Model Sequence Numbers
* m model names in alphabetic order

parameter test model type summary;
test(s,t)       = ts(t,s);
test(s,'total') = sum(t, test(s,t));
test('total',t) = sum(s, test(s,t));
*display test;

test(s,'mcp' )$ts('mpsge',s) = 1; test(s, 'mpsge') = 0;
$if not set licensed test(s,'nlp' )$ts('minlp',s) = 1;
$if not set licensed test(s,'mip' )$ts('minlp',s) = 1;
test(s,'qcp' )$ts('miqcp',s) = 1;
test(s,'mip' )$ts('miqcp',s) = 1;
test(s,'gams')$ts('gams' ,s) = 0;


* sets below are defined in gamsmod.inc
* big(s)      cannot be solved with student system
* notest(s)   should not be used for testseries
* t           model types  DECIS, GAMS, LP, MIP, ...

set solver master set of solvers
        / alphaecp, baron, bdmlp, bdmlpd, bonmin, bonminh, cbc, conopt, conopt4, couenne, cplex, cplexd
          dicopt, glomiqo, gurobi, ipopt, ipopth, jams, knitro, lgo, lindoglobal, miles, minos, msnlp
          mosek, nlpec, oqnlp, osicplex, osigurobi, osimosek, osixpress, osl, path, pathnlp
          sbb, scip, snopt, soplex, sulum, xa, xpress
        /

    dsolver dummy solvers to access solvers
        / decisc /

    gsolver(solver) solvers with 10x10 demo limit
        / baron, glomiqo, lgo, lindoglobal, msnlp, oqnlp /

    gsolverlim(solver) solvers with 2000x3000 global limit
        / lgo, lindoglobal /;

alias (solver,minlpslv,nlpslv,qcpslv,mipslv);
set minlpskip(minlpslv,nlpslv,mipslv) 'never use these combos for MINLP'
    miqcpskip(minlpslv,qcpslv,mipslv) 'never use these combos for MIQCP';

*Some MINLP solvers only with default subsolvers
minlpskip('BARON'      ,nlpslv,mipslv) = yes;  minlpskip('BARON'      ,'%system.nlp%','%system.mip%') = no;
minlpskip('LINDOGLOBAL',nlpslv,mipslv) = yes;  minlpskip('LINDOGLOBAL','%system.nlp%','%system.mip%') = no;
minlpskip('BONMIN'     ,nlpslv,mipslv) = yes;  minlpskip('BONMIN'     ,'%system.nlp%','%system.mip%') = no;
minlpskip('BONMINH'    ,nlpslv,mipslv) = yes;  minlpskip('BONMINH'    ,'%system.nlp%','%system.mip%') = no;
minlpskip('COUENNE'    ,nlpslv,mipslv) = yes;  minlpskip('COUENNE'    ,'%system.nlp%','%system.mip%') = no;
minlpskip('KNITRO'     ,nlpslv,mipslv) = yes;  minlpskip('KNITRO'     ,'%system.nlp%','%system.mip%') = no;
minlpskip('OQNLP'      ,nlpslv,mipslv) = yes;  minlpskip('OQNLP'      ,'%system.nlp%','%system.mip%') = no;
minlpskip('SBB'        ,nlpslv,mipslv) = yes;  minlpskip('SBB'        ,nlpslv        ,'%system.mip%') = no;
minlpskip('SCIP'       ,nlpslv,mipslv) = yes;  minlpskip('SCIP'       ,'%system.nlp%','%system.mip%') = no;

* Since AlphaECPs MIPs grow very large we only want COIN-OR solver to solve the MIPs
minlpskip('ALPHAECP',nlpslv,mipslv)         = yes;
minlpskip('ALPHAECP','%system.nlp%','Cbc')  = no;

* For global NLP solvers do only one combination under DICOPT
minlpskip('DICOPT','BARON'      ,mipslv) = yes; minlpskip('DICOPT','BARON'      ,'%system.mip%') = no;
minlpskip('DICOPT','COUENNE'    ,mipslv) = yes; minlpskip('DICOPT','COUENNE'    ,'%system.mip%') = no;
minlpskip('DICOPT','LGO'        ,mipslv) = yes; minlpskip('DICOPT','LGO'        ,'%system.mip%') = no;
minlpskip('DICOPT','LINDOGLOBAL',mipslv) = yes; minlpskip('DICOPT','LINDOGLOBAL','%system.mip%') = no;
minlpskip('DICOPT','MSNLP'      ,mipslv) = yes; minlpskip('DICOPT','MSNLP'      ,'%system.mip%') = no;
minlpskip('DICOPT','OQNLP'      ,mipslv) = yes; minlpskip('DICOPT','OQNLP'      ,'%system.mip%') = no;
minlpskip('DICOPT','SCIP'       ,mipslv) = yes; minlpskip('DICOPT','SCIP'       ,'%system.mip%') = no;
* For weak MIP solvers do only one combination under DICOPT
minlpskip('DICOPT',nlpslv,'BARON')       = yes;
minlpskip('DICOPT',nlpslv,'LINDOGLOBAL') = yes;

* BARON, LindoGLOBAL, ... can do MIQCPs without subsolvers (SCIP and others are included through MINLPskip)
miqcpskip('BARON'        ,qcpslv,mipslv) = yes;  miqcpskip('BARON'        ,'%system.qcp%','%system.mip%') = no;
miqcpskip('LINDOGLOBAL'  ,qcpslv,mipslv) = yes;  miqcpskip('LINDOGLOBAL'  ,'%system.qcp%','%system.mip%') = no;
miqcpskip('BONMIN'       ,qcpslv,mipslv) = yes;  miqcpskip('BONMIN'       ,'%system.qcp%','%system.mip%') = no;
miqcpskip('BONMINH'      ,qcpslv,mipslv) = yes;  miqcpskip('BONMINH'      ,'%system.qcp%','%system.mip%') = no;
miqcpskip('CPLEX'        ,qcpslv,mipslv) = yes;  miqcpskip('CPLEX'        ,'%system.qcp%','%system.mip%') = no;
miqcpskip('CPLEXD'       ,qcpslv,mipslv) = yes;  miqcpskip('CPLEXD'       ,'%system.qcp%','%system.mip%') = no;
miqcpskip('COUENNE'      ,qcpslv,mipslv) = yes;  miqcpskip('COUENNE'      ,'%system.qcp%','%system.mip%') = no;
miqcpskip('GLOMIQO'      ,qcpslv,mipslv) = yes;  miqcpskip('GLOMIQO'      ,'%system.qcp%','%system.mip%') = no;
miqcpskip('GUROBI'       ,qcpslv,mipslv) = yes;  miqcpskip('GUROBI'       ,'%system.qcp%','%system.mip%') = no;
miqcpskip('KNITRO'       ,qcpslv,mipslv) = yes;  miqcpskip('KNITRO'       ,'%system.qcp%','%system.mip%') = no;
miqcpskip('MOSEK'        ,qcpslv,mipslv) = yes;  miqcpskip('MOSEK'        ,'%system.qcp%','%system.mip%') = no;
miqcpskip('SCIP'         ,qcpslv,mipslv) = yes;  miqcpskip('SCIP'         ,'%system.qcp%','%system.mip%') = no;

* DICOPT uses nlp solver not qcp solver so we don't need to loop over qcp solver
miqcpskip('DICOPT',nlpslv,mipslv) = yes;  miqcpskip('DICOPT','%system.qcp%',mipslv) = no;

* Since AlphaECPs MIPs grow very large we only want COIN-OR solver to solve the MIPs
miqcpskip('ALPHAECP',nlpslv,mipslv) = yes; miqcpskip('ALPHAECP','%system.qcp%','Cbc')  = no;

miqcpskip('OQNLP'      ,nlpslv,mipslv) = yes;  miqcpskip('OQNLP'      ,'%system.nlp%','%system.mip%') = no;
miqcpskip('SBB'        ,nlpslv,mipslv) = yes;  miqcpskip('SBB'        ,nlpslv        ,'%system.mip%') = no;


set ssc solver subsystem codes /
      00    'GAMS/Demo GAMS Development Corp'
      BA    'BARON     University of Illinois at Urbana-Champaign'
      BD    'BDMLP     GAMS Development Corp'
      CL    'CPLEX/L   Cplex Optimization'
      CO    'CONOPT    ARKI Consulting'
      CM    'CPLEXPAR  Cplex Optimization'
      CP    'CPLEX     Cplex Optimization'
      DI    'DICOPT    EDRC, CMU'
      EC    'ALPHAECP  Abo Akademi University, Finland'
      FR    'FREE      Maintained Freeware'
      GE    'MPS/GE    Thomas Rutherford'
      GQ    'GLOMIQP   Princeton University'
      GU    'GUROBI    Gurobi Optimization'
      IP    'IPOPT     COIN-OR Initiative'
      KN    'KNITRO    Ziena Optimization'
      LG    'LGO       Pinter Consulting'
      LI    'LINDOGLOB Lindo Systems Inc.'
      M5    'MINOS     Stanford University'
      MC    'MILES     Thomas Rutherford'
      MK    'MOSEK/MIP EKA Consulting ApS'
      MN    'MSNLP     OptQuest NLP Multi Start Solver'
      OQ    'OQNLP/GRG OptTek Systems and Optimal Methods'
      OL    'OSL/L     IBM/OSL Link'
      PE    'OSL/PE    IBM/OSL Parallel Extension'
      PT    'PATH      University Wisconsin, Madison'
      SB    'SBB       ARKI Consulting'
      SE    'OSLSE     IBM/OSL Stochastic Extension'
      SP    'OSL/SPE   IBM/OSL Stoch & Par Extension'
      SN    'SNOPT     Stanford University'
      SU    'SULUM     Sulum Optimization'
      XA    'XA        Sunset Software'
      XP    'XPRESS    Dash Associates'
/;

set sc(solver,ssc) /
      alphaecp.EC
      baron.BA
      (bdmlp,bdmlpd).BD
      (bonmin,cbc,couenne,ipopt,scip,soplex).00
      (bonminh,ipopth).IP
      (conopt,conopt4).CO
      (cplex,cplexd).(CP,CM)
      dicopt.DI
      glomiqo.GQ
      gurobi.GU
      sulum.SU
      knitro.KN
      lgo.LG
      lindoglobal.LI
      miles.MC
      minos.M5
      mosek.MK
      msnlp.(MN,OQ)
      oqnlp.OQ
      osl.(OL,PE,SE,SP)
      (path,pathnlp).PT
      sbb.SB
      snopt.SN
      xa.XA
      xpress.XP
/;


*********! Skip lists !*********

$onempty
set exm(s) exclusion list for model /
$if %system.buildcode% == AIX 248,249,344         'scenred not available'
$if %system.buildcode% == AIX 338*340,355         'csdp not available'
$if %system.buildcode% == SOL 338*340,355         'csdp not available'
$if %system.buildcode% == SOX 338*340,355         'csdp not available'
$if set licensed              251*253             'skip lmp1,lmp2,lmp3 within full licensed tests since they just take too long'
                              217                 'gastrans needs about 7 hours to test despite tons of skips'
$if %system.buildcode% == SOL 326                 'CPLEX (hardcoded MIP solver) segmentation fault in model loc from step 7: #2252'
$if %system.buildcode% == SOX 326                 'CPLEX (hardcoded MIP solver) segmentation fault in model loc from step 7: #2252'
/;

set exS(solver) exclusion list for solvers /
   bdmlp    'bdmlp cycles and either exceeds reslim or fills up disk with nlpsta.dat, #1697'
/;

set exsmd(s,solver) model solver combination that deserve exclusion /
$if not set licensed (112,201).baron                    'the resulting LP does not fit in the CPLEX demo'
$if not set licensed (117,119,125,204,223,224,350).scip 'Generated models too big, license failures'
$if not set licensed (204,223).osigurobi                'Generated models too big, osigurobi writes to stdout'

      (20,22*25,27,28,33,35,36,41
       43,47,53,63,68,69,76,80,81
       84,92,95,97,99,100,107,111*113
       116*119,120,122,123,125,161
       165*169,173,194,201*206,214
       222*224,226*243,251*259,
       263*266,267,275*281,296,301
       305,321,339,350,358*369,373
       377,383).(mosek)                  'MOSEK cannot handle nonconvex models'

      (124,327).osl                      'OSL has problems with long path names #1474'
       239.pathnlp                       'pathnlp ends due to non-sufficient lemke_rank_deficiency_iterations'
                                         //with increased lemke_rank_deficiency_iterations path still stops due to lack of progress
       377.(snopt,lgo,msnlp)             'Several solvers have problems solving ps5_s_mn'
       (271,379,380).(cplex, xpress)     'Cplex link prevents recognition as SOCP, Xpress cannot do SOCP'
       273.(baron, ipopt, ipopth, conopt,
            conopt4, cplex, glomiqo, knitro,
            lindoglobal, lgo, minos,
            pathnlp, snopt, xa, xpress)  'Difficult SOCP'
       338.(baron,bdmlp,lindoglobal,
            mosek,osimosek,osl,xa)       'Difficult MIP, should not spend too much time on it'

/;   // end exsmd
* solnpool (326) sets the MIP solver hard to CPLEX
exsmd('326',solver)$(not sameas(solver, 'cplex')) = yes;

set exsmw(s,solver) waiting for fix /
       68.lindoglobal                    '(sometimes) lindoglobal does not come back on water'
      250.knitro                         'Gradient eval errors not handled properly on jit, #2142'
      328.knitro                         'Cannot solve danwolfe'
      241.lgo                            'does not return from methanol (lnx,vs8)'
      118.lgo                            'lgo on minlphi has unreported evaluation errors, conopt cannot cleanup, #1585'
      268.lindoglobal                    'lindoglobal (sometimes) does not come back, #1651'
      (205,206).minos                    'cycling: expand frequency (see useopt3) does not help, #1700'
      267.msnlp                          'MSNLP exceeds tolerance of solution check in mhwd4x'
      202.scip                           'SCIP gets stucked at some node until timelimit is hit, #2258'
      203.scip                           'Mumps in Ipopt in SCIP under SBB dies after iteration 17 (vs8/wei), 6 (lnx), #2120'
      377.scip                           'Mumps in Ipopt in SCIP segfaults for t = 21, #2120'
$if %system.buildcode% == VS8 223.(bonmin,bonminh) 'Bonmin throws exception on failed initialization at end, #2255'
$if %system.buildcode% == VS8 291.lindoglobal 'aborts on every 2nd run in 4th solve, #2261'
      226.dicopt                         'DICOPT generates MIPs with too large coefficients, #2063'
$if %system.buildcode% == VS8 68.baron   'NLP subsolver may not terminate properly, #2204'
/;

set exsml(s,solver) off limits /
*reslim 1000
     (122,123,125,205,
      206,223,226,350).alphaecp          'reslim exceeded on feedtray, hda, waterx, pump, spring, gasnet, nsharpx, tanksize'
     (22,24,76,81,100,117,125,173,227,233,239
      243*246,278,280,283,321,345).baron 'reslim exceeded on ship least, wall, camcge, korcge, torsion, synheat, waterx, qp3 (#1588)'
                                         // minlphix, pinene, glider, jbearing, minsurf, qp1x, twocge, quocge, qcp1, knp, tsp5
     (122,223).couenne                   'reslim exceeded on feedtray, gasnet'
      254.(ipopt,ipopth)                 'reslim exceeded on pool'
     (227,270).knitro                    'reslim exceeded on minlphix, kport'
     (62,66,78,169,234,239,240,
      243*245,283,344).lgo               'reslim exceeded on tfordy, msm, phosdis, traffic, popdymn, glider'
                                         //gasoil, torsion, jbearing, minsurf, qcp1, srpchase'
     (97,107).lindoglobal                'reslim exceeded on ganges(x), 23.1 infeasible, 23.2 reslim, 23.4 infeasible, 23.5 reslim'
     (243*245,283).lindoglobal           'reslim exceeded on torsion, jbearing, minsurf, qcp1, new with 23.2.1 (before weak)'
     (173,278,339,355).lindoglobal       'reslim exceeded on qp3 (#1588), twocge (new with 23.8), gqapsdp, kqkpsdp (new with 23.8)'
     (234,239,266).lindoglobal           'reslim exceeded on popdynm, glider and t1000'
      47.lindoglobal                     'iterlim exceeded on otpop'
     (81,97,107,233,234).msnlp           'reslim exceeded on camcge, ganges, gangesx, pinene, popdymn'
     (97,107,123,233,234,266).oqnlp      'reslim exceeded on ganges, gangesx, hda, pinene, popdynm'
      342.osl                            'reslim exceeded on poutil'
     (22,24,41,68,69,76,81,84,85,86,97,
      100,107,117,
      118,120,122,123,125,161,173,205,
      223,226,227,228,233,234,238,239,
      241,250,254,267,276,277,278,279,
      280,281,321,373).scip              'reslim exceeded on ship, least, prolog, wall, hhfair, harker, turkey, ganges, korcge, gangesx, synheat'
                                         //nonsharp, minlphi(nlp), feedtray, hda, water, waterx, launch, camcge, mhw4d,
                                         //qp3, pump (nlp)
                                         //gasnet, nsharpx (nlp), minlphix (minlp), cesam, pinene, popdymn, rocket, glider
                                         //methanol, jit (nlp), pool, mhw4dx, stdcge, lrgcge, twocge, moncge
                                         //quocge, irscge, knp, cclinpts
      342.xa                             'reslim exceeded on poutil'
      327.glomiqo                        'GloMIQO 2.1 does not solve 2nd MIQCP in time'
      357.xpress                         'SDDP does not terminate within time limit with Xpress'
      213.baron                          'Does not terminate within time limit with BARON'

*other limits
       254.knitro                        'major iteration limit exceeded on pool (case adhya2)'
       148.miles                         'Miles iteration limit exceeded'
       125.minos                         'Minos writes 10GB log'
      (243*245,266).(minos,snopt)        'superbasic limit too small on torsion, jbearing, minsurf, t1000'
       321.minos                         'minor iterlim exceeded on knp'
$if %system.buildcode% == WEI 254.msnlp  'minor iterlim exceeded on pool'
      (25,303).msnlp                     'minor iterlim exceeded on like, mlgamma'
      (25,81,124,203,303,321).oqnlp      'minor iterlim exceeded on like, camcge, alan, gear (with dicopt/cplex), mlgamma, knp'
       270.sbb                           'node limit exceeded on kport'
       123.knitro                        'NLP iteration limit (solver option maxit) exceeded on hda'

* take long (>= 1000s), but does not fail; run only in long tests
$ifthen not set licensed
       24.lindoglobal
       (25,28,80,263,368,378).scip
       (117,125,355).couenne
       296.sbb

* take very long (>= 3000s), but does not fail; do not even run in long tests
$if %system.buildcode% == LNX 28.msnlp   'seems to hang after 200 iterations and takes 9238s'
$if %system.buildcode% == LNX 300.oqnlp  'seems to hang after 420 iterations and takes 14780s'

*failed on etlim 1800 previously
      (321,383).lgo                      'etlim exceeded on knp (needs 5 hours) and saras'
      (321,383).lindoglobal              'etlim exceeded on knp (needs 8 hours) and saras'
$if %system.buildcode% == VS8 321.msnlp  'etlim exceeded on knp'
$if %system.buildcode% == WEI 321.msnlp  'etlim exceeded on knp'
      369.(lgo,msnlp,oqnlp,scip)         'etlim exceeded on ps10_s_mn'
      357.sulum                          'etlim exceeded on sddp'

$endif
/;

set exsm(s,solver) exclusion list for model solver combination;
exsm(exm,solver)               = yes;
exsm(s,exS)                    = yes;
exsm(s,solver)$exsmd(s,solver) = yes;

* do not use NLPEC for any model without an MPEC/RMPEC
exsm(s,'NLPEC')$[not (test(s,'MPEC') or test(s,'RMPEC'))] = yes;
* BCH Models only with Cplex, and SBB
exsm(s,solver)$(as('BCH',s))    = yes;
exsm(s,'CPLEX')$(as('BCH',s))   = no;
exsm(s,'SBB')$(as('BCH',s))     = no;

$if %runall%==yes $goto dorunall
exsm(s,solver)$exsmw(s,solver)=yes;
exsm(s,solver)$exsml(s,solver)=yes;
$label dorunall


*********! Weak test lists !*********

set weakm(s) exclusion list for model /
      330        'dicegrids first solve returns (1,14)'
      357        'sddp with GUSS returns (4,14)'
/;

set weakS(solver) 'list of weakly-checked solvers' /
    couenne
    lgo
/;


set weakMSd(s,solver) model solver combination that deserve weak check /
      (224,229,236,237,257*261,265,
       266).(baron,scip)                 'cannot handle trig functions'
       111.(baron,couenne,scip)          'cannot handle errorf'
      (299,300,302,303).(baron,couenne,
                       lindoglobal,scip) 'cannot handle gamma and loggamma'
       301.(baron,couenne,
            lindoglobal,scip)            'cannot handle betareg'
       305.(baron,couenne,
            lindoglobal,scip)            'cannot handle beta'
       265.couenne                       'cannot handle mod'
      (23,68,265).(ipopt,ipopth)         'Ipopt does not handle dnlps well, restoration failed'
       228.miles                         'Failure to converge, similar to #808, wontfix'
      (109,163,270,351,385,386).(baron,couenne,cplexd,mosek,
                         osicplex,osigurobi,osimosek,osixpress,
                         osl,sulum,xa)   'cannot handle SOS variables'
       123.(bonmin,bonminh)              'NLP relaxation too difficult for Ipopt'
       321.pathnlp                       'KNP is a nonconvex NLP'
       110.conopt                        'initial function value too large for some instances (now leads to exit with 6/5)'
       226.(minos,ipopt,ipopth)          'NLP relaxation/subproblem difficult to solve within dicopt or sbb (comes and goes)'
       296.sbb                           'QCP relaxations are nonconvex, which is not appreciated by xpress cplex ..., #1644'
       224.alphaecp                      'AlphaECP does not have to succeed on nonconvex models like windfac (exits with 4/14)'
       319.(ipopt,ipopth)                'Ipopt(h) sometimes converges to local infeasible points with epscm (comes and goes)'
/;

* no failure if knitro does not find a feasible solution for a minlp or miqcp
weakMSd(s,'knitro')$ts('minlp',s) = yes;
weakMSd(s,'knitro')$ts('miqcp',s) = yes;

set weakMSw(s,solver)  'should not be here - waiting on a fix' /
      (24,124).baron                     'BARON problems'
      (97,107,223,239).baron             'bounds to wide on ganges, gangesx, gasnet, glider'
      (23,265,266).(conopt,conopt4)      'CONOPT does not solve linear, fct, t1000'
      (125,204,205,224).dicopt           'DICOPT cannot solve waterx, trimloss, pump, windfac'
       270.dicopt                        'infeasible model in major iteration 2'
      (23,118,223,250,265,319,350,383).knitro 'does not solve linear, gasnet (as sbb subsolver), minlphi, jit, fct, epscm, tanksize (as sbb subsolver), saras'
      (23,265).minos                     'linear, fct: EXIT - The current point cannot be improved'
       236.minos                         'current point can be improved, #1595'
       257.minos                         'MINOS exceeds domlim on mathopt3 on DII, LNX, SIG ...'
       267.oqnlp                         'OQNLP gets a "too-good" point, is really infeasible'
      (23,68,111,125,205,223,224,230,
       238,250,254,264).pathnlp          'does not solve linear,worst,water,waterx,pump,gasnet,windfac,elecm,rocket,jit,pool,hs62'
      (23,125,223,239,265,293,358).snopt 'SNOPT does not solve linear,worst-on-dii_leg,gasnet-on-sol,elec-on-lnx,fct-on-aix,qabel,ps2_f_s'
       369.snopt                         'SNOPT does not solve ps10_s_mn (SIG,SOL,SOX)'

/;

set weakMSl(s,solver) off limits /
      (140,142,146).path                 'iterlim exceeded which on purpose is set to 0'
/;

set weakMS(s,solver) 'list of weakly-checked model-solver combinations';
weakMS(weakm,solver)               = yes;
weakMS(s,weakS)                    = yes;
weakMS(s,solver)$weakMSd(s,solver) = yes;

$if %runall%==yes $goto dorunallw
weakMS(s,solver)$weakMSw(s,solver)=yes;
weakMS(s,solver)$weakMSl(s,solver)=yes;
$label dorunallw


*********! Stdout/Stderr test skip lists !*********

set noso(s) skip model for test of stdout lines /
       197*199               'DECIS writes to stdout'
       338*340,355           'csdp writes to stdout'
/;


set nose(s) skip model for test of stderr lines /
/;

set noso2(solver) skip solver for test of stdout lines /
/;

set nose2(solver) skip solver for test of stderr lines /
/;

*********! Option file lists !*********
$if not set optdir $set optdir slv_optionfiles
$call rm -rf %optdir% && mkdir %optdir%
$set optdirS %optdir%%SLASH%

parameter useopt(s,solver) option file number for model solver combination /
/;

parameter useopt2(s,solver,solver) option file number for model solver combination /
/;

parameter useopt3(s,solver,solver,solver) option file number for model solver combination /
*minos cycles, #1700
         205.dicopt.minos.osl       899
         206.sbb.minos.%system.mip% 899
/;
$echo expand frequency 500 > %optdirS%minos.899
$echo nlpoptfile 899       > %optdirS%dicopt.899
$onecho > %optdirS%sbb.899
rootsolver minos
subsolver minos.899
$offecho

parameter useopt4(s,solver,solver,solver,solver) option file number for model solver combination /
/;

parameter useopt5(s,solver,solver,solver,solver,solver) option file number for model solver combination /
/;

$offempty


*********! Create tester file !*********

sets  ttt(t)           temp subset of model types
      sss(solver)      temp subset of solvers
      lic(solver)      subset of licensed solvers;

lic(solver) = sum(ssc$LicenseCodes(ssc), sc(solver,ssc));
lic(solver) $= sc(solver,'00');

alias(ttt,t1,t2,t3,t4,t5),(sss,s1,s2,s3,s4,s5);

$call rm -f slvtest.inc
file tester /'slvtest.inc'/, fx, pf /'pfile.txt'/; put tester; tester.lcase=1; tester.ap=1; tester.pw=500; fx.lcase=1; pf.lcase=1;

put   '*'
    / '* %system.gstring%'
    / '* %system.date% %system.time%'
    / '*'
    / '* SLVTEST u1=%gams.u1%'
    / '*'
    / '$ondollar'
    / '$echo "*" >> %trace%0'
    / '$echo "*" >> %trace%1'
    / '$echo "* %system.gstring%" >> %trace%0'
    / '$echo "* %system.gstring%" >> %trace%1'
    / '$echo "* %system.date% %system.time%" >> %trace%0'
    / '$echo "* %system.date% %system.time%" >> %trace%1'
    / '$echo "*" >> %trace%0'
    / '$echo "*" >> %trace%1'
    / '$echo "* Solvers tested:';
loop(solver$Solvers(solver),
   put ' 'solver.tl:0);
put '" >> %trace%0'
    / '$echo "* Solvers tested:';
loop(solver$Solvers(solver),
   put ' 'solver.tl:0);
put '" >> %trace%1'
put / '$echo "*" >> %trace%0';
put / '$echo "*" >> %trace%1';
put / / '$set err 0';
put / '$set GAMStime 0';
put / '$set DECIStime 0';
loop(solver$Solvers(solver),
   put / '$set 'solver.tl:0'time 0';
);
put / '$set GAMScalls 0';
put / '$set DECIScalls 0';
loop(solver$Solvers(solver),
   put / '$set 'solver.tl:0'calls 0';
);

put / / '$echo Runs with more than %TESTLIM% seconds > overtime.gms'
put /   '$echo -------------------------------- >> overtime.gms'

put / / '$echo Resource Usage per Run  > resused_run.txt'
put /   '$echo ----------------------- >> resused_run.txt'


$set mainsolver      "'s1.tl:0'"

$set solve1          "'t1.tl:0'='s1.tl:0'"
$set solve2 "%solve1% 't2.tl:0'='s2.tl:0'"
$set solve3 "%solve2% 't3.tl:0'='s3.tl:0'"
$set solve4 "%solve3% 't4.tl:0'='s4.tl:0'"
$set solve5 "%solve4% 't5.tl:0'='s5.tl:0'"

$set folder0         "%PREFIX%_slv_'m.tl:0'"
$set folder1 "%folder0%_'t1.tl:0'_'s1.tl:0'"
$set folder2 "%folder1%_'t2.tl:0'_'s2.tl:0'"
$set folder3 "%folder2%_'t3.tl:0'_'s3.tl:0'"
$set folder4 "%folder3%_'t4.tl:0'_'s4.tl:0'"
$set folder5 "%folder4%_'t5.tl:0'_'s5.tl:0'"

$set restart1            "--c1='s1.tl:0'"
$set restart2 "%restart1% --c2='s2.tl:0'"
$set restart3 "%restart2% --c3='s3.tl:0'"
$set restart4 "%restart3% --c4='s4.tl:0'"
$set restart5 "%restart4% --c5='s5.tl:0'"

*create slvcreate file
$onechoV > %slvcreate%
put
*Remove test folder if exists and create new
/ / '$call rm -rf %1'
/ '$call mkdir %1'
* Copy model and related files into test folder
/ '$call cd %1 && gamslib -q 'm.tl:0
* Write JobStart into small txt file and create parameter file
/ '$echo JobStart 'm.tl:0' > %1%SLASH%slvtest.txt'isWeak:0:0
/ '$echo lo=%gams.lo% al=0 ao=0 workspace=%MYWORKSPACE% jt='m.tl:0' trace=slvtest.txt'isWeak:0:0' %2 u1="%2" > %1%SLASH%pf.txt'
/ '$if not 'optfilenr:0:0'==0 $echo optfile='optfilenr:0:0' >> %1%SLASH%pf.txt'
/ '$if not 'optfilenr:0:0'==0 $call cp -f %optdirS%* %1'
* Start run in test folder and save stdout and stderr
$escape =
/ '$set before %=system.tcomp%='
/ '$call cd %1 && gams 'm.tl:0' pf=pf.txt 1>stdout.txt 2>stderr.txt'
/ '$set after %=system.tcomp%='
$escape %
/ '$eval time %after% - %before%'
/ '$echo %time% , $call =gams slvtest lo=%gams.lo% --prefix=%PREFIX% --test='m.tl:0' u1="ord(s)='s.tl:0'" --runall=%runall% %3 >> resused_run.txt'
/ '$eval %4time %%4time% + %time%'
/ '$eval %4calls %%4calls% + 1'
* Apend content of small txt file to general one
/ '$call cat %1%SLASH%slvtest.txt'isWeak:0:0' >> slvtest.txt'isWeak:0:0''
* Remove stderr.txt and stdout.txt if empty
/ '$call cd %1 && test -s stderr.txt || rm -f stderr.txt'
/ '$call cd %1 && test -s stdout.txt || rm -f stdout.txt'
* Remove stdout.txt/stderr.txt if test is skipped
/ '$if 'k:0:0'==1 $call rm -f %1%SLASH%stdout.txt'
/ '$if 'k2:0:0'==1 $call rm -f %1%SLASH%stderr.txt'
* Create single test file
/ '$echo "$call =gams slvtest.txt'isWeak:0:0' a=gt ps=0 pw=255 lo=%gams.lo% o=slvtest.rep'isWeak:0:0' tl='trl:0:0'" > %1%SLASH%tracetest.gms'
/ '$echo "$if errorlevel 1 $echo error in trace level test >> trcerr.txt" >> %1%SLASH%tracetest.gms'
* Run single test
/ '$call cd %1 && gams tracetest.gms lo=%gams.lo%'
* Check three possible error files and jump to keepxxx if one exists
/ '$if exist %1%SLASH%trcerr.txt $goto keep'cnt:0:0
/ '$if exist %1%SLASH%stderr.txt $goto keep'cnt:0:0
/ '$if exist %1%SLASH%stdout.txt $goto keep'cnt:0:0
* else remove folder and goto dontkeepxxx
/ '$echo "$call rm -rf %1" >> removedirs.gms'
/ '$goto dontkeep'cnt:0:0
* if keep, create failures_slv.gms
/ '$label keep'cnt:0:0
/ '$echo $call =gams slvtest lo=%gams.lo% --prefix=%PREFIX% --fail=%fail2% --test='m.tl:0' u1="ord(s)='s.tl:0'" --runall=%runall% %3 >> %1%SLASH%onetest.gms'
/ '$echon $call =gams slvtest lo=%gams.lo% --prefix=%PREFIX% --fail=%fail2% --test='m.tl:0' u1="ord(s)='s.tl:0'" --runall=%runall% %3 >> %fail%'
/ '$if exist %1%SLASH%trcerr.txt $echon " --ftrace=1"  >> %fail%'
/ '$if exist %1%SLASH%stderr.txt $echon " --fstderr=1" >> %fail%'
/ '$if exist %1%SLASH%stdout.txt $echon " --fstdout=1" >> %fail%'
/ '$ife %time%>%TESTLIM% $echo * %time% secs used by >> overtime.gms'
/ '$ife %time%>%TESTLIM% $echo $call =gams slvtest lo=%gams.lo% --prefix=%PREFIX% --test='m.tl:0' u1="ord(s)='s.tl:0'" --runall=%runall% %3 >> overtime.gms'
/ '$eval err %err% + 1'
/ '$echo " --dir=%1 --keepfail=1" >> %fail%'
/ '$label dontkeep'cnt:0:0 ;
$offecho

Set SolverCapabilitiesX(solver,t) restricted capability set;
SolverCapabilitiesX(solver,t) = SolverCapabilities(solver,t);
SolverCapabilitiesX('lgo','lp') = no;
SolverCapabilitiesX('bonmin ','mip')  = no;
SolverCapabilitiesX('bonminh ','mip')  = no;
//couenne either does not obey limit or exceeds, it is not ready to be tested
SolverCapabilitiesX('couenne','qcp')  = no;
SolverCapabilitiesX('couenne','nlp')  = no;
SolverCapabilitiesX('couenne','dnlp') = no;

display solvers, SolverCapabilitiesX;
scalar isWeak, skip, cnt /0/, trl, k, k2, optfilenr;

loop(sm(s,m)$(not notest(s) and %cond% and not exm(s)),

   ttt(t) = test(s,t);
   sss(solver)$Solvers(solver) =
       sum(ttt, SolverCapabilitiesX(solver,ttt))
       and (lic(solver)                               //license
            or tiny(s)                                // or less than 10x10
            or (not big(s) and not gsolver(solver)) ) // or smaller than 300x300 and not a global solver
       and not (gsolverlim(solver) and gbig(s));      //not solver with 2000x3000 license and model bigger than that

*  Take care of big MPSGE models
   sss(solver)$(big(s) and ts('mpsge',s)
          and not LicenseCodes("GE") and SolverCapabilitiesX(solver,'MCP')) = no;

   put tester / / / '$log  ===> executing  ' m.tl:0 '.gms';
   put / '$echo "*This file keeps track of which dirs to delete" > removedirs.gms'

   if(card(ttt)=0,
         isWeak           = 0;
         trl$isWeak       = %weaktl%;
         trl$(not isWeak) = %gams.tl%;
         cnt              = cnt+1;
         k                = noso(s);
         k2               = nose(s);
         optfilenr        = 0;

$batinclude %slvcreate% "%folder0%_gams" "" "" "GAMS"

   elseif(ts('decis',s) and not big(s) and Solvers('decisc')),
         isWeak           = 0;
         trl$isWeak       = %weaktl%;
         trl$(not isWeak) = %gams.tl%;
         cnt              = cnt+1;
         k                = noso(s);
         k2               = nose(s);
         optfilenr        = 0;

$batinclude %slvcreate% "%folder0%_decis" "" "" "DECIS"

   elseif card(ttt)=1,
      loop(SolverCapabilitiesX(s1,t1)$(not exsm(s,s1) and %cond1%),
         isWeak = weakMS(s,s1);
         trl$isWeak       = %weaktl%;
         trl$(not isWeak) = %gams.tl%;
         cnt              = cnt+1;
         k                = noso(s) or noso2(s1);
         k2               = nose(s) or nose2(s1);
         optfilenr        = useopt(s,s1);
$batinclude %slvcreate% "%folder1%" "%solve1%" "%restart1%" "%mainsolver%"
      )


   elseif card(ttt)=2,
      loop((s1,t1)$(SolverCapabilitiesX(s1,t1) and not exsm(s,s1) and %cond1%),
      loop((s2,t2)$(SolverCapabilitiesX(s2,t2) and not exsm(s,s2) and %cond2%
                                              and (oval(t1)<oval(t2))),
         isWeak = weakMS(s,s1) OR weakMS(s,s2);
         trl$isWeak       = %weaktl%;
         trl$(not isWeak) = %gams.tl%;
         cnt              = cnt+1;
         k                = noso(s) or noso2(s1) or noso2(s2);
         k2               = nose(s) or nose2(s1) or nose2(s2);
         optfilenr        = useopt2(s,s1,s2);

$batinclude %slvcreate% "%folder2%" "%solve2%" "%restart2%" "%mainsolver%"
      ))

   elseif card(ttt)=3,
      loop((s1,t1)$(SolverCapabilitiesX(s1,t1) and not exsm(s,s1) and %cond1%),
      loop((s2,t2)$(SolverCapabilitiesX(s2,t2) and not exsm(s,s2) and %cond2%
                                              and (oval(t1)<oval(t2))),
      loop((s3,t3)$(SolverCapabilitiesX(s3,t3) and not exsm(s,s3) and %cond3%
                                              and (oval(t2)<oval(t3))),
         isWeak = weakMS(s,s1) OR weakMS(s,s2) OR weakMS(s,s3);

         %MINLPSpecial%;

* todo: there should be a skip-list above to skip particular solver/solver/model combinations
* on LNX/LEG/SOL, snopt has convergence problems as subsolver of sbb on minlphix, #2207
         skip = skip or (sameas(s1,'sbb') and sameas(s2,'snopt') and sameas(s,'227'));
* on our AIX tester machine, sbb with gurobi gives a 'sh: cannot fork: too many processes' on qmeanvag (system is too old)
$if %system.buildcode% == AIX         skip = skip or (sameas(s1,'sbb') and sameas(s2,'gurobi') and sameas(s,'327'));
         skip = skip or (sameas(s1,'sbb') and sameas(s2,'glomiqo') and sameas(s,'291'));

         if (not skip,
            trl$isWeak       = %weaktl%;
            trl$(not isWeak) = %gams.tl%;
            cnt              = cnt+1;
            k                = noso(s) or noso2(s1) or noso2(s2) or noso2(s3);
            k2               = nose(s) or nose2(s1) or nose2(s2) or nose2(s3);
            optfilenr        = useopt3(s,s1,s2,s3);

$batinclude %slvcreate% "%folder3%" "%solve3%" "%restart3%" "%mainsolver%"
         )
      )))

   elseif card(ttt)=4,
      loop((s1,t1)$(SolverCapabilitiesX(s1,t1) and not exsm(s,s1) and %cond1%),
      loop((s2,t2)$(SolverCapabilitiesX(s2,t2) and not exsm(s,s2) and %cond2%
                                              and (oval(t1)<oval(t2))),
      loop((s3,t3)$(SolverCapabilitiesX(s3,t3) and not exsm(s,s3) and %cond3%
                                              and (oval(t2)<oval(t3))),
      loop((s4,t4)$(SolverCapabilitiesX(s4,t4) and not exsm(s,s4) and %cond4%
                                              and (oval(t3)<oval(t4))),
         isWeak = weakMS(s,s1) OR weakMS(s,s2) OR weakMS(s,s3) OR weakMS(s,s4);

         %MINLPSpecial%;
         skip = skip or (sameas('NLP',t2) and sameas('RMINLP',t4) and not sameas(s2,s4));

         if(not skip,
            trl$isWeak       = %weaktl%;
            trl$(not isWeak) = %gams.tl%;
            cnt              = cnt+1;
            k                = noso(s) or noso2(s1) or noso2(s2) or noso2(s3) or noso2(s4);
            k2               = nose(s) or nose2(s1) or nose2(s2) or nose2(s3) or nose2(s4);
            optfilenr        = useopt4(s,s1,s2,s3,s4);

$batinclude %slvcreate% "%folder4%" "%solve4%" "%restart4%" "%mainsolver%"
         )
      ))))

   elseif card(ttt)=5,
      loop((s1,t1)$(SolverCapabilitiesX(s1,t1) and not exsm(s,s1) and %cond1%),
      loop((s2,t2)$(SolverCapabilitiesX(s2,t2) and not exsm(s,s2) and %cond2%
                                              and (oval(t1)<oval(t2))),
      loop((s3,t3)$(SolverCapabilitiesX(s3,t3) and not exsm(s,s3) and %cond3%
                                              and (oval(t2)<oval(t3))),
      loop((s4,t4)$(SolverCapabilitiesX(s4,t4) and not exsm(s,s4) and %cond4%
                                              and (oval(t3)<oval(t4))),
      loop((s5,t5)$(SolverCapabilitiesX(s5,t5) and not exsm(s,s5) and %cond5%
                                              and (oval(t4)<oval(t5))),
         isWeak = weakMS(s,s1) OR weakMS(s,s2) OR weakMS(s,s3) OR weakMS(s,s4) OR weakMS(s,s5);

         %MINLPSpecial%;

         if(not skip,
            trl$isWeak       = %weaktl%;
            trl$(not isWeak) = %gams.tl%;
            cnt              = cnt+1;
            k                = noso(s) or noso2(s1) or noso2(s2) or noso2(s3) or noso2(s4) or noso2(s5);
            k2               = nose(s) or nose2(s1) or nose2(s2) or nose2(s3) or nose2(s4) or nose2(s5);
            optfilenr        = useopt5(s,s1,s2,s3,s4,s5);

$batinclude %slvcreate% "%folder5%" "%solve5%" "%restart5%" "%mainsolver%"
         )
      )))))

   else
        put tester / m.tl:0 ' ******** has more than 'card(ttt):0:0' possibilities'

   )
put / / '$call gams removedirs.gms lo=0'
);

put / / '$call rm -rf %optdir%'
put / / '$echo * %err% failures in 'cnt:0:0' runs >> %fail%'

put / '$call echo %err% failures in 'cnt:0:0' runs: check %fail%'
put / '$echo Resource Usage per Solver   > resused_slv.txt'
put / '$echo -------------------------- >> resused_slv.txt'
put / '$echo GAMS         used %GAMStime% sec in %GAMScalls% runs >> resused_slv.txt';
put / '$echo DECIS        used %DECIStime% sec in %DECIScalls% runs >> resused_slv.txt';

loop(solver$Solvers(solver),
   put / '$echo 'solver.tl:12' used %'solver.tl:0'time% sec in %'solver.tl:0'calls% runs >> resused_slv.txt';
);


$if     %system.filesys% == UNIX put / / '$call grep "$call" resused_run.txt | sort -nr  > resused_run_sorted.txt';
$if NOT %system.filesys% == UNIX put / / '$call grep "$call" resused_run.txt | gsort -nr > resused_run_sorted.txt';

putclose tester;
