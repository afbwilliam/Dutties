$TITLE Data for the Bond Index Model

* BondIndexData.gms: Data for the Bond Index Model.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 8.2
* Last modified: Apr 2008.


* The include files below were written by a simulation program
* an will be collected in a GDX container for further
* processing with GAMS.

$INLINECOM /* */


SET Scenarios Scenarios set /SS_1 * SS_500/;

ALIAS(Scenarios,l,SS);

$OFFLISTING
$INCLUDE "BondsUniverse.inc"
$INCLUDE "BondPricesAccrualsUSD.inc"
$INCLUDE "BondPricesAccrualsDEM.inc"
$INCLUDE "BondPricesAccrualsCHF.inc"
$INCLUDE "InitialBondsAccruals.inc"
$INCLUDE "RiskFreeReinvestmentRates.inc"
$INCLUDE "Probabilities.inc"
$INCLUDE "IndexReturns.inc"
$INCLUDE "ExchangeRates-BondIndex.inc"
$ONLISTING

SETS
         Currencies Currencies set / USD US Dollar
                                     DEM German Mark
                                     CHF Swiss Frank  /

         Bonds      Bonds set    / #USDBND, #DEMBND, #CHFBND /;

ALIAS(Currencies,j);
ALIAS(Bonds,i);

SET
         JxI(j,i) Bonds by Currencies / USD.#USDBND, DEM.#DEMBND, CHF.#CHFBND /;

PARAMETERS
         ExchangeRates0(j)         Exchange rate (USD against XXX)  at settlement
         ExchangeRates1(j,l)       Exchange rate scenarios ( USD against XXX ) at the end of the first stage
         Price0(i)                 Prices today (in unit of face value)
         Price1(i,l)               Prices at the end of the first stage (in unit of face value)
         InitialHoldings(i)        Initial bond holdings
         Accruals0(i)              Bonds initial accruals
         Accruals1(i,l)            Accruals for the first stage (in unit of face value)
         Outstanding(i,l)          Outstanding face for the first stage
         ReinvestmentRate(l)       Reinvestment rate scenarios ( plus one ) for USD
         IndexReturns(l)           Return of the Salomon index under each scenario
         pr(l)                     Scenario probability;

ExchangeRates0('USD') = 1;
ExchangeRates0('DEM') = USDDEM0;
ExchangeRates0('CHF') = USDCHF0;

ExchangeRates1('USD',l) = 1;
ExchangeRates1('DEM',l) = USDDEM1(l);
ExchangeRates1('CHF',l) = USDCHF1(l);

ReinvestmentRate(l) = RvstRt1(l);
IndexReturns(l)     = IdxRet1(l);

* Domain checking is ignored between the commands $ONUNI and $OFFUNI.

$ONUNI
Price0(i)    = USDPric0(i)    + DEMPric0(i)    + CHFPric0(i);
Price1(i,l)  =  USDPric1(i,l) + DEMPric1(i,l) + CHFPric1(i,l);

InitialHoldings(i)    = USDInitH(i)    + DEMInitH(i)    + CHFInitH(i);
Accruals0(i) = USDInitAccr(i) + DEMInitAccr(i) + CHFInitAccr(i);

Accruals1(i,l)  = USDaccr(i,l)  + DEMaccr(i,l)  + CHFaccr(i,l);
Outstanding(i,l) = USDoutst(i,l) + DEMoutst(i,l) + CHFoutst(i,l);
$OFFUNI

EXECUTE_UNLOAD 'BondIndexData';
