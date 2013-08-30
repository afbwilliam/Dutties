$ontext
Uses Rutherford canned output gams2tbl routines

$offtext
set columns / a Horses,b Cows,c Chickens/
set rows /r1 Housing,r2 Land,r3 Feed/
table data (rows,columns) Table with default formatting
              a            b              c
r1            1          14.8233        12.99
r2            2           12              2.2
r3            3           11              3.2;
file ruthput ; put ruthput ;
$libinclude gams2tbl
$libinclude gams2tbl data
parameter roworder(rows) /r1 3,r2 1,r3 2/;
parameter colorder(columns) /a 2,b 3, c 1/  ;
$setglobal row_order roworder
$setglobal col_order colorder
$setglobal title "Table 2 where item ordering is controlled"
$libinclude gams2tbl data
$setglobal row_label rows
$setglobal col_label columns
$setglobal title "Table 3 where labels for set items are used"
$libinclude gams2tbl data
parameter decimals(columns) /a 0,b 4 ,c 1/  ;
$setglobal c_decimals decimals
$setglobal title "Table 4 where decimals are controlled"
$libinclude gams2tbl data

$ontext
#user model library stuff
Main topic Output
Featured item 1 GAMS2tbl
Featured item 2 Put
Featured item 3
Description
Uses Rutherford canned output gams2tbl routines

$offtext
