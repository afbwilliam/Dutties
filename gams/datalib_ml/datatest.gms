$TITLE 'Driver for datalib tests of all sorts'

$eolcom //
$version 1

$set SLASH     \
$if %system.filesys% == UNIX $set SLASH /
$if not set PREFIX $set PREFIX %system.buildcode%

$if not set FAIL $set ALL all_data.gms
$if     set FAIL $set ALL all_data.tmp
$if not set FAIL $set FAIL failures_data.gms

$set GAMSlo %GAMS.lo%
$if %GAMS.ide% == 1 $set GAMSlo 2

$set FLAGS lo=%GAMSlo%
$if %DEMOSIZE% == 1 $set FLAGS --DEMOSIZE=1 %FLAGS%

$include datamod.inc

$if not set TEST $goto alltest
SET runtests(m) / %TEST% /;
$if errorfree $goto TEST_OK
$clearerror
$log The test model(s) specified (--TEST=%TEST%) are not all valid
$abort

$label alltest
SET runtests(m);
runtests(m)$(not letters(m)) = yes;
$label TEST_OK

Set ignore(m)  /
  CheckListbox     'model shows only the use of listbox and checklistbox'
  CHP              'model opens interactive spreadsheet in excel'
  CHP2             'model opens interactive spreadsheet in excel'
  Combobox         'model shows only the use of combobox'
  Fileopenbox      'model shows only the use of fileopenbox'
  Filesavebox      'model shows only the use of filesavebox'
  GDXViewerExample 'model shows only the use of the GDX viewer'
  GDXMRWPlotting01 'model just a placeholder for GDXMRW examples, requires Matlab'
  MDB2GDX1         'model has a gdx viewer call'
  MDB2GMS          'model has an ask call'
  MultipleAsk      'model has several ask calls'
  PopulateV        'model has an Access call'
  Portfolio        'model opens interactive spreadsheet'
  RadioButton      'model has two ask calls'
  SalesProfitDB4   'model has a gdx viewer call'
  SalesProfitDB7   'model has a gdx viewer call'
  Samurai          'model opens interactive spreadsheet'
  Samurai2         'model opens interactive spreadsheet'
  SingleAsk        'model has an ask call'
  SQL2GDX1         'model has a gdx viewer call'
  SQL2GMS          'model has an ask call'
  SQLServer        'model has an SQL server call'
  Sudoku           'model opens interactive spreadsheet'
  transxls         'model opens interactive spreadsheet'
  tsvngdx          'model needs two gdx files as input and uses WinMerge'
  TrnsxcllStarter  'model opens interactive spreadsheet'
  /;

Set WinOnly(m)  /
  SingleAsk,    MultipleAsk,
  RadioButton,  CheckListbox,   Combobox,       Fileopenbox,    Filesavebox,
  GDXXRWExample5  *GDXXRWExample10,
  GDXXRWExample11a,GDXXRWExample11b,
  GDXXRWExample12 *GDXXRWExample16,
  Distances1,   Distances2,
  SalesProfitDB1,SalesProfitDB2c,SalesProfitDB2m,SalesProfitDB3*SalesProfitDB7,
  DBTimestamp1, DBTimestamp2,
  IndexMapping1*IndexMapping4,
  MDB2GMS,      MDBSr5,         MDB2GDX1,       MDB2GDX2,
  Wiring,       PopulateV,
  SQL2GMS,      SQLSr5,         SQL2GDX1,       SQL2GDX2,       SQLServer,
  Excel,        Text,           dBASE,          ReadSet,        readdata
  ReadTrnsportData1,ReadTrnsportData2,ReadMultiDimPar,ReadMultiRange,
  GDXViewerExample,
  Sudoku,       Samurai,        Samurai2,       CHP,            CHP2,
  Portfolio,    transxls,       tsvngdx,        tompivot,       TrnsxcllStarter
  /;

$onempty
set mdlstdoutskip(m) 'skips for stdout check' /
  GDXDUMPExample15   'demonstrates simple use of gdxdump, writes to stdout'
/;
set mdlstderrskip(m) 'skips for stderr check' /
/;
$offempty

$if %system.filesys% == UNIX ignore(WinOnly) = yes;

scalar
  rc     / 0 /
  tot    / 0 /,
  err    / 0 /,
  stderr / 0 /,
  stdout / 0 /,
  cnt    / 0 /;

file oneTest  / 'onetest.gms' /         //Getting test from testlib and executing test
     stdTest  / 'stdtest.gms' /         //Checking if stderr and stdout are empty
     allTests / '%ALL%'  /
     ferr / '%FAIL%' /
     rmme / 'rmme.gms'  /
     log  / ''          /
     fx;

$if %ALL% == all_data.gms putclose allTests '* These are the tests we ran' /;
$if %FAIL% == failures_data.gms putclose ferr '* These are the tests that failed' /;

putclose rmme '* Delete all directories of tests without problems' /;
allTests.ap = 1;
ferr.ap = 1;
rmme.ap = 1;

$if not set DIRNAME $set DIRNAME "'%PREFIX%_data_' m.tl:0 "

loop(runtests(m)$(not ignore(m)),
  cnt = cnt + 1;
  tot = tot + 1;
  put_utility fx 'shell' / 'rm -rf ' %DIRNAME%;
  put_utility fx 'shell' / 'mkdir ' %DIRNAME%;
  put oneTest
     '$call datalib -q ' m.tl:0
   / '$if errorlevel 1 $abort'
   / '$call =gams ' m.tl:0 ' %FLAGS%';
  putclose oneTest
   / '$if errorlevel 1 $set err 1'
   / '$if set err scalar err /%err%/'
   / "$if %err% == 1 $abort 'Problem'";
  put_utility fx 'log' / 'Calling ' m.tl:0;
  put_utility fx 'shell' / 'mv -f onetest.gms ' %DIRNAME% ' && cd ' %DIRNAME% ' && gams onetest lo=%GAMS.lo% --err=0 gdx=..%SLASH%err > stdout.txt 2>stderr.txt'; rc=1; execute_load 'err' rc=err;
  putclose stdTest                                                                                          //Checking if stderr and stdout are empty
     '$call =test -s ' %DIRNAME% '%SLASH%stderr.txt'
   / '$if errorlevel 1 $set stderr 0'
   / '$if set stderr scalar stderr /%stderr%/'
   / '$call =test -s ' %DIRNAME% '%SLASH%stdout.txt'
   / '$if errorlevel 1 $set stdout 0'
   / '$if set stdout scalar stdout /%stdout%/'
  execute 'gams stdtest.gms lo=2 --stderr=1 --stdout=1 gdx=std'; stderr=1; stdout=1; execute_load 'std' stderr,stdout;
  put allTests;
  put '$call =gams datatest %FLAGS% --fail=failures_data.tmp --test=' m.tl:0 ' ';
  if {rc,     put '--ftrace=1 '};
  if {stderr and not mdlstderrskip(m), put '--fstderr=1 '};
  if {stdout and not mdlstdoutskip(m), put '--fstdout=1 '};
  putclose allTests '--dir='%DIRNAME% /;
  if {(rc or (stderr and not mdlstderrskip(m)) or (stdout) and not mdlstdoutskip(m)),
    err = err + 1;
    put ferr;                                                                                         // failure_data.gms
    put '$call =gams datatest %FLAGS% --fail=failures_data.tmp --test=' m.tl:0 ' ';                   // --fail defines alternative failures file
    if {rc,     put '--ftrace=1 '};                                                                   // execution error
    if {stderr and not mdlstderrskip(m), put '--fstderr=1 '};                                      // writing to standard error
    if {stdout and not mdlstdoutskip(m), put '--fstdout=1 '};                                      // writing to standard output
    putclose ferr '--dir='%DIRNAME% /;                                                        // name of kept directory
  else
    putclose rmme '$call rm -rf ' %DIRNAME% /;
  };
  if(cnt=5,
    execute "=gams rmme lo=0";
    cnt = 0;
    execute "echo '* Delete all directories of tests without problems' > rmme.gms";
  );
);

execute "=gams rmme lo=0";

putclose oneTest '*Total tests: ', tot:0:0, '  Failed tests: ', err:0:0 ;
$if %FAIL% == failures_data.gms execute 'cat onetest.gms >> %FAIL%'

execute 'rm -f rmme.* err.gdx std.gdx onetest.gms stdtest.*';

put log;
if {(err > 0),
  put 'There were errors: ', err:0:0, ' out of ',
       tot:0:0, ' tests failed.' /;
  put 'See the file failures_data.gms to reproduce the failed runs'/;
  put 'You have some failures. See failures_data.gms for details.';
else
  put 'Congratulations!  All ', tot:0:0, ' tests passed.'/;
};

put 'See the file %ALL%.gms to reproduce all the runs'/;
