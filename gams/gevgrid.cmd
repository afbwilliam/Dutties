@echo off

: gams grid submission script
:
: arg1 solver executable
:    2 control file
:    3 scratch directory
:    4 solver name

echo @echo off                        > %~s3runit.cmd
echo %1 %2 %4                        >> %~s3runit.cmd
echo echo OK ^> %~s3finished ^& exit >> %~s3runit.cmd

start /b /belownormal %~s3runit.cmd > nul

exit
