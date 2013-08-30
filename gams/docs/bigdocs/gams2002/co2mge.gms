*model from GAMS model library that illustrates TITLE and STITLE use
$TITLE  Carbon-Related Trade Model (static)  (CO2MGE,SEQ=142)

*       Reference:

*       Carlo Perroni and Thomas Rutherford (1993)  "International Trade
*       in Carbon Emission Rights and Basic Materials: General Equilibrium
*       Calculations for 2020", Scandinavian Journal of Economics.

SET     SCENARIOS  SCENARIOS USED FOR GRAPHS IN PAPER /
                BENCH, GLOBAL-B, GLOBAL-E, GLOBAL-T, GLOBAL,
                OECD-B, OECD-E, OECD-L, OECD-T, OECD /

        SC(SCENARIOS)  SINGLE SCENARIO TO RUN HERE /OECD-L/,

R       REGIONS
        /USA             USA,
         OEC             OECD countries,
         SUE             Soviet Union and Eastern Europe,
         CHN             China,
         ROW             Rest of the World/,

OECD(R)  OECD REGIONS  /USA,OEC/,

ES      ETA sectors
      / HYDR            Global 2100 electric sector HYDRO,
        COLR            Global 2100 electric sector COAL-R,
        NUCR            Global 2100 electric sector NUC-R,
        GASN            Global 2100 electric sector GAS-N,
        COLN            Global 2100 electric sector COAL-N,
        ADVL            Global 2100 electric sector ADV-LC,
        ADVH            Global 2100 electric sector ADV-HC,
        NEBK            Global 2100 non-electric sector NE-BAK,
        RNEW            Global 2100 non-electric sector RNEW,
        SYNF            Global 2100 non-electric sector SYNF,
        CLDU            Global 2100 non-electric sector CLDU,
        OILM            Global 2100 non-electric sector OILMX,
        OILX            Global 2100 non-electric sector OILMX,
        OILL            Global 2100 non-electric sector OIL-LC,
        OILH            Global 2100 non-electric sector OIL-HC,
        GASL            Global 2100 non-electric sector GAS-LC,
        GASH            Global 2100 non-electric sector GAS-HC,
        GNEL            Global 2100 non-electric sector GNEL/,

ET(ES)  Electric technologies
      / HYDR, COLR, NUCR, GASN, COLN, ADVL, ADVH/

NT(ES)  Non-electric technologies
     /  NEBK, RNEW, SYNF, CLDU, OILM, OILX, OILL, OILH, GNEL/,

GS(ES)  Gas supply technologies
     /  GASL, GASH /,

G       Goods

       /DOME             non-basic production (Y),
        DOMI             K-L-E-N-BSMA aggregate in non-basic production,
        BSMA             basic materials,
        NELE             non-electric energy,
        ELEC             electric energy,
        RESR             basic material resource,
        SBVA             basic material intermediate inputs,
        GASS             gas supply,
        CRTS             CO2 emission rights,
        OILT             internationally traded oil,
        UBND             upper bounds,
        LBND             lower bounds,
        KSPC             specific capital,
        KLVA             capital-labor value added/

MS      Macro sectors
       /CONS            Regional consumer,
        SDOM            DOME production,
        SDMI            DOMI production,
        SBSM            BSMA production,
        SBVA            BSMA intermediate production,
        DOMX            DOME exports,
        DOMM            DOME imports,
        BSMX            BSMA exports,
        BSMM            BSMA imports,
        CO2X            Carbon rights export,
        CO2M            Carbon rights import,
        IMEX            Current account balance,
        ETAG            Aggregated ETA sector/,

TP              Time periods /BASE, FUTURE/,

EG(G)           ETA input goods,

BE(G)           Basic energy goods,

OILM(ES)        Oil import sector,

OILX(ES)        Oil export sector

UPPER(ES,R)     ETA activities with active upper bounds,

LOWER(ES,R)     ETA activities with active lower bounds,

FIXED(ES,R)     ETA activities fixed,

BASIC(ES,R)     ETA activities operated between bounds;

ALIAS (R,RR);

        EG(G) = NO;
        EG("NELE") = YES;
        EG("ELEC") = YES;
        EG("GASS") = YES;
        OILM(ES) = NO;
        OILM("OILM") = YES;
        OILX(ES) = NO;
        OILX("OILX") = YES;
        BE(G) = NO;
        BE("NELE") = YES;
        BE("ELEC") = YES;

SCALAR  BYR     Base year   /1990/,
        FYR     Future year /2020/;

TABLE  BYD(R,*)   Base year macro data (1990).

*       GDP     Gross Domestic product (US$ billions)
*       PN      Reference non-electric price ($ per MBTU).
*       QN      Total non-electric energy (MBTU)
*       QE      Total electric energy (TKWH)
*       BMAM    Basic materials imports (US$ millions)

           GDP        ELVS          PN          QN          QE     BMAM
USA       5.60        0.33         3.5      51.335       2.661       10
OEC      10.20        0.33         4.0      50.858       3.288      -66
SUE       2.68        0.33         2.0      47.207       1.406        4
CHN       1.10        0.33         2.0      22.610       0.541        4
ROW       3.34        0.33         2.0      49.870       2.111       49


TABLE  FYD(R,*)  Future year data

*       GDP     Gross Domestic product (US$ billions)
*       PN      Reference non-electric price ($ per MBTU).
*       PE      Reference electric price ($ per TKWH).
*       PG      Reference price natural gas ($ per MBTU).
*       PO      Reference price of oil ($ per MBTU).

          GDP       PN        PE        PG         PO
USA    10.431     11.0      51.0       6.1        9.0
OEC    19.788     11.0      51.0       6.1        9.0
SUE     4.950      9.0      51.0       5.0        9.0
CHN     3.698      9.0      51.0       4.8        9.0
ROW     8.615      9.0      51.0       4.8        9.0


TABLE ELTECH(ET,R,*)  Electric technology data.

*       COST    US $ per TKWH
*       CARBON  CO2 emission rate (tons per TKWH).
*       GAS     Gas inputs (MBTU per TKWH).

                COST        CARBON         GAS

HYDR.USA         2.6
HYDR.OEC         2.6
HYDR.SUE         2.6
HYDR.CHN         2.1
HYDR.ROW         3.6

COLR.USA        20.1         0.2779
COLR.OEC        23.2         0.2844
COLR.SUE        20.1         0.2680
COLR.CHN        26.1         0.2776
COLR.ROW        27.9         0.3600

NUCR.USA        20.6
NUCR.OEC        20.6
NUCR.SUE        20.6
NUCR.CHN        18.2
NUCR.ROW        25.4

*       NOTE: THESE COSTS ARE REDUCED TO AVOID BENCHMARK LOSS:

GASN.USA        12.0                     7.500
GASN.OEC        12.0                     7.500
GASN.SUE        12.0                     7.500
GASN.CHN        12.0                     7.500
GASN.ROW        15.0                     7.500

COLN.USA        51.0       0.2533
COLN.OEC        51.0       0.2533
COLN.SUE        51.0       0.2533
COLN.CHN        51.0       0.2533
COLN.ROW        51.0       0.2533

ADVH.USA        75.0
ADVH.OEC        75.0
ADVH.SUE        75.0
ADVH.CHN        75.0
ADVH.ROW        75.0

ADVL.USA        50.0
ADVL.OEC        50.0
ADVL.SUE        50.0
ADVL.CHN        50.0
ADVL.ROW        50.0



TABLE GASTECH(GS,R,*)  Gas supply data.

*       COST    US $ per MBTU
*       CARBON  CO2 emission rate (tons per MBTU).

              COST          CARBON
GASL.USA       1.5           0.01374
GASL.OEC       1.5           0.01374
GASL.SUE       1.5           0.01374
GASL.CHN       1.5           0.01374
GASL.ROW       0.5           0.01374

GASH.USA       5.0           0.01374
GASH.OEC       5.0           0.01374
GASH.SUE       5.0           0.01374
GASH.CHN       5.0           0.01374
GASH.ROW       5.0           0.01374


TABLE NETECH(NT,R,*)  Non-electric technology data.

*       COST            US $ per MBTU
*       CARBON          CO2 emission rate (tons per MBTU).
*       GAS             Natural gas inputs (MBTU per MBTU).
*       OILT            Oil trade coefficient (MBTU export per unit activity)

              COST          CARBON         GAS        OILT

NEBK.USA      16.667
NEBK.OEC      16.667
NEBK.SUE      16.667
NEBK.CHN      16.667
NEBK.ROW      16.667

RNEW.USA       6.000
RNEW.OEC       6.000
RNEW.SUE       6.000
RNEW.CHN       6.000
RNEW.ROW       6.000

SYNF.USA       8.333         0.04
SYNF.OEC       8.333         0.04
SYNF.SUE       8.333         0.04
SYNF.CHN       8.333         0.04
SYNF.ROW       8.333         0.04

CLDU.USA         2.0         0.02412
CLDU.OEC         3.0         0.02412
CLDU.SUE         2.0         0.02412
CLDU.CHN         2.0         0.02412
CLDU.ROW         2.0         0.02412

OILM.USA                     0.01994                -1.000
OILM.OEC                     0.01994                -1.000
OILM.SUE                     0.01994                -1.000
OILM.CHN                     0.01994                -1.000
OILM.ROW                     0.01994                -1.000

OILX.USA                    -0.01994                 1.000
OILX.OEC                    -0.01994                 1.000
OILX.SUE                    -0.01994                 1.000
OILX.CHN                    -0.01994                 1.000
OILX.ROW                    -0.01994                 1.000

OILL.USA       2.5           0.01994
OILL.OEC       2.5           0.01994
OILL.SUE       2.5           0.01994
OILL.CHN       2.5           0.01994
OILL.ROW       1.0           0.01994

OILH.USA       6.0           0.01994
OILH.OEC       6.0           0.01994
OILH.SUE       6.0           0.01994
OILH.CHN       6.0           0.01994
OILH.ROW       6.0           0.01994

*       Note: these costs have been reduced relative to
*       the Global 2100 numbers.

GNEL.USA       1.0                       1.000
GNEL.OEC       1.0                       1.000
GNEL.SUE       1.0                       1.000
GNEL.CHN       1.0                       1.000
GNEL.ROW       1.0                       1.000  ;


TABLE ELSUPPLY(ET,R,*)  Electric supplies bounds and elasticities.

*       UBND    Upper bound (TKWH).
*       LBND    Lower bound (TKWH).
*       LVL     Reference output level for 2020 (TKWH).
*       ESUP    Elasticity of supply for activities operating in 2020.

                UBND          LBND         LVL        ESUP
HYDR.USA       0.190         0.190       0.190
HYDR.OEC       0.835         0.835       0.835
HYDR.SUE       0.213         0.213       0.213
HYDR.CHN       0.099         0.099       0.099
HYDR.ROW       0.452         0.452       0.452

COLR.USA       0.740                     0.740       1.000
COLR.OEC       0.458                     0.458       1.000
COLR.SUE       0.096                     0.096       1.000
COLR.CHN       0.191                     0.191       1.000
COLR.ROW       0.430                     0.430       1.000

NUCR.USA       0.280                     0.280
NUCR.OEC       0.424                     0.424
NUCR.SUE       0.157                     0.105       1.000

GASN.USA       3.200                     0.072       1.000
GASN.OEC       3.200                     0.072       1.000
GASN.SUE       3.200                     0.289       1.000
GASN.CHN       3.200                     0.072       1.000
GASN.ROW       3.200                     0.072       1.000

COLN.USA        +INF                     2.985       1.000
COLN.OEC        +INF                     2.995       1.000
COLN.SUE        +INF                     2.102       1.000
COLN.CHN        +INF                     1.703       1.000
COLN.ROW        +INF                     4.238       1.000

ADVL.USA         0.1                     0.100       1.000
ADVL.OEC         0.2                     0.198       1.000
ADVL.SUE         0.1                     0.100       1.000
ADVL.CHN         0.1                     0.100       1.000
ADVL.ROW         0.1                     0.100       1.000

ADVH.USA         0.8
ADVH.OEC         1.5
ADVH.SUE         0.8
ADVH.CHN         0.8
ADVH.ROW         0.8;


TABLE NESUPPLY(NT,R,*)  Non-electric supplies bounds and elasticities.

*       UBND    Upper bound (MBTU).
*       LBND    Lower bound (MBTU).
*       LVL     Reference output level for 2020 (MBTU).
*       ESUP    Elasticity of supply for activities operating in 2020.

                UBND          LBND         LVL        ESUP
CLDU.USA       2.740                     2.740
CLDU.OEC       5.250                     5.250
CLDU.SUE      11.440                    11.440
CLDU.CHN      17.590                    17.590
CLDU.ROW      12.230                    12.230

NEBK.USA      +INF
NEBK.OEC      +INF
NEBK.SUE      +INF
NEBK.CHN      +INF
NEBK.ROW      +INF

RNEW.USA        10.0                    10.000
RNEW.OEC        10.0                    10.000
RNEW.SUE        10.0                     5.254       1.000
RNEW.CHN        10.0                     5.293       1.000
RNEW.ROW        10.0                     9.695       1.000

SYNF.USA        +INF                     2.926       1.000
SYNF.OEC        +INF                     2.617       1.000
SYNF.CHN        +INF                     0.851       1.000
SYNF.ROW        +INF                     0.426       1.000

OILM.USA        +INF                    27.909
OILM.OEC        +INF                    24.825

OILX.SUE         3.0                       3.0
OILX.CHN         0.6                       0.6
OILX.ROW        +INF                    49.134

OILL.USA       8.223                     8.223
OILL.OEC       8.295                     8.295
OILL.SUE      15.369                    15.369
OILL.CHN       5.504                     5.504
OILL.ROW      59.465                    59.465

OILH.USA        +INF                     3.027       1.000
OILH.OEC        +INF                     4.442       1.000
OILH.SUE        +INF                     1.041       1.000
OILH.CHN        +INF                     3.588       1.000
OILH.ROW        +INF                    19.947       1.000

*       NB: GNEL NUMBERS ADJUSTED SLIGHTLY TO ACHIEVE GAS MARKET BALANCE:

GNEL.USA        +INF                    10.720       1.000
GNEL.OEC        +INF                    17.302       1.000
GNEL.SUE        +INF                    25.507       1.000
GNEL.CHN        +INF                     4.026       1.000
GNEL.ROW        +INF                    37.648       1.000 ;


TABLE GASSUPPLY(GS,R,*)  Natural gas supplies bounds and elasticities.

*       UBND    Upper bound (MBTU).
*       LBND    Lower bound (MBTU).
*       LVL     Reference output level for 2020 (MBTU).
*       ESUP    Elasticity of supply for activities operating in 2020.

                UBND          LBND         LVL        ESUP
GASL.USA       8.148                     8.148
GASL.OEC      12.546                    12.546
GASL.SUE      27.675                    27.675
GASL.CHN       2.441                     2.441
GASL.ROW      22.831                    22.831

GASH.USA        +INF                     3.112       1.000
GASH.OEC        +INF                     5.296       1.000
GASH.CHN        +INF                     2.125       1.000
GASH.ROW        +INF                    15.357       1.000;

SET ETACOL/GASOUT,GASINP,NELEOUT,NELEINP,ELECOUT,ELECINP,OILEXP,OILIMP,
           CARBOUT,CARBINP,YOUT,YINP,KINP/;

PARAMETER

        GDP(R, TP)      Domestic GDP,
        GDPGR(R)        GDP growth factor,

        PN(R,  TP)      Reference price of non-electric,
        PE(R,  TP)      Reference price of electric,
        PG(R,  TP)      Reference price of gas,
        PO(R,  TP)      Reference price of oil,

        QN(R,  TP)      Non-electric energy production,
        QE(R,  TP)      Electric energy production,

        BMAM(R)         Basic materials imports (base year),

        ELVS(R)         Electricity value share,

        BDRT(R)         Basic materials share of domestic product,
        NBSH(R)         Non-electric value share of basic materials,
        EBSH(R)         Electric value share of basic materials,
        RSHR(R)         Resource share of basic materials (calibrated),
        BDEL(R)         Basic-GDP growth elasticity,

        ELEC(ES,R)      Electricity supply,
        NELE(ES,R)      Non-electric supply,
        GASS(ES,R)      Gas supply,
        OILT(ES,R)      Oil trade,
        UBND(ES,R)      Energy sector upper bound,
        LBND(ES,R)      Energy sector lower bound,
        LEVL(ES,R)      Reference activity level,
        COST(ES,R)      Domestic inputs to energy production,
        CARBON(ES,R)    Carbon coefficient,
        ESUP(ES,R)      Elasticity of supply,

        QB(R)           BMAT benchmark quantity,
        QG(R)           BMAT benchmark quantity,
        QD(R)           BMAT benchmark quantity,

        PNI(R)          Future price index,
        PEI(R)          Future price index,
        PGI(R)          Future price index,
        PDI(R)          Future price index,
        PBI(R)          Future price index,

        BMESHR(R,G)     Basic materials share of domestic energy (%),
        GDPSHR(R,G)     Cost shares of GDP (%),
        DOMSHR(R,G)     Cost shares in gross output (%),
        BMMSHR(R)       Basic material import share of consumption (%),

        MX(R,MS,G)      Macro accounts for future year,
        ROWSUM(G,R)     Row sum check for macro accounts,
        COLSUM(MS,R)    Column sum check for macro accounts,
        EX(R,ES,G)      ETA accounts for future year,

        GASBAL(R)       Check of gas market balance,
        BMCHK(G)        Check of world market balance,
        BMCRTS(R)       Benchmark CRTS,
        PCTPFT(ES,R)    Unit profit margin in benchmark,
        PROFIT(ES,R)    Adjusted ETA profits,
      UNITPROFIT(ES,R)  Adjusted ETA profits per unit activity,
        BMPROFIT(ES,R)  Benchmark ETA profits,
        NETLOSS(ES,R)   Benchmark loss,

*       PARAMETERS USED IN MODEL PRESENTATION:

        ESUBB(R)        ENERGY-OTHER INPUT SUBSTITUTION IN B
        ESUBC(R)        SUBSTITUTION ELASTICITY IN Y,

        Y0(R)           NON-ENERGY OUTPUT,
        W0(R)           NON-ENERGY DEMAND,
        NY0(R)          NON-ELECTRIC ENERGY INPUT TO Y
        EY0(R)          ELECTRIC ENERGY INPUT TO Y
        VY0(R)          VALUE-ADDED INPUT TO Y
        BY0(R)          BASIC MATERIALS INPUT TO Y
        B0(R)           BASIC MATERIALS PRODUCTION
        RB0(R)          RESOURCE INPUTS TO B
        NB0(R)          NON-ELECTRIC ENERGY INPUT TO B
        EB0(R)          ELECTRIC ENERGY INPUT TO Y
        VB0(R)          VALUE-ADDED INPUT TO Y
ETA(R,ES,ETACOL)        ENERGY TECHNOLOGY
        CRTS_N(R)       CARBON RIGHTS ALLOCATION (NON-TRADED),
        CRTS_T(R)       CARBON RIGHTS ALLOCATION (TRADED)
        VA0(R)          REGIONAL VALUE-ADDED ENDOWMENT
        EMIT0(*)        BENCHMARK EMISSIONS
        CO2EMIT(*)      CO2 EMISSIONS
        RESULTS         RESULTS SUMMARY;

SCALAR  NYR             Number of years projected,
        OILBAL          Check of world oil market balance,
        BMATBAL         Check of basic materials trade balance,
        BMATFAC         BMAT growth factor,
        BEPS            Epsilon for diagnosing bounds /1.E-5/,
        ALPHA           Calibrated DOME value share;


SET     LVL   Emission levels  / L1*L6/;

PARAMETER CO2LEVEL(LVL)  CO2 ABATEMENT LEVELS
        /L1 1.2, L2 1.1, L3 1.0, L4 0.9, L5 0.8, L6 0.7/;

TABLE CARBLIM(R,*)  Carbon emissions limits and CRTS trade flag.

                        LEVEL   TRADE
        USA             1.144      0
        OEC             1.100      0
        SUE             0.844      0
        CHN             0.962      0
        ROW             2.253      0 ;

TABLE BMATPROD(R,*)   Basic materials production data.

*       NBSH    Non-electric share of basic materials cost.
*       EBSH    Electric share of basic materials cost.
*       BDRT    Basic-GDP ratio.
*       BDEL    Basic materials : GDP growth elasticity.

           NBSH        EBSH        BDRT        BDEL
USA       0.070       0.070       0.125         0.6
OEC       0.070       0.070       0.125         0.6
SUE       0.070       0.070       0.200         0.8
CHN       0.070       0.070       0.200         0.8
ROW       0.070       0.070       0.125         0.8 ;

TABLE ELAST(R,*)  Elasticities of substitution and supply

*       ESUBC   Elasticity of substitution in non-basic production.
*       ESUBB   Elasticity of substitution in basic materials production.
*       ELEC    Elasticity of supply for operating electric technologies.
*       NELE    Elasticity of supply for operating non-electric technologies.
*       GAS     Elasticity of supply for operating gas technologies.
*       BMAT    Elasticity of supply for basic materials.

         ESUBC       ESUBB     ELEC    NELE    GAS     BMAT
USA       0.5         0.3       1.0     1.0     1.0     1.0
OEC       0.5         0.3       1.0     1.0     1.0     1.0
SUE       0.25        0.3       1.0     1.0     1.0     1.0
CHN       0.25        0.3       1.0     1.0     1.0     1.0
ROW       0.25        0.3       1.0     1.0     1.0     1.0 ;

*       VERIFY THAT EXACTLY ONE COUNTERFACTUAL SCENARIO HAS BEEN SELECTED:

ABORT$(SUM(SCENARIOS$SC(SCENARIOS), 1) NE 1) " A SINGLE SCENARIO NOT SELECTED";

IF (SC("BENCH"),
$stitle: CARBON-RELATED TRADE MODEL - BENCHMARK REPLICATION
        CARBLIM(R,"LEVEL") = +INF;
        CO2LEVEL(LVL)$(ORD(LVL) GT 1) = 0;
);
IF (SC("OECD-L"),
$stitle:CARBON-RELATED TRADE MODEL - OECD ABATEMENT WITH HIGH LEAKAGE
        CARBLIM(R,"LEVEL")$(NOT OECD(R)) = +INF;
        CARBLIM(OECD,"TRADE") = 1;
        ELAST(R,"BMAT") = 4;
        ELAST(R,"ESUBC") = 2 * ELAST(R,"ESUBC");
        ELAST(R,"ESUBB") = 2 * ELAST(R,"ESUBB");
);
IF (SC("GLOBAL-E"),
$stitle:CARBON-RELATED TRADE MODEL - GLOBAL ABATEMENT WITH LOW ELASTICITIES
        CARBLIM(R,"TRADE") = 1;
        ELAST(R,"ESUBC") = 0.5 * ELAST(R,"ESUBC");
        ELAST(R,"ESUBB") = 0.5 * ELAST(R,"ESUBB");

);
IF (SC("GLOBAL-T"),
$stitle:CARBON-RELATED TRADE MODEL - GLOBAL ABATEMENT WITH TRADE IN CRTS
        CARBLIM(R,"TRADE") = 1;
);
IF (SC("GLOBAL"),
$stitle:CARBON-RELATED TRADE MODEL - GLOBAL ABATEMENT WITH NO TRADE IN CRTS
);
IF (SC("OECD-B"),
$stitle:CARBON-RELATED TRADE MODEL - OECD ABATEMENT WITH HIGH BMAT ELASTICITY
        CARBLIM(R,"LEVEL")$(NOT OECD(R)) = +INF;
        CARBLIM(OECD,"TRADE") = 1;
        ELAST(R,"BMAT") = 4;
);
IF (SC("OECD-E"),
$stitle:CARBON-RELATED TRADE MODEL - OECD ABATEMENT WITH LOW ELASTICITIES
        CARBLIM(R,"LEVEL")$(NOT OECD(R)) = +INF;
        CARBLIM(OECD,"TRADE") = 1;
        ELAST(R,"ESUBC") = 0.5 * ELAST(R,"ESUBC");
        ELAST(R,"ESUBB") = 0.5 * ELAST(R,"ESUBB");
);
IF (SC("OECD-L"),
$stitle:CARBON-RELATED TRADE MODEL - OECD ABATEMENT WITH HIGH LEAKAGE
        CARBLIM(R,"LEVEL")$(NOT OECD(R)) = +INF;
        CARBLIM(OECD,"TRADE") = 1;
        ELAST(R,"BMAT") = 4;
        ELAST(R,"ESUBC") = 2 * ELAST(R,"ESUBC");
        ELAST(R,"ESUBB") = 2 * ELAST(R,"ESUBB");
);
IF (SC("OECD-T"),
$stitle:CARBON-RELATED TRADE MODEL - OECD ABATEMENT WITH TRADE
        CARBLIM(R,"LEVEL")$(NOT OECD(R)) = +INF;
        CARBLIM(OECD,"TRADE") = 1;
);
IF (SC("OECD"),
$stitle: CARBON-RELATED TRADE MODEL - OECD ABATEMENT WITH NO TRADE IN CRTS
        CARBLIM(R,"LEVEL")$(NOT OECD(R)) = +INF;
);

*       BENCHMARKING BEGINS HERE:
*       ========================

        NYR = FYR - BYR;

        GDP(R,"BASE")  = BYD(R,"GDP");
        PN(R,"BASE")   = BYD(R,"PN");
        QN(R,"BASE")   = BYD(R,"QN");
        QE(R,"BASE")   = BYD(R,"QE");
        ELVS(R)        = BYD(R,"ELVS");
        BMAM(R)        = 0.001 * BYD(R,"BMAM");

        BDRT(R) = BMATPROD(R,"BDRT");
        NBSH(R) = BMATPROD(R,"NBSH");
        EBSH(R) = BMATPROD(R,"EBSH");
        BDEL(R) = BMATPROD(R,"BDEL");

        GDP(R,"FUTURE") = FYD(R,"GDP");
        PN(R, "FUTURE") = FYD(R,"PN");
        PE(R, "FUTURE") = FYD(R,"PE");
        PG(R, "FUTURE") = FYD(R,"PG");
        PO(R, "FUTURE") = FYD(R,"PO");

        ELEC(ET,R)   = 1;
        NELE(NT,R)   = 1;
        NELE(OILX,R) = -1;
        GASS(GS,R)   = 1;
        GASS(ET,R)   = -ELTECH(ET,R,"GAS");
        GASS(NT,R)   = -NETECH(NT,R,"GAS");
        COST(ET,R)   = ELTECH(ET,R,"COST");
        COST(NT,R)   = NETECH(NT,R,"COST");
        COST(GS,R)   = GASTECH(GS,R,"COST");
        CARBON(ET,R) = ELTECH(ET,R,"CARBON");
        CARBON(NT,R) = NETECH(NT,R,"CARBON");
        CARBON(GS,R) = GASTECH(GS,R,"CARBON");
        OILT(NT,R)   = NETECH(NT,R,"OILT");

        UBND(ET,R)   = ELSUPPLY(ET,R,"UBND");
        LBND(ET,R)   = ELSUPPLY(ET,R,"LBND");
        LEVL(ET,R)   = ELSUPPLY(ET,R,"LVL");
        ESUP(ET,R)   = ELSUPPLY(ET,R,"ESUP")*ELAST(R,"ELEC");

        UBND(NT,R)   = NESUPPLY(NT,R,"UBND");
        LBND(NT,R)   = NESUPPLY(NT,R,"LBND");
        LEVL(NT,R)   = NESUPPLY(NT,R,"LVL");
        ESUP(NT,R)   = NESUPPLY(NT,R,"ESUP")*ELAST(R,"NELE");

        UBND(GS,R)   = GASSUPPLY(GS,R,"UBND");
        LBND(GS,R)   = GASSUPPLY(GS,R,"LBND");
        LEVL(GS,R)   = GASSUPPLY(GS,R,"LVL");
        ESUP(GS,R)   = GASSUPPLY(GS,R,"ESUP")*ELAST(R,"GAS");

*       Benchmark calculations for the Carbon Trade model.
*
*       Check ETA data consistency:

        ABORT$(SMAX((ES,R), LBND(ES,R)-UBND(ES,R)) GT 0)
          " *** ERROR: ETA SUPPLY LOWER BOUND EXCEEDS UPPER BOUND";

        ABORT$(SMAX((ES,R), LEVL(ES,R)-UBND(ES,R)) GT 0)
          " *** ERROR: ETA BENCHMARK SUPPLY EXCEEDS UPPER BOUND";

        ABORT$(SMAX((ES,R), LBND(ES,R)-LEVL(ES,R)) GT 0)
          " *** ERROR: ETA BENCHMARK SUPPLY VIOLATES LOWER BOUND";

        BMATBAL = SUM(R, BMAM(R));
        ABORT$(ABS(BMATBAL) GT 0.01)
          " Imbalance in BMAT trade data.", BMAM, BMATBAL;

        GASBAL(R) = SUM(ES, GASS(ES,R) * LEVL(ES,R));
        ABORT$(SMAX(R, ABS(GASBAL(R))) GT 0.01)
          " Gas supply - demand imbalance.", GASBAL;

        OILBAL = SUM((R,ES), OILT(ES,R) * LEVL(ES,R));
        ABORT$(OILBAL GT 0.01)
          " International oil market imbalance.",OILBAL;

*       DATA ADJUSTMENTS:

*       Impose balance in basic materials trade:

        LOOP(R$(ORD(R) EQ 1), BMAM(R) = BMAM(R) - BMATBAL);

*       Check gas supply-demand balances and adjust GNEL accordingly:

        LEVL("GNEL",R) = LEVL("GNEL",R) - GASBAL(R) / LEVL("GNEL",R);
*
*       Assign oil trade discrepency to first region:
*
        LOOP(R$(ORD(R) EQ CARD(R)),
          LEVL("OILX",R) = LEVL("OILX",R) - OILBAL / LEVL("OILX",R);
          UBND("OILX",R) = MIN( UBND("OILX",R), LEVL("OILX",R) );
        );

*       ETA CALIBRATION AND BENCHMARK:
*
*       Initialize the ETA SAM:
*
        EX(R,ES,G) = 0;
*
*       Pull out coefficients (value):
*
        EX(R,ES,"NELE") = PN(R,"FUTURE") * NELE(ES,R) / 1000;
        EX(R,ES,"ELEC") = PE(R,"FUTURE") * ELEC(ES,R) / 1000;
        EX(R,ES,"GASS") = PG(R,"FUTURE") * GASS(ES,R) / 1000;
        EX(R,ES,"OILT") = PO(R,"FUTURE") * OILT(ES,R) / 1000;
        EX(R,ES,"DOME") = -COST(ES,R) / 1000;

*       Compute benchmark profit (per unit activity):

        BMPROFIT(ES,R) = SUM(G, EX(R,ES,G));

        NETLOSS(ES,R) = MIN(LEVL(ES,R)*(BMPROFIT(ES,R) - EX(R,ES,"DOME")), 0);
        ABORT$(SMIN((ES,R), NETLOSS(ES,R)) LT 0)
          " --- BENCHMARK PROFIT INCONSISTENCY", BMPROFIT, NETLOSS, COST, EX;

*       Define arrays which indicate the benchmark state of ETA activities:
*
        FIXED(ES,R) = YES$(UBND(ES,R) LT LBND(ES,R)+BEPS);
        LEVL(ES,R)$FIXED(ES,R) = LBND(ES,R);
        UBND(ES,R)$FIXED(ES,R) = LBND(ES,R);

        UPPER(ES,R)$(NOT FIXED(ES,R)) = YES$(LEVL(ES,R) GT UBND(ES,R)-BEPS);
        LOWER(ES,R)$(NOT FIXED(ES,R)) = YES$(LEVL(ES,R) LT LBND(ES,R)+BEPS);
        BASIC(ES,R) = YES$(NOT (FIXED(ES,R)+UPPER(ES,R)+LOWER(ES,R)));

*       Check that activities at bounds have appropriate profits:

        ABORT$(SMIN((ES,R)$UPPER(ES,R), BMPROFIT(ES,R)) LT 0)
             " Upper bounded activity makes negative profit:",BMPROFIT,UPPER;

        ABORT$(SMAX((ES,R)$LOWER(ES,R), BMPROFIT(ES,R)) GT 0)
             " Lower bounded activity makes positive profit:",BMPROFIT,LOWER;

*       Calibrate the supply functions:

        LOOP((ES,R)$FIXED(ES,R),
          EX(R,ES,"KSPC") = 0;
          EX(R,ES,"UBND") = -BMPROFIT(ES,R);
          EX(R,ES,"LBND") = 0;
        );

        LOOP((ES,R)$(NOT FIXED(ES,R)),
          IF (BASIC(ES,R),
            ALPHA = ESUP(ES,R) / (1 + ESUP(ES,R));
            EX(R,ES,"KSPC") = (-BMPROFIT(ES,R) + EX(R,ES,"DOME"))
                                * (1 - ALPHA);
            EX(R,ES,"DOME") = ALPHA * EX(R,ES,"KSPC") / (1 - ALPHA);
            EX(R,ES,"UBND") = 0;
            EX(R,ES,"LBND") = 0;
          ELSE
            IF (ESUP(ES,R)*LEVL(ES,R) GT EPS,
              ALPHA = ESUP(ES,R) / (1 + ESUP(ES,R));
              EX(R,ES,"KSPC") = (-BMPROFIT(ES,R) + EX(R,ES,"DOME"))
                                * (1 - ALPHA);
              EX(R,ES,"DOME") = ALPHA * EX(R,ES,"KSPC") / (1 - ALPHA);
              EX(R,ES,"UBND") = 0;
              EX(R,ES,"LBND") = 0;
            ELSE
              EX(R,ES,"KSPC") = 0;
              EX(R,ES,"UBND")$UPPER(ES,R) = -BMPROFIT(ES,R);
              EX(R,ES,"LBND")$LOWER(ES,R) =  BMPROFIT(ES,R);
            );
          );
        );

        UNITPROFIT(ES,R)$(NOT FIXED(ES,R)) = SUM(G, EX(R,ES,G));
        PROFIT(ES,R)    $(NOT FIXED(ES,R)) = LEVL(ES,R) * SUM(G, EX(R,ES,G));

        DISPLAY BMPROFIT, PROFIT, UNITPROFIT, EX, FIXED, BASIC, UPPER, LOWER;

*       Redefine the UPPER and LOWER indicator arrays to include
*       bounds which are inactive in the benchmark:

        LOOP((ES,R)$LBND(ES,R),
          LOWER(ES,R)$(BASIC(ES,R)+UPPER(ES,R)) = YES; );

        LOOP((ES,R)$(UBND(ES,R) LT INF),
          UPPER(ES,R)$(BASIC(ES,R)+LOWER(ES,R)) = YES; );

        UPPER(ES,R)$FIXED(ES,R) = NO;
        LOWER(ES,R)$FIXED(ES,R) = NO;
        LOWER(ES,R)$(LBND(ES,R) EQ 0) = NO;

*       MACRO CALIBRATION AND BENCHMARK:

*       Initialize the MACRO SAM:

        MX(R,MS,G) = 0;

*       Incorporate row representing ETA commodity inputs:

        MX(R,"ETAG",G) = SUM(ES, EX(R,ES,G) * LEVL(ES,R));

*       Trade balance

*       Oil trade:

        MX(R,"IMEX","OILT") = -MX(R,"ETAG","OILT");

*       Compute BMAT 1990=2020 trade index:

        GDPGR(R) = (GDP(R,"FUTURE") / GDP(R,"BASE"))**(1.0/NYR) - 1;

*       BMAT growth factor based on geometric mean:

        BMATFAC = PROD(R, (1 + GDPGR(R) * BDEL(R))**NYR)**(1/CARD(R));

*       BMAT trade extrapolated using growth factor:

        MX(R,"IMEX","BSMA") = BMAM(R) * BMATFAC;

*       Non-basic trade:

        MX(R,"IMEX","DOME") = -SUM(G, MX(R,"IMEX",G));

*       Infer RSHR(R) from the supply elasticity:

        RSHR(R) = 1 / (1 + ELAST(R,"BMAT"));

*       2020 B quantity:

        QB(R) = BDRT(R) * GDP(R,"BASE") * (1 + BDEL(R) * GDPGR(R))**NYR;

        QD(R) = QB(R) * (1 - RSHR(R) - EBSH(R) - NBSH(R));

*       B production: conditional demands and output (values at 2020 prices)

        MX(R,"SBSM","RESR") = - QB(R) * RSHR(R);
        MX(R,"SBSM","NELE") = - QB(R) * NBSH(R);
        MX(R,"SBSM","ELEC") = - QB(R) * EBSH(R);
        MX(R,"SBSM","KLVA") = - QD(R);

*       Total B production:

        MX(R,"SBSM","BSMA") = - SUM(G, MX(R,"SBSM",G));

*       Energy inputs to macro production: values are computed as
*       residual, the difference between supply and B sector inputs.

        MX(R,"SDMI",BE) = - MX(R,"ETAG",BE) - MX(R,"SBSM",BE);

*       NB: GDP defined as consumption plus investment, which is then
*       equal to K-L value added plus net value of capacity constraints,
*       KLVA = GDP - net value of capacity constraints.

        MX(R,"SDMI","KLVA") = - (GDP(R,"FUTURE") + QD(R) +
                 MX(R,"ETAG","UBND") - MX(R,"ETAG","LBND"));

        MX(R,"SDMI","BSMA") = - (MX(R,"SBSM","BSMA") + MX(R,"IMEX","BSMA"));

        ABORT$(SMAX(R, MX(R,"SDMI","BSMA")) GT 0)
          " NEGATIVE INPUTS OF BMAT.", MX;

*       Total DOMI production:

        MX(R,"SDMI","DOMI") = -SUM(G, MX(R,"SDMI",G));

*       DOME:

        MX(R,"SDOM","DOMI") = - MX(R,"SDMI","DOMI");

*       Domestic non-basic production:

        MX(R,"SDOM","DOME") = - SUM(G, MX(R,"SDOM",G));

*       Consumer:

        MX(R,"CONS","RESR") = -MX(R,"SBSM","RESR");
        MX(R,"CONS","KLVA") = -MX(R,"SDMI","KLVA") - MX(R,"SBSM","KLVA");
        MX(R,"CONS","UBND") = -MX(R,"ETAG","UBND");
        MX(R,"CONS","LBND") = -MX(R,"ETAG","LBND");
        MX(R,"CONS","KSPC") = -MX(R,"ETAG","KSPC");
        MX(R,"CONS","DOME") = -SUM(MS, MX(R,MS,"DOME"));

*       Install carbon emissions coefficient (price=0 in benchmark)
*       and define carbon rights for the benchmark:

        EX(R,ES,"CRTS") = -CARBON(ES,R);

        BMCRTS(R) =  -SUM(ES, EX(R,ES,"CRTS") * LEVL(ES,R));

        BMCHK(G) = SUM(R, MX(R,"IMEX", G));

*       Basic materials share of energy inputs:

        BMESHR(R,BE) = -100 * MX(R,"SBSM",BE) / MX(R,"ETAG",BE);
        GDPSHR(R,BE) = 100 * MX(R,"ETAG",BE) / GDP(R,"FUTURE");
        DOMSHR(R,G)  = -100 * MX(R,"SDMI",G) / MX(R,"SDOM","DOME");
        DOMSHR(R,"DOMI") = 0;
        BMMSHR(R) = -MX(R,"IMEX","BSMA") / MX(R,"SDMI","BSMA");

*       Trap benchmark errors:

        ABORT$(SMAX((R,BE), MX(R,"SDMI",BE)) GT 0)
          "*** Negative ELEC or NELE inputs to SDMI.";

        ROWSUM(G, R) = SUM(MS, MX(R,MS,G));
        COLSUM(MS,R) = SUM(G,  MX(R,MS,G));

        DISPLAY BMCRTS, BMCHK, BMESHR, GDPSHR, DOMSHR, BMMSHR, ROWSUM, COLSUM;

*       Extract elasticities:

        ESUBC(R) = ELAST(R,"ESUBC");
        ESUBB(R) = ELAST(R,"ESUBB");

*       EXTRACT DATA FROM THE BENCHMARK

        W0(R) = -MX(R,"CONS","DOME");
        Y0(R) = MX(R,"SDOM","DOME");
        NY0(R) = -MX(R,"SDMI","NELE");
        EY0(R) = -MX(R,"SDMI","ELEC");
        VY0(R) = -MX(R,"SDMI","KLVA");
        BY0(R) = -MX(R,"SDMI","BSMA");
        B0(R)  =  MX(R,"SBSM","BSMA");
        RB0(R) = -MX(R,"SBSM","RESR");
        NB0(R) = -MX(R,"SBSM","NELE");
        EB0(R) = -MX(R,"SBSM","ELEC");
        VB0(R) = -MX(R,"SBSM","KLVA");
        VA0(R) = VY0(R) + VB0(R);
        EMIT0(R) = -SUM(ES, LEVL(ES,R) * EX(R,ES,"CRTS"));
        EMIT0("TOTAL") = SUM(R, EMIT0(R));

        ETA(R,ES,"GASOUT")      = MAX(EX(R,ES,"GASS"), 0);
        ETA(R,ES,"GASINP")      = MAX(-EX(R,ES,"GASS"), 0);
        ETA(R,ES,"NELEOUT")     = MAX(EX(R,ES,"NELE"), 0);
        ETA(R,ES,"NELEINP")     = MAX(-EX(R,ES,"NELE"), 0);
        ETA(R,ES,"ELECOUT")     = MAX(EX(R,ES,"ELEC"), 0);
        ETA(R,ES,"ELECINP")     = MAX(-EX(R,ES,"ELEC"), 0);
        ETA(R,ES,"OILEXP")      = MAX(EX(R,ES,"OILT"), 0);
        ETA(R,ES,"OILIMP")      = MAX(-EX(R,ES,"OILT"), 0);
        ETA(R,ES,"CARBOUT")     = MAX( EX(R,ES,"CRTS"), 0);
        ETA(R,ES,"CARBINP")     = MAX(-EX(R,ES,"CRTS"), 0);
        ETA(R,ES,"YOUT")        = MAX( EX(R,ES,"DOME"), 0);
        ETA(R,ES,"YINP")        = MAX(-EX(R,ES,"DOME"), 0);
        ETA(R,ES,"KINP")        = MAX(-EX(R,ES,"KSPC"), 0)

$ONTEXT

$MODEL:CRTM_S

$SECTORS:
        Y(R)                            ! OTHER OUTPUT
        B(R)                            ! BASIC MATERIALS OUTPUT
        E(ES,R)$(NOT FIXED(ES,R))       ! ENERGY SECTOR OUTPUT

$COMMODITIES:
        PWY             ! OTHER OUTPUT PRICE
        PWB             ! WORLD PRICE OF BASIC MATERIALS
        PWOIL           ! WORLD PRICE OF OIL
        PGAS(R)         ! REGIONAL PRICE OF GAS
        PELEC(R)        ! REGIONAL ELECTRIC PRICE
        PNELE(R)        ! REGIONAL NON-ELECTRIC PRICE
        PVA(R)          ! REGIONAL PRICE OF VALUE-ADDED
        PBR(R)          ! REGIONAL PRICE OF BASIC MATERIALS RESOURCE

        PU(ES,R)$UPPER(ES,R)      ! ENERGY SUPPLY UPPER BOUND
        PL(ES,R)$LOWER(ES,R)      ! ENERGY SUPPLY LOWER BOUND
        PK(ES,R)$ETA(R,ES,"KINP") ! ENERGY SUPPLY SPECIFIC FACTOR
        PWC$(SMAX(R,CRTS_T(R)))   ! WORLD PRICE OF CARBON RIGHTS
        PC(R)$CRTS_N(R)           ! REGIONAL CARBON EMISSION PRICE

$CONSUMERS:

        RA(R)   ! REPRESENTATIVE AGENT

*       Generate report variables for inputs and demands:

$REPORT:
        V:W(R)          D:PWY           DEMAND:RA(R)
        V:BC(R)         I:PWB           PROD:Y(R)
        V:EY(R)         I:PELEC(R)      PROD:Y(R)
        V:NY(R)         I:PNELE(R)      PROD:Y(R)
        V:EB(R)         I:PELEC(R)      PROD:B(R)
        V:NB(R)         I:PNELE(R)      PROD:B(R)

*       Non-basic production:

$PROD:Y(R)  s:ESUBC(R)  a:1
        O:PWY           Q:Y0(R)
        I:PNELE(R)      Q:NY0(R)  a:
        I:PELEC(R)      Q:EY0(R)  a:
        I:PVA(R)        Q:VY0(R)
        I:PWB           Q:BY0(R)

*       Basic materials production:

$PROD:B(R)  s:1  a:ESUBB(R)  b(a):1
        O:PWB           Q:B0(R)
        I:PBR(R)        Q:RB0(R)
        I:PNELE(R)      Q:NB0(R)  b:
        I:PELEC(R)      Q:EB0(R)  b:
        I:PVA(R)        Q:VB0(R)  a:

*       Energy activities:

$PROD:E(ES,R)$(NOT FIXED(ES,R))   s:0  a:1

*       Energy inputs and outputs:

        O:PGAS(R)       Q:ETA(R,ES,"GASOUT")
        O:PNELE(R)      Q:ETA(R,ES,"NELEOUT")
        O:PELEC(R)      Q:ETA(R,ES,"ELECOUT")

        I:PGAS(R)       Q:ETA(R,ES,"GASINP")
        I:PNELE(R)      Q:ETA(R,ES,"NELEINP")
        I:PELEC(R)      Q:ETA(R,ES,"ELECINP")

        O:PWOIL         Q:ETA(R,ES,"OILEXP")
        I:PWOIL         Q:ETA(R,ES,"OILIMP")

*       Carbon requirements (international and domestic):

        O:PC(R)$CRTS_N(R)       Q:ETA(R,ES,"CARBOUT")
        I:PC(R)$CRTS_N(R)       Q:ETA(R,ES,"CARBINP")
        O:PWC$CRTS_T(R)         Q:ETA(R,ES,"CARBOUT")
        I:PWC$CRTS_T(R)         Q:ETA(R,ES,"CARBINP")

*       Upper and lower bounds:

        I:PU(ES,R)$UPPER(ES,R)  Q:1
        O:PL(ES,R)$LOWER(ES,R)  Q:1

*       Other inputs:

        O:PWY           Q:ETA(R,ES,"YOUT")
        I:PWY           Q:ETA(R,ES,"YINP")      a:$ETA(R,ES,"KINP")
        I:PK(ES,R)      Q:ETA(R,ES,"KINP")      a:$ETA(R,ES,"YINP")

$DEMAND:RA(R)

*       All regions consume the non-energy good:

        D:PWY           Q:W0(R)

*       Value-added endowment:

        E:PVA(R)        Q:VA0(R)

*       Basic materials resource endowment:

        E:PBR(R)        Q:RB0(R)

*       Upper and lower bounds on energy sector activities:

        E:PU(ES,R)$UPPER(ES,R)  Q:UBND(ES,R)
        E:PL(ES,R)$LOWER(ES,R)  Q:(-LBND(ES,R))

*       Specific capital:

        E:PK(ES,R)      Q:(ETA(R,ES,"KINP")*LEVL(ES,R))

*       Carbon emission rights:

        E:PWC           Q:CRTS_T(R)
        E:PC(R)         Q:CRTS_N(R)

*       Fixed ETA activities:

        E:PGAS(R)  Q:(SUM(ES$FIXED(ES,R), LEVL(ES,R)*ETA(R,ES,"GASOUT")))
        E:PNELE(R) Q:(SUM(ES$FIXED(ES,R), LEVL(ES,R)*ETA(R,ES,"NELEOUT")))
        E:PELEC(R) Q:(SUM(ES$FIXED(ES,R), LEVL(ES,R)*ETA(R,ES,"ELECOUT")))
        E:PGAS(R)  Q:(SUM(ES$FIXED(ES,R), -LEVL(ES,R)*ETA(R,ES,"GASINP")))
        E:PNELE(R) Q:(SUM(ES$FIXED(ES,R), -LEVL(ES,R)*ETA(R,ES,"NELEINP")))
        E:PELEC(R) Q:(SUM(ES$FIXED(ES,R), -LEVL(ES,R)*ETA(R,ES,"ELECINP")))
        E:PWOIL Q:(SUM(ES$FIXED(ES,R), LEVL(ES,R)*ETA(R,ES,"OILEXP")))
        E:PWOIL Q:(SUM(ES$FIXED(ES,R), -LEVL(ES,R)*ETA(R,ES,"OILIMP")))
        E:PC(R)$CRTS_N(R)
+               Q:(SUM(ES$FIXED(ES,R), LEVL(ES,R)*ETA(R,ES,"CARBOUT")))
        E:PC(R)$CRTS_N(R)
+               Q:(SUM(ES$FIXED(ES,R), -LEVL(ES,R)*ETA(R,ES,"CARBINP")))
        E:PWC$CRTS_T(R)
+               Q:(SUM(ES$FIXED(ES,R), LEVL(ES,R)*ETA(R,ES,"CARBOUT")))
        E:PWC$CRTS_T(R)
+               Q:(SUM(ES$FIXED(ES,R), -LEVL(ES,R)*ETA(R,ES,"CARBINP")))
        E:PWY   Q:(SUM(ES$FIXED(ES,R), LEVL(ES,R)*ETA(R,ES,"YOUT")))
        E:PWY   Q:(SUM(ES$FIXED(ES,R), -LEVL(ES,R)*ETA(R,ES,"YINP")))

$OFFTEXT
$SYSINCLUDE mpsgeset CRTM_S

E.L(ES,R) = LEVL(ES,R);
PU.L(ES,R) = -EX(R,ES,"UBND");
PL.L(ES,R) = -EX(R,ES,"LBND");

*       CHECK BENCHMARK WITH NO CARBON RESTRICTIONS:

CRTS_N(R) = 0;
CRTS_T(R) = 0;

CRTM_S.ITERLIM = 0;
$INCLUDE CRTM_S.GEN
SOLVE CRTM_S USING MCP;

*       LOOP OVER CO2 LEVELS:

LOOP(LVL$CO2LEVEL(LVL),

*       SET THE LEVEL OF EMISSIONS:

  CRTS_N(R) = 0;
  CRTS_T(R) = 0;

  LOOP(R$(CARBLIM(R,"LEVEL") LT INF),
    IF (CARBLIM(R,"TRADE"),
      CRTS_T(R) = CARBLIM(R,"LEVEL") * CO2LEVEL(LVL);
    ELSE
      CRTS_N(R) = CARBLIM(R,"LEVEL") * CO2LEVEL(LVL);
    );
  );

*       DEFINE A NUMERAIRE:

  PWY.FX = 1;

*       GENERATE AND SOLVE:

  CRTM_S.ITERLIM = 2000;
$INCLUDE CRTM_S.GEN
  SOLVE CRTM_S USING MCP;

*       EXTRACT THE SOLUTION VALUES:

  RESULTS("CPU","--",LVL)    = CRTM_S.RESUSD;
  RESULTS("CONTOL","--",LVL) = CRTM_S.OBJVAL;
  RESULTS("NITER","--",LVL)  = CRTM_S.ITERUSD;

  CO2EMIT(R) = - SUM(ES, EX(R,ES,"CRTS") * E.L(ES,R));
  CO2EMIT("TOTAL") = SUM(R, CO2EMIT(R));

  RESULTS("CO2EXP",R,LVL) = ((CO2EMIT(R)-CRTS_T(R))*PWC.L*1000)$CRTS_T(R);
  RESULTS("CO2PCT",R,LVL)       = 100 * (CO2EMIT(R)-EMIT0(R))/EMIT0(R);
  RESULTS("CO2PCT","TOTAL",LVL) = 100 *
                (CO2EMIT("TOTAL") - EMIT0("TOTAL")) / EMIT0("TOTAL");
  RESULTS("CO2TAX",R,LVL)       = 1000 * (PC.L(R)$CRTS_N(R) + PWC.L$CRTS_T(R));
  RESULTS("LEAKAGE","--",LVL) = 0;
  RESULTS("LEAKAGE","--",LVL)$
        SUM(R$(CARBLIM(R,"LEVEL") LT INF), EMIT0(R) - CO2EMIT(R))
    = 100 * (1 - (EMIT0("TOTAL") - CO2EMIT("TOTAL")) /
      SUM(R$(CARBLIM(R,"LEVEL") LT INF), EMIT0(R) - CO2EMIT(R)));
  RESULTS("BMATOUTP",R,LVL)     =  100 * (B.L(R) - 1);
  RESULTS("POIL",R,LVL)         = PNELE.L(R) * PO(R,"FUTURE");
  RESULTS("POIL","WORLD",LVL)   = PWOIL.L    * PO("USA","FUTURE");
  RESULTS("EV",R,LVL) = 100 * (W.L(R) - W0(R)) / W0(R);

);

OPTION RESULTS:1:2:1;
DISPLAY RESULTS;

$ONTEXT

*       THE FOLLOWING CODE IS NOT USED FOR THE GAMS LIBRARY VERSION


*       APPEND THE SOLUTION TO THE REPORT FILE:

FILE REP /crtm-s.rep/;

*       APPEND TO THIS FILE:

REP.AP = 1;

*       SCIENTIFIC FORMAT WITH 17 COLUMN NUMBERS, 8 DECIMALS

REP.NR = 2;
REP.NW =17;
REP.ND = 8;

*       NO PADDING ON LABELS:

REP.LW = 0;
PUT REP;

*       DUMP RESULTS FOR AGGREGATION IN THE REPORT PROGRAM:

LOOP((SC,LVL)$CO2LEVEL(LVL),

  PUT SC.TL'.CONTOL.TOTAL.',  LVL.TL, @32, RESULTS("CONTOL","--",LVL)/;
  PUT SC.TL '.NITER.TOTAL.',  LVL.TL, @32, RESULTS("NITER","--",LVL)/;
  PUT SC.TL,'.CPU.TOTAL.'  ,  LVL.TL, @32, RESULTS("CPU","--",LVL)  /;
  PUT SC.TL,'.CO2PCT.TOTAL.', LVL.TL, @32, RESULTS("CO2PCT","TOTAL",LVL)/;
  PUT SC.TL,'.LEAKAGE.TOTAL.',LVL.TL, @32, RESULTS("LEAKAGE","--",LVL)/;
  PUT SC.TL,'.POIL.WORLD.',   LVL.TL, @32, RESULTS("POIL","WORLD",LVL)/;
  LOOP(R,
    PUT SC.TL,'.CO2EXP.',R.TL,'.', LVL.TL, @32, RESULTS("CO2EXP",R,LVL)/;
    PUT SC.TL,'.CO2PCT.',R.TL,'.', LVL.TL, @32, RESULTS("CO2PCT",R,LVL)/;
    PUT SC.TL,'.CO2TAX.',R.TL,'.', LVL.TL, @32, RESULTS("CO2TAX",R,LVL)/;
    PUT SC.TL,'.BMATOUTP.'R.TL,'.',LVL.TL, @32, RESULTS("BMATOUTP",R,LVL)/;
    PUT SC.TL,'.POIL.',R.TL,'.',   LVL.TL, @32, RESULTS("POIL",R,LVL)/;
  );
);

$OFFTEXT

$ontext
#user model library stuff
Main topic Dollar commands
Featured item 1 $Title
Featured item 2 $Stitle
Featured item 3
Featured item 4
Description
Model from GAMS model library that illustrates TITLE and STITLE use


$offtext
