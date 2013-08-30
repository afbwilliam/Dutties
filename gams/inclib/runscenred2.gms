* runscenred2.gms
* %1 ident to keep files distinct
* %2 instruction tree_con or scen_red
* %3 nodes
* %4 ancestor relation
* %5 probability
* %6 ancestor relation of reduced tree
* %7 probability of reduced tree
* %8 ... random value

$setargs ident instr n anc p newanc newp *
$if not declared scenRedParms $libinclude scenred2

scenRedParms('%instr%') = 1;

* Remove GDX files to ensure that we don't get old stuff
$set closeGDX
$if not %system.filesys% == UNIX $set closeGDX || IDECmds ViewClose %ProjDir%\sr2%ident%_in.gdx && rm -f sr2%ident%_in.gdx
execute "rm -f sr2%ident%_in.gdx %closegdx%"
execute "=test -e sr2%ident%_in.gdx"; abort$(errorlevel=0) 'sr2%ident%_in.gdx still exists';
$if not %system.filesys% == UNIX $set closeGDX || IDECmds ViewClose %ProjDir%\sr2%ident%_out.gdx && rm -f sr2%ident%_out.gdx
execute "rm -f sr2%ident%_out.gdx %closegdx%"
execute "=test -e sr2%ident%_out.gdx"; abort$(errorlevel=0) 'sr2%ident%_out.gdx still exists';

execute_unload 'sr2%ident%_in.gdx', scenRedParms, %n%, %anc%, %p%
$set rv ,%8
$label morerv
$if not x%9==x $set rv '%rv%,%9' $shift $goto morerv
%rv%;

* Call scenred2
$set runide
$ife %gams.ide%>0 $set runide -i
execute 'scenred2 %runide% -p %ident% %system.redirlog%';
scenRedRC = errorlevel;
abort$scenRedRC "Nonzero return code from scenred2 indicates error : ", scenRedRC;

execute_load 'sr2%ident%_out.gdx', ScenRedReport
$ifi not %newanc%==na , %newanc%=red_ancestor
$ifi not %newp%==na   , %newp%=red_prob
;

