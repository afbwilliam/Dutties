$TITLE Indexation model using the co-movements approach

* ComovementsModel.gms: Indexation model using the co-movements approach
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 7.2.2
* Last modified: Apr 2008.


SCALAR
         EpsTolerance;

SETS  BB          Available bonds
      EE          Available currencies
      BxE(BB,EE)  Bonds by Currencies
      SS          Scenarios set

PARAMETERS
         BondPrices0(BB)    Bond prices at the beginning of the stage
         BondPrices1(SS,BB) Bond prices at the end of the stage
         BondReturns(SS,BB) Bond returns
         ExchangeRates0(EE)
         ExchangeRates1(SS,EE)
         ExchangeRatesReturns(SS,EE)
         ExpectedReturns(BB)
         IndexReturns(SS);

$gdxin InputData
$load BB=BB2 EE BxE=BxE2 SS BondPrices1=data2
$load BondPrices0=data3 ExchangeRates0 ExchangeRates1
$load IndexReturns
$gdxin

ALIAS(BB,i)

ALIAS(SS,l)

ALIAS(EE,e);

BondReturns(l,i) =  ( BondPrices1(l,i) - BondPrices0(i) ) / BondPrices0(i);
ExchangeRatesReturns(l,e) = ( ExchangeRates1(l,e) - ExchangeRates0(e) ) / ExchangeRates0(e);

* Calculate bond returns in USD currency

BondReturns(l,i)$BxE(i,'DEM') = BondReturns(l,i)$BxE(i,'DEM') + ExchangeRatesReturns(l,'DEM');
BondReturns(l,i)$BxE(i,'CHF') = BondReturns(l,i)$BxE(i,'CHF') + ExchangeRatesReturns(l,'CHF');

ExpectedReturns(i) = ( 1.0 / CARD(l) ) * SUM(l, BondReturns(l,i) );


DISPLAY BondPrices0,BondReturns,ExchangeRatesReturns,ExpectedReturns,IndexReturns;

VARIABLE
         z;

POSITIVE VARIABLES
         x(i);


EQUATIONS
         ObjDef
         NormalCon
         TrackingConL(l)
         TrackingConG(l);

ObjDef..            z =E= SUM(i, ExpectedReturns(i) * x(i));

TrackingConG(l)..   SUM(i, BondReturns(l,i) * x(i)) - IndexReturns(l) =G= - EpsTolerance;

TrackingConL(l)..   SUM(i, BondReturns(l,i) * x(i)) - IndexReturns(l) =L= EpsTolerance;

NormalCon..         SUM(i, x(i)) =E= 1.0;


MODEL IndexFund 'PFO Model 7.3.3' /ObjDef,TrackingConG,TrackingConL,NormalCon/;

EpsTolerance = 0.1;

WHILE ( IndexFund.MODELSTAT <= 2,

        SOLVE IndexFund MAXIMIZING z USING LP;

        EpsTolerance = EpsTolerance - 0.01;
);


EpsTolerance = EpsTolerance  + 0.02;

SOLVE IndexFund MAXIMIZING z USING LP;


DISPLAY x.l,z.l;