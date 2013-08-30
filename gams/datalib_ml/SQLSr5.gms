$ontext
This program calls a number of GAMS programs. Each program performs one task in the given sequence:
Data extraction --> Data manipulation --> Model definition --> Model solution --> Report writing
$offtext

*Data extraction
execute '=gams.exe SQLSr0 lo=%GAMS.lo% save=s0';
abort$errorlevel "step 0 failed";

*Data manipulation
execute '=gams.exe Sr1 lo=%GAMS.lo% restart=s0 save=s1';
abort$errorlevel "step 1 failed";

*Model definition
execute '=gams.exe Sr2 lo=%GAMS.lo% restart=s1 save=s2';
abort$errorlevel "step 2 failed";

*Model solution
execute '=gams.exe Sr3 lo=%GAMS.lo% restart=s2 save=s3';
abort$errorlevel "step 3 failed";

*Report writing
execute '=gams.exe Sr4 lo=%GAMS.lo% restart=s3';
abort$errorlevel "step 4 failed";
