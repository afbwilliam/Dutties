$TITLE  Tracking international bond index - GDX input

* BondIndexGDX.gms: Tracking international bond index - GDX input.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 8.2
* Last modified: Apr 2008.

$EOLCOM #


SETS
         Currencies   Currencies set
         Bonds        Bonds set
         Scenarios    Scenarios set

ALIAS(Currencies,j);
ALIAS(Bonds,i);
ALIAS(Scenarios,l,SS);

SET
         JxI(j,i) Bonds by Currencies;

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



$GDXIN BondIndexData                                                     # open GDX container
$LOAD Bonds Currencies Scenarios JxI ExchangeRates0 ExchangeRates1       # extract data
$LOAD Price0 Price1 InitialHoldings  Accruals0 Accruals1                 # extract data
$LOAD Outstanding ReinvestmentRate IndexReturns pr                       # extract data
$GDXIN                                                                   # close GDX container

SCALARS TrnCstB          Buying transaction costs   /0.0025/
        TrnCstS          Selling transaction costs  /0.0015/
        CashInfusion     Available budget infused /100000/
        EpsTolerance     Tolerance    /0.10/
        UpprBnd          Maximum holding percentage for each bond  /0.1/
        CHFtrade         Maximum trading value allowed for Swiss bonds (in CHF) /15000000/
        HoldVal          Value of the initial holdings
        InitAccrCash     Accrued cash originated by the initial holdings
        InitVal          Initial portfolio value;

* Calculate initial portfolio value

HoldVal      = SUM(JxI(j,i), ExchangeRates0(j)*InitialHoldings(i)*Price0(i));
InitAccrCash = SUM(JxI(j,i), ExchangeRates0(j)*InitialHoldings(i)*Accruals0(i));
InitVal      = CashInfusion + InitAccrCash + HoldVal;


POSITIVE VARIABLES
        X0(*)         Face value bought today.
        Y0(*)         Face value sold today.
        Z0(*)         Face value hold today for the next period.
        Cash          Amount of cash resulting from trading (sell and buy) today.
        FinalCash(l)  Amount of cash resulting from portfolio liquidation;

FREE VARIABLES
        z        Objective function value;

* Set the upper bound on the holdings

loop(JxI(j,i), Z0.UP(i) = InitVal/ExchangeRates0(j)/Price0(i)*UpprBnd );

* Set the limit on trading (sell or buy)
* CHF bonds for liquidity reasons

X0.UP(i)$JxI('CHF',i) = CHFtrade / Price0(i);
Y0.UP(i)$JxI('CHF',i) = CHFtrade / Price0(i);

EQUATIONS

   ObjDef            Objective function definition (Expected return)
   CashInventoryCon  Cash balance equation today.
   FinalCashCon(l)   Cash balance equations at the end of first stage.
   InventoryCon(i)   Constraints defining the asset inventory balance
   MADCon(l)         MAD constraints;


ObjDef ..     z =E= 1000*SUM(l, pr(l)*(FinalCash(l)/InitVal - 1 ) );

CashInventoryCon ..   CashInfusion
                    + SUM(JxI(j,i), ExchangeRates0(j)*Y0(i)*Price0(i)*(1-TrnCstS) )
                  =E= SUM(JxI(j,i), ExchangeRates0(j)*X0(i)*Price0(i)*(1+TrnCstB) )
                    + Cash;

FinalCashCon(l) ..  SUM(JxI(j,i), ExchangeRates1(j,l)*Accruals1(i,l)*Z0(i) )
                  + ReinvestmentRate(l)*Cash
                  + SUM(JxI(j,i), ExchangeRates1(j,l)*Z0(i)*Outstanding(i,l)*Price1(i,l)*(1-TrnCstS) )
                =E= FinalCash(l);

InventoryCon(i) .. InitialHoldings(i) + X0(i) =E= Y0(i) + Z0(i);


MADCon(l) ..  ( FinalCash(l)/InitVal  - 1 ) - IndexReturns(l) =G= - EpsTolerance;


MODEL BondIndex 'PSO 7.4.4' / All /;


OPTION LIMROW=0,LIMCOL=0,SOLPRINT=off; # 'Turn off row and colum listing'

* Find a feasible EpsTolerance

SCALAR low    Lower bisection value
       high   Upper bisection value;

high = -INF;  low = 0; EpsTolerance = .01;

REPEAT
   SOLVE BondIndex USING LP MAXIMIZING z;
   IF(BondIndex.MODELSTAT <= 2,
      high := EpsTolerance
   ELSE
      EpsTolerance = 2*EpsTolerance)
UNTIL high > 0;

* Find a small feasible EpsTolerance via bisection

REPEAT
   EpsTolerance = (low+high)/2;
   SOLVE BondIndex USING LP MAXIMIZING z;
   IF(BondIndex.MODELSTAT <=2,
      High = EpsTolerance
   ELSE
      low  = EpsTolerance );
UNTIL (high-low) < 0.005 AND BondIndex.MODELSTAT <= 2;

PARAMETER
CurrentValue(i) Holdings in USD;

CurrentValue(i) = SUM(JxI(j,i), ExchangeRates0(j))*Price0(i)*Z0.L(i);

SET ColHeaders Column headers / 'Face Value','USD Value','Percent'/

PARAMETER SummaryReport(*,ColHeaders);

SummaryReport(i,'Face Value') = Z0.l(i);

SummaryReport(i,'USD Value')  = currentValue(i);

SummaryReport(i,'Percent')    = currentValue(i)/InitVal*100;

SummaryReport('Total',ColHeaders)    = SUM(i, SummaryReport(i,ColHeaders));

DISPLAY SummaryReport,EpsTolerance,z.l,InitVal;

FILE ResultHandle /"BondIndex.csv"/;

ResultHandle.pc = 5; ResultHandle.pw = 1048;

PUT ResultHandle "Objective Function", z.L:12:8 /;

PUT "Final Epsilon", EpsTolerance:12:8/;

PUT "Initial Portfolio Value in USD",InitVal:0:0/;

PUT /;
PUT "Bond number","CUSIP code","Holdings in unit of face value","Holdings in USD","Percentage of the portfolio value";
LOOP(i$Z0.L(i),

      PUT / i.TL:0:0,i.TE(i):0:0,Z0.L(i)::3;

      PUT currentValue(i)::2,((currentValue(i)/InitVal)*100)::2

);

PUTCLOSE / "Cash in US dollar",Cash.L::2,((Cash.L/InitVal)*100)::3;
