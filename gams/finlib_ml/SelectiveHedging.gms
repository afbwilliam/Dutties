$TITLE Indexation model with selective hedging

* SelectiveHedging.gms: Indexation model with selective hedging
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 7.2.3
* Last modified: Apr 2008.


$if NOT set out $set out selectivehedging
$call rm -f  %out%.gdx
$if NOT %system.errorlevel% == 0 $abort %out%.gdx cannot be removed - close

SCALARS
         mu                 Target expected value
         USDDEMForwardRate  USD-DEM forward rate
         USDCHFForwardRate  USD-CHF forward rate;


USDDEMForwardRate = -0.005;
USDCHFForwardRate = 0.001;


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
         UnhedgedBondReturns(SS,BB) Unhedged bond returns
         HedgedBondReturns(SS,BB)   Hedged bond returns
         ExchangeRates0(EE)
         ExchangeRates1(SS,EE)
         ExchangeRatesReturns(SS,EE)
         IndexReturns(SS);

$gdxin InputData
$load BB=BB2 EE BxE=BxE2 SS BondPrices1=data2
$load BondPrices0=data3 ExchangeRates0 ExchangeRates1
$load IndexReturns
$gdxin


ALIAS(BB,i)

ALIAS(SS,l,s)

ALIAS(EE,e);


BondReturns(l,i) =  ( BondPrices1(l,i) - BondPrices0(i) ) / BondPrices0(i);
ExchangeRatesReturns(l,e) = ( ExchangeRates1(l,e) - ExchangeRates0(e) ) / ExchangeRates0(e);

* Unhedged bond returns in USD currency

UnhedgedBondReturns(l,i)$BxE(i,'USD') = BondReturns(l,i)$BxE(i,'USD');
UnhedgedBondReturns(l,i)$BxE(i,'DEM') = BondReturns(l,i)$BxE(i,'DEM') + ExchangeRatesReturns(l,'DEM');
UnhedgedBondReturns(l,i)$BxE(i,'CHF') = BondReturns(l,i)$BxE(i,'CHF') + ExchangeRatesReturns(l,'CHF');


* Hedged bond returns

HedgedBondReturns(l,i)$BxE(i,'DEM') = BondReturns(l,i)$BxE(i,'DEM') + USDDEMForwardRate;
HedgedBondReturns(l,i)$BxE(i,'CHF') = BondReturns(l,i)$BxE(i,'CHF') + USDCHFForwardRate;


DISPLAY BondPrices0,BondReturns,ExchangeRatesReturns,UnhedgedBondReturns,HedgedBondReturns,IndexReturns;


PARAMETERS
        pr(l)       Scenario probability;

pr(l) = 1.0 / CARD(l);

VARIABLE
         z;

POSITIVE VARIABLES
         h(i)
         u(i)
         x(i)
         y(l);


VARIABLES
     r(l,i);

EQUATIONS
         ObjDef
         ReturnCon
         NormalCon
         yPosDef(l)
         yNegDef(l);


ObjDef ..        z =E= SUM(l, pr(l) * y(l));

yPosDef(l) ..    y(l) =G= SUM(i, UnhedgedBondReturns(l,i) * u(i) +  HedgedBondReturns(l,i) * h(i) ) -
                          SUM(s, pr(s) * SUM(i, UnhedgedBondReturns(s,i) * u(i) +  HedgedBondReturns(s,i) * h(i) ));

ReturnCon..      SUM(l, pr(l) * SUM(i, UnhedgedBondReturns(l,i) * u(i) +  HedgedBondReturns(l,i) * h(i))) =G= mu;


yNegDef(l) ..    y(l) =G= SUM(s, pr(s) * SUM(i, UnhedgedBondReturns(s,i) * u(i) +  HedgedBondReturns(s,i) * h(i) )) -
                          SUM(i, UnhedgedBondReturns(l,i) * u(i) +  HedgedBondReturns(l,i) * h(i) );

NormalCon ..     SUM(i, h(i) + u(i)) =E= 1.0;


MODEL IndexFund 'Model PFO 10.5.1' /ALL/;



SET FrontierPoints /P_1 * P_50/;

ALIAS(FrontierPoints,p);


PARAMETER
   Frontiers(p,*) Frontiers;

* We assign to each point a return level mu

Frontiers('P_1','mu') = 0.0;

LOOP (p$(ORD(p) > 1),

    Frontiers(p,'mu') = Frontiers(p-1,'mu') +   (0.0005)$(ORD(p) <= 20) + (0.001)$(ORD(p) > 20);

);


IndexFund.MODELSTAT = 1;

LOOP(p$(IndexFund.MODELSTAT <= 2),

   mu = Frontiers(p,'mu');

   SOLVE IndexFund MINIMIZING z USING LP;

   IF ( IndexFund.MODELSTAT <= 2,

      Frontiers(p,'Partial Hedge') = z.l;

   );

);

* Fully hedged model



u.FX(i) = 0.0;

IndexFund.MODELSTAT = 1;

LOOP(p$(IndexFund.MODELSTAT <= 2),

   mu = Frontiers(p,'mu');

   SOLVE IndexFund MINIMIZING z USING LP;

   IF ( IndexFund.MODELSTAT <= 2,

      Frontiers(p,'Fully Hedged') = z.l;

   );

);

* Unhedged model


u.LO(i) = 0.0;
u.UP(i) = 1.0;

h.FX(i) = 0.0;

IndexFund.MODELSTAT = 1;

LOOP(p$(IndexFund.MODELSTAT <= 2),

   mu = Frontiers(p,'mu');

   SOLVE IndexFund MINIMIZING z USING LP;

   IF ( IndexFund.MODELSTAT <= 2,

     Frontiers(p,'Unhedged') = z.l;

   );

);


DISPLAY Frontiers;

EXECUTE_UNLOAD "%out%.gdx";

EXECUTE 'gdxxrw %out%.gdx o=%out%.xls par=Frontiers Rdim=1';