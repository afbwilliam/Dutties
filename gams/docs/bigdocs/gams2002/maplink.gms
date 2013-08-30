*illustrate put of csv file
sets meas /nitrogen,phosporous,potassium,cropland,
                   watererosn,winderosn,sediment,pub-water,pumpwater,
                   chemicalco/;
sets region /EAST,STHEAST,MIDWEST,WEST,STHCENTRAL,NORTHERNPL  /
table data(region,meas) data to be put
                nitrogen   phosporous  potassium  chemicalco  cropland
EAST               0.96      -0.17       0.52      -0.24       0.00
STHEAST            0.13       0.09       0.13      -0.12       0.02
MIDWEST            0.40       0.36       0.54      -0.03       0.36
WEST               1.74       1.51       1.73       0.59       1.63
STHCENTRAL        -0.09      -0.15       0.04       0.17       0.12
NORTHERNPL         3.55       1.70       2.59       3.16       1.65
  +             watererosn winderosn sediment pub-water pumpwater
EAST             -1.14      0.01     -1.16      0.00    -10.71
STHEAST           3.13      0.67      3.64      0.34      0.00
MIDWEST          -0.23      0.59     -0.23      0.00     -1.11
WEST              0.57      0.02      0.74      0.01      0.26
STHCENTRAL       -0.16     -1.33     -0.08      0.00     -1.55
NORTHERNPL        0.92     -3.06      0.85      0.00     -0.07

file mapdat;
put mapdat;
mapdat.pw=250;
set s1(meas) /nitrogen,phosporous,potassium,chemicalco,cropland/
put '"region"'; loop(s1,put ' , "' s1.tl '"'); put /;
loop(region,
   put '"' region.tl '"'; loop(s1,put ',' data(region,s1):10:2); put /);
set s2(meas) / watererosn,winderosn,sediment,pub-water,pumpwater/
put '"region"'; loop(s2,put ' , "' s2.tl '"'); put /;
loop(region,
   put '"' region.tl '"'; loop(s2,put ',' data(region,s2):10:2); put /);


$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 CSV
Featured item 2 Put
Featured item 3
Featured item 4
Description
Illustrate put of csv file
$offtext
