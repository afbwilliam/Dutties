$TITLE Personal Asset Allocation

* PersonalAssetAllocation.gms: Personal Asset Allocation.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 8.5
* Last modified: May 2008.


$INCLUDE "PersonalCommonInclude.inc";


PARAMETER ar(l,t,i)
/
$ONDELIM
$INCLUDE "AssetReturns-PersonalAssetAllocation.inc";
$OFFDELIM
/;

PARAMETER lblty(l,t)
/
$ONDELIM
$INCLUDE "LiabilityScenarios.inc";
$OFFDELIM
/;

PARAMETER infltn(l,t)
/
$ONDELIM
$INCLUDE "InflationScenarios.inc"
$OFFDELIM
/;


PARAMETER cfs(l,t)
/
$ONDELIM
$INCLUDE "CapFactorsScenarios.inc"
$OFFDELIM
/;



POSITIVE VARIABLES
   HO(i)           Asset holdings
   YP(l,t)         yPlus - surplus in excess of  growth rate.
   YM(l,t)         yMinus - deficit in lack of growth rate.;

FREE VARIABLES
   OF              Objective function value;


EQUATIONS
   OFe             Objective Function equation (Call).
   OFPCe           Objective Function equation (Call - lambda * Put).
   BAe             BAlance equation.
   PUTe            Constraint to bound the expected value of the negative deviations.
   YPMd(l,t)       Equations defining the yPlus and yMinus dynamics;


OFe..          OF =E= (1.0/CARD(l)) * SUM(l, SUM(t, lblty(l,t) * YP(l,t) * cfs(l,t)));

OFPCe..        OF =E= (1.0/CARD(l)) * (SUM(l, SUM(t, lblty(l,t) * YP(l,t) * cfs(l,t))) -
                        lambda * SUM(l, SUM(t,lblty(l,t) * YM(l,t) * cfs(l,t))));

PUTe ..        SUM(l, SUM(t,lblty(l,t) * YM(l,t) * cfs(l,t))) / CARD(l)  =L= omega;

BAe..          SUM(i, HO(i)) =E= ipv;

YPMd(l,t)..  SUM( i, (HO(i) * ar(l,t,i))) - (grr + infltn(l,t)) =E= YP(l,t) - YM(l,t);


*  Model that maximizes the Call side with  bound on the Put side

MODEL PersonalModelOne 'PFO Model 13.5.1' /OFe,PUTe,BAe,YPMd/;

PersonalModelOne.RESLIM = 100000000;
PersonalModelOne.ITERLIM = 100000000;

HO.UP(i) = ipv;

SOLVE PersonalModelOne USING LP MAXIMIZING OF;

FILE AssetAllocationHandle /"PAA.csv"/;

AssetAllocationHandle.pc = 5;
AssetAllocationHandle.pw = 1048;

PARAMETER
   YpYm(l,t);

YpYm(l,t) = YP.l(l,t) * YM.l(l,t);

DISPLAY YpYm,PUTe.M;


PUT AssetAllocationHandle;

PUT "Maximize the Call side with bound on the Put side"/;

LOOP(i,

   PUT CARD(l):0:0,CARD(t):0:0,nbryears:0:0,omega:0:3,agrr:0:4,i.TL,i.TE(i),HO.L(i):12:8/;

);


*  Model that maximizes the Call side and minimize the Put side

MODEL PersonalModelTwo /OFPCe,BAe,YPMd/;

PersonalModelTwo.RESLIM = 100000000;
PersonalModelTwo.ITERLIM = 100000000;

HO.UP(i) = ipv;

SOLVE PersonalModelTwo USING LP MAXIMIZING OF;

YpYm(l,t) = YP.l(l,t) * YM.l(l,t);

DISPLAY YpYm;

PUT "Maximize the Call side and minimize the Put side"/;

LOOP(i,

   PUT CARD(l):0:0,CARD(t):0:0,nbryears:0:0,lambda:0:3,agrr:0:4,i.TL,i.TE(i),HO.L(i):12:8/;

);