SET TT Time span /TT_1 * TT_10/

SET SS Number of scenarios /SS_1 * SS_500/;

SET AA Set of Assets
   /AA_1        SBGVNIT.1-3
    AA_2        SBGVNIT.3-7
    AA_3        SBGVNIT.7-10
    AA_4        ITMSBNK
    AA_5        ITMSAUT
    AA_6        ITMSCEM
    AA_7        ITMSCST
    AA_8        ITMSDST
    AA_9        ITMSELT
    AA_10        ITMSFIN
    AA_11        ITMSFPA
    AA_12        ITMSFMS
    AA_13        ITMSFNS
    AA_14        ITMSFOD
    AA_15        ITMSIND
    AA_16        ITMSINM
    AA_17        ITMSINS
    AA_18        ITMSPUB
    AA_19        ITMSMAM
    AA_20        ITMSPAP
    AA_21        ITMSMAC
    AA_22        ITMSPSU
    AA_23        ITMSRES
    AA_24        ITMSSER
    AA_25        ITMSTEX
    AA_26        ITMST&T/;

SCALARS
   mig      Minimum Guarantee /0.04/
   ptr      Partecipation Rate /0.85/
   ili      Initial Liability /1.0/
   txr      Tax Rate for shareholders /0.51/
   rho      Equity Ratio /0.04/;

ALIAS(SS,l);
ALIAS(TT,t,k);
ALIAS(AA,i,j);