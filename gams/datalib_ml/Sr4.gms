$ontext
step 4: report writing
execute as: > gams sr4 restart=s3
$offtext
abort$(transport.modelstat <> %MODELSTAT.Optimal%) "model not solved to optimality";
display x.l,z.l;
