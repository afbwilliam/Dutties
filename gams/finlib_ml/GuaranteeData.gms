$TITLE Data for the Insurance Policies with Guarantee - The Prometeia Model.

* GuaranteeData.gms: Data for the Insurance Policies with Guarantee
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 8.4
* Last modified: Apr 2008.

* Since all data input is via data definition we can place the statement below
* at the any place in this program. GAMS is two pass system.

EXECUTE_UNLOAD 'GuaranteeData';

SETS
         TT Time                 /TT_1 * TT_10/
         SS Number of scenarios  /SS_1 * SS_500/
         AA Set of Assets    /
                              AA_1        SBGVNIT.1-3
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

$INCLUDE "AssetReturns-Guarantee.inc";
$INCLUDE "AbandonProbabilities.inc";
$INCLUDE "PeriodicCapFactors.inc";
$INCLUDE "CapFactors.inc";
