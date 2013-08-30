*illustrate mip model

option solprint=off;
option reslim=1000000;
option iterlim=1000000;
option limrow=0
option limcol=0;
sets
   securities  type of securities
        /ustres     US Treasury Bills and Notes
         govtoblig  Obligations of US Govt Agencies
         primecomm  Prime Commercial Paper
         reinvest   short term reinvestment at reinvestment rate/

   investment  types of specific investments
      / fhdn      Federal Home Loan Bank Board
        gnma      Government National Mortgage Association
        farmha    Farmers Home Administration
        fmcdn     Federal Home Loan Mortgage Company
        fha       Federal Housing Administration
        fndn      Federal Mational Mortgage Association
        fcdn      Federal Farm Credit Bank
        ustbill   US Treasury Bill
        ustnote   US Treasury Note
        primecomm prime commercial paper
        primecom2 prime commercial paper
        merrilcp  Merril Lynch Commercial Paper
        gecccp    GE Capital Commercial Paper
        fordcp    Ford Commercial Paper
        reinvest  short term reinvestment at at reinvestment rate/
   securtypes(securities,investment)   grouping of securities
       /ustres    .(ustbill
                    ustnote)
        govtoblig.(
       fhdn
        gnma
        farmha
        fmcdn
        fha
        fndn
        fcdn
                      )
        primecomm.(primecomm
                   primecom2
                    merrilcp
                    gecccp
                    fordcp

                   )
        reinvest .reinvest  /

   months    month ending dates when cash flow is needed
      /
    30-Jun-97
    31-Jul-97
    31-Aug-97
    30-Sep-97
    31-Oct-97
    30-Nov-97
    31-Dec-97
    31-Jan-98
    28-Feb-98
    31-Mar-98
    30-Apr-98
    31-May-98
*   30-Jun-98
*   31-Jul-98
*   31-Aug-98
*   30-Sep-98
*   31-Oct-98
*   30-Nov-98
        /
alias (month,months)
parameter needcash(months)  month ending dates when cash flow is needed
      /
    30-Jun-97  0
    31-Jul-97  6800000
    31-Aug-97  0
    30-Sep-97  6900000
    31-Oct-97  0
    30-Nov-97  6900000
    31-Dec-97  0
    31-Jan-98  6700000
    28-Feb-98  0
    31-Mar-98  7300000
    30-Apr-98  0
    31-May-98  7300000
*   30-Jun-98  0
*   31-Jul-98  9000000
*   31-Aug-98  0
*   30-Sep-98  7400000
*   31-Oct-98  0
*   30-Nov-98  4400000
       /
parameter days(months)  days in month
      /
    30-Jun-97  19
    31-Jul-97  31
    31-Aug-97  31
    30-Sep-97  30
    31-Oct-97  31
    30-Nov-97  30
    31-Dec-97  31
    31-Jan-98  31
    28-Feb-98  28
    31-Mar-98  31
    30-Apr-98  30
    31-May-98  31
*   30-Jun-98  30
*   31-Jul-98  31
*   31-Aug-98  31
*   30-Sep-98  30
*   31-Oct-98  31
*   30-Nov-98  30
        /
parameter totalyr;
totalyr=sum(months,days(months))/365;
*display totalyr;

set item /
   price     current price of one unit of paper
   prior6    coupon payment 6 months prior to maturity
   prior12   coupon payment 12 months prior to maturity
   matureval amount recieved on maturity
   maxav     maximum amount of the issuance available
   minreq    minimum amount of the issuance that must be purchased
   reinvest  reinvestment income in few days befor maturity /

table returndata(investment,month,item)
*data are security and maturity data in row
*price and return in column
*the fedhlbank data below are for   3 and 6 month securities
*the passbook data below are for   1 month securities
*the tbill data below are for   3 month securities
*only one prime commercial paper put in for now
*i did not set up data for different length months
*all investments are done on last day of month
*could set up a monday model if needed
*or daily
*reinvest is the money we would make holding the security for the rest of the time period
                          price    matureval  prior6  prior12 reinvest maxav minreq

ustnote   .  31-Jul-97   1022.8229  1029.375   0.000    0.000    0.000   0      5
fmcdn     .  31-Jul-97    992.5950  1000.000   0.000    0.000    0.137   0     25
merrilcp  .  31-Jul-97    992.2917  1000.000   0.000    0.000    0.000   0    100
gecccp    .  31-Jul-97    992.4867  1000.000   0.000    0.000    0.000   0    100
fordcp    .  31-Jul-97    992.5003  1000.000   0.000    0.000    0.000   0    100
ustnote   .  30-Sep-97   1011.7572  1027.500   0.000    0.000    0.000   0      1
fndn      .  30-Sep-97    983.2861  1000.000   0.000    0.000    0.137   0     10
merrilcp  .  30-Sep-97    982.7950  1000.000   0.000    0.000    0.000   0    100
gecccp    .  30-Sep-97    982.9500  1000.000   0.000    0.000    0.000   0    100
fordcp    .  30-Sep-97    982.9806  1000.000   0.000    0.000    0.000   0    100
ustnote   .  30-Nov-97   1004.3033  1030.000   0.000    0.000    0.000   0      1
fndn      .  30-Nov-97    974.6253  1000.000   0.000    0.000    0.685   0     10
merrilcp  .  30-Nov-97    973.2444  1000.000   0.000    0.000    0.000   0    100
gecccp    .  30-Nov-97    973.4000  1000.000   0.000    0.000    0.000   0    100
fordcp    .  30-Nov-97    973.4475  1000.000   0.000    0.000    0.000   0    100
ustnote   .  31-Jan-98   1020.3557  1028.125  28.125    0.000    0.000   0      1
fndn      .  31-Jan-98      0.0000     0.000   0.000    0.000    0.000   0      0
merrilcp  .  31-Jan-98    963.2100  1000.000   0.000    0.000    0.000   0    100
gecccp    .  31-Jan-98    963.5614  1000.000   0.000    0.000    0.000   0    100
fordcp    .  31-Jan-98    963.6261  1000.000   0.000    0.000    0.000   0    100
ustnote   .  31-Mar-98   1006.0195  1025.625  25.625    0.000    0.000   0      1
fhdn      .  31-Mar-98   5064.2938  5142.875 142.875    0.000    7.750   0      2
ustnote   .  31-May-98   1003.9908  1030.000  30.000    0.000    0.000   0      5
fhdn      .  31-May-98   1000.0000  1027.400  27.400    0.000    0.281   0    100
*ustnote   .  31-Jul-98   1012.7486  1026.250  26.250   26.250    0.000   0      1
*fhdn      .  31-Jul-98      0.0000     0.000   0.000    0.000    0.000   0      0
*stnote   .  30-Sep-98   1013.3658  1030.000  30.000   30.000    0.000   0      5
*fcdn      .  30-Sep-98   1013.8567  1031.350  31.350   31.350    0.141   0    100
*ustnote   .  30-Nov-98    990.6028  1025.625  25.625   25.625    0.000   0      1
*fcdn      .  30-Nov-98   1003.8569  1000.000   0.000    0.000    0.000   0    100
*       gnma
*       farmha
*       fedhomlm
*       fha
*       fnma
*       farmcred
*       ustbill
*       passbook
;

*/Right hand side amounts and miscellaneous required coefficients*/
scalar
available   dollars available to invest   /61700000/
reinvrate    reinvestment rate  /.05/
mintresamt   minimum amount of US treasuries allowed /32000000/
maxagency  maximum allowable amount of any one US agency obligations
             /.10/
maxcompap  maximum allowable amount of all commercial paper /.20/
maxindivcp  maximum amount of any one type of comm paper /5000000/

scalar docash /0/;

parameter cumdays(month);
scalar start /0/;

loop(month,
     start=start+days(month)/(365/12);
     cumdays(month)=start;);
*display cumdays,start;
start =365/12;
*display start;
parameter time(month);
          time(month)=cumdays(month);

variables
    obj      objective function
integer variables
    invest(investment,month)         investment income
    investmin(investment,month)      minimum bonds to buy
positive variables
    endwrth               ending net worth
    reinvest(month)       reinvestment income
    cashflow(month)       cash withdrawn by authority
*    art(month)            artificial cash
    initcash              initial cash    ;
 equations
    objt
    money(month)                 money balance in a month
    mintreas                     minimum in us treasuries
    maxgovt(investment)          max in govt agencies
    maxinprime                   maximum in prime commercial paper
    maxindprim (investment)      maximum in one prime paper
    mincash(month)               minimum cash
    investmina(investment,month) helps impose minimum bonds to buy
    investminb(investment,month) helps impose minimum bonds to buy
    initalcash                     initial cash;

invest.up(investment,month)$returndata(investment,month,"matureval")
  =round(available/returndata(investment,month,"price"),0);
invest.up(investment,month)$returndata(investment,month,"maxav")
  =min(round(available/returndata(investment,month,"price")),
       returndata(investment,month,"maxav"));
 investmina(investment,month)$(returndata(investment,month,"minreq") gt 0)..
     invest(investment,month)
     =l=invest.up(investment,month)*investmin(investment,month);
 investminb(investment,month)$(returndata(investment,month,"minreq") gt 0)..
     invest(investment,month)
     =g= returndata(investment,month,"minreq")
        *investmin(investment,month);
   initalcash$(docash eq 0)..
       initcash=e=available;
money(month)..
*all investments in first month only
      sum((investment,months)$returndata(investment,months,"matureval")
      , returndata(investment,months,"price")
       *invest(investment,months))$(ord(month) eq 1)
      +reinvest(month)$(ord(month) lt card(month))
     +endwrth$(ord(month) eq card(months))
     +cashflow(month)$needcash(month)
      =e=
      sum(investment$returndata(investment,month,"matureval"),
                 invest(investment,month)*
                 (returndata(investment,month,"matureval")
                 +returndata(investment,month,"reinvest")))
     +sum(investment$returndata(investment,month+6,"prior6"),
                 invest(investment,month+6)*
                 returndata(investment,month+6,"prior6"))$
                 (ord(month) le card(month)-6)
     +sum(investment$returndata(investment,month+12,"prior12"),
                 invest(investment,month+12)*
                 returndata(investment,month+12,"prior12"))$
                 (ord(month) le card(month)-12)
     + reinvest(month-1) *(1+reinvrate)**(1/12)
                                  $(ord(month) gt 1)
      +(initcash)$(ord(month) eq 1);
mintreas..
     sum(investment$securtypes("ustres",investment),
        sum(month$returndata(investment,month,"matureval")
      , returndata(investment,month,"price")*
                invest(investment,month)))
             =g=mintresamt;
maxgovt(investment)$securtypes("govtoblig",investment)..
        sum(month$returndata(investment,month,"matureval")
      , returndata(investment,month,"price")*
                invest(investment,month))
             =l=maxagency*available;
maxinprime..
     sum(investment$securtypes("primecomm",investment),
        sum(month$returndata(investment,month,"matureval")
      , returndata(investment,month,"price")*
                invest(investment,month)))
             =l=maxcompap*available;
maxindprim (investment) $securtypes("primecomm",investment)..
        sum(month$returndata(investment,month,"matureval")
      , returndata(investment,month,"price")*
                invest(investment,month))
             =l=maxindivcp;
mincash(month)$needcash(month)..
    cashflow(month)
*    +art(month)
     =g=needcash(month);
     objt.. obj=e=endwrth$(docash eq 0)
*      -999999*( sum(month$needcash(month),art(month)))
                  -initcash$docash;

*option rmip=gamschk;
option mip=cplex;

*osl;
model security /all/;
security.workspace=20;
security.optfile=1;
security.cheat=0;
security.optcr=0.00001;
parameter monthret(month,*)  monthly rate of return
          costrestrt(securities,*,*,*)  cost of restrictions on portfol;
solve security using rmip maximizing obj


parameter usemoney(month,*,month,*) monthly uses of money
;
usemoney(month,investment,months,"price")$(ord(month) eq 1 and
                                          invest.l(investment,months))=
       returndata(investment,months,"price");
usemoney(month,investment,months,"quantity")$(ord(month) eq 1 and
                                          invest.l(investment,months))=
       invest.l(investment,months);
usemoney(month,investment,months,"totalcost")$(ord(month) eq 1 and
                                          invest.l(investment,months))=
       returndata(investment,months,"price") *invest.l(investment,months);
usemoney(month,"reinvest",month,"totalcost")
    $(ord(month) lt card(month))=
      +reinvest.l(month);
usemoney(month,"cashflow",month,"totalcost")=
     +cashflow.l(month)$needcash(month);
usemoney(month,"endbalance",month,"totalcost")
     $(ord(month) eq card(months))=
     +endwrth.l;
parameter sourcmoney(month,*,month,*,*) monthly Income and other sources
 ;
sourcmoney(month,investment,month,"mature","perunit")$
                 invest.l(investment,month)=
                 returndata(investment,month,"matureval");
sourcmoney(month,investment,month,"mature","perunitrin")$
                 invest.l(investment,month)=
                 returndata(investment,month,"reinvest");
 sourcmoney(month,investment,month,"mature","quantity")$
                 invest.l(investment,month)=
                 invest.l(investment,month);
 sourcmoney(month,investment,month,"mature","totalreven")$
                 invest.l(investment,month)=
                 (returndata(investment,month,"matureval")+
                  returndata(investment,month,"reinvest"))
                 *invest.l(investment,month);
 sourcmoney(month,investment,month,"mature","earning")$
                 invest.l(investment,month)=
                 (returndata(investment,month,"matureval")+
                  returndata(investment,month,"reinvest")-
                  returndata(investment,month,"price"))
                 *invest.l(investment,month);
 sourcmoney(month,investment,month,"mature","shrtreinv")$
                 invest.l(investment,month)=
                  returndata(investment,month,"reinvest")
                 *invest.l(investment,month);

 sourcmoney(month-6,investment,month,"coupon6","perunit")$
                 ((ord(month) ge 6+1) and
                 invest.l(investment,month))=
                 returndata(investment,month,"prior6");
 sourcmoney(month-6,investment,month,"coupon6","quantity")$
                 ((ord(month) ge 6+1          ) and
                 invest.l(investment,month)
                  and returndata(investment,month,"prior6"))=
                 invest.l(investment,month);
 sourcmoney(month-6,investment,month,"coupon6","totalreven")$
                 ((ord(month) ge 6+1          ) and
                 invest.l(investment,month))=
                 returndata(investment,month,"prior6")*
                 invest.l(investment,month);
 sourcmoney(month-6,investment,month,"coupon6","earning")=
 sourcmoney(month-6,investment,month,"coupon6","totalreven");
 sourcmoney(month-12,investment,month,"coupon12","perunit")$
                 ((ord(month) ge 12+1)          and
                 invest.l(investment,month))=
                 returndata(investment,month,"prior12");
 sourcmoney(month-12,investment,month,"coupon12","quantity")$
                 ((ord(month) ge 12+1          ) and
                 invest.l(investment,month)
                  and returndata(investment,month,"prior12"))=
                 invest.l(investment,month);
 sourcmoney(month-12,investment,month,"coupon12","totalreven")$
                 ((ord(month) ge 12+1          ) and
                 invest.l(investment,month))=
                 returndata(investment,month,"prior12")*
                 invest.l(investment,month);
 sourcmoney(month-6,investment,month,"coupon12","earning")=
 sourcmoney(month-6,investment,month,"coupon12","totalreven");
 sourcmoney(month,"reinvest",month-1,"mature","quantity")
        $(ord(month) gt 1)
     = reinvest.l(month-1) ;
 sourcmoney(month,"reinvest",month-1,"mature","perunit")
        $(ord(month) gt 1 and reinvest.l(month-1))
     =1.05**(1/12);
 sourcmoney(month,"reinvest",month-1,"mature","totalreven")$(ord(month) gt 1)
     = reinvest.l(month-1) *1.05**(1/12);
 sourcmoney(month,"reinvest",month-1,"mature","earning")=
 sourcmoney(month,"reinvest",month-1,"mature","totalreven")
     - reinvest.l(month-1)$(ord(month) gt 1);
 sourcmoney(month,"initial",month,"mature","totalreven")$(ord(month) eq 1)
      =(initalcash.l);
option usemoney:0:2:1;display usemoney;
option sourcmoney:0:3:1;display sourcmoney;
set itemsinp /principal,interest,totalinc,reinvinc,lessrequ,cumbalan/
parameter proposal(month,itemsinp) rough cut at schedule C
;
loop(month,
proposal(month,"principal")=initcash.l$(ord(month) eq 1);

proposal(month,"principal")$(ord(month) gt 1)=
        proposal(month-1,"cumbalan");
proposal(month,"interest")=
      sum(investment,
          (returndata(investment,month,"matureval")-
          returndata(investment,month,"price"))
         *invest.l(investment,month)
       +sum(months,
            sourcmoney(month,investment,months,"coupon6","totalreven")
       +sourcmoney(month,investment,months,"coupon12","totalreven")));

proposal(month,"totalinc")= proposal(month,"principal")
                           +proposal(month,"interest");
proposal(month,"reinvinc")=
      sum(investment,
           returndata(investment,month,"reinvest")
         *invest.l(investment,month))
     + (reinvest.l(month-1) *(1.05**(1/12)-1))
        $(ord(month) gt 1);

proposal(month,"lessrequ")=needcash(month);
proposal(month,"cumbalan")=
proposal(month,"totalinc")+
proposal(month,"reinvinc")-
proposal(month,"lessrequ");
   );
option decimals=0;
display proposal;
set those
   /totpurch   total amount purchased
    percent
    totpurchs  total amount purchased
    percents /
parameter composit(*,*,*,those)   portfolio composition;
composit(securities,investment,months,"totpurch") =
        sum(securtypes(securities,investment),
             returndata(investment,months,"price")
             *invest.l(investment,months));
composit(securities,investment,"total","totpurchs") =
   sum(months,composit(securities,investment,months,"totpurch") );
composit(securities,"total","total","totpurchs") =
    sum(investment,composit(securities,investment,"total","totpurchs"));
composit("total","total","total","totpurchs") =
    sum(securities,composit(securities,"total","total","totpurchs"));
composit(securities,investment,months,"percent") =
   (100*composit(securities,investment,months,"totpurch")
         /composit("total","total","total","totpurchs")) ;
composit(securities,investment,"total","percents") =
   round(100*composit(securities,investment,"total","totpurchs")
         /composit("total","total","total","totpurchs"),6) ;
composit(securities,"total","total","percents") =
   round(100*composit(securities,"total","total","totpurchs")
         /composit("total","total","total","totpurchs"),6) ;
composit("total","total","total","percents") =
   round(100*composit("total","total","total","totpurchs")
         /composit("total","total","total","totpurchs"),6) ;
option composit:0:3:1;display composit;



parameter monthret(month,*)  monthly rate of return
          costrestrt(securities,*,*,*)  cost of restrictions on portfol;
monthret(month,"ip")=money.m(month);
costrestrt("ustres","all","min","ip")= mintreas.m;
costrestrt("govtoblig",investment,"max","ip")= maxgovt.m(investment) ;
costrestrt("primecomm",investment,"max","ip")= maxindprim.m(investment);
costrestrt("primecomm","all","max","ip")= maxinprime.m;
option costrestrt:4:3:1;display costrestrt;
option monthret:4:1:1;display monthret;

security.nodlim=10000;
solve security using mip maximizing obj
monthret(month,"ip")=money.m(month);
costrestrt("ustres","all","min","lp")= mintreas.m;
costrestrt("govtoblig",investment,"max","lp")= maxgovt.m(investment) ;
costrestrt("primecomm",investment,"max","lp")= maxindprim.m(investment);
costrestrt("primecomm","all","max","lp")= maxinprime.m;
option costrestrt:4:3:1;display costrestrt;
option decimals=4;
display time,cumdays;
time(month)=cumdays(month);
scalar lowi,rate ;
scalar highi;
scalar  midi;
scalar npvlowi ;
scalar npvhighi;
scalar npvmidi;
scalar pprice;
set iter /i1*i20/
parameter return(month);
parameter rreturn(investment,month);
loop((investment,month)$returndata(investment,month,"price"),
 pprice= returndata(investment,month,"price");
return(months)=
  +returndata(investment,month,"matureval")$(sameas(month,months))
  +returndata(investment,month,"prior6")$(ord(months) eq ord(month)-6)
  +returndata(investment,month,"prior12")$(ord(months) eq ord(month)-12)
  ;

lowi= 0.001;
highi=0.02;
   npvlowi= sum(months,return(months)
        *(1/(1+lowi)**time(months)))-pprice;
   npvhighi= sum(months,return(months)
        *(1/(1+highi)**time(months)))-pprice;
   loop(iter,
     midi=0.5*lowi+0.5*highi;
     npvmidi= sum(months,return(months)
        *(1/(1+midi)**time(months)))-pprice;
 option decimals=6;
     if(npvmidi gt 0,
          lowi=midi;
          npvlowi=npvmidi;
     else
          highi=midi;
          npvhighi=npvmidi;
     );
 option decimals=3;
 );
rate=midi;
rreturn(investment,month)=100*((1+rate)**12-1);
   );
option rreturn:6:1:1;display rreturn;

scalar s,st,sp,grt /0/,s2,s3,s4,sg;
file output
put output
put "Schedule I   --  Cash Flow Under Proposal"//
put "                                Total    Reinvest    Less     Cumulative"/
put "  Date    Principal  Interest   Income    Income  Requirement   Balance" /
loop(month,
    put months.te(month):10;
    put proposal(month,"principal"):10:0
    put proposal(month,"interest"):9:0
    put proposal(month,"totalinc"):10:0
    put proposal(month,"reinvinc"):9:2;
    s=  -proposal(month,"lessrequ");
    put s:11:0
    put proposal(month,"cumbalan"):12:0/);
pprice=sum(month$(ord(month) eq 1), proposal(month,"principal"));
return(month)=
              +proposal(month,"lessrequ")+
               proposal(month,"cumbalan")$(ord(month) eq card(month))
              ;

display pprice,return;

lowi= 0.001;
highi=0.02;
   npvlowi= sum(months,return(months)
        *(1/(1+lowi)**time(months)))-pprice;
   npvhighi= sum(months,return(months)
        *(1/(1+highi)**time(months)))-pprice;
   loop(iter,
     midi=0.5*lowi+0.5*highi;
     npvmidi= sum(months,return(months)
        *(1/(1+midi)**time(months)))-pprice;
 option decimals=6;
     if(npvmidi gt 0,
          lowi=midi;
          npvlowi=npvmidi;
     else
          highi=midi;
          npvhighi=npvmidi;
     );
 option decimals=3;
 );
rate=midi;
rate=((1+rate)**12 -1 )*100;
display rate;
put // "Annualized Bond Equivilant Rate of Interest " rate:10:4/;
put // "Schedule II  --  Schedule of Securities to be Purchased"//
put @24 "             Model    Security  Number of            Percent"/
put @24 "Name of    Maturity      ID       Units    Cost of   of Total"/
PUt @24 "Security     Date      Number   Purchased  Purchases Portfolio"/
loop(securities,
    put$ sum((investment,months),
           composit(securities,investment,months,"totpurch"))
           / securities.te(securities) //;
   st=0;
   sp=0;
      loop((investment,months)$
           composit(securities,investment,months,"totpurch"),
          put @24 investment.tl:11
          put months.tl:10;
          put @51;
          s=  composit(securities,investment,months,"totpurch")
              /returndata(investment,months,"price");
          put s:11:0;
          put composit(securities,investment,months,"totpurch"):13:0;
          st=st +composit(securities,investment,months,"totpurch");
          sp=sp +composit(securities,investment,months,"percent");
          put composit(securities,investment,months,"percent"):9:4;
          put /)
          put$st / @24 "Total" @62 st:13:0  sp:9:4 /;
          grt=grt+st;
          );
          put / @24 "Total Portfolio" @62 grt:13:0 ;
put // "Schedule III --  Compliance with Portfolio Requirements"//

Put "The portfolio in Schedule II satisfies all constraints. "//
put " Namely,"//;
          s=  composit("ustres","total","total","totpurchs");
put "a)  The total investment in U.S. Treasuries   is  $" s:9:0 /
put "       which satisfies the minimum requirement of $ 32000000"//
put "b)  No proposed security has a maturity dated beyond Nov 30,1998"//;
          s=  composit("total","total","total","totpurchs");
put "c)  The total cost to the Authority is      $" s:9:0/
put "       which does not exceed the maximum of $ 61700000"//
put "d)  The portfolio contains purchases of government obligations as follows"//
put "             Agency" @45 "Total Purchase     Percent of Portfolio "/
loop (investment$(securtypes("govtoblig",investment)  and
                  composit("govtoblig",investment,"total","totpurchs")),
     put investment.tE(investment):40
     put composit("govtoblig",investment,"total","totpurchs"):14:0
     put composit("govtoblig",investment,"total","percents"):21:4 /;)
put  / "     None of those purchases exceed 10% of the portfolio"//
put "e)  The portfolio contains purchases of prime commercial paper as follows"//
put "     Commercial Issuer" @45 "Total Purchase     Percent of Portfolio "/
loop (investment$(securtypes("primecomm",investment)  and
                  composit("primecomm",investment,"total","totpurchs")),
     put investment.tE(investment):40
     put composit("primecomm",investment,"total","totpurchs"):14:0
     put composit("primecomm",investment,"total","percents"):21:4 /;)
put  / "     None of those purchases exceed $5000000            "//
Put    "     Furthermore the total purchase of prime commercial paper is "
     put composit("primecomm","total","total","totpurchs"):9:0 /
Put    "      which amounts to "
      put composit("primecomm","total","total","percents"):7:4
 Put " % of the portfolio and does not exceed the "/
 put   "      20% maximum" //
put "f)  The portfolio reinvests only minor amounts at a 5% annual rate"//
put "     Reinvestment occurs for two reasons:"//
put "       1) Investments are lumpy -- whole units of securities need to"/
put "            be aquired and interest from whole units of sale are recieved"/
put "            so minor amounts of money may not be carried over "//
put "       2) Maturity dates do not always exactly match the dates on which "/
put "            cash is required , so cash is held for a few days"//


put // "Schedule IV --  Monthly Returns on Money             "//
      loop(month,
          put month.tl monthret(month,"ip"):11:5 /);

put // "Schedule V --  Costs of Restrictions "//
put "Value of allowing one less dollar in U.S. Treasuries " ;
s=-costrestrt("ustres","all","min","lp");
put s:10:7//
put / "Value of allowing one more dollar in U.S. Agency Obligations" //
loop(investment$costrestrt("govtoblig",investment,"max","lp"),
    put investment.te(investment) :40
    put costrestrt("govtoblig",investment,"max","lp"):10:7 /);
put / "Value of allowing one more dollar in individual commercial papers" //
loop(investment$costrestrt("primecomm",investment,"max","lp")
    ,put investment.te(investment):40
     put costrestrt("primecomm",investment,"max","lp"):10:7 /);
put //
put "Value of allowing one more dollar in total commercial paper"
 put costrestrt("primecomm","all","max","lp"):10:7  /;

put // "Schedule VI --  Monthly Cash Flow "/

loop(month,
 put / "----------------------------------------------------------"/;
sg=0;
st=0;
 sp=0;
    put  / "Sources of Funds - " month.tl //
 loop((investment,months)$(not sameas(investment,"reinvest")),
 s=sourcmoney(month,investment,months,"mature","totalreven");
 s2=sourcmoney(month,investment,months,"mature","earning");
 s4= sourcmoney(month,investment,month,"mature","shrtreinv")
  $sourcmoney(month,investment,months,"mature","totalreven");
 s2=s2-s4;
 s3=sourcmoney(month,investment,months,"coupon6","totalreven")
    +sourcmoney(month,investment,months,"coupon12","totalreven");
 st=st+s+s3;
sg=sg+s4;
 sp=sp+s2+s3;
 if(s+s2+s3 gt 0,
    put @10 investment.tl,months.tl;
    put$s  "Maturity " s:8:0   " Earning " s2:8:0 , " Reinv" s4:8:0/;
    put$s3 "Coupon   " s3:8:0  " Earning " s3:8:0/;);
  );
 s=sourcmoney(month,"reinvest",month-1,"mature","totalreven");
 s2=sourcmoney(month,"reinvest",month-1,"mature","earning");
 st=st+s;
 sg=sg+s2;
if(s gt 0,
    put @10 "Reinvestment ";
    put$s  @34 "Maturity" s:9:0   @68 " Reinv"  s2:8:0/);
 s=sourcmoney(month,"initial",month,"mature","totalreven");
 st=st+s;
 if(s gt 0,
    put @10 "Initial investment" @43 s:8:0 /);
    put / @10 "Totals            " @35 "Cash in" st:9:0
    put  " Earning " sp:8:0 " Reinv" sg:8:0//;
    put  / "Uses of Funds - " month.tl //;
 st=0;
  if((ord(month) eq 1),
    put @10 "Buy Securities" /
 loop((investment,months)$(not sameas(investment,"reinvest")),
 s= usemoney(month,investment,months,"totalcost");
 st=st+s;
 if(s gt 0,
    put @10 investment.tl,months.tl;
    put  "         " s:8:0   /;
   )));
s=usemoney(month,"reinvest",month,"totalcost");
 st=st+s;
    put$s / @10 "Reinvest" @43 s:8:0 /;
s=usemoney(month,"cashflow",month,"totalcost");
 st=st+s;
    put$s / @10 "Authority Draw    " @43 s:8:0 /;
s=usemoney(month,"endbalance",month,"totalcost");
 st=st+s;
    put$s / @10 "Ending Balance " @43 s:8:0 /;
    put / @10 "Totals            " @33 "Cash used" st:9:0

    );

put // "Schedule VII --  Raw Security Data Used "//
put "                       Price              Coupon    Coupon     Short"/
put "                      Less Any            6 months 12 months   Term   "
put "Minimum "/
put "Name of     Model     Payments    Mature  before    before   Reinvest "
put "  Lot   Maximum"/

put "Security   Maturity   to Seller    Value  Maturity Maturity   Income  "
put " Size   Available"/
loop((investment,months)$sum(item,returndata(investment,months,item)),
    put investment.tl:11 months.tl:10
    put returndata(investment,months,"price"):10:4;
    put returndata(investment,months,"matureval"):10:3;
    put returndata(investment,months,"prior6"):8:2;
    put returndata(investment,months,"prior12"):9:2;
    put returndata(investment,months,"reinvest"):10:3;
    put returndata(investment,months,"minreq"):7:0;
    put$returndata(investment,months,"maxav")
        returndata(investment,months,"maxav"):7:0;
     put /);

$ontext
#user model library stuff
Main topic  MIP
Featured item 1 MIP
Featured item 2
Featured item 3
Featured item 4
Description
Illustrate mip model
$offtext
