*demonstrate ondelim

SETS
   PLANT  PLANT LOCATIONS /NEWYORK,CHICAGO,LOSANGLS /
   MARKET DEMANDS  /MIAMI,HOUSTON, PORTLAND/
table datafrmcsv(plant,market)  data in csv format
$ondelim
$include csvtoinc
$offdelim
display datafrmcsv;

$ontext
#user model library stuff
Main topic Include
Featured item 1 CSV
Featured item 2 $Ondelim
Featured item 3
Featured item 4
Description
demonstrate ondelim with CSV file for inclusion

$offtext
