$TITLE Estimate variance and covariance data

* Estimate.gms:  Estimate variance and covariance data.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 3.2.1
* Last modified: Apr 2008.

* Extract data from AssetsData.inc, and calculate ER and VarCov matrix
* for just a subset of the data, given by the set SUBSET.
* The resulting data are used in the MeanVar.gms and Sharpe.gms models.

* We use real data for the 10-year period 1990-01-01 to 2000-01-01.
* Data cover:
*       23 Italian Stock indices
*       3 Italian Bond indices (1-3yr, 3-7yr, 5-7yr)
*       Italian risk-free rate (3-month cash)
*
*       7 international Govt. bond indices
*       5 Regions Stock Indices: (EMU, Eur-ex-emu, PACIF, EMER, NORAM)
*       3 risk-free rates (3-mth cash) for EUR, US, JP
*
*       US Corporate Bond Sector Indices (Finance, Energy, Life Ins.)
*
*       Exchange rates, ITL to: (FRF, DEM, ESP, GBP, US, YEN, EUR)
*       Also US to EUR.


* Include the file containing the set definition
* for the asset classes, time periods and exchange rates.

$INCLUDE "AssetsUniverse.inc";

* Include the file storing the 10 year monthly data for 45 asset classes.
* Also include an Italian risk-free asset, which is treated separately
* (not based on historical data).

$INCLUDE "AssetsData.inc";

* Include the file storing the 10 year monthly exhange rate
* Italian Lire against: DEM. ESP. GBP. USD. JPY. ECU.
* Also US-EUR.

$INCLUDE "ExchangeRates.inc";

* Indexes converted to IT Lira
PARAMETER DATA_ITL(TS_DATES, ASSETS);

* Annualized returns in IT Lira
PARAMETER Ret_ITL(TS_DATES, ASSETS);

ALIAS (TS_DATES,   t);
ALIAS (ASSETS,     i);
ALIAS (IT_ALL,     it);

* 27 Italian asset classes:
DATA_ITL(t, it) = ASSET_DATA(t, it);

* Government Bonds, various currencies:
DATA_ITL(t, "GVT_GM") = ASSET_DATA(t, "GVT_GM")   * EXCHRT(t, "ITL-DEM");
DATA_ITL(t, "GVT_IT") = ASSET_DATA(t, "GVT_IT");
DATA_ITL(t, "GVT_FR") = ASSET_DATA(t, "GVT_FR")   * EXCHRT(t, "ITL-FRF");
DATA_ITL(t, "GVT_SP") = ASSET_DATA(t, "GVT_SP")   * EXCHRT(t, "ITL-ESP");
DATA_ITL(t, "GVT_US") = ASSET_DATA(t, "GVT_US")   * EXCHRT(t, "ITL-USD");
DATA_ITL(t, "GVT_JP") = ASSET_DATA(t, "GVT_JP")   * EXCHRT(t, "ITL-JPY");
DATA_ITL(t, "GVT_UK") = ASSET_DATA(t, "GVT_UK")   * EXCHRT(t, "ITL-GBP");

* Stock Indices, various currencies:
DATA_ITL(t, "EMU") = ASSET_DATA(t, "EMU")         * EXCHRT(t, "ITL-EUR");
DATA_ITL(t, "EU_EX") = ASSET_DATA(t, "EU_EX")     * EXCHRT(t, "ITL-EUR");
DATA_ITL(t, "PACIFIC") = ASSET_DATA(t, "PACIFIC") * EXCHRT(t, "ITL-JPY");
DATA_ITL(t, "EMERGT") = ASSET_DATA(t, "EMERGT")   * EXCHRT(t, "ITL-USD");
DATA_ITL(t, "NOR_AM") = ASSET_DATA(t, "NOR_AM")   * EXCHRT(t, "ITL-USD");

* Risk-free, 3-months cash, various currencies:
DATA_ITL(t, "CASH_EU") = ASSET_DATA(t, "CASH_EU") * EXCHRT(t, "ITL-EUR");
DATA_ITL(t, "CASH_US") = ASSET_DATA(t, "CASH_US") * EXCHRT(t, "ITL-USD");
DATA_ITL(t, "CASH_JP") = ASSET_DATA(t, "CASH_JP") * EXCHRT(t, "ITL-JPY");

* Corporate Bond Indices, all in USD:
DATA_ITL(t, "CRP_FIN") = ASSET_DATA(t, "CRP_FIN") * EXCHRT(t, "ITL-USD");
DATA_ITL(t, "CRP_ENG") = ASSET_DATA(t, "CRP_ENG") * EXCHRT(t, "ITL-USD");
DATA_ITL(t, "CRP_LFE") = ASSET_DATA(t, "CRP_LFE") * EXCHRT(t, "ITL-USD");

* Italian total stock index
 DATA_ITL(t, "ITMHIST") = ASSET_DATA(t, "ITMHIST");

* Calculate annualized returns, expected returns and covariances.
* Note that the risk-free asset is treated specially (no historical data).
SCALAR RiskFreeRt / 0.035 /;

Ret_ITL(t,i) $ (data_ITL(t-1,i) <> 0) =
              log( data_ITL(t,i) / data_ITL(t-1,i) ) / Delta;

* Expected (average) return
PARAMETER MU(i);
MU(i) = SUM( t $ (ORD(t) > 1), Ret_ITL(t,i)) / (CARD(t) - 1);

PARAMETER MAX_MU;
MAX_MU = SMAX(i, MU(i));

ALIAS (i, i1, i2);

PARAMETER Q(i1, i2);
Q(i1,i2) =
          SUM(t $ (ORD(t) > 1),
             (Ret_ITL(t,i1) - mu(i1))*(Ret_ITL(t,i2) - mu(i2))) / (CARD(t)-2);

* Remove very small elements from Q
* (e.g. from the RiskFree asset shows up with correlations around 1e-17):

Q(i1,i2) $ (abs(Q(i1,i2)) <= 1e-12) = 0;


* SUBSET: From here the model differs from IntlAssets.gms.
* The following code estimates data for the MeanVar model, MeanVar.gms

SET SUBSET(ASSETS) /
    Cash_EU    Cash in Euro,
    YRS_1_3    Short-term Italian bonds,
    EMU        Euro stock index,
    EU_EX      Ex-Euro stock index,
    PACIFIC    Pacific stock index,
    EMERGT     Emerging markets stock index,
    NOR_AM     North-America stock index,
    ITMHIST    Italian General stock index
/;

ALIAS (SUBSET, s1, s2);

PARAMETERS
   VarCov(s1, s2)
   ExpectedReturns(s1);

VarCov(s1, s2) = Q(s1, s2);
ExpectedReturns(s1)    = Mu(s1);

SCALAR
   MeanRiskFreeReturn;

PARAMETER
   ExcessRet(t,s1),
   ExcessCov(s1, s2),
   MeanExcessRet(s1);

ExcessRet(t,s1)    = Ret_ITL(t,s1) - Ret_ITL(t,'CASH_EU');
MeanRiskFreeReturn = SUM(t$(ORD(t) > 1), Ret_ITL(t,'CASH_EU')) / (CARD(t)-1);
MeanExcessRet(s1)  = SUM(t$(ORD(t) > 1), ExcessRet(t,s1)) / (CARD(t)-1);
ExcessCov(s1,s2)   = SUM(t$(ORD(t) > 1), (ExcessRet(t,s1) - MeanExcessRet(s1))
                                        *(ExcessRet(t,s2) - MeanExcessRet(s2))) / (CARD(t)-2);

FILE ExpecRetHandle /"ExpectedReturns.csv"/;
FILE VarCovHandle   /"VarianceCovariance.csv"/;

ExpecRetHandle.pc = 5; VarCovHandle.pc = 5;
ExpecRetHandle.pw = 1048; VarCovHandle.pw = 1048;

PUT ExpecRetHandle; LOOP(s1, PUT s1.TL,ExpectedReturns(s1):8:6/ ); PUTCLOSE;
PUT  VarCovHandle; LOOP((s1,s2), PUT s1.TL,s2.TL,VarCov(s1,s2):8:6/ );PUTCLOSE;

* The following code estimates data for the Sharpe model, Sharpe.gms
* A Library of Financial Optimization Models, Section 2.3.

* We assume that the CASH_EU is the risk free asset. In general,
* these data can be used to determine the optimal Sharpe ratio
* respect to a benchmark.

FILE RiskFreeReturn    /"RiskFreeReturn.inc"/;
FILE ExExpecRetHandle  /"ExcessExpectedReturns.csv"/;
FILE ExVarCovHandle    /"ExcessVarianceCovariance.csv"/;

ExExpecRetHandle.pc = 5; ExExpecRetHandle.pw = 1024;
ExVarCovHandle.pc   = 5; ExVarCovHandle.pw = 1024;

PUT RiskFreeReturn "SCALAR RiskFreeRate /", MeanRiskFreeReturn:8:6, " /;"; PUTCLOSE;
PUT ExExpecRetHandle; LOOP(s1, PUT s1.TL,MeanExcessRet(s1):8:6/ ); PUTCLOSE;
PUT ExVarCovHandle; LOOP((s1,s2), PUT s1.TL,s2.TL,ExcessCov(s1,s2):8:6/ ); PUTCLOSE;

* Dump everything into one GDX container

EXECUTE_UNLOAD 'Estimate';