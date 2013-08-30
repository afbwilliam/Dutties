set tests / testCex1
            testCex2
            testCPPex1
            testCPPex2
            testCPPtrseq
            testDCex1
            testDOex1
            testDPex1
            testDOex2
            testFex1
            testFex2
            testJBenders
            testJCutstock
            testJex1
            testJex2
            testJInterrupt
            testJtrseq
            testJWarehouse
            testCSex1
            testCSex2
            testCStrseq
            testCSBenders
            testCSCutstock
            testCSWarehouse
            testPex1
            testPex2
            testPtrseq
            testPBenders
            testPCutstock
            testPWarehouse
            testVBex1
            testVBex2
            testVBtrseq /

    suite / C 'C and CPP'
            D 'Delphi'
            F 'Fortran'
            J 'Java'
            N '.Net'
            P 'Python'    /

    st(suite, tests) / C.(testCex1,  testCex2,  testCPPex1, testCPPex2)
                       D.(testDCex1, testDOex1, testDPex1,  testDOex2 )
                       F.(testFex1,  testFex2)
                       J.(testJBenders, testJCutstock, testJex1,  testJex2, testJInterrupt, testJtrseq
$if not set demosize      ,testJWarehouse
                         )
                       N.(testCSex1, testCSex2, testCStrseq, testCSBenders, testCSCutstock,
$if not set demosize      testCSWarehouse,
$if %system.buildcode% == VS8 testVBex1, testVBex2, 
                          testVBtrseq, testCPPtrseq
                         )
                       P.(testPex1,  testPex2, testPtrseq, testPBenders, testPCutstock
$if not set demosize      ,testPWarehouse
                         ) /

    pfsuite(*,suite) / deg.(C,  F,J,  P)
                       sig.(C,  F,J    )
                       sol.(C,  F,J    )
                       sox.(C,  F,J    )
                       leg.(C,  F,J,  P)
                       lnx.(C,  F,J,  P)
                       vs8.(C,D,F,J,N,P)
                       wei.(C,  F,J,N,P) /;



$if not set TEST $goto alltest
SET runtests(tests) / %TEST% /;
$if errorfree $goto TEST_OK
$clearerror
$log The test model(s) specified (--TEST=%TEST%) are not all valid
$abort

$label alltest
SET runtests(tests);
runtests(tests) = yes;
$label TEST_OK

*Not done for all platforms yet
$if %system.buildcode% == AIX $exit

scalar
  tot    / 0 /,
  err    / 0 /,
  cnt    / 0 /;

file fall / 'all_api.gms'      /
     ferr / 'failures_api.gms' /
     rmme / 'rmme.gms'         /
     log  / ''                 /
     fx;

putclose fall '* These are the tests we ran' /;
putclose ferr '* These are the tests that failed' /;
fall.ap = 1;
ferr.ap = 1;

$set S     \
$if %system.filesys% == UNIX $set S /
$if not set PREFIX $set PREFIX %system.buildcode%
$set DIRNAME "'%PREFIX%_api_' tests.tl:0 "

loop(runtests(tests)$sum(pfsuite('%system.buildcode%',suite)$st(suite,tests),1),
  tot = tot + 1;
  put_utility fx 'shell' / 'rm -rf ' %DIRNAME%;
  put_utility fx 'shell' / 'gams ' tests.tl:0 ' lo=%GAMS.lo% > stdout.txt 2>stderr.txt';
  if(errorlevel,
    err = err + 1;
    putclose ferr '$call =gams testapi --test=' tests.tl:0 ' lo=%GAMS.lo% --dir='%DIRNAME% /;;
    put_utility fx 'shell' / 'mkdir ' %DIRNAME%;
    put_utility fx 'shell' / 'cp stdout.txt stderr.txt ' tests.tl:0 '.* ' %DIRNAME%
  );
  putclose fall '$call =gams testapi --test=' tests.tl:0 ' lo=%GAMS.lo% --dir='%DIRNAME% /;;
);


putclose ferr '*Total tests: ', tot:0:0, '  Failed tests: ', err:0:0 ;

put log;
if {(err > 0),
  put 'There were errors: ', err:0:0, ' out of ',
       tot:0:0, ' tests failed.' /;
  put 'See the file failures_api.gms to reproduce the failed runs'/;
  abort 'You have some failures. See failures_api.gms for details.';
else
  put 'Congratulations!  All ', tot:0:0, ' tests passed.'/;
};

put 'See the file all_api.gms to reproduce all the runs'/;
