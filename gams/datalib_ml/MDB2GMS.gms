$ontext
   Runs MDB2GMS interactively.
   It offers the user first a menu of options, which
   includes "mdb2gms" help, "mdb2gms" PDF documentation
   and running "mdb2gms" interactively.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > ask.opt
T=radiobuttons
M=MDB2GMS Access->GAMS database import facility
D=Show help|Show PDF docs|Run interactively
E=1|2|3
R=scalar task /%s/;
O=task.inc
$offecho

$call =ask @ask.opt
$include task.inc

if (task=1,
  execute '=shellexecute "%gams.sysdir%mdb2gms.chm"';
elseif task=2,
  execute '=shellexecute "%gams.sysdir%docs\tools\mdb2gms.pdf"';
else
  execute 'mdb2gms';
);
