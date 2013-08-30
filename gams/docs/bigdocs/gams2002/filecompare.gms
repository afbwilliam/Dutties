*identify name of first file to compare
$setglobal file1 "tranerr.gms"
*identify name of second file to compare
$setglobal file2 "tranport.gms"
*show the control variables so you can check names are rifht
$show
*invoke the difference
$call "diff.exe %file1% %file2%"

*note the differences are shown in the LOG file
