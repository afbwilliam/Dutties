$ontext
Simple exchange model - works if you do not define stuff to create
errors.  Other models will simply $define things to cause certain
errors when this file is $include'd file, and to force a verification
that the errors are caught and reported correctly.
$offtext

$eolcom //


$if NOT set QT            $set QT "'"  // a single quote by default
$if NOT set ILABEL        $set ILABEL i1
$if NOT set SETUPFAIL     $set SETUPFAIL 0

SETS
i       / %QT%%ILABEL%%QT% /,
j       / j1 * j2 /,
h       / h1 * h2 /;

display i;

parameter       d0(i,h)         Reference demands,
                e0(i,h)         Reference endowments;

d0(i,h) = uniform(0,1);
e0(i,h) = uniform(0,1);

$ontext

$model:exchange

$commodities:
        price67890(i,j)

$consumers:
        ra34567890(h)


$demand:ra34567890(h) s:1
        d:price67890(i,j)       q:d0(i,h)
        e:price67890(i,j)       q:e0(i,h)

$offtext

$sysinclude mpsgeset exchange


$include EXCHANGE.GEN
solve exchange using mcp;

if {(%SETUPFAIL%=1),
* expect solvestat 9 ERROR SETUP FAILURE
  abort$( exchange.solvestat <> 9)            'wrong solvestat';
* expect modelstat 13 ERROR NO SOLUTION
  abort$( exchange.modelstat <> 13)           'wrong modelstat';
else
  abort$( exchange.solvestat <> 1)            'wrong solvestat';
  abort$( exchange.modelstat <> 1)            'wrong modelstat';
};
