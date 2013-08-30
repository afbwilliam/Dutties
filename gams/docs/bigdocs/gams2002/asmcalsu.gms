$ontext

One time calculations done in setting up ASM model

$offtext
scalar skipinput skip input recalculation /0/;

*  ????????????????????????????????????????????????????????????
*
*          COMPUTATIONS THAT ARE DONE IN SETTING UP
*
*  ????????????????????????????????????????????????????????????
*

*   COMPUTE PROFITS

    SET REGION(REGIONS) ; REGION(REGIONS) = YES ; REGION("TOTAL") = NO;
        REGION("TOTAL") = NO;


*### CHECK PRICES  #################

     PDEMAND(PRIMARY,"PRICE")$(FARMPROD("SLIPPAGE",PRIMARY) GT 0. AND
         FARMPROD("MKTLOANY-N",PRIMARY) LE 0. AND PDEMAND(PRIMARY,"PRICE")
          LT FARMPROD("LOANRATE",PRIMARY) )
        =FARMPROD("LOANRATE",PRIMARY)   ;

     FARMPROD("DEFIC",PRIMARY)$(FARMPROD("SLIPPAGE",PRIMARY) GT 0. AND
         FARMPROD("LOANRATE",PRIMARY) LT PDEMAND(PRIMARY,"PRICE"))
       = FARMPROD("TARGET",PRIMARY) - PDEMAND(PRIMARY,"PRICE") ;

     FARMPROD("DEFIC",PRIMARY)$(FARMPROD("SLIPPAGE",PRIMARY) GT 0. AND
         FARMPROD("LOANRATE",PRIMARY) GE PDEMAND(PRIMARY,"PRICE"))
       = FARMPROD("TARGET",PRIMARY) - FARMPROD("LOANRATE",PRIMARY) ;

     FARMPROD("DEFIC",PRIMARY)$(FARMPROD("SLIPPAGE",PRIMARY) GT 0. AND
         FARMPROD("TARGET",PRIMARY) LE PDEMAND(PRIMARY,"PRICE"))
        =0.0 ;

*!!!!!!!!!!!!!!!!!!!!!!!


PARAMETER
  PROFITL(SUBREG,ANIMAL,LIVETECH)
  costl(SUBREG,ANIMAL,LIVETECH)  sum of input and cost for livestock
  costc(SUBREG,CROP,WTECH,ctech,TECH) sum of input and cost for crops;


  LBUDDATA("PROFIT",SUBREG,ANIMAL,LIVETECH)
        $ (LBUDDATA("noprofit",SUBREG,ANIMAL,LIVETECH) eq 0)=0;

      PROFITL(SUBREG,ANIMAL,LIVETECH)
      $(sum(primary, LBUDDATA(PRIMARY,SUBREG,ANIMAL,LIVETECH)) gt 0
        and  LBUDDATA("noprofit",SUBREG,ANIMAL,LIVETECH) eq 0)=
              SUM(PRIMARY,PDEMAND(PRIMARY,"PRICE")
                        *LBUDDATA(PRIMARY,SUBREG,ANIMAL,LIVETECH))
             -SUM(SECONDARY,SDEMAND(SECONDARY,"PRICE")
                        *LBUDDATA(SECONDARY,SUBREG,ANIMAL,LIVETECH))
             -SUM(INPUT,INPUTPRICE(INPUT)
                        *LBUDDATA(INPUT,SUBREG,ANIMAL,LIVETECH))
             -SUM(COST,LBUDDATA(COST,SUBREG,ANIMAL,LIVETECH))
             -WATERSUP(SUBREG,"PUMPPRICE")
                    *LBUDDATA("WATER",SUBREG,ANIMAL,LIVETECH)
             - SUM(LANDTYPE,LANDSUPPL(LANDTYPE,SUBREG,"PRICE")
                        *LBUDDATA(LANDTYPE,SUBREG,ANIMAL,LIVETECH))
             -AUMSSUP(SUBREG,"PRIVATEP")
                        *LBUDDATA("AUMS",SUBREG,ANIMAL,LIVETECH)
             -SUM(REGION$MAPPING(REGION,SUBREG),
                LABORSUP(REGION,"HIREP")
                        *LBUDDATA("LABOR",SUBREG,ANIMAL,LIVETECH) ) ;

  LBUDDATA("PROFIT",SUBREG,ANIMAL,LIVETECH)
        $ (LBUDDATA("noprofit",SUBREG,ANIMAL,LIVETECH) eq 0)=
                                     PROFITL(SUBREG,ANIMAL,LIVETECH)   ;




LBUDDATA("maximum",SUBREG,ANIMAL,LIVETECH)=0.0 ;


    PARAMETER PROFITPR(PROCESSALT);

  PROCBUD("PROFIT",PROCESSALT)$
  (PROCBUD("noPROFIT",PROCESSALT) eq 0)= 0.0;

    PROFITPR(PROCESSALT)  $
  (PROCBUD("noPROFIT",PROCESSALT) eq 0)=
            -SUM(PRIMARY,PDEMAND(PRIMARY,"PRICE")
                        *PROCBUD(PRIMARY,PROCESSALT))
            +SUM(SECONDARY,SDEMAND(SECONDARY,"PRICE")
                        *PROCBUD(SECONDARY,PROCESSALT))
            -SUM(INPUT,INPUTPRICE(INPUT)
                        *PROCBUD(INPUT,PROCESSALT))
            -SUM(COST,PROCBUD(COST,PROCESSALT))   ;

  PROCBUD("PROFIT",PROCESSALT)$
  (PROCBUD("noPROFIT",PROCESSALT) eq 0)
  = PROFITPR(PROCESSALT)  ;

*    DISPLAY PROFITC;
*    DISPLAY PROFITL;
*    DISPLAY PROFITPR;

*   COMPUTE FARM PROGRAM BUDGET AND YIELD
  cccbuddata(ALLI,SUBREG,CROP,WTECH,"PARTICIP",TECH)
       $(SUM(FARMPRO,ABS(FARMPROD(FARMPRO,CROP))) gt 0
          and cccbuddata("cropland",subreg,crop,wtech,"base",tech) gt 0)
   = cccbuddata(ALLI,SUBREG,CROP,WTECH,"BASE",TECH)  ;

  cccbuddata(ALLI,SUBREG,CROP,WTECH,"NONPART",TECH)
       $(SUM(FARMPRO,ABS(FARMPROD(FARMPRO,CROP))) gt 0
          and cccbuddata("cropland",subreg,crop,wtech,"base",tech) gt 0)
   = cccbuddata(ALLI,SUBREG,CROP,WTECH,"BASE",TECH)  ;

 cccbuddata(CROP,SUBREG,CROP,WTECH,"NONPART",TECH) $
    (FARMPROD("SLIPPAGE",CROP) ne 0
       and cccbuddata("cropland",subreg,crop,wtech,"base",tech) gt 0)
      =  cccbuddata(CROP,SUBREG,CROP,WTECH,"BASE",TECH)
        / ((1- FPPART(SUBREG,CROP))
          + FPPART(SUBREG,CROP) * (1+(FARMPROD("SETASIDE",CROP)
          +FARMPROD("DIVERSION",CROP)+FARMPROD("50-92",CROP)*0.50
          +FARMPROD("0-92",CROP)+FARMPROD("unharvacr",CROP))
          * (1-FARMPROD("SLIPPAGE",CROP))));

 cccbuddata(CROP,SUBREG,CROP,WTECH,"PARTICIP",TECH)
   $ (FARMPROD("SLIPPAGE",CROP) gt 0
      and cccbuddata("cropland",subreg,crop,wtech,"base",tech) gt 0)
      =
 cccbuddata(CROP,SUBREG,CROP,WTECH,"NONPART",TECH) *
           (1+(FARMPROD("SETASIDE",CROP)+farmprod("unharvacr",crop)
          +FARMPROD("DIVERSION",CROP)+FARMPROD("50-92",CROP)*0.50
          +FARMPROD("0-92",CROP))
          * (1-FARMPROD("SLIPPAGE",CROP)));
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*don't change the land because flex doesn't effect the amount in these
*programs
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
cccbuddata("addLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH)$
      ( cccbuddata("cropland",subreg,crop,wtech,"base",tech) gt 0)=
    cccbuddata("cropLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH);

cccbuddata("cropLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH)
          $(FARMPROD("SLIPPAGE",CROP) ne 0 and
         cccbuddata("CROPLAND",SUBREG,CROP,WTECH,"BASE",TECH) gt 0)
      =   cccbuddata("CROPLAND",SUBREG,CROP,WTECH,"BASE",TECH)/(1.0 -
           (FARMPROD("SETASIDE",CROP)+FARMPROD("DIVERSION",CROP)
          +FARMPROD("50-92",CROP)*0.50 +FARMPROD("0-92",CROP))
           *FPPART(SUBREG,CROP))    ;

cccbuddata("addLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH)$
cccbuddata("addLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH)=
    cccbuddata("cropLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH)
   - cccbuddata("addLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH);
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*don't effect complianc because no compliance costs on flex
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 cccbuddata("COMPLIANC",SUBREG,CROP,WTECH,"PARTICIP",TECH)
          $(FARMPROD("SLIPPAGE",CROP) ne 0 and
         cccbuddata("CROPLAND",SUBREG,CROP,WTECH,"BASE",TECH) gt 0)
      =  cccbuddata("CROPLAND",SUBREG,CROP,WTECH,"PARTICIP",TECH)
             *FPPART(SUBREG,CROP)
         *FARMPROD("SETASDCOST",CROP) * ( FARMPROD("SETASIDE",CROP)
         +FARMPROD("DIVERSION",CROP)+FARMPROD("50-92",CROP)*0.50
         +FARMPROD("0-92",CROP)    )    ;

 cccbuddata("PROFIT",SUBREG,CROP,WTECH,ctech,TECH)
    $(cccbuddata("noPROFIT",SUBREG,CROP,WTECH,ctech,TECH) eq 0)=0;

 cccbuddata("PROFIT",SUBREG,CROP,WTECH,"base",TECH)
       $( cccbuddata("cropland",subreg,crop,wtech,"base",tech) gt 0
  and    cccbuddata("noPROFIT",SUBREG,CROP,WTECH,"base",TECH) eq 0)
     =   + sum(primary,PDEMAND(PRIMARY,"PRICE")      *
               cccbuddata(PRIMARY,subreg,CROP,WTECH,"base",TECH)  )
         -SUM(SECONDARY,SDEMAND(SECONDARY,"PRICE")
                      *cccbuddata(SECONDARY,subreg,CROP,WTECH,"base",TECH))
         -SUM(INPUT,INPUTPRICE(INPUT)
                         *cccbuddata(INPUT,subreg,CROP,WTECH,"base",TECH))
         -SUM(COST,cccbuddata(COST,subreg,CROP,WTECH,"base",TECH))
         -watersuP(subreg,"PUMPPRICE")
            *cccbuddata("WatER",subreg,CROP,WTECH,"base",TECH)
         -SUM(LANDTYPE,landsuppl(LANDTYPE,subREG,"PRICE")
            *cccbuddata(LANDTYPE,subreg,CROP,WTECH,"base",TECH))
         -AUMSSUP(subREG,"PRIVatEP")
            *cccbuddata("AUMS",subREG,CROP,WTECH,"base",TECH)
         -sum(MAPPING(REGION,SUBREG),laborsup(REGion,"HIREP")
            *cccbuddata("LABOR",subreg,CROP,WTECH,"base",TECH));

 cccbuddata("PROFIT",subreg,CROP,WTECH,"PARTICIP",TECH)$
   ( cccbuddata("noPROFIT",SUBREG,CROP,WTECH,"particip",TECH) eq 0)
    =0;

 cccbuddata("PROFIT",subreg,CROP,WTECH,"PARTICIP",TECH)
        $(FARMPROD("SLIPPAGE",CROP) GT 0
      and cccbuddata("cropland",subreg,crop,wtech,"base",tech) gt 0
      and cccbuddata("noPROFIT",SUBREG,CROP,WTECH,"base",TECH) eq 0)=
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*production sold at market price
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 + sum(primary,PDEMAND(PRIMARY,"PRICE")      *(
*  non participating
              cccbuddata(PRIMARY,subreg,CROP,WTECH,"NONPART",TECH)
              *(1.0-(FPPART(subreg,CROP)))
*unpaid
             + cccbuddata(PRIMARY,subreg,CROP,WTECH,"PARTICIP",TECH)
              *(FPPART(subreg,CROP) )
              *(1.0-FARMPROD("PERCNTPAID",CROP))
* flexed
             + cccbuddata(PRIMARY,subreg,CROP,WTECH,"PARTICIP",TECH)
                 *(fPPART(subreg,CROP)*(farmprod("flex",crop)))
                 *FARMPROD("PERCNTPAID",CROP)
*above farm prog yield
             + 1$(farmprod("fpyield",crop) le 1)
              * cccbuddata(PRIMARY,subreg,CROP,WTECH,"PARTICIP",TECH)
              *(FPPART(subreg,CROP) )
              *(FARMPROD("PERCNTPAID",CROP))
              *(1.0-FARMPROD("FPYIELD",CROP))    ))
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*production valued at target price
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
       + FARMPROD("TARGET",CROP)*
       ( (FPPART(subreg,CROP)*(1-farmprod("flex",crop)))
                    * FARMPROD("PERCNTPAID",CROP)
         * cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)
         * min(FARMPROD("FPYIELD",CROP),1.))
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*farm program deficiency payments
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

      + FARMPROD("DEFIC",CROP)*(
        FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        *FARMPROD("50-92",CROP)*FARMPROD("FPYIELD",CROP)
        *cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)  *0.42
        +FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        *FARMPROD("0-92",CROP)*FARMPROD("FPYIELD",CROP)
        *cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)  *0.92
        +  FPPART(subreg,CROP) *(1-farmprod("flex",crop))
        *FARMPROD("PERCNTPAID",CROP)
        * FARMPROD("UNHARVACR",CROP) *FARMPROD("FPYIELD",CROP)
        * cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)
        +  (FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        * FARMPROD("PERCNTPAID",CROP)
         * (FARMPROD("FPYIELD",CROP)-1.0)
         * cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH))
           $(FARMPROD("FPYIELD",CROP) gt 1.0))
       +FARMPROD("DIVERPAY",CROP)*(
       FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        *FARMPROD("DIVERSION",CROP)*FARMPROD("FPYIELD",CROP)
       *cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH))
       -SUM(SECONDARY,SDEMAND(SECONDARY,"PRICE")
                 *cccbuddata(SECONDARY,subreg,CROP,WTECH,"particip",TECH))
       - SUM(COST,cccbuddata(COST,subreg,CROP,WTECH,"PARTICIP",TECH))
       -SUM(INPUT,INPUTPRICE(INPUT)
                     *cccbuddata(INPUT,subreg,CROP,WTECH,"particip",TECH))
       -watersuP(subreg,"PUMPPRICE")
            *cccbuddata("WatER",subreg,CROP,WTECH,"particip",TECH)
       -SUM(LANDTYPE,landsuppl(LANDTYPE,subreg,"PRICE")
            *cccbuddata(LANDTYPE,subreg,CROP,WTECH,"particip",TECH))
       -AUMSSUP(subreg,"PRIVatEP")
            *cccbuddata("AUMS",subreg,CROP,WTECH,"particip",TECH)
    -sum(MAPPING(REGION,SUBREG),laborsup(REGion,"HIREP"))
            *cccbuddata("LABOR",subreg,CROP,WTECH,"particip",TECH)
;

$ontext
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*production sold at market price need to impact
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 + sum(primary,PDEMAND(PRIMARY,"PRICE")      *(
               cccbuddata(PRIMARY,subreg,CROP,WTECH,"NONPART",TECH)
              *(1.0-(FPPART(subreg,CROP)))
             + cccbuddata(PRIMARY,subreg,CROP,WTECH,"PARTICIP",TECH)
              *(FPPART(subreg,CROP) )
              *(1.0-FARMPROD("PERCNTPAID",CROP))
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*percentage paid (or unpaid) valued at market price
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
         +    1$(FARMPROD("SLIPPAGE",CROP) GT 0.0 AND
                  FARMPROD("FPYIELD",CROP))
                 *(fPPART(subreg,CROP)*(1-farmprod("flex",crop)))
                 *FARMPROD("PERCNTPAID",CROP)
                 *cccbuddata(PRIMARY,subreg,CROP,WTECH,"PARTICIP",TECH)
                 *(1.0-FARMPROD("FPYIELD",CROP))    ))
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*production valued at target price need to impact
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
       + FARMPROD("TARGET",CROP)*
       ( (FPPART(subreg,CROP)*(1-farmprod("flex",crop)))
                    * FARMPROD("PERCNTPAID",CROP)
         * cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)
         * min(FARMPROD("FPYIELD",CROP),1.))
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*farm program deficiency payments
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

      + FARMPROD("DEFIC",CROP)*(
        FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        *FARMPROD("50-92",CROP)*FARMPROD("FPYIELD",CROP)
        *cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)  *0.92
        +FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        *FARMPROD("0-92",CROP)*FARMPROD("FPYIELD",CROP)
        *cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)  *0.92
        +  FPPART(subreg,CROP) *(1-farmprod("flex",crop))
        *FARMPROD("PERCNTPAID",CROP)
        * FARMPROD("UNHARVACR",CROP) *FARMPROD("FPYIELD",CROP)
        * cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH)
        +  (FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        * FARMPROD("PERCNTPAID",CROP)
         * (FARMPROD("FPYIELD",CROP)-1.0)
         * cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH))
           $(FARMPROD("FPYIELD",CROP) gt 1.0))
       +FARMPROD("DIVERPAY",CROP)*(
       FPPART(subreg,CROP)*(1-farmprod("flex",crop))
        *FARMPROD("DIVERSION",CROP)*FARMPROD("FPYIELD",CROP)
       *cccbuddata(CROP,subreg,CROP,WTECH,"PARTICIP",TECH))
       -SUM(SECONDARY,SDEMAND(SECONDARY,"PRICE")
                 *cccbuddata(SECONDARY,subreg,CROP,WTECH,"particip",TECH))
       - SUM(COST,cccbuddata(COST,subreg,CROP,WTECH,"PARTICIP",TECH))
       -SUM(INPUT,INPUTPRICE(INPUT)
                     *cccbuddata(INPUT,subreg,CROP,WTECH,"particip",TECH))
       -watersuP(subreg,"PUMPPRICE")
            *cccbuddata("WatER",subreg,CROP,WTECH,"particip",TECH)
       -SUM(LANDTYPE,landsuppl(LANDTYPE,subreg,"PRICE")
            *cccbuddata(LANDTYPE,subreg,CROP,WTECH,"particip",TECH))
       -AUMSSUP(subreg,"PRIVatEP")
            *cccbuddata("AUMS",subreg,CROP,WTECH,"particip",TECH)
    -sum(MAPPING(REGION,SUBREG),laborsup(REGion,"HIREP"))
            *cccbuddata("LABOR",subreg,CROP,WTECH,"particip",TECH)
;
$offtext

 cccbuddata("PROFIT",subreg,CROP,WTECH,"nonPART",TECH)
   $(cccbuddata("PROFIT",subreg,CROP,WTECH,"PARTICIP",TECH) ne 0
  and    cccbuddata("noPROFIT",SUBREG,CROP,WTECH,"base",TECH) eq 0)
   =cccbuddata("PROFIT",subreg,CROP,WTECH,"PARTICIP",TECH);
$ontext
#user model library stuff
Main topic ASM Model
Featured item 1 Code seperation
Featured item 2 Static calculation
Featured item 3 ASM sector model
Description
One time calculations done in setting up ASM model

$offtext
