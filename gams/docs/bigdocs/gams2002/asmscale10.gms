$ontext

Scaling data for ASM model

$offtext

SCALAR  SCALOBJ        OBJECTIVE FUNCTION SCALAR   /1./
        SCALPROD       CROP PRODUCTION SCALE       /1./
        SCALPROC       PROCESSING SCALE            /1./
        SCALLIVE       LIVESTOCK PRODUCTION SCALE  /1./
        SCALMIX        MIX SCALING                 /1./
;
parameter scale(alli) scaling factors ;
   scale(alli)=1.;
   scalobj=1000.;
   scalprod=1000.;
   scalmix=1000.;
   scalproc=1000.;
   scallive=1000.;
   scale(primary)=1000.;
   scale("water")=1000.;
   scale("aums")=1000.;
   scale(landtype)=1000.;
   scale("labor")=1000.;
   scale(input)=1000.;
   scale(secondary)=1000.;
   scale("cotton")=1000.;
   scale("corn")=1000000.;
   scale("soybeans")=100000.;
   scale("wheat")=100000.;
   scale("sorghum")=1000000.;
   scale("rice")=10000.;
   scale("barley")=100000.;
   scale("oats")=10000.;
   scale("otherlives")=1000.;
   scale("eggs")=1000.;
   scale("broilers")=1000.;
   scale("turkeys")=1000.;
   scale("cullewes")=1000.;
   scale("wool")=10000.;
   scale("soybeanmea")=100000.;
   scale("soybeanoil")=10000.;
   scale("fluidmilk")=100000.;
   scale("fedbeef")=100000.;
   scale("nonfedbeef")=100000.;
   scale("pork")=1000000.;
   scale("chicken")=1000000.;
   scale("turkey")=1000000.;
   scale("butter")   =1000000.;
   scale("amcheese")=1000000.;
   scale("otcheese")=1000000.;
   scale("icecream")=1000000.;
   scale("nonfatdrym")=1000000.;
   scale("evapcondm")=1000000.;
   scale("cottageche")=1000000.;
   scale("beverages")=10000.;
   scale("baking")=1000000.;
        SCALPROD = 1;
        SCALPROC = 1;
        SCALLIVE = 1;
        SCALMIX  = 1;
parameter pscale(alli   ) primary commodity scaling factors  /
                   COTTON                   1000.00
                   CORN                   100000.00
                   SOYBEANS               100000.00
                   WHEAT                   10000.00
                   SORGHUM                 10000.00
                   RICE                   100000.00
                   BARLEY                  10000.00
                   OATS                    10000.00
                   OTHERLIVES              10000.00
                   CULLDAIRYC              10000.00
                   CULLBEEFCO              10000.00
                   MILK                   100000.00
                   SILAGE                  10000.00
                   HAY                      1000.00
                   HOGSLAUGHT              10000.00
                   FEEDERPIG               10000.00
                   BEEFYEARLI               10000.00
                   BEEFHYEARL             10000.00
                   CALFsLAUGH              10000.00
                   NONFEDSLA               10000.00
                   FEDBEEFSLA              10000.00
                   CULLSOW                  1000.00
                   LAMBSLAUGH               1000.00
                   LAMBFEERDE               1000.00
                   CULLEWES                 1000.00
                   WOOL                     1000.00
                   WOOLINCPAY             100000.00
                   UNSHRNLAMB              10000.00
                   SUGARCANE                1000.00
                   SUGARBEET                1000.00
                   POTATOES               100000.00
                   TOMATOFRSH            1000000.00
                   ORANGEFRSH             100000.00
                   ORANGEPROC             100000.00
                   GRPFRTFRSH             100000.00
                   GRPFRTPROC             100000.00
                   TOMATOPROC              10000.00
                   STEERCALVE               10000.00
                   HEIFCALVE                10000.00
                   STEERYEARL               10000.00
                   HEIFYEARL                10000.00
                   VEALERS                  10000.00
                   DCALVES                 1000.00
                   BEEFSYEARL              100000.00
                   TURKEYS                  1000000.00
                   BROILERS                 1000000.00
                   EGGS                 10.00
/
parameter sscale(alli)  Secondary commodity scaling factors/
                   ORANGEJUIC            1000000.00
                   GRPFRTJUIC            1000000.00
                   SOYBEANMEA              10000.00
                   SOYBEANOIL              1000.00
                   FLUIDMILK                100000.00
                   FEDBEEF                  1000.00
                   VEAL                     1000.00
                   NONFEDBEEF               1000.00
                   PORK                     10000.00
                   BUTTER                 100000.00
                   AMCHEESE                100000.00
                   OTCHEESE                100000.00
                   ICECREAM                1000000.00
                   NONFATDRYM              100000.00
                   evapcondm               100000.00
                   COTTAGECHE               1000000.00
                   SKIMMILK                 1000000.00
                   CREAM                    100000.00
                   HFCS                   10000.00
                   BEVERAGES             1000000.00
                   CONFECTION            1000000.00
                   BAKING                1000000.00
                   CANNING               100000.00
                   REFSUGAR               100000.00
                   GLUTENFEED              1000.00
                   CHICKEN                  100000.00
                   TURKEY                100000.00
                   HIGHPROTCA              10000.00
                   TURKEYGRN0             100000.00
                   TURKEYPRO0              10000.00
                   STOCKPRO0                10000.00
                   SHEEPGRN0                10000.00
                   SHEEPPRO0                10000.00
                   CATGRAIN0              100000.00
                   CATGRAIN1              100000.00
                   COWGRAIN0              100000.00
                   COWHIPRO0               10000.00
                   BROILGRN0              10000.00
                   BROILPRO0              10000.00
                   EGGGRAIN0              100000.00
                   EGGPRO0                 10000.00
                   RANGECUBES               100000.00
                   FPGGRAIN0              100000.00
                   FPGGRAIN1              100000.00
                   FPGPROSWN0              10000.00
                   FARGRAIN0               100000.00
                   FARGRAIN1               100000.00
                   FARPROSWN0               10000.00
                   FINGRAIN0              100000.00
                   FINGRAIN1              100000.00
                   FINPROSWN0             10000.00
                   DAIRYCON0              100000.00
                   FEEDMIX0              100000.00
                   STARCH                10000.00
                   CANEREFINI            1000.00
                   CORNOIL                  100.00
                   ETHANOL                 1000.00
                   COSYRUP               10000.0
                   DEXTROSE              10000.00
                   FROZENPOT               100000.00
                   DRIEDPOT                 10000.00
                   CHIPPOT                 100000.00/
parameter iscale(*   ) Input Scaling factors/
                   NITROGEN                 1000.00
                   POTASSIUM                1000.00
                   PHOSPOROUS               1000.00
                   LIMEIN                   1000.00
                   OTHERVARIA               1000.00
                   PUBLICGRAZ               1000.00
                   CUSTOMOPER               1000.00
                   CHEMICALCO               1000.00
                   SEEDCOST                 1000.00
                   CAPITAL                  1000.00
                   REPAIRCOST               1000.00
                   VETANDMEDI               1000.00
                   MARKETING                1000.00
                   INSURANCE                1000.00
                   MACHINERY                1000.00
                   MANAGEMENT               1000.00
                   LANDTAXES                1000.00
                   GENERALOVE               1000.00
                   NONCASHVAR               1000.00
                   MGT                      1000.00
                   FUELANDOTH               1000.00
                   CROPINSUR                1000.00
                   LANDRENT                 1000.00
                   SETASIDE                 1000.00
                   BLANK                    1000.00
                   LABORINHOU               1000.00
                   IRRIGATION               1000.00
                   FERTILIZER               1000.00
                   HARVEST                  1000.00
                   CUTTINGS                 1000.00
                   SOILTEST                 1000.00
                   COPPICE                  1000.00
                   PLOWING                  1000.00
                   DISCING                  1000.00
                   SITECLEAR                1000.00
                   MOWING                   1000.00
                   CAPITALR                 1000.00
                   NITRATE                  1000.00
                   PHOSPHATE                1000.00
                   POTASH                   1000.00
                   FERTAPPL                 1000.00
                   PLANTS                   1000.00
                   STARTER                  1000.00
                   HARVNHAUL                1000.00
                   PICKNHAUL                1000.00
                   GRADENPACK               1000.00
                   PACK                     1000.00
                   HAUL                     1000.00
                   MACHINES                 1000.00
                   SEED                     1000.00
                   CUSTHIRE                 1000.00
                   ANHYDROUS                1000.00
                   BINS                     1000.00
                   LIME                     1000.00
                   CONDITION                1000.00
                   WIRE                     1000.00
                   PESTICIDE                1000.00
                   HERBICIDE                1000.00
                   FUNGICIDE                1000.00
                   FUMIGANT                 1000.00
                   IRRIGCOST                1000.00
                   DRIP                     1000.00
                   STAKE                    1000.00
                   STRING                   1000.00
                   BUCKETS                  1000.00
                   CONTAINERS               1000.00
                   LABORCOST                1000.00
                   MACHTRUCK                1000.00
                   PLASTIC                  1000.00
                   TIEPLANTS                1000.00
                   OVERHEAD                 1000.00
                   FROSTPROTC               1000.00
                   TREECARE                 1000.00
                   MITICIDE                 1000.00
                   CITRUSOIL                1000.00
                   WEEDCONTRL               1000.00
                   PRUNING                  1000.00
                   REPAIR                   1000.00
                   MARKET                   1000.00
                   CROPRESIDU               1000.00
                   LIVEHAUL                 1000.00
                   BEDDING                  1000.00
                   FUELNELEC                1000.00
                   MISCELL                  1000.00
                   MANURECRED               1000.00
                   TAXESNINSR               1000.00
                   HIREDMANAG               1000.00
                   INTEREST                 1000.00
                   CAPREPLACE               1000.00
                   OPERATECAP               1000.00
                   OTHERNLCAP               1000.00
                   CHICKCOST                1000.00
                   GROWPYMT                 1000.00
                   FUELNLITT                1000.00
                   SERVICE                  1000.00
                   TAXINSINT                1000.00
                   SALTMINER                1000.00
                   FEEDMIX                  1000.00
                   COTTONSEED               1000.00
                   COMMISION                1000.00
                   PULLETCOST               1000.00
                   CONTRPYMT                1000.00
                   BLENDPADJ                1000.00
                   MILKREPCER               1000.00
                   DAIRYBY                  1000.00
                   MILKHAUL                 1000.00
                   AI                       1000.00
                   DHIA                     1000.00
                   DAIRYSUP                 1000.00
                   DAIRYASS                 1000.00
                   DEATHLOSS                1000.00
                   SHEARTAG                 1000.00
                   FUELUBEREP               1000.00
                   WHEATPASTU               1000.00
                   POULTCOST                1000.00
              /
parameter ascale(*)
/                  CROPLAND                 1000.00
                   ADDLAND                     1.00
                   PASTURE                  1000.00
                   AUMS                     1000.00
                   CRP                      1000.00
                   WETLAND                  1000.00
                   MISCCOST                 1000.00
                   PROFIT                      1.00
                   COMPLIANC                   1.00
                   VALIDNUM                    1.00
                   PROCCOST                    1.00
                   TRANCOST                    1.00
                   NOPROFIT                    1.00
                   UPLIMIT                     1.00
                   MISCINPUT                   1.00
                   MAXIMUM                     1.00
                   MINIMUM                     1.00
                   WATER                    1000.00
                   LABOR                    1000.00
                   TOTALPS                     1.00
                   CS                          1.00
                   GRNDTOT                     1.00
                   PRODN                       1.00
                   PROCS                       1.00
                   OBJ                         1.00
/
;
scalobj=1;
sscale(secondary)$(sscale(secondary) le 0.00001) =1;
pscale(primary  )$(pscale(primary  ) le 0.00001) =1;
iscale(input    )$(iscale(input    ) le 0.00001) =1;
parameter bscale(*) scaling factors;
parameter cscale(*) scaling factors;
parameter mscale(*) scaling factors;
ascale(landtype)=scale(landtype);
scale(alli)=1;
cscale(crop  )=scalprod;
bscale(processalt)=scalproc;
bscale("butterpow")=scalproc*100;
*in bscale mult to make bigger
bscale("hogtopork")=scalproc*10;
bscale("fmix1965")=scalproc*100;
bscale("fmix1966")=scalproc*100;
bscale("fmix1967")=scalproc*100;
bscale("fmix1968")=scalproc*100;
bscale("fmix1969")=scalproc*100;
bscale("fmix1970")=scalproc*100;
bscale("fmix1971")=scalproc*100;
bscale("fmix1972")=scalproc*100;
bscale("fmix1973")=scalproc*100;
bscale("fmix1974")=scalproc*100;
bscale("fmix1975")=scalproc*100;
bscale("fmix1976")=scalproc*100;
bscale("fmix1977")=scalproc*100;
bscale("fmix1978")=scalproc*100;
bscale("fmix1979")=scalproc*100;
bscale("fmix1980")=scalproc*100;
bscale("fmix1981")=scalproc*100;
bscale("fmix1982")=scalproc*100;
bscale("fmix1983")=scalproc*100;
bscale("fmix1984")=scalproc*100;
bscale("fmix1985")=scalproc*100;
bscale("fmix1986")=scalproc*100;
bscale("fmix1987")=scalproc*100;
bscale("fmix1988")=scalproc*100;
bscale("fmix1989")=scalproc*100;
bscale("fmix1990")=scalproc*100;
bscale("fmix1991")=scalproc*100;
bscale("fmix1992")=scalproc*100;
bscale("catpro1")=scalproc*10;
bscale("catpro3")=scalproc*10;
bscale("fluidmlk1")=scalproc*100;
bscale("fluidmlk2")=scalproc*100;
bscale("cowpromix0")=scalproc*10;
bscale("cowpromix2")=scalproc*10;
bscale("cowgrnmix0")=scalproc*100;
bscale("catgrnmix0")=scalproc*100;
bscale("catgrnmix1")=scalproc*100;
bscale("farpromix0")=scalproc*10;
bscale("farpromix6")=scalproc*10;
bscale("catgrnmix2")=scalproc*100;
bscale("rangcbmix0")=scalproc*100;
bscale("fdpgrnmix0")=scalproc*100;
bscale("fdpgrnmix1")=scalproc*100;
bscale("fdppromix0")=scalproc*10;
bscale("fdppromix6")=scalproc*10;
bscale("finpromix0")=scalproc*10;
bscale("finpromix6")=scalproc*10;
bscale("fingrnmix0")=scalproc*100;
bscale("fingrnmix1")=scalproc*100;
bscale("fargrnmix0")=scalproc*100;
bscale("fargrnmix1")=scalproc*100;
bscale("shppromix0")=scalproc*10;
bscale("shppromix2")=scalproc*10;
bscale("shpgrnmix0")=scalproc*100;
bscale("stkpromix0")=scalproc*10;
bscale("stkpromix2")=scalproc*10;
bscale("trkgrnmix0")=scalproc*100;
bscale("trkpromix0")=scalproc*10;
bscale("trkpromix4")=scalproc*10;
bscale("egggrnmix0")=scalproc*100;
bscale("eggpromix0")=scalproc*10;
bscale("eggpromix5")=scalproc*10;
bscale("brlgrnmix0")=scalproc*10;
bscale("brlpromix0")=scalproc*10;
bscale("brlpromix4")=scalproc*10;
bscale("darconmix0")=scalproc*10;
bscale("darconmix1")=scalproc*100;
bscale("darconmix2")=scalproc*100;
bscale("clcowsla" )=scalproc*10;
bscale("beefhconvt")=scalproc*10;
bscale("beefsconvt")=scalproc*10;
bscale("clcowsla" )=scalproc*10;
bscale("hfcs"     )=scalproc/100;
bscale("evapomilk" )=scalproc*100;
bscale("amcheese" )=scalproc*100;
bscale("otcheese" )=scalproc*100;
bscale("dextrose" )=scalproc/100;
bscale("beverages")=scalproc*1;
bscale("confection")=scalproc*1;
bscale("baking"    )=scalproc*1;
bscale("canning"   )=scalproc/10;
bscale("ethanol"   )=scalproc/100;
bscale("wetmill"   )=scalproc/10;
bscale("csyrup"    )=scalproc/100;
bscale("dlcowsla" )=scalproc*10;
bscale("bfhefsla" )=scalproc*10;
bscale("dcafsla" )=scalproc*10;
bscale("icecream2" )=scalproc*1000;
bscale("icecream1" )=scalproc*1000;
bscale("cottage"   )=scalproc*1000;
bscale("frozen-pot" )=scalproc*100;
bscale("dcowsla" )=scalproc*10;
bscale("chip-pot" )=scalproc*100;
bscale("dehydr-pot" )=scalproc*10;
bscale("gluttosbm")=scalproc/1000;
bscale("refsugar2")=scalproc/1000;
bscale("refsugar1")=scalproc/1000;
bscale("canerefine")=scalproc/10;
bscale("broilchick")=scalproc*100;
bscale("turkeyproc")=scalproc*100;
bscale("soycrush1")=scalproc/10;
bscale("soycrush2")=scalproc/10;
bscale(animal)=scallive;
bscale("egg" )=scallive*1000;
bscale("broiler" )=scallive*100;
bscale("turkey" )=scallive*100;
ascale("mix")=scalmix;
mscale(primary)=scalmix;
CROPBUDGET.scale(subreg,CROP,WTECH,CTECH,TECH)
   $(CCcBUDDATA(CROP,subreg,CROP,WTECH,ctech,TECH) GT 0.0)=cscale(crop);
LVSTBUDGET.scale(subreg,ANIMAL,LIVETECH)
       $ lBUDdata("profit",subreg,ANIMAL,LIVETECH)=bscale(animal );
LANDSUPPLS.scale(subreg,LANDTYPE,STEPS)=ascale(landtype);
*frompastur.scale(SUBREG)=ascale(cropland);
PROCESS.scale(PROCESSALT)=bscale(processalt);
WATERFIX.scale(subreg)=ascale("water");
WATERVAR.scale(subREG)= ascale("water");
WATERVARS.scale(subreg,STEPS)$sepag=1$ascale("water");
AUMSPUB.scale(subREG)=ascale("aums" )*10;
AUMSPRIV.scale(subREG)=ascale("aums" )*10;
AUMSPRIVS.scale(subreg,STEPS)$sepag=1$ascale("aums" );
FAMILY.scale(REGion)=ascale("labor");
HIRED.scale(REGion)=ascale("labor");
HIREDS.scale(region,STEPS)$sepag=1$ascale("labor");
DEMANDP.scale(PRIMARY)=pscale(primary);
DEMANDPS.scale(PRIMARY,STEPS)$sepag=1$pscale(primary);
IMPORTP.scale(PRIMARY)=pscale(primary);
IMPORTPS.scale(PRIMARY,STEPS)$sepag=1$pscale(primary);
EXPORTP.scale(PRIMARY)=pscale(primary);
EXPORTPS.scale(PRIMARY,STEPS)$sepag=1$pscale(primary);
DEMANDS.scale(SECONDARY)=sscale(secondary);
DEMANDSS.scale(SECONDARY,STEPS)$sepag=1$sscale(secondary);
IMPORTS.scale(SECONDARY)=sscale(secondary);
IMPORTSS.scale(SECONDARY,STEPS)$sepag=1$sscale(secondary);
EXPORTS.scale(SECONDARY)=sscale(secondary);
EXPORTSS.scale(SECONDARY,STEPS)$sepag=1$sscale(secondary);
*to increase multiply
MIXR.scale(subreg,CRPMIXALT)=1;
NATMIX.scale(PRIMARY,NATMIXALT)=1;
NATMIX.scale("broilers",NATMIXALT)=1;
NATMIX.scale("turkeys" ,NATMIXALT)=10;
NATMIX.scale("eggs" ,NATMIXALT)=1000;
NATMIX.scale("milk" ,NATMIXALT)=100/1;
NATMIX.scale("wool" ,NATMIXALT)=1/1;
NATMIX.scale("hogslaught" ,NATMIXALT)=1;
NATMIX.scale("fedbeefsla" ,NATMIXALT)=10;
CCCLOANP.scale(PRIMARY)=pscale(primary);
CCCLOANS.scale(SECONDARY)=sscale(secondary);
DEFPRODN.scale(primary)=pscale(primary);
PRDN5092.scale(primary)=pscale(primary)/10;
PRDN092.scale(primary)=pscale(primary)/10;
DIVPRODN.scale(primary)=pscale(primary   )/10;
ARTIF.scale(primary)=pscale(primary   )/10;
UNHARV.scale(primary)=pscale(primary   )/10;

csps.scale=1000000;
TWID.scale(CROP,subREG)=ascale("mix");
TOLR.scale(PRIMARY,subREG)=mscale(primary);


 objt.scale=1000000;
*  ASM PART
 PRIMARYBAL.scale(PRIMARY)=pscale(primary);
 SECONDBAL.scale(SECONDARY)=sscale(secondary);
 MAXLAND.scale(subreg,LANDTYPE)=ascale(landtype);
 LAND.scale(subreg,LANDTYPE)=ascale(landtype);
 WATERR.scale(subREG)=ascale("water"  );
 FIX.scale(subREG)=ascale("water"  );
 AUMSR.scale(subREG)=ascale("aums"   )*10;
 PUBAUMS.scale(subREG)=ascale("aums"   )*10;
 LABOR.scale(REGion)=ascale("labor"  );
 FAMILYLIM.scale(REGion)=ascale("labor"  );
 HIRELIM.scale(REGion)=ascale("labor"  );
 MIXREG.scale(CROP,subREG)=ascale("mix");
 MIXREGTOT.scale(subREG)=ascale("mix"  );
 MIXNAT.scale(PRIMARY,subREG)=mscale(primary);
 MIXNAT.scale("milk",subREG)=mscale("milk" )*1000;
 MIXNAT.scale("wool",subREG)=mscale("wool" )*1;
 MIXNAT.scale("eggs",subREG)=mscale("eggs" )*1;
 MIXNAT.scale("turkeys",subREG)=mscale("turkeys" )*1000;
 MIXNAT.scale("broilers",subREG)=mscale("broilers" )*100;
TOLR.scale("eggs" ,subREG)=mscale("eggs")*1/1000;
TOLR.scale("milk" ,subREG)=mscale("milk")*10;
TOLR.scale("wool" ,subREG)=mscale("wool")*10;
 FRMPROG.scale(CROP)=pscale(crop   );
 P5092.scale(CROP)=pscale(crop   )/10;
 P092.scale(CROP)=pscale(crop   )/10;
 DIVERT.scale(CROP)=pscale(crop   )/10;
 ARTIFICIAL.scale(CROP)=pscale(crop   )/10;
 UNHARVEST.scale(CROP)=pscale(crop   )/10;

$ontext
#user model library stuff
Main topic ASM Model
Featured item 1 Scale
Featured item 2 Code seperation
Featured item 3 ASM sector model
Description
Defines Scaling for ASM model
$offtext
