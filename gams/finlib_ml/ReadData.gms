$onecho > temp.txt
Trace=2
input = BondIndexData.xls
output = BondIndexDataXLS.gdx
PAR = USD rng = "USD!A7" rdim = 1 cdim = 1
PAR = DEM rng = "DEM!A7" rdim = 1 cdim = 1
PAR = CHF rng = "CHF!A7" rdim = 1 cdim = 1
PAR = USDPrices1 rng = "USDPrices1!A1" rdim = 1 cdim = 1
PAR = DEMPrices1 rng = "DEMPrices1!A1" rdim = 1 cdim = 1
PAR = CHFPrices1 rng = "CHFPrices1!A1" rdim = 1 cdim = 1
PAR = USDPrices0 rng = "USDPrices0!A1" rdim = 1
PAR = DEMPrices0 rng = "DEMPrices0!A1" rdim = 1
PAR = CHFPrices0 rng = "CHFPrices0!A1" rdim = 1
PAR = ExchangeRates0 rng = "ExchangeRates0!A1" rdim = 1
PAR = ExchangeRates1 rng = "ExchangeRates1!A1" rdim = 1 cdim = 1
PAR = IndexReturns rng = "IndexReturns!A1" rdim = 1
$offecho

$call =gdxxrw @temp.txt

parameters
         usd(*,*),dem(*,*),chf(*,*),
         USDPrices1(*,*),DEMPrices1(*,*),CHFPrices1(*,*),
         USDPrices0(*),DEMPrices0(*),CHFPrices0(*),
         ExchangeRates0(*),ExchangeRates1(*,*),
         IndexReturns(*);

$gdxin BondIndexDataXLS
$load usd dem chf USDPrices1 DEMPrices1 CHFPrices1 USDPrices0 DEMPrices0 CHFPrices0
$load ExchangeRates0 ExchangeRates1 IndexReturns
$gdxin

alias(*,i,j);

set EE   currencies / USD,DEM,CHF /
    BB   bonds for structural model
    BB2  bonds for co-movements model
    CC   columns for structural model
    SS   set of scenarios for co-movements model
    BxE(*,EE)
    BxE2(*,EE);

parameter data(*,*),data2(*,*),data3(*);

data(i,j) = usd(i,j) + dem(i,j) + chf(i,j);

data2(i,j) =  USDPrices1(i,j)+ DEMPrices1(i,j) + CHFPrices1(i,j);

data3(i) =  USDPrices0(i)+ DEMPrices0(i) + CHFPrices0(i);


BB(i) = SUM(j$data(i,j), YES);
BB2(j) = SUM(i$data2(i,j), YES);

SS(i) = SUM(j$data2(i,j), YES);

CC(j) = SUM(i$data(i,j), YES);

BxE2(j,'USD') = SUM(i$USDPrices1(i,j), YES);
BxE2(j,'DEM') = SUM(i$DEMPrices1(i,j), YES);
BxE2(j,'CHF') = SUM(i$CHFPrices1(i,j), YES);

BxE(i,'USD') = SUM(j$usd(i,j), YES);
BxE(i,'DEM') = SUM(j$dem(i,j), YES);
BxE(i,'CHF') = SUM(j$chf(i,j), YES);


$onecho > temp.txt
Trace=2
input = BroadIndexData.xls
output = BroadIndexDataXLS.gdx
PAR = AssetReturns rng = "Asset Returns!A1" rdim = 1 cdim = 2
PAR = ExchangeRateReturns rng = "Exchange Rate Returns!A1" rdim = 1 cdim = 1
$offecho

$call =gdxxrw @temp.txt

PARAMETERS
         AssetReturns(*,*,*), ExchangeRateReturns(*,*);

$gdxin BroadIndexDataXLS
$load AssetReturns ExchangeRateReturns
$gdxin

ALIAS(*,i,j,k);

SETS
         EE2 Currencies
         TT Time periods
         AA Asset classes
         AxE(*,*);


TT(i) =  SUM((j,k)$AssetReturns(i,j,k), YES );
AA(j) =  SUM((i,k)$AssetReturns(i,j,k), YES );
EE2(k) = SUM((i,j)$AssetReturns(i,j,k), YES );

AxE(j,'USD') = SUM(i$AssetReturns(i,j,'USD'), YES );
AxE(j,'EUR') = SUM(i$AssetReturns(i,j,'EUR'), YES );
AxE(j,'GBP') = SUM(i$AssetReturns(i,j,'GBP'), YES );
AxE(j,'JPY') = SUM(i$AssetReturns(i,j,'JPY'), YES );

DISPLAY TT,EE2,AA,AxE,ExchangeRateReturns;

EXECUTE_UNLOAD 'InputData';
