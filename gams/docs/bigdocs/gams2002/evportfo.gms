*use gnupltxy to graph a set of model solution generated data

$OFFSYMLIST OFFSYMXREF
 OPTION LIMCOL = 0;
 OPTION LIMROW = 0;
 OPTION SOLSLACK = 1;

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
parameter graphit (*,raps,*);
graphit("Frontier",raps,"Mean")=OUTPUT("MEAN",RAPS);
graphit("frontier",raps,"Var")=OUTPUT("std",RAPS)**2;
*$include gnu_opt.gms
* titles
$setglobal gp_title  "E-V Frontier "
$setglobal gp_xlabel "Variance of Income"
$setglobal gp_ylabel "Mean Income"

$libinclude gnupltxy graphit mean var
$ontext
#user model library stuff
Main topic Output
Featured item 1 GNUPLTXY.gms
Featured item 2 Graphics
Featured item 3
Featured item 4
Description
Use gnupltxy to graph a set of model solution generated data

$offtext
