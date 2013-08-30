$ontext

Processing budgets for ASM model

$offtext

TABLE PROCBUD(ALLI,PROCESSALT) PROCESSING BUDGET DATA

                       FROZEN-POT
    PROCCOST               4.60300
    PROFIT                 9.40700
    POTATOES               2.00000
    FROZENPOT              1.00000

+                       DEHYDR-POT
    PROFIT                25.48000
    POTATOES               7.00000
    DRIEDPOT               1.00000

+                         CHIP-POT
    PROFIT                79.84000
    POTATOES               4.00000
    CHIPPOT                1.00000

+                        wetmill
    PROFIT              2787.52808
    corn                1000.00000
    glutenfeed            15.40000
    cornoil                1.50000
    starch                31.50000

+                      gluttosbm
    PROFIT              -125.00000
    glutenfeed         -1000.00000
    soybeanmea          6500.00000

+                           hfcs
    PROFIT            112204.94531
    starch             -1000.00000
    hfcs                1058.00000

+                         csyrup
    PROFIT             17269.63281
    starch             -1000.00000
    cosyrup             1058.00000

+                       dextrose
    PROFIT            155911.67188
    starch             -1000.00000
    dextrose            1058.00000

+                        ethanol
    PROFIT               112.00000
    starch             -1000.00000
    ethanol               79.00000

+                        beverages
    PROFIT            280811.00000
    hfcs                 -88.00000
    REFSUGAR              -7.00000
    BEVERAGES           1000.00000

+                       confection
    PROFIT           1582556.00000
    hfcs                 -11.00000
    REFSUGAR            -514.00000
    CONFECTION          1000.00000

+                        canning
    PROFIT            729019.00000
    hfcs                -208.00000
    REFSUGAR            -127.00000
    CANNING             1000.00000

+                        baking
    PROFIT            661684.00000
    hfcs                 -49.00000
    REFSUGAR            -123.00000
    BAKING              1000.00000

+                        refsugar1
    PROFIT                  .00000
    SUGARCANE           1000.00000
    CANEREFINI          1000.00000

+                        refsugar2
    PROFIT              6688.00000
    SUGARBEET          1000.00000
    REFSUGAR             934.00000

+                       canerefine
    PROFIT              6688.00000
    CANEREFINI         -1000.00000
    REFSUGAR             934.00000

+                        soycrush1
    PROCCOST             755.23004
    PROFIT               770.92902
    soybeans            1000.00000
    soybeanmea           476.29999
    soybeanoil            10.63000

+                        soycrush2
    PROCCOST             852.91003
    PROFIT               635.73004
    soybeans            1000.00000
    soybeanmea           468.00000
    soybeanoil            10.90000

+                        hogtopork
    PROCCOST              71.90000
    PROFIT                19.68800
    hogslaught             1.40500
    pork                   1.00000

+                        broilchick
    broilers               1.3774
    chicken               1.00

+                       turkeyproc
    turkeys               1.2654
    turkey                1.00


+                        nfslatonf
    PROCCOST              62.90000
    PROFIT                -1.69500
    nonfedsla             1.68900
    nonfedbeef             1.00000

+                        fslatofbe
    PROCCOST              62.90000
    PROFIT                53.42700
    fedbeefsla             1.68900
    fedbeef                1.00000

+                        caftoveal
    PROCCOST              78.57000
    PROFIT                94.99500
    calfslaugh             1.65000
    veal                   1.00000

* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *
* ADDED FEED MIXES FOR LIVESTOCK 1994 MODEL *
* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *

+                        FDPGRNMIX1
    CORN                   1.785714
    FPGGRAIN1              1
+                        FDPproMIX0
    SOYBEANMEA            -1.000
    fpgproswn0              1
+                        FDPproMIX6
    SOYBEANMEA            -0.5000
    fpgproswn0              1
+                        farGRNMIX1
    CORN                   1.785714
    farGRAIN1              1
+                        FARproMIX0
    SOYBEANMEA            -1.000
    FARproswn0              1
+                        FARproMIX6
    SOYBEANMEA            -0.5000
    FARproswn0              1
+                        finGRNMIX1
    CORN                   1.785714
    finGRAIN1              1
+                        FINproMIX0
    SOYBEANMEA            -1.000
    FINproswn0              1

+                        FINproMIX6
    SOYBEANMEA            -0.5000
    FINproswn0              1
+                        catgrnMIX1
    corn                   1.785714
    catgrain1              1.00
+                         catpro1
    SOYBEANMEA            -1.000
    highprotca             1

+                         catpro3
    SOYBEANMEA            -0.25000
    highprotca             1
+                        COWPROMIX0
    SOYBEANMEA            -1.00
    COWHIPRO0               1.00
+                        COWPROMIX2
    SOYBEANMEA            -0.500
    COWHIPRO0               1.00

+                        RANGCBMIX0
    HAY                    0.00750
    soybeanmea            -0.35
    corn                   0.125
    barley                 0.146
    wheat                  0.1167
    oats                   0.219
    sorghum                0.125
    RANGECUBES             1.00
+                        DARCONMIX1
    feedmix0              -0.7
    soybeanmea            -0.193199
    DAIRYCON0              1.00
+                        DARCONMIX2
    glutenfeed            - 0.017728
    feedmix0              -0.77
    soybeanmea            - 0.082733
    DAIRYCON0              1.00
+                        SHPPROMIX0
    SOYBEANMEA            -1.000
    SHEEPPRO0              1.00
+                        SHPPROMIX2
    SOYBEANMEA            -0.5000
    SHEEPPRO0              1.00
+                        STKPROMIX0
    SOYBEANMEA            -1.000
    STOCKPRO0              1.00
+                        STKPROMIX2
    SOYBEANMEA            -0.500
    STOCKPRO0              1.00
+                        EGGPROMIX0
    SOYBEANMEA            -1.00
    EGGPRO0                1.00
+                        EGGPROMIX5
    SOYBEANMEA            -0.500
    EGGPRO0                1.00
+                        BRLPROMIX0
    SOYBEANMEA            -1.00
    BROILPRO0              1.00
+                        BRLPROMIX4
    SOYBEANMEA            -0.500
    BROILPRO0              1.00
+                        trkPROMIX0
    SOYBEANMEA            -1.00
    turkeyPRO0             1.00
+                        trkPROMIX4
    SOYBEANMEA            -0.500
    turkeyPRO0             1.00

*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*new processes
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

+        fmix1965
corn     1.403031
barley   0.098349
sorghum  0.237455
wheat    0.056867
feedmix0        1
+        fmix1966
corn      1.40249
barley   0.102572
sorghum  0.252818
wheat    0.039654
feedmix0        1
+        fmix1967
corn     1.464402
barley   0.099414
sorghum   0.22072
wheat    0.014354
feedmix0        1
+        fmix1968
corn     1.398713
barley   0.102696
sorghum  0.238095
wheat    0.056822
feedmix0        1
+        fmix1969
corn     1.394155
barley   0.105485
sorghum  0.232602
wheat    0.063972
feedmix0        1
+        fmix1970
corn     1.348956
barley   0.125745
sorghum  0.256497
wheat    0.067648
feedmix0        1
+        fmix1971
corn     1.370543
barley   0.106305
sorghum  0.234304
wheat    0.083765
feedmix0        1
+        fmix1972
corn     1.425465
barley    0.09177
sorghum  0.215489
wheat    0.061694
feedmix0        1
+        fmix1973
corn     1.428368
barley   0.091941
sorghum   0.23574
wheat    0.039947
feedmix0        1
+        fmix1974
corn     1.487788
barley   0.096849
sorghum  0.198771
wheat    0.015065
feedmix0        1
+        fmix1975
corn     1.488579
barley   0.087994
sorghum  0.208036
wheat    0.012764
feedmix0        1
+        fmix1976
corn     1.509274
barley   0.079033
sorghum  0.180086
wheat    0.026704
feedmix0        1
+             FMIX1977
CORN          1.4682
WHEAT         0.0760
SORGHUM       0.1763
BARLEY        0.0697
FEEDMIX0      1.0000
+             FMIX1978
CORN          1.4775
WHEAT         0.0546
SORGHUM       0.1860
BARLEY        0.0743
FEEDMIX0      1.0000
+             FMIX1979
CORN          1.5307
WHEAT         0.0288
SORGHUM       0.1660
BARLEY        0.0678
FEEDMIX0      1.0000
+             FMIX1980
CORN          1.5869
WHEAT         0.0221
SORGHUM       0.1211
BARLEY        0.0630
FEEDMIX0      1.0000
+             FMIX1981
CORN          1.5232
WHEAT         0.0485
SORGHUM       0.1497
BARLEY        0.0711
FEEDMIX0      1.0000
+             FMIX1982
CORN          1.4901
WHEAT         0.0635
SORGHUM       0.1613
BARLEY        0.0772
FEEDMIX0      1.0000
+             FMIX1983
CORN          1.4135
WHEAT         0.1353
SORGHUM       0.1404
BARLEY        0.1014
FEEDMIX0      1.0000
+             FMIX1984
CORN          1.3740
WHEAT         0.1359
SORGHUM       0.1800
BARLEY        0.1005
FEEDMIX0      1.0000
+             FMIX1985
CORN          1.3717
WHEAT         0.0947
SORGHUM       0.2214
BARLEY        0.1064
FEEDMIX0      1.0000
+             FMIX1986
CORN          1.4155
WHEAT         0.1216
SORGHUM       0.1625
BARLEY        0.0903
FEEDMIX0      1.0000
+             FMIX1987
CORN          1.4596
WHEAT         0.0852
SORGHUM       0.1688
BARLEY        0.0770
FEEDMIX0      1.0000
+             FMIX1988
CORN          1.4942
WHEAT         0.0554
SORGHUM       0.1767
BARLEY        0.0648
FEEDMIX0      1.0000
+             FMIX1989
CORN          1.5001
WHEAT         0.0489
SORGHUM       0.1767
BARLEY        0.0660
FEEDMIX0      1.0000
+             FMIX1990
CORN          1.4684
WHEAT         0.1554
SORGHUM       0.0956
BARLEY        0.0645
FEEDMIX0      1.0000
+             FMIX1991
CORN          1.5096
WHEAT         0.1001
SORGHUM       0.1094
BARLEY        0.0693
FEEDMIX0      1.0000
+             FMIX1992
CORN          1.5286
WHEAT         0.0655
SORGHUM       0.1383
BARLEY        0.0568
FEEDMIX0      1.0000


+                        FDPGRNMIX0
    feedmix0              -1
    FPGGRAIN0              1

+                        farGRNMIX0
    feedmix0              -1
    farGRAIN0              1

+                        finGRNMIX0
    feedmix0              -1
    finGRAIN0              1

+                        COWGRNMIX0
    feedmix0              -1.0
    COWGRAIN0              1.00


+                        SHPGRNMIX0
    feedmix0              -1.0
    SHEEPGRN0              1.00

+                        EGGGRNMIX0
    feedmix0              -1.0
    EGGGRAIN0              1.00
+                        BRLGRNMIX0
    feedmix0              -1.0
    BROILGRN0              1.00
+                        trkGRNMIX0
    feedmix0              -1.0
    turkeyGRN0             1.00
+                        catgrnMIX0
    feedmix0              -1.0
    catgrain0              1.00



* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *
* CONVERSION OF STOCKER STEER YEARLINGS TO BEEF YEARLINGS *
* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

+                         BEEFSCONVT
    BEEFSYEARL                1
    BEEFYEARLI               -1

* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *
* CONVERSION OF STOCKER HEIFER YEARLINGS TO BEEF YEARLINGS *
* THE CONEFFICIENT IS OBTAINED FROM BEEF CATTLE SCIENCE, ENSMINGER P.840*
* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *

+                         BEEFHCONVT
    BEEFHYEARL                1.1666667
    BEEFYEARLI               -1

+                        sowtopork
    PROCCOST              71.90000
    PROFIT                24.16800
    cullsow                2.03800
    pork                   1.00000
+                        butterpow
    PROFIT                 -.59900
    milk                   1.00000
    butter                 4.45000
    nonfatdrym             3.00000

+                        evapomilk
    milk                   1.00000
    evapcondm               5.477

+                        fluidmlk1
    PROFIT                14.41800
    milk                   1.00000
    fluidmilk               .95400
    cream                  4.47000

+                       fluidmlk2
    PROFIT                14.51300
    milk                   1.00000
    skimmilk              90.90000
    cream                  9.10000

+                       icecream1
    PROFIT                 -.01900
    milk                    .00820
    icecream               1.00000
    nonfatdrym             -.20400
    cream                  -.17400

+                       icecream2
    PROFIT                 -.15400
    milk                    .00830
    icecream               1.00000
    skimmilk              -1.94200
    cream                  -.17400

+                        amcheese
    PROFIT                 -.35300
    amcheese               1.00000
    skimmilk              -2.75200
    cream                  -.80500

+                        otcheese
    PROFIT                 -.19600
    otcheese               1.00000
    skimmilk              -2.76600
    cream                  -.78100

+                        cottage
    PROFIT                  .69600
    milk                    .00300
    cottageche             1.00000
    skimmilk               -.98000
    cream                  -.17100

+                        clcowsla
    PROFIT                  .00100
    cullbeefco             1.00000
    nonfedsla             -1.00000

+                        dcowsla
    PROFIT                  .00100
    culldairyc             1.00000
    nonfedsla             -1.00000

+                        bfhefsla
    PROFIT               -15.62000
    beefhyearl             1.00000
    nonfedsla             -1.00000

+                        dcafsla
    PROFIT                 1.39400
    vealers                1.00000
    calfslaugh            -1.00000

+                        dclftobeef
    dcalves                1.00
    steercalve            -1.00
+                        juiceorang
    orangeproc            166.535
    orangejuic           1000.00

+                        juicegrpft
    grpfrtproc            205.802
    grpfrtjuic           1000.00
;
$ontext
#user model library stuff
Main topic ASM Model
Featured item 1 Code seperation
Featured item 2 Table
Featured item 3 ASM sector model
Description
Defines processing data that will be used in ASM model
$offtext
