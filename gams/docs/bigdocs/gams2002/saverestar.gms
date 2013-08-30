*Execute GAMS from GAMS to act like batch file and manage save and restart

*run without logging
execute "GAMS trandata         s=s1"
execute "GAMS tranmodl  r=s1   s=s2"
execute "GAMS tranrept  r=s2"

*run with logging
file logger a blank file name writes to the log / '' /;
putclose logger '***' / '*** now comes the run with logging' / '***';

$set gamsparm "ide=%gams.ide% lo=%gams.lo% errorlog=%gams.errorlog% errmsg=1"
$show
execute "GAMS trandata  %gamsparm%         s=s1"
execute "GAMS tranmodl  %gamsparm%  r=s1   s=s2"
execute "GAMS tranrept  %gamsparm%  r=s2"

$ontext
#user model library stuff
Main topic GAMS from GAMS
Featured item 1 Batch file
Featured item 2 Save restart
Featured item 3
Featured item 4
Description
Execute GAMS from GAMS to act like batch file and manage save and restart

$offtext
