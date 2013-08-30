lim=1;
option solveopt=replace;

*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*  ITERATIVE SOLVING PROCEDURE USING LOOP
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
$offsymlist offsymxref
TOL = 0.00015;
converge = 1;
*option lp=gamschk;
*converge = 0;
*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
   rESULT(C,"1",'defic')$FARMPROD("TARGET",C) = farmprod("defic",c);
LOOP(ITER$(CONVERGE GT 0 ),
sector.optfile=1;


$if not "%solveasm%" == "nonlinear"      $goto solveln
$if     "%solveasm%" == "nonlinear"      $goto solvenln

$label solveln
   SOLVE SECTOR USING LP MAXIMIZING CSPS ;
$goto continsol

$label solvenln
   SOLVE SECTOR USING NLP MAXIMIZING CSPS ;
$goto continsol

$label continsol
*   ABORT$(SUM(C,(FARMPROD("TARGET",C)+FARMPROD("LOANRATE",C))) LE 0)
*         "NON-FARM PROGRAM SCENARIO";

   FARMPROD("TARGET",C)$(FARMPROD("TARGET",C) LE 0 AND
       FARMPROD("MKTLOANY-N",C) GT 0)
    =FARMPROD("LOANRATE",C) ;

   TOLER(C) = TOL*FARMPROD("TARGET",C) ;

   RESULT(C,ITER+1,'PRICE')$FARMPROD("TARGET",C) = PRIMARYBAL.M(C)*scalobj
                                                   /scale(c) ;
   RESULT(C,ITER+1,'TRIAL')$FARMPROD("TARGET",C) = FRMPROG.M(C)*scalobj
                                                   /scale(c);
   RESULT(C,ITER+1,'TARGET')$FARMPROD("TARGET",C) = FARMPROD("TARGET",C);
   RESULT(C,ITER+1,'DEFIC')$FARMPROD("TARGET",C)  = FARMPROD("DEFIC",C);


   FARMPROD("DEFIC",C)$FARMPROD("TARGET",C)
    = MAX(0, FARMPROD("DEFIC",C)+(FARMPROD("TARGET",C)-FRMPROG.M(C)*scalobj
               /scale(c))*0.90 );

   CONVERGE=SUM(C,1$(ABS(FARMPROD("DEFIC",C)-RESULT(C,ITER+1,'DEFIC'))
                    -TOLER(C) GT 0 ));
   converge=converge$(ord(iter) lt lim);
   display converge;

FARMPROD("DEFIC",C) $(FARMPROD("TARGET",C) NE 0 AND  CONVERGE EQ 0.)
                                         = RESULT(C,ITER+1,'DEFIC') ;
   ) ;
*
   DISPLAY RESULT;
$ontext
#user model library stuff
Main topic ASM Model
Featured item 1 Code seperation
Featured item 2 Loop
Featured item 3 ASM sector model
Description
Solves for farm program deficiency payment in ASM model
$offtext
