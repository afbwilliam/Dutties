$TITLE Factor Immunization model for corporate bonds

* CreditImmunization.gms:  Factor Immunization model for corporate bonds.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.6
* Last modified: Apr 2008.


SETS
    i        Maximum number of securities    /Bond-1 * Bond-13/
    j        Factors risk types              /shift, tilt, curve/
    class    Rating classes                  /AAA, B3/
    ja(j)    Active factors;


SCALAR
        BaseDate Earliest liability date;

$INCLUDE "TimeDefinitionSets.inc"

$INCLUDE "CreditYieldRates.inc"

* Continous yields

yield(ty,class,'yield')= log( 1 + ( yield(ty,class,'interest') /100 ) ) * 100;

DISPLAY yield;

$INCLUDE "BondAndLiabilityData.inc"

PARAMETERS
                rl(tl,class)     Interest rate of liability
                pl(class)        Present value of liability
                r(ts,class)      Current yield of bonds
                cf(ts,i,class)   Cash flow of bonds
                p(i,class)       Present value of bonds (current price)
                pv(i,class)      Present value of cashflows of bonds
                k(i,class)       Dollar duration of bonds;


BaseDate = SMIN(tl, jdate(LiabData(tl,'year'),LiabData(tl,'month'),LiabData(tl,'day')));

DISPLAY BaseDate;

* Convert time points from days to year units.

LiabData(tl,'days') = jdate(LiabData(tl,'year'),LiabData(tl,'month'),LiabData(tl,'day')) - BaseDate;
LiabData(tl,'term') = LiabData(tl,'days')/365;

stime(ts,'days') = jdate(stime(ts,'year'),stime(ts,'month'),
                   stime(ts,'day'))- BaseDate;
stime(ts,'term') = stime(ts,'days') / 365;


* Compute term structure data for liabilities and bonds on their dates,
* using interpolation:


LOOP( (tl,ty,class)$(yield(ty,class,"term") eq trunc(LiabData(tl,"term"))),

                rl(tl,class) = ( yield(ty,class,"yield" ) +
                       ( yield(ty+1,class,"yield") - yield(ty,class,"yield") ) /
                                           ( yield(ty+1,class,"term") - yield(ty,class,"term") ) * ( LiabData(tl,"term") - yield(ty,class,"term") ) ) / 100

);

LOOP( (ts,ty,class)$(yield(ty,class,"term") eq trunc(stime(ts,"term"))),

                r(ts,class) = ( yield(ty,class,"interest" ) +
                          ( yield(ty+1,class,"interest" ) - yield(ty,class,"interest") ) /
                                          ( yield(ty+1,class,"term") - yield(ty,class,"term") ) * ( stime(ts,"term") - yield(ty,class,"term") ) ) / 100

);

DISPLAY rl,r,yield,LiabData;

pl(class)      =  SUM( tl, LiabData(tl,'liability') * exp(-rl(tl,class)*LiabData(tl,'term')) );

cf(ts,i,class) =  BondData(ts,i,class);

p(i,class)     =  BondData('price',i,class) + BondData('accr',i,class) ;

pv(i,class)    =  SUM( ts, cf(ts,i,class) * ( 1 + r(ts,class)/2 )**( -2*stime(ts,'term') ) );

k(i,class)     = -SUM( ts, cf(ts,i,class) *  stime(ts,'term') * ( 1 + r(ts,class)/2 )**(-2*stime(ts,'term') - 1) );


* note: (4) dollar amounts scaled by 10 to indicate par value.
*       (5) current price used to indicate present value.
*       (6) dollar duration and dollar convexity uses semiannual compounding.

DISPLAY  k;

$INCLUDE "FactorLoadings.inc"

PARAMETERS
                sfac(ts,class,j)    Interpolated factor loadings on term of securities
                lfac(tl,class,j)    Interpolated factor loadings on term of liabilities
                f(i,j,class)        Factor sensitivities of securities
                fl(j,class)         Factor sensitivities of liabilities ;

SCALAR
        lambda     Penalty on squared deviations from given factor liability;


LOOP( (ts,tf,class)$( a(tf,class,"term") eq trunc(stime(ts,"term"))),

                sfac(ts,class,j) = ( a(tf,class,j) + ( a(tf+1,class,j) - a(tf,class,j) ) /
                                                   ( a(tf+1,class,"term") - a(tf,class,"term") ) * (stime(ts,"term")-a(tf,class,"term") ) ) / 100

);

LOOP( (tl,tf,class)$(a(tf,class,"term") eq trunc(LiabData(tl,"term"))),

                lfac(tl,class,j) = ( a(tf,class,j) + ( a(tf+1,class,j) - a(tf,class,j) ) /
                                                   ( a(tf+1,class,"term") - a(tf,class,"term") ) * ( LiabData(tl,"term") - a(tf,class,"term") ) ) / 100

);


f(i,j,class) = - SUM( ts, sfac(ts,class,j) * cf(ts,i,class) * stime(ts,"term") *
                                        ( 1 + r(ts,class)/2 )**( -2*stime(ts,'term')-1 ) );

fl(j,"AAA")  = - SUM( tl, lfac(tl,"AAA",j) * LiabData(tl,"liability") * LiabData(tl,"term") * exp(-rl(tl,"AAA")*LiabData(tl,"term")) );

fl(j,"B3")  = - SUM( tl, lfac(tl,"B3",j) * LiabData(tl,"liability")/100 * LiabData(tl,"term") * exp(-rl(tl,"B3")*LiabData(tl,"term")) );


POSITIVE VARIABLE
   x(i,class)      Holdings of bonds (amount of face value);

POSITIVE VARIABLE
   long(i,class)      Holdings of bonds (amount of face value)
   short(i,class)     Holdings of bonds (amount of face value);

VARIABLES
   z                    Objective function value
   Deviations(j,class)  Deviations from the correspondent liability factor level;


EQUATIONS
   PresentValueMatchOne          Equation matching the present value of asset and liability
   PresentValueMatchTwo          Equation matching the present value of asset and liability
   DurationMatchOne(j,class)     Equation matching the factor duration of asset and liability for each credit class
   DurationMatchTwo(j,class)     Equation matching the factor duration of asset and liability for each credit class
   DeviationsEq(j,class)         Equation defining the deviation from the correspondent liability factor
   xDef(i,class)                 Equation defining the asset allocations as the sum of long and short positions
   xShort                        Equation limiting the amount of bonds shorted
   ObjDefOne                     Objective function definition (only AAA bonds)
   ObjDefTwo                     Objective function definition (both credit classes)
   ObjDefThree                   Objective function definition (minimizing also the sum of the squared deviations);


ObjDefOne ..                  z =E= SUM(i, k(i,"AAA")* ( BondData('yield',i,"AAA") / 100 ) * x(i,"AAA") );

ObjDefTwo ..                  z =E= SUM((i,class), k(i,class) * ( BondData('yield',i,class) / 100 ) * x(i,class) );

ObjDefThree ..                z =E= (SUM(i, k(i,"AAA")* ( BondData('yield',i,"AAA") / 100 ) * x(i,"AAA") ) +
                                    lambda * SUM((ja,class), SQR(Deviations(ja,class))))/1000000;


PresentValueMatchOne ..           SUM(i, pv(i,"AAA")*x(i,"AAA")) =E= pl("AAA");

DurationMatchOne(ja,"AAA") ..     SUM(i, f(i,ja,"AAA")*x(i,"AAA")) =E= fl(ja,"AAA");

PresentValueMatchTwo ..           SUM((i,class), pv(i,class)*x(i,class)) =E= pl("AAA");

DurationMatchTwo(ja,class) ..     SUM(i, f(i,ja,class)*x(i,class)) =E= fl(ja,"AAA");

DeviationsEq(ja,class) ..         Deviations(ja,class) =E= SUM(i, f(i,ja,class)*x(i,class))- fl(ja,"AAA");

xDef(i,class)..                   x(i,class) =E= long(i,class) - short(i,class);

xShort         ..                 SUM((i,class), short(i,class)) =L= 5000.0;


MODEL FactorCreditOne 'PFO Model 4.5.1' /ObjDefOne, PresentValueMatchOne, DurationMatchOne/;

MODEL FactorCreditTwo /ObjDefTwo, PresentValueMatchTwo, DurationMatchTwo/;

MODEL FactorCreditThree /ObjDefTwo, PresentValueMatchTwo, DurationMatchTwo, xDef, xShort/;

MODEL FactorCreditFour /ObjDefThree, PresentValueMatchTwo, DeviationsEq/;

ja( "shift" ) = YES;
ja( "tilt" )  = YES;
ja( "curve" ) = YES;

OPTION LIMROW = 100, LIMCOL = 100;

PARAMETER SummaryReport;


SOLVE  FactorCreditOne MINIMIZING z USING LP;

SummaryReport(class,i,'one') = x.l(i,class);
SummaryReport('model','status','one') = FactorCreditOne.MODELSTAT;

SOLVE  FactorCreditTwo MINIMIZING z USING LP;

SummaryReport(class,i,'two') = x.l(i,class);
SummaryReport('model','status','two') = FactorCreditTwo.MODELSTAT;

DISPLAY i,pv,pl,f,fl,x.L;

x.LO(i,class) = -INF;


SOLVE  FactorCreditThree MINIMIZING z USING LP;

SummaryReport(class,i,'three') = x.l(i,class);
SummaryReport('model','status','three') = FactorCreditThree.MODELSTAT;

DISPLAY ja,class,x.L;

x.LO(i,class) = 0.0;

lambda = 2;

SOLVE  FactorCreditFour MINIMIZING z USING NLP;

SummaryReport(class,i,'four') = x.l(i,class);
SummaryReport('model','status','four') = FactorCreditFour.MODELSTAT;

DISPLAY x.L,Deviations.L,fl;

DISPLAY SummaryReport;

EXECUTE_UNLOAD 'CreditSummary.gdx', SummaryReport;
EXECUTE 'gdxxrw.exe CreditSummary.gdx O=CreditSummary.xls par=SummaryReport rng=sheet1!a1' ;