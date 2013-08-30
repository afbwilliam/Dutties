* Declare the basic sets (time periods and asset classes).

* Set of all 46 asset classes (incl. Ital. total stk markt)

SET ASSETS /
*
*       Italian Risk-free Rate:
*
*
*       23 Italian Stock Indices:
*
                ITMSBNK, ITMSAUT, ITMSCEM,
                ITMSCST, ITMSDST, ITMSELT, ITSFIN,
                ITMSFPA, ITMSFMS, ITMSFNS, ITMSFOD,
                ITMSIND, ITMSINM, ITMSINS, ITMSPUB,
                ITMSMAM, ITMSPAP, ITMSMAC, ITMSPSV,
                ITMSRES, ITMSSER, ITMSTEX, ITMSTAT,
*
*       3 Italian Bond Indices:
*
                YRS_1_3, YRS_3_7, YRS_5_7,
*
*       7 International Govt Bond Indices:
*
                GVT_GM, GVT_IT, GVT_FR, GVT_SP, GVT_US, GVT_JP, GVT_UK,
*
*       5 regional stock indices:
*
                EMU, EU_EX, PACIFIC, EMERGT, NOR_AM,
*
*       3 risk-free regional rates:
*
                CASH_EU, CASH_US, CASH_JP,
*
*       3 US Corporate Bond Sectional Indices:
*
        CRP_FIN, CRP_ENG, CRP_LFE,
*
*       The Italian General Stock Index
        ITMHIST
  /;


* Italian stock indexes

SET IT_STOCK(ASSETS) /
                     ITMSBNK, ITMSAUT, ITMSCEM,
                     ITMSCST, ITMSDST, ITMSELT, ITSFIN,
                     ITMSFPA, ITMSFMS, ITMSFNS, ITMSFOD,
                     ITMSIND, ITMSINM, ITMSINS, ITMSPUB,
                     ITMSMAM, ITMSPAP, ITMSMAC, ITMSPSV,
                     ITMSRES, ITMSSER, ITMSTEX, ITMSTAT /;


* Italian stock plus bond indexes

SET IT_ALL(ASSETS) /
                   ITMSBNK, ITMSAUT, ITMSCEM,
                   ITMSCST, ITMSDST, ITMSELT, ITSFIN,
                   ITMSFPA, ITMSFMS, ITMSFNS, ITMSFOD,
                   ITMSIND, ITMSINM, ITMSINS, ITMSPUB,
                   ITMSMAM, ITMSPAP, ITMSMAC, ITMSPSV,
                   ITMSRES, ITMSSER, ITMSTEX, ITMSTAT,
                   YRS_1_3, YRS_3_7, YRS_5_7 /;

* Italian and international stock indexes

SET INT_STOCK(ASSETS) /
                      ITMSBNK, ITMSAUT, ITMSCEM,
                      ITMSCST, ITMSDST, ITMSELT, ITSFIN,
                      ITMSFPA, ITMSFMS, ITMSFNS, ITMSFOD,
                      ITMSIND, ITMSINM, ITMSINS, ITMSPUB,
                      ITMSMAM, ITMSPAP, ITMSMAC, ITMSPSV,
                      ITMSRES, ITMSSER, ITMSTEX, ITMSTAT,
                      YRS_1_3, YRS_3_7, YRS_5_7,
                      EMU, EU_EX, PACIFIC, EMERGT, NOR_AM /;

* Italian stock and government indexes, international stock and government
* indexes, plus corporate indexes.

SET INT_ALL(ASSETS) /
                    ITMSBNK, ITMSAUT, ITMSCEM,
                    ITMSCST, ITMSDST, ITMSELT, ITSFIN,
                    ITMSFPA, ITMSFMS, ITMSFNS, ITMSFOD,
                    ITMSIND, ITMSINM, ITMSINS, ITMSPUB,
                    ITMSMAM, ITMSPAP, ITMSMAC, ITMSPSV,
                    ITMSRES, ITMSSER, ITMSTEX, ITMSTAT,
                    YRS_1_3, YRS_3_7, YRS_5_7,
                    GVT_GM, GVT_FR, GVT_SP, GVT_US, GVT_JP, GVT_UK,
                    CRP_FIN, CRP_ENG, CRP_LFE,
                    EMU, EU_EX, PACIFIC, EMERGT, NOR_AM/;



SCALAR Delta "Time steps of 1/12 year"; Delta = 1/12;

SET TS_DATES /
    1990-01-01
    1990-02-01
    1990-03-01
    1990-04-01
    1990-05-01
    1990-06-01
    1990-07-01
    1990-08-01
    1990-09-01
    1990-10-01
    1990-11-01
    1990-12-01
    1991-01-01
    1991-02-01
    1991-03-01
    1991-04-01
    1991-05-01
    1991-06-01
    1991-07-01
    1991-08-01
    1991-09-01
    1991-10-01
    1991-11-01
    1991-12-01
    1992-01-01
    1992-02-01
    1992-03-01
    1992-04-01
    1992-05-01
    1992-06-01
    1992-07-01
    1992-08-01
    1992-09-01
    1992-10-01
    1992-11-01
    1992-12-01
    1993-01-01
    1993-02-01
    1993-03-01
    1993-04-01
    1993-05-01
    1993-06-01
    1993-07-01
    1993-08-01
    1993-09-01
    1993-10-01
    1993-11-01
    1993-12-01
    1994-01-01
    1994-02-01
    1994-03-01
    1994-04-01
    1994-05-01
    1994-06-01
    1994-07-01
    1994-08-01
    1994-09-01
    1994-10-01
    1994-11-01
    1994-12-01
    1995-01-01
    1995-02-01
    1995-03-01
    1995-04-01
    1995-05-01
    1995-06-01
    1995-07-01
    1995-08-01
    1995-09-01
    1995-10-01
    1995-11-01
    1995-12-01
    1996-01-01
    1996-02-01
    1996-03-01
    1996-04-01
    1996-05-01
    1996-06-01
    1996-07-01
    1996-08-01
    1996-09-01
    1996-10-01
    1996-11-01
    1996-12-01
    1997-01-01
    1997-02-01
    1997-03-01
    1997-04-01
    1997-05-01
    1997-06-01
    1997-07-01
    1997-08-01
    1997-09-01
    1997-10-01
    1997-11-01
    1997-12-01
    1998-01-01
    1998-02-01
    1998-03-01
    1998-04-01
    1998-05-01
    1998-06-01
    1998-07-01
    1998-08-01
    1998-09-01
    1998-10-01
    1998-11-01
    1998-12-01
    1999-01-01
    1999-02-01
    1999-03-01
    1999-04-01
    1999-05-01
    1999-06-01
    1999-07-01
    1999-08-01
    1999-09-01
    1999-10-01
    1999-11-01
    1999-12-01
    2000-01-01
/;

 SET Currencies /
     ITL-FRF, ITL-DEM, ITL-ESP, ITL-GBP, ITL-USD, ITL-JPY, ITL-EUR, US-EUR /;