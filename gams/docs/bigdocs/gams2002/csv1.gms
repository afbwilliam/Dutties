SETS
   PLANT  PLANT LOCATIONS /NEWYORK,CHICAGO,LOSANGLS /
   MARKET DEMANDS  /MIAMI,HOUSTON, PORTLAND/
table datafrmcsv(plant,market)  data in csv format
$ondelim
dummy,MIAMI,HOUSTON,PORTLAND
NEWYORK,1300,1800,1100
CHICAGO,2200,1300,700
LOSANGLS,3700,2400,2500
$offdelim
display datafrmcsv;

table datafrmcsv2(plant,market)  data in csv format
$ondelim
,MIAMI,HOUSTON,PORTLAND
NEWYORK,1300,1800,1100
CHICAGO,2200,1300,700
LOSANGLS,3700,2400,2500
$offdelim
display datafrmcsv2;

$ontext

#user model library stuff
Main topic CSV
Featured item 1 CSV
Featured item 2 $Ondelim
Featured item 3
Featured item 4
Description
demonstrate ondelim with CSV typed data


$offtext
