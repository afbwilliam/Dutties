$ontext
   Run SQL2GMS interactively.
   It offers the user first a menu of options, which
   includes "sql2gms" help, "sql2gms" PDF documentation
   and running "sql2gms" interactively.
$offtext

$if %system.filesys% == UNIX $abort.noerror 'This model cannot run on a non-Windows platform';

$onecho > ask.opt
T=radiobuttons
M=SQL2GMS SQL database->GAMS import facility
D=Show help|Show PDF docs|Run interactively
E=1|2|3
R=scalar task /%s/;
O=task.inc
$offecho

$call =ask @ask.opt
$include task.inc

if (task=1,
  execute '=shellexecute "%gams.sysdir%sql2gms.chm"';
elseif task=2,
  execute '=shellexecute "%gams.sysdir%docs\tools\sql2gms.pdf"';
else
  execute 'sql2gms';
);
