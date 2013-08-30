*Iink with spreadsheet to illustrate interaction
$OFFSYMLIST OFFSYMXREF
 OPTION LIMCOL = 0;
 OPTION LIMROW = 0;
 OPTION SOLSLACK = 1;

set orderset/mean,BUYSTOCK1*BUYSTOCK4,intercept,rap,rapsquare/
 SETS       STOCKS  POTENTIAL INVESTMENTS / BUYSTOCK1*BUYSTOCK4 /
            EVENTS  EQUALLY LIKELY RETURN STATES OF NATURE
                                          /EVENT1*EVENT10 / ;

 ALIAS (STOCKS,STOCK);

 PARAMETERS     PRICES(STOCKS) PURCHASE PRICES OF THE STOCKS
                              / BUYSTOCK1   22
                                BUYSTOCK2   30
                                BUYSTOCK3   28
                                BUYSTOCK4   26 / ;

 SCALAR      FUNDS    TOTAL INVESTABLE FUNDS / 500 / ;

 TABLE RETURNS(EVENTS,STOCKS) RETURNS BY STATE OF NATURE EVENT

           BUYSTOCK1   BUYSTOCK2   BUYSTOCK3   BUYSTOCK4
   EVENT1      7           6           8           5
   EVENT2      8           4          16           6
   EVENT3      4           8          14           6
   EVENT4      5           9          -2           7
   EVENT5      6           7          13           6
   EVENT6      3          10          11           5
   EVENT7      2          12          -2           6
   EVENT8      5           4          18           6
   EVENT9      4           7          12           5
   EVENT10     3           9          -5           6

 PARAMETERS    MEAN (STOCKS)       MEAN RETURNS TO X(STOCKS)
               COVAR(STOCK,STOCKS) VARIANCE COVARIANCE MATRIX;

 MEAN(STOCKS) = SUM(EVENTS , RETURNS(EVENTS,STOCKS) / CARD(EVENTS) );
 COVAR(STOCK,STOCKS)=SUM(EVENTS,(RETURNS(EVENTS,STOCKS) - MEAN(STOCKS))
                               *(RETURNS(EVENTS,STOCK)- MEAN(STOCK)))/CARD(EVENTS);

 SCALAR RAP   RISK AVERSION PARAMETER / 0.0 /

 POSITIVE VARIABLES    INVEST(STOCKS)  MONEY INVESTED IN EACH STOCK
 VARIABLE              OBJ             NUMBER TO BE MAXIMIZED ;
 EQUATIONS             OBJJ            OBJECTIVE FUNCTION
                       INVESTAV        INVESTMENT FUNDS AVAILABLE            ;

 OBJJ.. OBJ =E=   SUM(STOCKS, MEAN(STOCKS) * INVEST(STOCKS))
                - RAP*(SUM(STOCK, SUM(STOCKS,
                       INVEST(STOCK)* COVAR(STOCK,STOCKS) * INVEST(STOCKS))));

 INVESTAV..     SUM(STOCKS, PRICES(STOCKS) * INVEST(STOCKS)) =L= FUNDS ;

 MODEL EVPORTFOL /ALL/ ;

 SOLVE EVPORTFOL USING NLP MAXIMIZING OBJ ;

 SCALAR VAR  THE VARIANCE ;
 VAR = SUM(STOCK, SUM(STOCKS,INVEST.L(STOCK)*COVAR(STOCK,STOCKS)*INVEST.L(STOCKS)))
 DISPLAY VAR ;

 SET RAPS   RISK AVERSION PARAMETERS /R0*R25/

 PARAMETER RISKAVER(RAPS) RISK AVERSION COEFICIENT BY RISK AVERSION PARAMETER
              /R0   0.00000,  R1   0.00025,  R2   0.00050,  R3   0.00075,
               R4   0.00100,  R5   0.00150,  R6   0.00200,  R7   0.00300,
               R8   0.00500,  R9   0.01000,  R10  0.01100,  R11  0.01250,
               R12  0.01500,  R13  0.02500,  R14  0.05000,  R15  0.10000,
               R16  0.30000,  R17  0.50000,  R18  1.00000,  R19  2.50000,
               R20  5.00000,  R21  10.0000,  R22  15.    ,  R23  20.
               R24  40.    ,  R25  80./

 PARAMETER OUTPUT(*,RAPS) RESULTS FROM MODEL RUNS WITH VARYING RAP

 OPTION SOLPRINT = OFF;


 LOOP (RAPS,RAP=RISKAVER(RAPS);
            SOLVE EVPORTFOL USING NLP MAXIMIZING OBJ ;
            VAR = SUM(STOCK, SUM(STOCKS,
                INVEST.L(STOCK)*COVAR(STOCK,STOCKS)*INVEST.L(STOCKS))) ;
            OUTPUT("RAP",RAPS)=RAP;
            OUTPUT(STOCKS,RAPS)=INVEST.L(STOCKS);
            OUTPUT("OBJ",RAPS)=OBJ.L;
            OUTPUT("MEAN",RAPS)=SUM(STOCKS, MEAN(STOCKS) * INVEST.L(STOCKS));
            OUTPUT("VAR",RAPS) = VAR;
            OUTPUT("STD",RAPS)=SQRT(VAR);
            OUTPUT("SHADPRICE",RAPS)=INVESTAV.M;
            OUTPUT("IDLE",RAPS)=FUNDS-INVESTAV.L
              );
 DISPLAY OUTPUT;
set funstoestimate(*);
funstoestimate("mean")=yes;
funstoestimate(stock)=yes;
set regpar /intercept,rap,rapsquare,rapcube,rapfour,rsquare/;
set regres /coef,stderr/
set rsqp /r2/
parameter rsq(rsqp);
PARAMETER estimatedata(RAPS,*) data to estimate regression over
PARAMETER regestimate(Regres,regpar) RESULTS FROM MODEL RUNS WITH VARYING RAP
PARAMETER regestimates(*,Regres,regpar) RESULTS FROM MODEL RUNS WITH VARYING RAP
loop(funstoestimate,
    estimatedata(raps,funstoestimate)=output(funstoestimate,raps);
    estimatedata(raps,'Intercept')=1;
    estimatedata(raps,'rap')=output('rap',raps);
    estimatedata(raps,'rapsquare')=output('rap',raps)**2;
    estimatedata(raps,'rapcube')=output('rap',raps)**3;
    estimatedata(raps,'rapfour')=output('rap',raps)**4;
    execute_unload 'regdata.gdx',estimatedata;
    execute 'gdxxrw regdata.gdx o=gdxxrwss.xls par=estimatedata rng=regdata!a1';
    execute 'gdxxrw gdxxrwss.xls o=regdata.gdx par=regestimate rng=regress!a1:f3 par=rsq rng=regress!a4:b4 rdim=1';
    execute_load 'regdata.gdx',regestimate,rsq;
    regestimates(funstoestimate,Regres,regpar)=regestimate(Regres,regpar);
    regestimates(funstoestimate,'coef','rsquare')=rsq('r2');
    estimatedata(raps,funstoestimate)=0;
);
option regestimates:4:2:1;display regestimates;

$ontext
#user model library stuff
Main topic Spreadsheet
Featured item 1 Interaction
Featured item 2
Featured item 3
Featured item 4
include gdxxrwss.xls
Description
Iink with spreadsheet to illustrate calculation interaction
$offtext
