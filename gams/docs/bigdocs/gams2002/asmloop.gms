$ontext

Comparative analysis file for ASM model

$offtext

*Alternative Run File for Atrazine and Pendimethalin Ban
*Price-endogenous Model Specification of ASM

OPTION LP=CPLEX;
$OFFSYMLIST OFFSYMXREF
OPTION PROFILETOL=5;
OPTION SOLVEOPT=REPLACE;
SKIPINPUT =0;
*
*    Step 1
*    Define scenario sets for all technological changes
*     __________________________________________________
*
SET FPRUNS
/BASE         NO CHANGE,
 SOYBHERB     PENDIMETHALIN BAN ON SOYBEAN FIELDS,
 CORNHERB     ATRAZINE BAN ON CORN FIELDS,
 BOTHHERB     BOTH OF THE ABOVE TWO HERBICIDE RESTRICTIONS /;
*
*     Step 2
*    Define active scenario subset
*    _____________________________
*
SET FPRUN(FPRUNS)
   /BASE, SOYBHERB, CORNHERB, BOTHHERB /;
*  /BASE, CORNHERB, BOTHHERB /;
*
*    Step 3
*    Enter data
*     __________
*
PARAMETER ADJUST(ALLI,SUBREG,CROP,FPRUNS);
ADJUST(ALLI,SUBREG,CROP,FPRUNS)=0;

SET CHANGEITEM
/USEAREA   PERCENT OF CORN OR SOYBEAN LAND TO WHICH PESTICED WAS APPLIED,
 CHEMCOST  INCREASE IN CHEMICAL COSTS IN $ PER ACRE,
 YIELDLOSS PERCENT REDUCTION IN YIELDS
/;

TABLE ATRAZINE (SUBREG,CHANGEITEM)
                USEAREA   CHEMCOST  YIELDLOSS

northeast        0.544       3.750       0.023
lakestates       0.508       5.646       0.019
cornbelt         0.768       6.821       0.031
northplain       0.152       2.021       0.009
appalachia       0.608       2.844       0.019
southeast        0.283       1.487       0.021
southplain       0.705       7.540       0.094
mountain         0.376       0.962       0.014
;

ADJUST("CHEMICALCO",SUBREG,"CORN","CORNHERB")
   $ATRAZINE(SUBREG,"CHEMCOST")
   =ATRAZINE(SUBREG,"USEAREA") * ATRAZINE(SUBREG,"CHEMCOST");

ADJUST("CHEMICALCO",SUBREG,"CORN","BOTHHERB")
   $ATRAZINE(SUBREG,"CHEMCOST")
   =ATRAZINE(SUBREG,"USEAREA") * ATRAZINE(SUBREG,"CHEMCOST");

ADJUST("CORN",SUBREG,"CORN","CORNHERB")
   $ATRAZINE(SUBREG,"YIELDLOSS")
   =ATRAZINE(SUBREG,"USEAREA") * ATRAZINE(SUBREG,"YIELDLOSS");

ADJUST("CORN",SUBREG,"CORN","BOTHHERB")
   $ATRAZINE(SUBREG,"YIELDLOSS")
   =ATRAZINE(SUBREG,"USEAREA") * ATRAZINE(SUBREG,"YIELDLOSS");

TABLE PENDIMETH (SUBREG,CHANGEITEM)
               USEAREA   CHEMCOST

lakestates       0.048       2.957
cornbelt         0.244       5.260
northplain       0.017      -0.085
appalachia       0.170       3.987
southeast        0.013       5.289
deltastate       0.040       0.033
;

ADJUST("CHEMICALCO",SUBREG,"SOYBEANS","SOYBHERB")
   $PENDIMETH(SUBREG,"CHEMCOST")
   =PENDIMETH(SUBREG,"USEAREA") * PENDIMETH(SUBREG,"CHEMCOST");

ADJUST("CHEMICALCO",SUBREG,"SOYBEANS","BOTHHERB")
   $PENDIMETH(SUBREG,"CHEMCOST")
   =PENDIMETH(SUBREG,"USEAREA") * PENDIMETH(SUBREG,"CHEMCOST");
*
*    Step 4
*    Define sets and parameters for comparative report writing
*     _________________________________________________________
*
SETS

SURITEM    ITEMS FOR THE OVERALL WELFARE COMPARISON TABLE
/CONSURPLUS, PROSURPLUS, FORSURPLUS, GOVCOST, TOTDOMSURP, TOTSURPLUS,
 NETSURPLUS, FORCONSSUR, FORPRODSUR /


PARAMETERS
SURCOMP   (SURITEM,FPRUN)           WELFARE COMPARISON IN BILLION $
PRICECOMP (ALLI,FPRUN)              COMMODITY PRICE COMPARISON
PRODNCOMP (ALLI,FPRUN)              COMMODITY PRODUCTION COMPARISON
CBALANCEP (PRIMARY,BALITEM,FPRUN)   PRODUCTION BALANCE SHEET
CBALANCES (SECONDARY,BALITEM,FPRUN) SECONDARY PRODUCTS BALANCE SHEET
*
*    Step 5
*    Save original parameters
*     ________________________
*
PARAMETERS
SCBUDDATA(ALLI,SUBREG,CROP,WTECH,CTECH,TECH)  SAVE CCCBUDDATA ;
SCBUDDATA(ALLI,SUBREG,CROP,WTECH,CTECH,TECH)
         = CCCBUDDATA(ALLI,SUBREG,CROP,WTECH,CTECH,TECH);
*
*
*    Step 6
*    Set farm program to zero for all runs
*     _____________________________________
*
FARMPROD("TARGET",CROP)
  $(FARMPROD("TARGET",CROP))  = FARMPROD("TARGET",CROP)  * 0.00001 ;
FARMPROD("DEFIC",CROP)
  $(FARMPROD("DEFIC",CROP))   = FARMPROD("DEFIC",CROP)   * 0.00001 ;
FARMPROD("LOANRATE",CROP)     = FARMPROD("LOANRATE",CROP)* 0.00001 ;
FARMPROD("MKTLOANY-N",CROP)   = 0;
*
*
*    Step 7
*     Loop over all activated scenarios
*     _________________________________
*
LOOP(FPRUN,

CCCBUDDATA(ALLI,SUBREG,CROP,WTECH,CTECH,TECH)
      = SCBUDDATA(ALLI,SUBREG,CROP,WTECH,CTECH,TECH) ;

CCCBUDDATA("CORN",SUBREG,CROP,WTECH,CTECH,TECH)
  $( (CCCBUDDATA("CORN",SUBREG,CROP,WTECH,CTECH,TECH)) and
              (ADJUST("CORN",SUBREG,CROP,FPRUN))     )
     = SCBUDDATA("CORN",SUBREG,CROP,WTECH,CTECH,TECH) *
           (1 - ADJUST("CORN",SUBREG,CROP,FPRUN))
;

CCCBUDDATA("CHEMICALCO",SUBREG,CROP,WTECH,CTECH,TECH)
  $( (CCCBUDDATA("CHEMICALCO",SUBREG,CROP,WTECH,CTECH,TECH)) and
              (ADJUST("CHEMICALCO",SUBREG,CROP,FPRUN))     )
     = SCBUDDATA("CHEMICALCO",SUBREG,CROP,WTECH,CTECH,TECH) +
          ADJUST("CHEMICALCO",SUBREG,CROP,FPRUN)
;

$INCLUDE asmcalrn
$INCLUDE asmsolve
$INCLUDE asmrept
$INCLUDE asmcompr
);
$ontext
#user model library stuff
Main topic ASM Model
Featured item 1 Code seperation
Featured item 2 Comparative analysis
Featured item 3 ASM sector model
Description
Comparative analysis file for ASM model
$offtext