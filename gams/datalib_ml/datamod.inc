* -*- fundamental -*-
$hidden When adding models we need to update this file at a few
$hidden spots. Look for $hidden lines. To check > gams testdata.inc
$hidden   update lib version above and run gams testdata.inc
alias (u,*)
SETS s Model Sequence Numbers / 1*83 /
$hidden                           bump sequences numbers above

$stitle Model Names and Titles
set m model names in alphabetic order /
$hidden enter the new model here, keep in order
A
B
C
CheckListbox               'Multiple ask popups for entering values through listboxes or checklistboxes'
CHP                        'Optimize combined heat and power generation in Excel, using vba API (gamsx and opt) and GDXXRW'
CHP2                       'Optimize combined heat and power generation in Excel, using vba API (gamsx, opt and gdx)'
Combobox                   'Multiple ask popups for entering values through comboboxes'
CompTimeWriteTrnsportGDX   'Writes data to GDX file during compile time'
D
dBASE                      'Reads a dBASE table from United Nations Statistics Division'
DBTimestamp1               'Retrieve data from database once each day'
DBTimestamp2               'Retrieves data from database once each day'
Distances1                 'Single-valued tables'
Distances2                 'Single-valued tables'
E
Excel                      'Reads data from Excel through ODBC'
ExecTimeReadTrnsportGDX    'Reads data from a GDX file during execution time'
F
Fileopenbox                'Ask popup for opening a file'
Filesavebox                'Ask popup for saving a file'
G
GDXCOPYExample19           'Copies a GDX file to a compressed format for version 6'
GDXDIFFExample16           'Compares two GDX files and writes the difference to a third GDX file'
GDXDUMPExample15           'Generates first a GDX file and then lists symbols in the GDX file'
GDXExecute_unloadExample4  'Writes data to GDX file during execution time'
GDXINExample1              'Illustrates use of demand data from an external source in compile phase'
GDXINExample2              'Illustrates use of demand and market data from an external source in compile phase'
GDXINExample3              'Lists all the symbols in Trnsport.gdx in the listing file in compile phase'
GDXMERGEExample17          'Merges a number of GDX files into one'
GDXMRWPlotting01           'Packages GDXMRW data plotting examples'
GDXRANKExample18           'Sorts a parameter, creates a sorted version and verifies that the sort works correctly'
GDXViewerExample           'Illustrates conversion of GDX data into different formats'
GDXXRWExample10            'Reads a number of parameters and sets using the index option from an MS Excel file and writes it to a GDX file'
GDXXRWExample11a           'Generates a GDX file and writes it to an MS Excel file'
GDXXRWExample11b           'Reads a table from an MS Excel file and writes it to a GDX file'
GDXXRWExample12            'Illustrates the use of merge and clear option'
GDXXRWExample13            'Reads a table from an MS Excel file, manipulates data and writes it to first a GDX file and then to the MS Excel file'
GDXXRWExample14            'This example illustrates reading from and writing to an MS Excel file using a modified version of trnsport.gms'
GDXXRWExample15            'Write spreadsheet using a filter'
GDXXRWExample16            'Write spreadsheet using text and hyperlinks'
GDXXRWExample5             'Reads a two dimensional parameter from an MS Excel file and writes it to a GDX file'
GDXXRWExample6             'Reads a two dimensional parameter from an MS Excel file and writes it to a GDX file'
GDXXRWExample7             'Reads a four dimensional parameter from an MS Excel file and writes it to a GDX file'
GDXXRWExample8             'Reads a parameter with special values from an MS Excel file and writes it to a GDX file'
GDXXRWExample9             "Reads a set using 'values' option from an MS Excel file and writes it to a GDX file"
H
I
IndexMapping1              'Index mapping in GAMS code'
IndexMapping2              'Index mapping in MS Access'
IndexMapping3              'Index mapping in GAMS code'
IndexMapping4              'Index mapping in MS Access'
J
K
L
Loadpoint                  'Illustrates use of "execute_loadpoint" command'
M
MakeQL                     'Create Querry Library routines for extrinsic functions'
MDB2GDX1                   'Creates a GDX file in execution time and displays it in GDXVIEWER'
MDB2GDX2                   'Creates a GDX file in compile time'
MDB2GMS                    'Runs MDB2GMS interactively'
MDBSr5                     'Sequence of GAMS models using save/restart facility'
MultipleAsk                'Multiple ask popups for entering various data types'
N
O
P
PopulateV                  'Creates MS Access database'
Portfolio                  'Determines an efficient frontier in Excel, using the GDX DLL (vba API) and the GAMS executable'
Q
R
RadioButton                'Multiple ask popups for entering values through radio buttons'
readdata                   'Read data from .inc, .xls, .mdb and .csv file'
ReadMultiDimPar            'Reads a multidimensional parameter'
ReadMultiRange             'Reads a multi-area range and does post processing to eliminate invalid entries'
ReadSet                    'Reads set data'
ReadTrnsportData1          'Reads set data and the table of the transportation model in several calls'
ReadTrnsportData2          'Reads set data and the table of the transportation model in one call'
S
SalesProfitDB1             'Single-valued tables'
SalesProfitDB2c            'Use of UNION to read multi-data column tables'
SalesProfitDB2m            'Use of UNION to read multi-data column tables'
SalesProfitDB3             'Multiple queries in one call'
SalesProfitDB4             'Multiple queries in one call'
SalesProfitDB5             'Use of UNION to read multi-data column tables'
SalesProfitDB6             'Multiple queries in one call'
SalesProfitDB7             'Multiple queries in one call'
Samurai                    'Solve a Samurai Sudoku in Excel, using the GDX DLL (vba API) and the GAMS executable'
Samurai2                   'Solve a Samurai Sudoku in Excel, using the GDX and GAMSX DLL (vba API)'
Savepoint                  'Saves solution to a log or GDX file'
SingleAsk                  'Single ask popup for entering an integer value'
SQL2GDX1                   'Creates a GDX file in execution time and displays it in GDXVIEWER'
SQL2GDX2                   'Creates a GDX file in compile time'
SQL2GMS                    'Runs SQL2GMS interactively'
SQLServer                  'Test timeouts against SQL Server'
SQLSr5                     'Sequence of GAMS models using save/restart facility'
Sudoku                     'Solve a Sudoku in Excel, using the GDX DLL (vba API) and the GAMS executable'
T
Text                       'Reads table from a text file using the ODBC Text Driver'
tompivot                   'Little GAMS Program from Tom Rutherford that Illustrates Report Generation with Excel'
transxls                   'Solve classical transportation problem in Excel, using vba API (gamsx, opt and gdx)'
TrnsxcllStarter            'Trnsxcll: Excel Spreadsheet in Charge of GAMS'
tsvngdx                    'Integrate gdxdiff with TortoiseSVN'
U
V
W
Wiring                     'Use of wiring option to read multi-data column tables'
X
Y
Z
     /

letters(m) / a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z /

set inc 'list of include files, .inc extension assumed' /
  'CityListLarge'
  'CityListMedium'
  'CityListSmall'
  'stocks'
  'Trnsport'
  'TrnsportSetDec'
/;

$onempty
set minc(m) 'list of model files $included' /
*  'trnsport'
*  'Makedata'
*  'MDBSr0'
*  'SQLSr0'
*  'Sr1'
*  'Sr2'
*  'Sr3'
*  'Sr4'
/;
$offempty

set oinc 'list of other files needed and/or $included' /
  'DemandData.gdx'
  'ODBCData.txt'
  'ODBCData2.txt'
  'Profit.xls'
  'Sample.mdb'
  'Schema.ini'
  'stocks.csv'
  'stocks.mdb'
  'stocks.xls'
  'Table02.dbf'
  'Test1.xls'
  'Test2.gdx'
  'Test2.xls'
  'Test3.xls'
  'Transportation.gdx'
  'Transportation.mdb'
  'Transport_p1.gdx'
  'Trnsport.gdx'
  'TrnsportData.xls'
  'TrnsportSetData.gdx'
  'UNESCO.xls'
  'UNStatistics.gdx'
  'Yield.xls'
  'do_plot.m', 'simple.gms', 'do_ehl.m', 'seepress.m', 'ehl_kost.gms'
  'extfwrapper.gms', 'tricclib.gms', 'tridclib.gms', 'triifort.gms'
/;

$onempty
set linc 'list of library files needed (these are not in src/datalib_ml)' /
xxx
/;
$offempty

set ainc(*) 'all include files';
* ainc(u) = inc(u) or minc(u);
ainc(u) = inc(u) or sum{minc,sameas(minc,u)} or sum{oinc,sameas(oinc,u)} or sum{linc,sameas(linc,u)};
*display ainc;

$onempty
$stitle Model Assignments
set sm(s,m) model sequence number assignment /
$hidden seq . name mapping goes here
/

Set F(M, *) /
  CheckListbox.('CheckListbox.gms')
  CHP.('CHP.gms', 'chp.xls')
  CHP2.('CHP2.gms', 'chp2.xls')
  Combobox.('Combobox.gms', 'CityListSmall.inc', 'CityListMedium.inc', 'CityListLarge.inc')
  CompTimeWriteTrnsportGDX.('CompTimeWriteTrnsportGDX.gms')
  dBASE.('dBASE.gms', 'Table02.dbf')
  DBTimestamp1.('DBTimestamp1.gms', 'MDBSr0.gms', 'Transportation.mdb')
  DBTimestamp2.('DBTimestamp2.gms', 'SQLSr0.gms', 'Transportation.mdb')
  Distances1.('Distances1.gms', 'Sample.mdb')
  Distances2.('Distances2.gms', 'Sample.mdb')
  Excel.('Excel.gms', 'Profit.xls')
  ExecTimeReadTrnsportGDX.('ExecTimeReadTrnsportGDX.gms', 'Trnsport.gdx')
  Fileopenbox.('Fileopenbox.gms', 'TrnsportSetDec.inc', 'TrnsportSetData.gdx', 'Trnsport.inc')
  Filesavebox.('Filesavebox.gms')
  GDXCOPYExample19.('GDXCOPYExample19.gms', 'UNStatistics.gdx')
  GDXDIFFExample16.('GDXDIFFExample16.gms', 'trnsport.gms')
  GDXDUMPExample15.('GDXDUMPExample15.gms', 'trnsport.gms')
  GDXExecute_unloadExample4.('GDXExecute_unloadExample4.gms')
  GDXINExample1.('GDXINExample1.gms', 'DemandData.gdx')
  GDXINExample2.('GDXINExample2.gms', 'DemandData.gdx')
  GDXINExample3.('GDXINExample3.gms', 'Trnsport.gdx')
  GDXMERGEExample17.('GDXMERGEExample17.gms')
  GDXMRWPlotting01.('GDXMRWPlotting01.gms', 'do_plot.m', 'simple.gms', 'do_ehl.m', 'seepress.m', 'ehl_kost.gms')
  GDXRANKExample18.('GDXRANKExample18.gms')
  GDXViewerExample.('GDXViewerExample.gms', 'Trnsport.gdx')
  GDXXRWExample10.('GDXXRWExample10.gms', 'Test1.xls')
  GDXXRWExample11a.('GDXXRWExample11a.gms', 'Makedata.gms')
  GDXXRWExample11b.('GDXXRWExample11b.gms')
  GDXXRWExample12.('GDXXRWExample12.gms', 'Test2.xls', 'Test2.gdx')
  GDXXRWExample13.('GDXXRWExample13.gms', 'Test1.xls')
  GDXXRWExample14.('GDXXRWExample14.gms', 'TrnsportData.xls')
  GDXXRWExample15.('GDXXRWExample15.gms')
  GDXXRWExample16.('GDXXRWExample16.gms')
  GDXXRWExample5.('GDXXRWExample5.gms', 'Test1.xls')
  GDXXRWExample6.('GDXXRWExample6.gms', 'Test1.xls')
  GDXXRWExample7.('GDXXRWExample7.gms', 'Test1.xls')
  GDXXRWExample8.('GDXXRWExample8.gms', 'Test1.xls')
  GDXXRWExample9.('GDXXRWExample9.gms', 'Test1.xls')
  IndexMapping1.('IndexMapping1.gms', 'Sample.mdb')
  IndexMapping2.('IndexMapping2.gms', 'Sample.mdb')
  IndexMapping3.('IndexMapping3.gms', 'Sample.mdb')
  IndexMapping4.('IndexMapping4.gms', 'Sample.mdb')
  Loadpoint.('Loadpoint.gms', 'trnsport.gms', 'Transport_p1.gdx')
  MakeQL.('MakeQL.gms','extfwrapper.gms','tricclib.gms','tridclib.gms','triifort.gms')
  MDB2GDX1.('MDB2GDX1.gms', 'MDBSr0.gms', 'Transportation.mdb')
  MDB2GDX2.('MDB2GDX2.gms', 'Transportation.mdb')
  MDB2GMS.('MDB2GMS.gms')
  MDBSr5.('MDBSr5.gms', 'MDBSr0.gms', 'Sr1.gms', 'Sr2.gms', 'Sr3.gms', 'Sr4.gms', 'Transportation.mdb')
  MultipleAsk.('MultipleAsk.gms')
  PopulateV.('PopulateV.gms')
  Portfolio.('Portfolio.gms', 'portfolio.xls')
  RadioButton.('RadioButton.gms')
  readdata.('readdata.gms', 'stocks.inc', 'stocks.xls', 'stocks.mdb', 'stocks.csv')
  ReadMultiDimPar.('ReadMultiDimPar.gms', 'Yield.xls')
  ReadMultiRange.('ReadMultiRange.gms', 'UNESCO.xls')
  ReadSet.('ReadSet.gms', 'Test3.xls')
  ReadTrnsportData1.('ReadTrnsportData1.gms', 'Test3.xls')
  ReadTrnsportData2.('ReadTrnsportData2.gms', 'Test3.xls')
  SalesProfitDB1.('SalesProfitDB1.gms', 'Sample.mdb')
  SalesProfitDB2c.('SalesProfitDB2c.gms', 'Sample.mdb')
  SalesProfitDB2m.('SalesProfitDB2m.gms', 'Sample.mdb')
  SalesProfitDB3.('SalesProfitDB3.gms', 'Sample.mdb')
  SalesProfitDB4.('SalesProfitDB4.gms', 'Sample.mdb')
  SalesProfitDB5.('SalesProfitDB5.gms', 'Sample.mdb')
  SalesProfitDB6.('SalesProfitDB6.gms', 'Sample.mdb')
  SalesProfitDB7.('SalesProfitDB7.gms', 'Sample.mdb')
  Samurai.('Samurai.gms', 'samurai.xls')
  Samurai2.('Samurai2.gms', 'samurai2.xls')
  Savepoint.('Savepoint.gms', 'trnsport.gms')
  SingleAsk.('SingleAsk.gms')
  SQL2GDX1.('SQL2GDX1.gms', 'SQLSr0.gms', 'Transportation.mdb')
  SQL2GDX2.('SQL2GDX2.gms', 'Transportation.mdb')
  SQL2GMS.('SQL2GMS.gms')
  SQLServer.('SQLServer.gms')
  SQLSr5.('SQLSr5.gms', 'SQLSr0.gms', 'Sr1.gms', 'Sr2.gms', 'Sr3.gms', 'Sr4.gms', 'Transportation.mdb')
  Sudoku.('Sudoku.gms', 'sudoku.xls')
  Text.('Text.gms', 'ODBCData.txt', 'ODBCData2.txt', 'Schema.ini')
  tompivot.('tompivot.gms')
  transxls.('transxls.gms', 'transport.xls')
  TrnsxcllStarter.('TrnsxcllStarter.gms','Trnsxcll.xls','Trnsxcll.gms')
  tsvngdx.('tsvngdx.gms')
  Wiring.('Wiring.gms', 'Sample.mdb')
  /;

set incmap(*,s) 'list of $included files required for model s' /
$hidden enter new include files and/or new $includes
$hidden datalib will copy $included files according to this mapping
/;
$offempty

$onempty
set big(s) need full solver license to run  / /
set tiny(s) model that have not more than 10x10 variables and equation / /
$offempty
