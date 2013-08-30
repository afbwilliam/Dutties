@echo off
: gmsxitnt.cmd: Command Line Interface for Windows NT
: GAMS Development Corporation, Washington, DC, USA  1996
:
:  %1  Scratch directory with a '\' at the end
:  %2  Working directory with a '\' at the end
:  %3  completion code, OS-specific
:  %4  completion code, GAMS internal
:
: The command line length in NT is "pretty long".
:
: echo --- Erasing scratch files
: if exist %1*.dat erase %1*.dat
: for /D %%g IN (%1grid*) DO rmdir /s /q "%%g"
