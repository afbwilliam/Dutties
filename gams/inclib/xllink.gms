%$dollar $
$hidden xllink.gms installs xllink
$if setglobal XLLINK $exit
$if NOT decla_ok $goto nodecla
$if NOT declared xllinkscalar scalar xllinkscalar;
$if NOT declared xllinkparams file xllinkparams  / xllink.txt /; xllinkparams.lw=0; xllinkparams.nw=0; xllinkparams.nd=0;
$setglobal XLLINK installed
$exit
$label nodecla
$error you need to '$libinclude xllink' outside the scope of IF/LOOP structures

