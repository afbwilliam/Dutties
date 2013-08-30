*illustrate a nonlinear mixed integer minlp model


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

 Integer VARIABLES    INVEST(STOCKS)     MONEY INVESTED IN EACH STOCK
 binary variables mininv(stocks)         require at least 10 shares to be bought
 VARIABLE              OBJ               NUMBER TO BE MAXIMIZED ;
 EQUATIONS             OBJJ              OBJECTIVE FUNCTION
                       INVESTAV          INVESTMENT FUNDS AVAILABLE
                       minstock(stocks)  Require at least 10 units to be bought
                       maxstock(stocks)  Set up indicator variable ;

 OBJJ.. OBJ =E=   SUM(STOCKS, MEAN(STOCKS) * INVEST(STOCKS))
                - RAP*(SUM(STOCK, SUM(STOCKS,
                       INVEST(STOCK)* COVAR(STOCK,STOCKS) * INVEST(STOCKS))));

 INVESTAV..     SUM(STOCKS, PRICES(STOCKS) * INVEST(STOCKS)) =L= FUNDS ;

  minstock(stocks)..    invest(stocks) =g= 10*mininv(stocks);
  maxstock(stocks)..    invest(stocks)=l=1000*mininv(stocks);
 MODEL EVPORTFOL /ALL/ ;

 SOLVE EVPORTFOL USING MINLP MAXIMIZING OBJ ;


$ontext
#user model library stuff
Main topic MIP
Featured item 1 MINLP
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate a nonlinear mixed integer minlp model
$offtext
