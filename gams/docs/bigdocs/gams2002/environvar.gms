*illustrate environment variables


* Display current values of the system environment variables like the PATH variable
display '%sysenv.PATH%'

*display environment varialbe in log file

*first set up a simple command processor

$onechoV > xx.cmd
echo  the path is %path%
echo  the os is %os%
$offecho

*now run it

$call xx.cmd

*test environment variable and do somthing in response as used in comparewhere.gms
$set console
$if %system.filesys% == UNIX  $set console /dev/tty
$if %system.filesys% == DOS $set console con
$if %system.filesys% == MS95  $set console con
$if %system.filesys% == MSNT  $set console con
$if "%console%." == "." abort "filesys not recognized";
file screen / '%console%' /;
file log /''/

*set a user defined environment variable
$setenv myvariable here it is
display '%sysenv.myvariable%'

* Display the content of the variable in a DOS box
$onechoV > x.cmd
echo %myvariable%
$offecho

* check for existence
$if setenv myvariable display 'myvariable is set at this time to %sysenv.myvariable%'
$if not setenv myvariable display 'myvariable is not set at this time'
$if setenv myvariable2 display 'myvariable2 is set at this time to %sysenv.myvariable2%'
$if not setenv myvariable2 display 'myvariable 2 is not set at this time'

*set another user defined environment variable
$setenv myvariable2 good morning
*define another processor
$onechoV > cx.cmd
echo %myvariable2%
$offecho
$call cx.cmd
display 'first myvariable 2 %sysenv.myvariable2%'

*augment the variable adding to the end
$setenv myvariable2 %sysenv.myvariable2% from bruce
$call cx.cmd
display 'second myvariable2 %sysenv.myvariable2%'

*augment the variable adding to the end
$setenv myvariable2  hello %sysenv.myvariable2%
$call cx.cmd
display 'third myvariable2 %sysenv.myvariable2%'

$onechoV > y.cmd
path
$offecho

$call y.cmd
*$prefixpath %sysenv.mrb%
* That doesn't work and I don't know why:
*manipulate system path variable
$prefixpath c:\some\path\somehwere
$call y.cmd

$ontext
#user model library stuff
Main topic Conditional compile
Featured item 1 Environment variable
Featured item 2 %system.name%
Featured item 3 $Echo
Featured item 4

Description
Illustrate environment variables


$offtext
