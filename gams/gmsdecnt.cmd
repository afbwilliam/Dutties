@echo off
:GAMS/DECIS driver
: %1 scratch directory
: %2 working directory
: %3 gamsparm file for restarting GAMS
: %4 control file
: %5 system directory

: kill mailbox file and files to be created
if exist mailbox.err del mailbox.err
if exist model.cor del model.cor
if exist model.tim del model.tim
if exist model.sto del model.sto
if exist model.sog del model.sog
if exist model.mo  del model.mo
if exist model.inp del model.inp
if exist model.obj del model.obj
if exist model.err del model.err
if exist model.sol del model.sol
if exist model.map del model.map
if exist model.spa del model.spa


: create file with filenames
echo model.cor  > model.fln
echo model.tim >> model.fln
echo model.inp >> model.fln
echo model.obj >> model.fln
echo model.map >> model.fln
echo model.stg >> model.fln
echo model.sto >> model.fln
echo model.err >> model.fln
echo model.sog >> model.fln
echo model.scr >> model.fln
echo model.spa >> model.fln


: reorder matrix
gmsdernx "%~4" model.fln
if exist mailbox.err goto restart


: translate the put file
gmsdetnx "%~4" model.fln
if exist mailbox.err goto restart


:call DECIS here
: input: GAMS.COR, GAMS.STO, GAMS.TIM
: output: GAMS.SOL
if exist model.mo del model.mo
if exist model.so del model.so
if exist model.bo del model.bo
if exist model.spr del model.spr
if exist model.scr del model.scr
if exist model.rep del model.rep
if exist model.sol del model.sol
if exist model.fst del model.fst
if exist model.snd del model.snd
if exist minos.prn del minos.prn
if not exist decis.lic copy %5decis.lic .
if exist minos.spc goto run
echo begin > minos.spc
echo end   >> minos.spc
:run
echo | decisc "%~4"

: translate the solution file back
gmsdesnx "%~4" model.fln

:restart
:gamscmex  %3
:gamsnext  %3

