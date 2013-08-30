@echo off

: gams grid submission script
:
: arg1 solver executable
:    2 control file
:    3 scratch directory
:    4 solver name
:
: gmscr_nx.exe processes the solution and produces 'gmsgrid.gdx'
:
: note: %3 will be the short name, this is neeeded because
:       the START command cannot handle spaces or "...'
:       before we use %~3  will strip surrounding "..."
:       makes the name short
:
: gmsrerun.cmd will resubmit runit.cmd

echo @echo off                      > %3runit.cmd
echo %1 %2 %4                      >> %3runit.cmd
echo gmscr_nx.exe %2               >> %3runit.cmd
echo echo OK ^> %3finished ^& exit >> %3runit.cmd

echo @start /b /belownormal %3runit.cmd ^> nul  > %3gmsrerun.cmd

start /b /belownormal %3runit.cmd > nul

exit
