set fileset /
DedicationNoBorrow
MeanVar
Estimate
MeanVarShort
Sharpe
Borrow
MeanVarMip
InternationalMeanVar
JDate
DiscreteFinCalc
ContinuousFinCalc
Bootstrap
Dedication
Horizon
DedicationMIP
Immunization
FactorImmunization
FactorYieldImmunization
CreditImmunization
MAD
TrackingMAD
Regret
CVar
Utility
PutCall
StochDedication
StochDedicationBL
TwoStageDeterministic
TwoStageStochastic
ThreeStageSPDA
ReadData
StructuralModel
ComovementsModel
SelectiveHedging
BondIndex
BondIndexData
Corporate
CorporateCVaR
GuaranteeModel
PersonalAssetAllocation
GuaranteeData
GuaranteeModelGDX /;

file outfile /LibraryTestScript.gms /; outfile.nw=0; outfile.nd=0; outfile.pw=32000;

put outfile '$set fdir C:\Documents and Settings\esen\My Documents\svn\finlib\FinLib3' /;
put '$set ftrace trace_results.gms' /;

loop(fileset,
    if(sameas(fileset,"FactorImmunization"),
        put '$call gams ' fileset.tl:30:30 ' idir = "%fdir%" trace=%ftrace% -save FactorSave' /;
    elseif sameas(fileset,"FactorYieldImmunization"),
        put '$call gams ' fileset.tl:30:30 ' idir = "%fdir%" trace=%ftrace% -restart FactorSave' /;
    else
        put '$call gams ' fileset.tl:30:30 ' idir = "%fdir%" trace=%ftrace%' / ));
putclose;

