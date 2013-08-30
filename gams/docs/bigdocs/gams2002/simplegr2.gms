*Illustrate GNUPLTXY usage with titles and labeling

SETS
LINES      Lines in graph /A,B/
POINTS     Points on line /1*10/
ORDINATES  ORDINATES      /X-AXIS,Y-AXIS/  ;

TABLE GRAPHDATA(LINES,POINTS,ORDINATES)
       X-AXIS   Y-AXIS
A.1       1       1
A.2       2       4
A.3       3       9
A.4       5      25
A.5      10     100
B.1       1       2
B.2       3       6
B.3       7      15
B.4      12      36
;
$LIBINCLUDE GNUPLTXY GRAPHDATA Y-AXIS X-AXIS
$setglobal gp_title  "First Graph of data "
$setglobal gp_xlabel "Label for X Axis"
$setglobal gp_ylabel "Label for Y Axis"
$LIBINCLUDE GNUPLTXY GRAPHDATA Y-AXIS X-AXIS
GRAPHDATA("B",POINTS,"Y-axis")
        $GRAPHDATA("B",POINTS,"Y-axis")=
    100-GRAPHDATA("B",POINTS,"Y-axis");
$setglobal gp_title  "Second Graph of data with modified line B "
$LIBINCLUDE GNUPLTXY GRAPHDATA Y-AXIS X-AXIS

$ontext
#user model library stuff
Main topic Output
Featured item 1 Graphics
Featured item 2 GNUPLTXY.gms
Featured item 3
Featured item 4
Description
Illustrate GNUPLTXY usage with titles and labeling

$offtext
