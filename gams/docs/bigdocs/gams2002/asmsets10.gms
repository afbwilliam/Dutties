*Section of total ASM model giving data
*used in good modeling chapter

$OFFSYMLIST OFFSYMXREF

SETS

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

* REGIONAL BREAKDOWN

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

REGIONS            REGIONS
                   / northeast ,   lakestates,
                     cornbelt  ,   northplain,
                     appalachia,   southeast ,
                     deltastate,   southplain,
                     mountain  ,   pacific   ,
                     TOTAL                   /
subreg            REGIONS
                   / northeast ,   lakestates,
                     cornbelt  ,   northplain,
                     appalachia,   southeast ,
                     deltastate,   southplain,
                     mountain  ,   pacific   ,
                     TOTAL                   /
mapping(regions,subreg)  mapping of regions to subregions
                   / northeast.northeast   ,   lakestates.lakestates,
                     cornbelt.cornbelt     ,   northplain.northplain,
                     appalachia.appalachia ,   southeast.southeast ,
                     deltastate.deltastate ,   southplain.southplain,
                     mountain.mountain     ,   pacific.pacific       /

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

*  COMMODITY DEFINITIONS

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

ALLI               ALL BUDGET ITEMS
         /  const     ,    yield     ,
            cornsorg  ,    cotton    ,
            corn      ,    soybeans  ,
            wheat     ,    sorghum   ,
            rice      ,    barley    ,
            oats      ,    silage    ,
            hay       ,    sugarcane ,
            sugarbeet ,    potatoes  ,
            tomatofrsh,    tomatoproc,
            orangefrsh,    orangeproc,
            grpfrtfrsh,    grpfrtproc,
            orangejuic,    grpfrtjuic,
            nonfedsla ,    fedbeefsla,
            beefyearli,    calfslaugh,
            cullbeefco,    milk      ,
            culldairyc,    hogslaught,
            feederpig ,    cullsow   ,
            lambslaugh,    lambfeerde,
            cullewes  ,    wool      ,
            woolincpay,    unshrnlamb,
            otherlives,    soybeanmea,
            soybeanoil,    fedbeef   ,
            nonfedbeef,    veal      ,
            pork      ,    fluidmilk ,
            butter    ,    amcheese  ,
            otcheese  ,    evapcondm ,
            icecream  ,    nonfatdrym,
            cottageche,    skimmilk  ,
            cream     ,    hfcs      ,
            beverages ,    confection,
            baking    ,    canning   ,
            refsugar  ,    glutenfeed,
            starch    ,    canerefini,
            cornoil   ,    ethanol   ,
            cosyrup   ,    dextrose  ,
            frozenpot ,    driedpot  ,
            chippot   ,    cropland  ,
            pasture   ,    aums      ,
            forest    ,    water     ,
            labor     ,    crp       ,
            wetland   ,    addland   ,
            nitrogen  ,    potassium ,
            phosporous,    limein    ,
            othervaria,    publicgraz,
            customoper,    chemicalco,
            seedcost  ,    capital   ,
            repaircost,    vetandmedi,
            marketing ,    insurance ,
            machinery ,    management,
            landtaxes ,    generalove,
            noncashvar,    mgt       ,
            fuelandoth,    cropinsur ,
            landrent  ,    setaside  ,
            blank     ,    laborinhou,
            nitrate   ,    phosphate ,
            potash    ,    fertappl  ,
            plants    ,    starter   ,
            harvnhaul ,    picknhaul ,
            gradenpack,    pack      ,
            haul      ,    machines  ,
            seed      ,    custhire  ,
            anhydrous ,    bins      ,
            lime      ,    condition ,
            wire      ,
            pesticide ,    herbicide ,
            fungicide ,    fumigant  ,
            irrigcost ,    drip      ,
            stake     ,    string    ,
            buckets   ,    containers,
            laborcost ,    machtruck ,
            plastic   ,    tieplants ,
            overhead  ,    frostprotc,
            treecare  ,    miticide  ,
            citrusoil ,    weedcontrl,
            pruning   ,    irrigation,
            misccost  ,    profit    ,
            complianc ,    validnun  ,
            proccost  ,    trancost  ,
            noprofit  ,    uplimit   ,
            miscinput ,    maximum   ,
            minimum   ,    total     ,
            totalps   ,    cs        ,
            grndtot   ,    prodn     ,
            procs     ,    obj       ,
            feedmix0  ,    repair    ,
            market    ,    catgrain0 ,
            catgrain1 ,    cropresidu,
            livehaul  ,    bedding   ,
            highprotca,    fuelnelec ,
            miscell   ,    manurecred,
            taxesninsr,    hiredmanag,
            interest  ,    capreplace,
            operatecap,    othernlcap,
            chicken   ,    broilers  ,
            proteinsup,    chickcost ,
            broilgrn0 ,    broilpro0 ,
            growpymt  ,    fuelnlitt ,
            service   ,    taxinsint ,
            steercalve,    heifcalve ,
            steeryearl,    heifyearl ,
            cowgrain0 ,    cowhipro0 ,
            saltminer ,    feedmix   ,
            cottonseed,    rangecubes,
            commision ,    eggs      ,
            pulletcost,    contrpymt ,
            blendpadj ,    egggrain0 ,
            eggpro0   ,    fpggrain0 ,
            fpgproswn0,    fpggrain1 ,
            fargrain0 ,    farproswn0,
            fargrain1 ,    fingrain0 ,
            finproswn0,    fingrain1 ,
            vealers   ,    milkrepcer,
            dairycon0 ,    dairyby   ,
            milkhaul  ,    ai        ,
            dhia      ,    dairysup  ,
            dairyass  ,    dcalves   ,
            sheepgrn0 ,    sheeppro0 ,
            deathloss ,    sheartag  ,
            beefhyearl,    fueluberep,
            wheatpastu,    stockpro0 ,
            beefsyearl,    turkey    ,
            turkeygrn0,    turkeypro0,
            turkeys   ,    poultcost  /


PRIMARY(ALLI)      PRIMARY PRODUCTS
          / cotton    ,    soybeans  ,
            wheat     ,    rice      ,
            corn      ,    cornsorg  ,
            sorghum   ,    barley    ,
            oats      ,    silage    ,
            hay       ,    sugarcane ,
            sugarbeet ,    potatoes  ,
            tomatofrsh,    tomatoproc,
            orangefrsh,    orangeproc,
            grpfrtfrsh,    grpfrtproc,
            nonfedsla ,    fedbeefsla,
            beefyearli,    calfslaugh,
            steercalve,    heifcalve ,
            steeryearl,    heifyearl ,
            beefsyearl,    beefhyearl,
            cullbeefco,    otherlives,
            milk      ,    culldairyc,
            dcalves   ,    vealers   ,
            hogslaught,    feederpig ,
            cullsow   ,    lambslaugh,
            lambfeerde,    cullewes  ,
            wool      ,    woolincpay,
            unshrnlamb,    broilers  ,
            eggs      ,    turkeys    /


CROP(PRIMARY)      CROPS
        /   cotton    ,    corn      ,
            cornsorg  ,    soybeans  ,
            wheat     ,    sorghum   ,
            rice      ,    barley    ,
            oats      ,    silage    ,
            hay       ,    sugarcane ,
            sugarbeet ,    potatoes  ,
            tomatofrsh,    tomatoproc,
            orangefrsh,    orangeproc,
            grpfrtfrsh,    grpfrtproc /


C(CROP)             FARM PROGRAM CROPS
        /   cotton    ,    corn      ,
            soybeans  ,    wheat     ,
            sorghum   ,    rice      ,
            barley    ,    oats       /


LIVESTOCK(PRIMARY) LIVESTOCK PRODUCTS
        /   otherlives,    culldairyc,
            cullbeefco,    milk      ,
            hogslaught,    feederpig ,
            beefyearli,    calfslaugh,
            nonfedsla ,    fedbeefsla,
            cullsow   ,    lambslaugh,
            lambfeerde,    cullewes  ,
            wool      ,    woolincpay,
            unshrnlamb,    steercalve,
            heifcalve ,    steeryearl,
            heifyearl ,    broilers  ,
            eggs      ,    beefsyearl,
            beefhyearl,    turkeys   ,
            dcalves   ,    vealers    /



SECONDARY(ALLI)    PROCESSED PRODUCTS
        /   soybeanmea,    soybeanoil,
            fedbeef   ,    nonfedbeef,
            pork      ,    chicken   ,
            turkey    ,    veal      ,
            fluidmilk ,    butter    ,
            amcheese  ,    otcheese  ,
            icecream  ,    nonfatdrym,
            evapcondm ,    cottageche,
            skimmilk  ,    cream     ,
            canerefini,    hfcs      ,
            beverages ,    confection,
            baking    ,    canning   ,
            refsugar  ,    glutenfeed,
            starch    ,    cornoil   ,
            ethanol   ,    cosyrup   ,
            dextrose  ,    frozenpot ,
            driedpot  ,    chippot   ,
            orangejuic,    grpfrtjuic,
            feedmix0  ,    catgrain0 ,
            catgrain1 ,    highprotca,
            cowgrain0 ,    cowhipro0 ,
            rangecubes,    fpggrain0 ,
            fpgproswn0,    fargrain0 ,
            fpggrain1 ,    fargrain1 ,
            fingrain1 ,    farproswn0,
            dairycon0 ,    fingrain0 ,
            finproswn0,    turkeygrn0,
            turkeypro0,    egggrain0 ,
            eggpro0   ,    broilgrn0 ,
            broilpro0 ,    sheepgrn0 ,
            sheeppro0 ,    stockpro0  /



COST(ALLI)          BUDGET COST ITEMS
        /   complianc ,    misccost  ,
            proccost  ,    profit     /


INPUT(ALLI)    NATIONAL INPUTS
        /   nitrogen  ,    potassium ,
            trancost  ,    phosporous,
            othervaria,    publicgraz,
            customoper,    chemicalco,
            seedcost  ,    capital   ,
            repaircost,    vetandmedi,
            marketing ,    insurance ,
            machinery ,    management,
            landtaxes ,    generalove,
            noncashvar,    mgt       ,
            fuelandoth,    cropinsur ,
            landrent  ,    setaside  ,
            blank     ,    laborinhou,
            irrigation,    limein    ,
            nitrate   ,    phosphate ,
            potash    ,    fertappl  ,
            plants    ,    starter   ,
            harvnhaul ,    picknhaul ,
            gradenpack,    pack      ,
            haul      ,    machines  ,
            misccost  ,    seed      ,
            custhire  ,    anhydrous ,
            bins      ,    lime      ,
            condition ,    wire      ,
            pesticide ,    herbicide ,
            fungicide ,    fumigant  ,
            irrigcost ,    drip      ,
            stake     ,    string    ,
            buckets   ,    containers,
            laborcost ,    machtruck ,
            plastic   ,    tieplants ,
            overhead  ,    frostprotc,
            treecare  ,    miticide  ,
            citrusoil ,    weedcontrl,
            pruning   ,    market    ,
            repair    ,    cropresidu,
            livehaul  ,    bedding   ,
            fuelnelec ,    miscell   ,
            manurecred,    taxesninsr,
            hiredmanag,    interest  ,
            capreplace,    operatecap,
            othernlcap,    chickcost ,
            growpymt  ,    fuelnlitt ,
            service   ,    taxinsint ,
            saltminer ,    feedmix   ,
            cottonseed,    rangecubes,
            commision ,    pulletcost,
            contrpymt ,    blendpadj ,
            milkhaul  ,    ai        ,
            dhia      ,    dairysup  ,
            dairyass  ,    dairyby   ,
            deathloss ,    sheartag  ,
            fueluberep,    wheatpastu,
            poultcost ,    milkrepcer /


LANDTYPE(ALLI)         LAND TYPES

        /   cropland  ,    pasture   ,
            aums      ,    crp       ,
            wetland                   /


LANDTWO(ALLI)         LAND TYPES

        /   cropland  ,    pasture    /


LANDITEM               LAND SUPPLY PARAMETERS

        /   price     ,    elasticity,
            quantity                  /


LABORITEM              LABOR SUPPLY PARAMETERS

        /   familymax ,    familyprc ,
            hireq     ,    hirep     ,
            hiremax   ,    hireelas   /


WATERITEM              WATER SUPPLY PARAMETERS

        /   well      ,    surface   ,
            fixedmax  ,    fixedprc  ,
            pumpq     ,    pumpprice ,
            pumpmax   ,    pumpelas   /


AUMSITEM               AUMS SUPPLY PARAMETERS

        /   publicmax ,    publicprc ,
            privateq  ,    privatep  ,
            privatelas,    privatemax /


*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

*  BUDGET SETUP -- LIVESTOCK

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

ANIMAL           NAMES OF LIVESTOCK BUDGETS
         /  beefcows  ,    cowcalf   ,
            beeffeed  ,    dairy     ,
            hogfarrow ,    feedpig   ,
            pigfinish ,    farfin79a ,
            sheep     ,    pigfin79a ,
            othlvstk  ,    fdrpig79a ,
            feedlot79 ,    broiler   ,
            egg       ,    stockscav ,
            stockhcav ,    stocksyea ,
            stockhyea ,    turkey    ,
            vealcalf                  /


LIVETECH      LIVESTOCK TECHNOLOGY ALTERNATIVES

                 /0*10/

PROCESSALT       PROCESSING ALTERNATIVES

         /  beverage2 ,    beverage3 ,
            corn-sorg1,    corn-sorg2,
            beverage4 ,    confectin2,
            confectin3,    confectin4,
            canning2  ,    canning3  ,
            canning4  ,    baking2   ,
            baking3   ,    baking4   ,
            wetmill   ,    gluttosbm ,
            hfcs      ,    csyrup    ,
            dextrose  ,    ethanol   ,
            beverages ,    confection,
            canning   ,    baking    ,
            refsugar1 ,    refsugar2 ,
            canerefine,    soycrush1 ,
            soycrush2 ,    hogtopork ,
            broilchick,    turkeyproc,
            nfslatonf ,    fslatofbe ,
            caftoveal ,    grain1    ,
            grain2    ,    grain3    ,
            dairysup1 ,    dairysup2 ,
            dairysup3 ,    dairysup4 ,
            dairysup5 ,    dairysup6 ,
            catpro1   ,    catpro2   ,
            catpro3   ,    catpro4   ,
            loproswn1 ,    loproswn2 ,
            hiproswn1 ,    catprohi  ,
            sowtopork ,    grain1a   ,
            grain1b   ,    grain1c   ,
            butterpow ,    fluidmlk1 ,
            evapomilk ,    juicegrpft,
            fluidmlk2 ,    icecream1 ,
            icecream2 ,    amcheese  ,
            otcheese  ,    cottage   ,
            clcowsla  ,    bcafsla   ,
            dcowsla   ,    bfhefsla  ,
            dcafsla   ,    frozen-pot,
            dehydr-pot,    chip-pot  ,
            ftomtoproc,    juiceorang,
            fmix1965  ,    fmix1966  ,
            fmix1967  ,    fmix1968  ,
            fmix1969  ,    fmix1970  ,
            fmix1971  ,    fmix1972  ,
            fmix1973  ,    fmix1974  ,
            fmix1975  ,    fmix1976  ,
            fmix1977  ,    fmix1978  ,
            fmix1979  ,    fmix1980  ,
            fmix1981  ,    fmix1982  ,
            fmix1983  ,    fmix1984  ,
            fmix1985  ,    fmix1986  ,
            fmix1987  ,    fmix1988  ,
            fmix1989  ,    fmix1990  ,
            fmix1991  ,    fmix1992  ,
            fmix1965s ,    fmix1966s ,
            fmix1967s ,    fmix1968s ,
            fmix1969s ,    fmix1970s ,
            fmix1971s ,    fmix1972s ,
            fmix1973s ,    fmix1974s ,
            fmix1975s ,    fmix1976s ,
            fmix1977s ,    fmix1978s ,
            fmix1979s ,    fmix1980s ,
            fmix1981s ,    fmix1982s ,
            fmix1983s ,    fmix1984s ,
            fmix1985s ,    fmix1986s ,
            fmix1987s ,    fmix1988s ,
            fmix1989s ,    fmix1990s ,
            fmix1991s ,    fmix1992s ,
            catgrnmix0,    catgrnmix1,
            catgrnmix2,    catgrnmix3,
            catgrnmix4,    catgrnmix5,
            catgrnmix6,    catgrnmix7,
            catgrnmix8,    catgrnmix9,
            cowgrnmix0,    cowgrnmix1,
            cowgrnmix2,    cowgrnmix3,
            cowgrnmix4,    cowgrnmix5,
            cowgrnmix6,    cowgrnmix7,
            cowgrnmix8,    cowgrnmix9,
            cowgrnmi10,    cowgrnmi11,
            cowpromix0,    cowpromix1,
            cowpromix2,    rangcbmix0,
            fdpgrnmix0,    fdpgrnmix1,
            fdpgrnmix2,    fdpgrnmix3,
            fdpgrnmix4,    fdpgrnmix5,
            fdppromix0,    fdppromix1,
            fdppromix2,    fdppromix3,
            fdppromix4,    fdppromix5,
            fdppromix6,    fdppromix7,
            fdppromix8,    fdppromix9,
            fdppromi10,    fdppromi11,
            fedpigpro1,    fargrnmix0,
            fargrnmix1,    fargrnmix2,
            fargrnmix3,    fargrnmix4,
            fargrnmix5,    farpromix0,
            farpromix1,    farpromix2,
            farpromix3,    farpromix4,
            farpromix5,    farpromix6,
            farpromix7,    farpromix8,
            farpromix9,    farpromi10,
            farpromi11,    fingrnmix0,
            fingrnmix1,    fingrnmix2,
            fingrnmix3,    fingrnmix4,
            fingrnmix5,    finpromix0,
            finpromix1,    finpromix2,
            finpromix3,    finpromix4,
            finpromix5,    finpromix6,
            finpromix7,    finpromix8,
            finpromix9,    finpromi10,
            finpromi11,    darconmix0,
            darconmix1,    darconmix2,
            darconmix3,    darconmix4,
            darconmix5,    darybymix0,
            egggrnmix0,    egggrnmix1,
            egggrnmix2,    egggrnmix3,
            egggrnmix4,    eggpromix0,
            eggpromix1,    eggpromix2,
            eggpromix3,    eggpromix4,
            eggpromix5,    eggpromix6,
            eggpromix7,    eggpromix8,
            eggpromix9,    brlgrnmix0,
            brlgrnmix1,    brlgrnmix2,
            brlgrnmix3,    brlpromix0,
            brlpromix1,    brlpromix2,
            brlpromix3,    brlpromix4,
            brlpromix5,    brlpromix6,
            brlpromix7,    trkgrnmix0,
            trkgrnmix1,    trkgrnmix2,
            trkgrnmix3,    trkpromix0,
            trkpromix1,    trkpromix2,
            trkpromix3,    trkpromix4,
            trkpromix5,    trkpromix6,
            trkpromix7,    shpgrnmix0,
            shppromix0,    shppromix1,
            shppromix2,    stkpromix0,
            stkpromix1,    stkpromix2,
            beefsconvt,    beefhconvt,
            dclftobeef                /


SORGFEED(PROCESSALT)     SORGHUM FEED MIXING PROCESSING ALTERNATIVES

         /  fmix1965s ,    fmix1966s ,
            fmix1967s ,    fmix1968s ,
            fmix1969s ,    fmix1970s ,
            fmix1971s ,    fmix1972s ,
            fmix1973s ,    fmix1974s ,
            fmix1975s ,    fmix1976s ,
            fmix1977s ,    fmix1978s ,
            fmix1979s ,    fmix1980s ,
            fmix1981s ,    fmix1982s ,
            fmix1983s ,    fmix1984s ,
            fmix1985s ,    fmix1986s ,
            fmix1987s ,    fmix1988s ,
            fmix1989s ,    fmix1990s ,
            fmix1991s ,    fmix1992s  /

MIXFEED(PROCESSALT)     FEED MIXING PROCESSING ALTERNATIVES
         /  grain1    ,    grain2    ,
            grain3    ,    dairysup1 ,
            dairysup2 ,    dairysup3 ,
            dairysup4 ,    dairysup5 ,
            dairysup6 ,    catpro1   ,
            catpro2   ,    catpro3   ,
            catpro4   ,    loproswn1 ,
            loproswn2 ,    hiproswn1 ,
            catprohi  ,    grain1a   ,
            grain1b   ,    grain1c   ,
            fmix1965  ,    fmix1966  ,
            fmix1967  ,    fmix1968  ,
            fmix1969  ,    fmix1970  ,
            fmix1971  ,    fmix1972  ,
            fmix1973  ,    fmix1974  ,
            fmix1975  ,    fmix1976  ,
            fmix1977  ,    fmix1978  ,
            fmix1979  ,    fmix1980  ,
            fmix1981  ,    fmix1982  ,
            fmix1983  ,    fmix1984  ,
            fmix1985  ,    fmix1986  ,
            fmix1987  ,    fmix1988  ,
            fmix1989  ,    fmix1990  ,
            fmix1991  ,    fmix1992  ,
            fmix1965s ,    fmix1966s ,
            fmix1967s ,    fmix1968s ,
            fmix1969s ,    fmix1970s ,
            fmix1971s ,    fmix1972s ,
            fmix1973s ,    fmix1974s ,
            fmix1975s ,    fmix1976s ,
            fmix1977s ,    fmix1978s ,
            fmix1979s ,    fmix1980s ,
            fmix1981s ,    fmix1982s ,
            fmix1983s ,    fmix1984s ,
            fmix1985s ,    fmix1986s ,
            fmix1987s ,    fmix1988s ,
            fmix1989s ,    fmix1990s ,
            fmix1991s ,    fmix1992s ,
            catgrnmix0,    catgrnmix1,
            catgrnmix2,    catgrnmix3,
            catgrnmix4,    catgrnmix5,
            catgrnmix6,    catgrnmix7,
            catgrnmix8,    catgrnmix9,
            cowgrnmix0,    cowgrnmix1,
            cowgrnmix2,    cowgrnmix3,
            cowgrnmix4,    cowgrnmix5,
            cowgrnmix6,    cowgrnmix7,
            cowgrnmix8,    cowgrnmix9,
            cowgrnmi10,    cowgrnmi11,
            cowpromix0,    cowpromix1,
            cowpromix2,    rangcbmix0,
            fdpgrnmix0,    fdpgrnmix1,
            fdpgrnmix2,    fdpgrnmix3,
            fdpgrnmix4,    fdpgrnmix5,
            fdppromix0,    fdppromix1,
            fdppromix2,    fdppromix3,
            fdppromix4,    fdppromix5,
            fdppromix6,    fdppromix7,
            fdppromix8,    fdppromix9,
            fdppromi10,    fdppromi11,
            fedpigpro1,    fargrnmix0,
            fargrnmix1,    fargrnmix2,
            fargrnmix3,    fargrnmix4,
            fargrnmix5,    farpromix0,
            farpromix1,    farpromix2,
            farpromix3,    farpromix4,
            farpromix5,    farpromix6,
            farpromix7,    farpromix8,
            farpromix9,    farpromi10,
            farpromi11,    fingrnmix0,
            fingrnmix1,    fingrnmix2,
            fingrnmix3,    fingrnmix4,
            fingrnmix5,    finpromix0,
            finpromix1,    finpromix2,
            finpromix3,    finpromix4,
            finpromix5,    finpromix6,
            finpromix7,    finpromix8,
            finpromix9,    finpromi10,
            finpromi11,    darconmix0,
            darconmix1,    darconmix2,
            darconmix3,    darconmix4,
            darconmix5,    egggrnmix0,
            egggrnmix1,    egggrnmix2,
            egggrnmix3,    egggrnmix4,
            eggpromix0,    eggpromix1,
            eggpromix2,    eggpromix3,
            eggpromix4,    eggpromix5,
            eggpromix6,    eggpromix7,
            eggpromix8,    eggpromix9,
            brlgrnmix0,    brlgrnmix1,
            brlgrnmix2,    brlgrnmix3,
            brlpromix0,    brlpromix1,
            brlpromix2,    brlpromix3,
            brlpromix4,    brlpromix5,
            brlpromix6,    brlpromix7,
            trkgrnmix0,    trkgrnmix1,
            trkgrnmix2,    trkgrnmix3,
            trkpromix0,    trkpromix1,
            trkpromix2,    trkpromix3,
            trkpromix4,    trkpromix5,
            trkpromix6,    trkpromix7,
            shpgrnmix0,    shppromix0,
            shppromix1,    shppromix2,
            stkpromix0,    stkpromix1,
            stkpromix2                /


*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

*  BUDGET SETUP -- CROPS

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

        WTECH               IRRIGATION ALTERNATIVES
                                 /DRYLAND,IRRIG/

        CTECH               CROP BUDGET ALTERNATIVES
                                 /BASE,NONPART,PARTICIP/

        TECH                CROP TECHNOLOGY ALTERNATIVES
                               /0*10/

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

*  MISCELANEOUS

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

        SDITEM             SUPPLY DEMAND CURVE PARAMETERS
                              /PRICE,QUANTITY,ELASTICITY,MAXQ,MINQ
                               ,TFAC,CONSTANT1,CONSTANT2,CONSTANT3,BOX/

        CRPMIXALT          REGIONAL CROP MIX ALTERNATIVES
                               /1960*1992/

        NATMIXALT          PRIMARY PRODUCT MIX ALTERNATIVES ACROSS REGIONS
                               /1960*1992/ ;

SETS
         ITER          ITERATION COUNT /1*50/;

PARAMETER  RESULT(C,ITER,*) ITERATION  RESULTS ;
PARAMETER  TOLER(C)         TOLERANCE LEVEL ;

SCALAR  TOL    /0.0015/;
SCALAR  CONVERGE     /1/;



sets
mixtype /number    mixes constrained by the number of budgets
         quant     mixes constrained by quantity produced in region
/
;
parameter
livemix(animal,mixtype)   whether the mix is a quantity or number constraint
;

$ontext
#user model library stuff
Main topic ASM Model
Featured item 1 Set
Featured item 2 Code seperation
Featured item 3 ASM sector model
Description
Defines sets that will be used in ASM model
$offtext
