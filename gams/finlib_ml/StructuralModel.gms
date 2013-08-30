$TITLE Indexation model using the structural approach

* StructuralModel.gms: Indexation model using the structural approach
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 7.2.1
* Last modified: Apr 2008.

SETS  BB          Available bonds
      EE          Available currencies
      BxE(BB,EE)  Bonds by Currencies
      CC          Data columns

PARAMETER data(BB,CC) Raw data;

$gdxin InputData
$load BB EE BxE CC data
$gdxin

SETS DD Duration levels / LOW, MEDIUM, HIGH /
     BxD(BB,DD) Bonds by Duration levels;

ALIAS (BB,i)
ALIAS (EE,e)
ALIAS (DD,k);


* Partition the set of bonds by duration levels

BxD(i,'LOW') = data(i,'Duration') <= 3;

BxD(i,'MEDIUM') = data(i,'Duration') > 3 and data(i,'Duration') <= 7;

BxD(i,'HIGH') = data(i,'Duration') > 7;



* The index dollar duration

SCALARS IndexDollarDuration  /820/;

PARAMETERS
         DurationWeights(k) / LOW 0.3, MEDIUM 0.2, HIGH 0.5 /
         CurrencyWeights(e) / USD 0.6, DEM 0.3, CHF 0.1 /;

VARIABLE
         z;

POSITIVE VARIABLES
         x(i);


EQUATIONS
         ObjDef              Linear approximation of the portfolio yield
         ObjDefTwo           NonLinear approximation of the portfolio yield
         NormalCon           Equation defining the budget contraint
         DurationMatch       Equation matching the dollar duration of the portfolio and of the index
         CurCons(e)          Equation matching the index currency allocation
         DurCons(k)          Equation matching the index duration allocation;

ObjDef..         z =E= - SUM(i, data(i,'Duration') * data(i, 'Price') * data(i,'Yield') * x(i)) / IndexDollarDuration;

DurationMatch .. SUM(i, data(i,'Duration') * data(i, 'Price') * x(i)) =E= IndexDollarDuration;

CurCons(e)..    SUM(i$BxE(i,e), x(i) ) =E= CurrencyWeights(e);

DurCons(k)..    SUM(i$BxD(i,k), x(i) ) =E= DurationWeights(k);

NormalCon..      SUM(i, x(i)) =E= 1.0;

MODEL IndexFund 'PFO Model 7.3.1' /ObjDef,DurationMatch,CurCons,DurCons,NormalCon/;

SOLVE IndexFund MAXIMIZING z USING LP;

DISPLAY x.l,z.l;

* If we let the duration of the portfolio unconstrained, the objective
* function turns to nonlinear as the variable x(i) will appear in the denominator


ObjDefTwo..         z =E= - SUM(i, data(i,'Duration') * data(i, 'Price') * data(i,'Yield') * x(i)) /
                          SUM(i, data(i,'Duration') * data(i, 'Price') * x(i));

MODEL NonLinearIndexFund /ObjDefTwo,CurCons,DurCons,NormalCon/;

SOLVE NonLinearIndexFund MAXIMIZING z USING NLP;

DISPLAY x.l,z.l;