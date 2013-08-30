* ThreeStageSPDA.gms: A three stage stochastic programming model for SPDA
* Consiglio, Nielsen, Vladimirou and Zenios: A Library of Financial Optimization Models, Section 5.4
* See also Zenios: Practical Financial Optimization, Section 6.4.
* Last modified: Nov. 2005.

SET Scenarios Set of scenarios
   /uu, ud, dd, du/;

SET Assets  Available assets
   /io2, po7, po70, io90/;

SET Time Time steps
   /t0, t1, t2/;

ALIAS (Scenarios, l);
ALIAS (Assets, i);
ALIAS (Time, t);

TABLE Yield(i,t,l) Asset yields
                        UU          UD          DD          DU
       IO2 .T0    1.104439    1.104439    0.959238    0.959238
       IO2 .T1    1.110009    0.975907    0.935106    1.167817
       PO7 .T0    0.938159    0.938159    1.166825    1.166825
       PO7 .T1    0.933668    1.154590    1.156536    0.903233
       PO70.T0    0.924840    0.924840    1.167546    1.167546
       PO70.T1    0.891527    1.200802    1.141917    0.907837
       IO90.T0    1.107461    1.107461    0.908728    0.908728
       IO90.T1    1.105168    0.925925    0.877669    1.187143 ;

TABLE CashYield(t,l) Risk free (cash) yield

                        UU          UD          DD          DU
            T0    1.030414    1.030414    1.012735    1.012735
            T1    1.032623    1.014298    1.009788    1.030481 ;

TABLE Liability(t,l) Liabilities due to annuitant lapses
                        UU          UD          DD          DU
            T1   26.474340   26.474340   10.953843   10.953843
            T2   31.264791   26.044541   10.757200   13.608207 ;

PARAMETER FinalLiability(l)  Final liabilities
   / uu = 47.284751,
     ud = 49.094838,
     dd = 86.111238,
     du = 83.290085/;

PARAMETER
   Output(*,i)       Parameter used to save the optimal holdings for each model

SCALARS
   PropCost          Proportional transaction cost;

POSITIVE VARIABLES
   buy(t,i,l)        Amount purchased
   sell(t,i,l)       Amount sold
   hold(t,i,l)       Holdings
   cash(t,l)         Holding in cash;

VARIABLES
   wealth(l)         Final wealth
   z                 Objective function value;

EQUATIONS
   AssetInventoryCon(t,i,l)   Constraints defining the asset inventory balance
   CashInventoryCon(t,l)      Constraint defining the inventory balance
   WealthRatioDef(l)          Equations defining the final asset-liability ratio
   NonAnticConOne(i,l)        Constraints defining the first nonanticipativity set
   NonAnticConTwo(i,l)        Constraints defining the second nonanticipativity set
   ExpWealthObjDef            Expected wealth objective function definition;


AssetInventoryCon(t,i,l) ..
         buy(t,i,l)                           $ (ORD(t) lt CARD(t)) +
         ( Yield(i,t-1,l) * hold(t-1,i,l) )   $ (ORD(t) gt 1) =E=
         sell(t,i,l)                          $ (ORD(t) gt 1) +
         hold(t,i,l)                          $ (ORD(t) lt CARD(t));


CashInventoryCon(t,l) ..
         SUM(i,  sell(t,i,l) * (1 - PropCost))      $ (ORD(t) gt 1) +
         ( CashYield(t-1,l) * cash(t-1,l) )         $ (ORD(t) gt 1) +
         100                                        $ (ORD(t) eq 1) =E=
         SUM(i, buy(t,i,l))                         $ (ORD(t) lt CARD(t)) +
         cash(t,l) + Liability(t,l);


NonAnticConOne(i,l)$(ORD(l) lt CARD(l)) ..
         hold("t0",i,l) =E= hold("t0",i,l+1);


NonAnticConTwo(i,l)$(ORD(l) eq 1 OR ORD(l) eq 3) ..
         hold("t1",i,l) =E= hold("t1",i,l+1);


WealthRatioDef(l) ..
         wealth(l) =E= cash("t2",l) / FinalLiability(l);

ExpWealthObjDef ..
         z =E= SUM(l, wealth(l)) / CARD(l);


MODEL ThreeStageExpWealth /AssetInventoryCon,CashInventoryCon,WealthRatioDef,
                           ExpWealthObjDef,NonAnticConOne,NonAnticConTwo/;


* Model 1: Maximize the expected wealth, without transaction cost

PropCost = 0.0;

SOLVE ThreeStageExpWealth MAXIMIZING z USING LP;

DISPLAY "Model 1";
DISPLAY buy.l, sell.l, hold.l, wealth.l;

Output('Exp Wealth no TC',i) = hold.l('t0',i,'uu');

* Model 2: Maximize the expected wealth, with transaction cost

PropCost = 0.01;

SOLVE ThreeStageExpWealth MAXIMIZING z USING LP;

DISPLAY "Model 2";
DISPLAY buy.l, sell.l, hold.l, wealth.l;

Output('Exp Wealth with TC',i) = hold.l('t0',i,'uu');

* Model 3: Maximize the worst-cast outcome.

VARIABLE
   WorstCase         Worst case outcome;

EQUATIONS
   WorstCaseDef(l)   Equations defining the worst case outcome;

WorstCaseDef(l) ..   WorstCase =L= wealth(l);

MODEL ThreeStageWorstCase /AssetInventoryCon,CashInventoryCon,WealthRatioDef,
                           WorstCaseDef,NonAnticConOne,NonAnticConTwo/;

SOLVE ThreeStageWorstCase MAXIMIZING WorstCase USING LP;

DISPLAY "Model 3";
DISPLAY buy.l, sell.l, hold.l, wealth.l, WorstCase.l;

Output('Worst Case',i) = hold.l('t0',i,'uu');

* Model 4: Maximize expected utility:

EQUATIONS
   UtilityObjDef       Utility objective function definition;

UtilityObjDef ..     z =E= SUM(l, LOG ( wealth(l) ) ) / CARD(l);

MODEL  ThreeStageUtility  /AssetInventoryCon,CashInventoryCon,WealthRatioDef,
                           UtilityObjDef,NonAnticConOne,NonAnticConTwo/;

SOLVE ThreeStageUtility MAXIMIZING z USING NLP;

DISPLAY "Model 4";
DISPLAY buy.l, sell.l, hold.l, wealth.l, z.l;

Output('Utility',i) = hold.l('t0',i,'uu');


* Model 5: Maximize expected wealth with MAD constraints such that A/L > 1.1

PARAMETER
    EpsTolerance  Tolerance;

EQUATIONS
    MADCon(l)     MAD contraints;


MADCon(l) ..   wealth(l) =G= 1.1 - EpsTolerance;

MODEL ThreeStageMAD /AssetInventoryCon,CashInventoryCon,WealthRatioDef,
                     MADCon,ExpWealthObjDef,NonAnticConOne,NonAnticConTwo/;

EpsTolerance = 0.09;

SOLVE ThreeStageMAD MAXIMIZING z USING LP;

DISPLAY "Model 5";
DISPLAY buy.l, sell.l, hold.l, wealth.l, z.l;

Output('MAD',i) = hold.l('t0',i,'uu');

Execute_Unload "ThreeStage.gdx";

Execute 'GDXXRW.EXE ThreeStage.gdx par=Output rng=Holdings!a1';

Execute 'GDXXRW.EXE ThreeStage.gdx var=buy.l rng=Purchase!a1';

Execute 'GDXXRW.EXE ThreeStage.gdx var=sell.l rng=Sell!a1';