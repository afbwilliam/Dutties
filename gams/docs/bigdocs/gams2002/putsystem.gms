*Illustrate put of system attributes

file my1;
put my1;
put 'LP       ' system.lp        /;
option lp=osl;
$title my run
put 'CNS      ' system.CNS       /;
put 'DNLP     ' system.DNLP       /;
put 'date     ' system.date      /;
put 'gstring  ' system.gstring   /;
put 'ifile    ' system.ifile     /;
put 'iline    ' system.iline     /;
put 'lice1    ' system.lice1     /;
put 'lice2    ' system.lice2     /;
put 'LP       ' system.lp        /;
put 'MIP      ' system.MIp       /;
put 'MINLP    ' system.MINlp     /;
put 'NLP      ' system.Nlp       /;
put 'MCP      ' system.MCp       /;
put 'MPEC     ' system.MPEC      /;
put 'ofile    ' system.ofile     /;
put 'opage    ' system.opage     /;
put 'page     ' system.page      /;
put 'pfile    ' system.pfile     /;
put 'platform ' system.platform  /;
put 'prline   ' system.prline    /;
put 'prpage   ' system.prpage    /;
put 'rdate    ' system.rdate     /;
put 'rfile    ' system.rfile     /;
put 'RMINLP   ' system.RMINlp    /;
put 'RMIP     ' system.RMIp      /;
put 'rtime    ' system.rtime     /;
put 'time     ' system.time      /;
put 'title    ' system.title     /;
put 'version  ' system.version   /;
put 'fe       ' '%system.fe%'    /;
put 'fp       ' '%system.fp%'    /;
put 'fn       ' '%system.fn%'    /;

put 'sstring  ' system.sstring   /;

$ontext
#user model library stuff
Main topic Output via Put
Featured item 1 Put
Featured item 2 System.xxx
Featured item 3 System attributes
Featured item 4
Description
Illustrate put of system attributes
$offtext
