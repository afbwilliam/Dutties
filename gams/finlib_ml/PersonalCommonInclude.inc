SET TT Time span /TT_1 * TT_10/

SET SS Set of scenarios /SS_1 * SS_1000/;

SET AA Set of Assets
   /AA_1    MSNAMR
    AA_2    MSPACF
    AA_3    MSEMKG
    AA_4    MSEMUI
    AA_5    MSEXEM
    AA_6    JPMUSU
    AA_7    JPMJPU
    AA_8    JAGALL
    AA_9    JPMUKU
    AA_10   SBSZEUE
    AA_11   JPMPTOT
    AA_12   JPEC3M
    AA_13   JPUS3M
    AA_14   JPJP3ML/;

* IMPORTANT NOTE
* The only parameters that can be modified are:
* lambda and omega


SCALARS
   grr         Growth rate /0.04/
   agrr        Annual growth rate /0.04/
   lambda      Risk Aversion /3.0/
   omega       Risk Level /0.15/
   nbryears    Number Of Years /10/
   ipv         Initial portfolio value /1/;

ALIAS(SS,l);
ALIAS(AA,i);
ALIAS(TT,t,k);