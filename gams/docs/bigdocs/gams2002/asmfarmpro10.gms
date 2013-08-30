$ontext

Farm program provision data for ASM model

$offtext

*######################################################################
*#####  THE FPYIELD IS CALCULATED BY DIVIDING FPYIELD BY 1990 AGSTATYLD
*######################################################################

SETS  FARMPRO     FARM PROGRAM PARAMETERS
                    /SLIPPAGE  , SETASIDE  ,
                     SETASDCOST, DIVERSION ,
                     50-92     , 0-92      ,
                     UNHARVACR , PERCNTPAID,
                     FPYIELD   , AGSTATYLD ,
                     DIVERPAY  , MKTLOANY-N,
                     TARGET    , FLEX      ,
                     SAVTARGET , LOANRATE  ,
                     DEFIC     , MKTLOAN    /


TABLE FARMPROD(FARMPRO,ALLI)    FARM PROGRAM DATA

              COTTON   CORN    WHEAT   SORGHUM    RICE    BARLEY   OATS
slippage       0.7     0.60     0.80     0.60     0.45     0.60     0.60
setaside      0.10     0.05     0.05     0.05     0.00     0.05     0.00
flex          0.15     0.15     0.15     0.15     0.15     0.15     0.15
setasdcost   20.00    20.00    20.00    20.00    20.00    20.00     0.01
diversion    0.000    0.000    0.000    0.000    0.000    0.000    0.000
50-92        0.082    0.000    0.000    0.000    0.263    0.000    0.000
0-92         0.000    0.044    0.077    0.175    0.000    0.312    0.298
unharvacr    0.021    0.000    0.000    0.000    0.038    0.024    0.00
percntpaid   1.000    0.967    0.897    0.806    1.000    1.000    0.502
fpyield      1.254    105.4     34.4     59.1    48.42     46.4     48.6
AGSTATYLD    1.458    131.4     39.3     72.6    57.36     62.5     65.4
diverpay     0.000    0.000    0.000     0.00    0.000     0.00    0.000
mktloany-n   1.000    0.000    1.000     0.00    1.000     0.00    0.000
target       349.92   2.75      4.00     2.61    10.71     2.36    1.45
loanrate     251.28   2.01      2.58     1.91     6.50     1.32    0.85
defic        86.40    0.68      0.76     0.72     4.82     0.31    0.13
mktloan        0.0    0.00      0.0      0.00     0.00     0.0     0.0

+               soybeans     butter    amcheese   nonfatdrym
loanrate           4.920      0.7625     1.1175     0.9730
;

FARMPROD("FPYIELD",ALLI)$FARMPROD("AGSTATYLD",ALLI)
    =FARMPROD("FPYIELD",ALLI)/FARMPROD("AGSTATYLD",ALLI);

TABLE FPPART(subreg,ALLI)    FARM PROGRAM PARTICIPATION RATES

                cotton        corn       wheat     sorghum        rice

northeast                    0.559       0.315
lakestates                   0.810       0.817
cornbelt         0.764       0.782       0.623       0.565       0.999
northplain                   0.911       0.888       0.846
appalachia       0.692       0.624       0.425       0.494
southeast        0.818       0.680       0.858       0.524
deltastate       0.841       0.322       0.916       0.625       1.000
southplain       0.967       0.789       0.758       0.571       1.000
mountain         1.000       0.811       0.924       0.853
pacific          0.924       0.642       0.841                   1.000

         +      barley        oats

northeast        0.098       0.221
lakestates       0.760       0.320
cornbelt                     0.163
northplain       0.838       0.615
appalachia       0.250       0.055
southeast        0.506       0.175
deltastate                   0.342
southplain       0.699       0.185
mountain         0.754       0.326
pacific          0.805       0.162
;

 FARMPROD('savtarget',ALLI)$FARMPROD('target',ALLI)=
                              FARMPROD('target',ALLI);
$ontext
#user model library stuff
Main topic ASM Model
Featured item 1 Code seperation
Featured item 2
Featured item 3 ASM sector model
Description
Farm program provision data for ASM model

$offtext
