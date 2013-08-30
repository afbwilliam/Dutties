
SET Assets Set of Assets /RF, AA_1 * AA_17/;

SET Scenarios  Number of scenarios /SS_1 * SS_10000/;

ALIAS (Assets, i);

ALIAS (Scenarios, l);

SET BroadAssetClasses Number of broad asset classes /BA_1,BA_2,BA_3/;

ALIAS (BroadAssetClasses, j);

SET BroadAssetClassOne(i) First broad asset class /RF, AA_1 * AA_5/;
SET BroadAssetClassTwo(i) Second broad asset class /AA_6 * AA_11/;
SET BroadAssetClassThree(i) Third broad asset class /AA_12 * AA_17/;


ALIAS (BroadAssetClassOne, m1);
ALIAS (BroadAssetClassTwo, m2);
ALIAS (BroadAssetClassThree, m3);

SET ACTIVE(Assets);

ALIAS (ACTIVE, a);
