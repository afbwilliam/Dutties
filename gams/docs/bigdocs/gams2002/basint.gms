*Base MIP example with optca set

OPTION LIMROW=0;
OPTION LIMCOL=0;
OPTION SOLSLACK =1;

$OFFSYMLIST OFFSYMXREF

 POSITIVE VARIABLE       X1
 INTEGER VARIABLE        X2
 BINARY VARIABLE         X3
 VARIABLE                OBJ

 EQUATIONS               OBJF
                         X1X2
                         X1X3;

 OBJF..     7*X1-3*X2-10*X3 =E= OBJ;
 X1X2..     X1-2*X2 =L=10.1;
 X1X3..     X1-20*X3 =L=20.2;
 x2.up=125;
 option optcr=0.01;
 MODEL IPTEST /ALL/;
 iptest.optcr=0.0001;
 iptest.optca=1.;
 iptest.cheat=0.1;
 iptest.cutoff=12.;

 SOLVE IPTEST USING MIP MAXIMIZING OBJ;
$ontext
#user model library stuff
Main topic MIP
Featured item 1 Integer
Featured item 2 Optcr , Optca
Featured item 3 Cheat
Featured item 4 Binary
Description
Base MIP example with optca, cheat, optcr and cutoff set

$offtext
