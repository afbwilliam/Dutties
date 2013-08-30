*illustrate the conditional compile test for open put files
file myfile;
put myfile;
$if putopen $goto arond
*connment not again
file myfile;
put myfile;
$label arond
putclose myfile
$if putopen $goto narond
*connment not again
file notmyfile;
put notmyfile;
$label narond

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 Conditional compile
Featured item 3 Putopen
Featured item 4 $If putopen
Description
Illustrate the conditional compile test for open put files
$offtext
