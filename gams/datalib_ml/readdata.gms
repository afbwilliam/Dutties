$title Read Data from .inc, .xls, .mdb and .csv file
$Ontext
This model reads data from different sources. With...
--datainput=GAMS an GAMS include file is used
--datainput=EXCEL an Excel file is read using gdxxrw
--datainput=ACCESS an Access file is read using mdb2gms
--datainput=CSV an CSV file is read using csv2gms

Contributor: Michael Bussieck
$Offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';
$call msappavail -Excel
$if errorlevel 1 $abort.noerror 'Microsoft Excel is not available!';

sets       days
           stocks
           upper(stocks,stocks)
           lower(stocks,stocks);
parameters val(stocks,days)    closing value
           valX(days,stocks)   closing value permuted indices
           return(stocks,days) daily returns - derived;

$if not set datainput $set datainput GAMS
$ifi %datainput%==GAMS   $goto datGAMS
$ifi %datainput%==EXCEL  $goto datEXCEL
$ifi %datainput%==ACCESS $goto datACCESS
$ifi %datainput%==CSV    $goto datCSV
$abort 'No data input %datainput% known'

$label datGAMS
$include stocks.inc
$goto continue

$label datEXCEL
$onecho > gdxxrw.in
i=stocks.xls
o=stocks.gdx
dset days   rng=stockdata!b1 cdim=1
dset stocks rng=stockdata!a2 rdim=1
par  val    rng=stockdata!a1 rdim=1 cdim=1
$offecho
$call gdxxrw @gdxxrw.in trace=0
$if errorlevel 1 $abort 'problems with reading from Excel'
$goto gdxinput

$label datACCESS
$onecho > mdb2gms.in
I=stocks.mdb
X=stocks.gdx
Q1=select Stock,StockDate,ClosingValue from stockdata
P1=val
Q2=select distinct(StockDate) from stockdata
S2=days
Q3=select distinct(Stock) from stockdata
S3=stocks
$offecho
$call mdb2gms @mdb2gms.in > %system.nullfile%
$if errorlevel 1 $abort 'problems with reading from Access'
$goto gdxinput

$label datCSV
$onecho > csv2gms.gms
alias (*,s,d);
parameter val(s,d) /
$ondelim offlisting
$include stocks.csv
$offdelim  onlisting
/;
sets stocks(s), days(d);
option stocks<val, days<val;
$offecho
$call gams csv2gms lo=%gams.lo% gdx=stocks
$if errorlevel 1 $abort 'problems with reading from CSV file'
$goto gdxinput

$label gdxinput
$gdxin stocks
$load days stocks val

$label continue

alias (stocks,sstocks);
return(stocks,days-1) = val(stocks,days)-val(stocks,days-1);

upper(stocks,sstocks) = ord(stocks) <= ord(sstocks);
lower(stocks,sstocks) = not upper(stocks,sstocks);

set d(days)   selected days
    s(stocks) selected stocks
alias(s,t);

* select subset of stocks and periods
d(days)   = ord(days) >1 and ord(days) < 31;
s(stocks) = ord(stocks) < 51;

parameter mean(stocks)          mean of daily return
          dev(stocks,days)      deviations
          covar(stocks,sstocks) covariance matrix of returns (upper)
          totmean               total mean return;

mean(s)  = sum(d, return(s,d))/card(d);
dev(s,d) = return(s,d)-mean(s);

* calculate covariance
* to save memory and time we only compute the uppertriangular
* part as the covariance matrix is symmetric
covar(upper(s,t)) = sum(d, dev(s,d)*dev(t,d))/(card(d)-1);

totmean = sum(s, mean(s))/(card(s));

variables z          objective variable
          x(stocks)  investments;

positive variables x;

equations obj    objective
          budget
          retcon return constraint
          ;


obj.. z =e= sum(upper(s,t), x(s)*covar(s,t)*x(t)) +
            sum(lower(s,t), x(s)*covar(t,s)*x(t));
budget.. sum(s, x(s)) =e= 1.0;
retcon.. sum(s, mean(s)*x(s)) =g= totmean*1.25;

model qp1 /all/;

* Some solvers need more memory
qp1.workfactor = 10;
solve qp1 using nlp minizing z;

display x.l;
