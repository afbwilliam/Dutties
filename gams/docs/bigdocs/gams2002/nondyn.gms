$ontext

Model illustrating static, and dynamic calculation differences

$offtext
set crop /corn/
parameter price(crop),yield(crop),cost(crop),revenue(crop);
Price(Crop) = 2.00;
Yield(Crop) = 100;
Cost(Crop) = 50;
Revenue (Crop) = Price(Crop)*Yield(Crop)-Cost(Crop);
Equations
        obj             objective function
        Land            Land available;
Positive Variables      Acres(Crop)     Cropped Acres
Variables               Objf    Objective function;
obj..           objf=E=Sum(Crop,Revenue(Crop)*Acres(Crop));
Land..          Sum(Crop, Acres(Crop))=L=100;
Model           FARM/ALL/
SOLVE FARM USING LP Maximizing objf;
Price ("corn")=2.50;
Solve FARM USING LP Maximizing objf;
Revenue (Crop)=Price (CROP)*Yield(Crop)-Cost(Crop);
Solve FARM Using LP Maximizing objf;
Equations
  obj2 dynamic version of objective function;
obj2..
objf=E=Sum(Crop,(Price (CROP)*Yield(Crop)-Cost(Crop))
                *Acres(Crop));
model farmdyn /obj2,land/ ;
Price(Crop) = 2.00;
SOLVE FARMdyn USING LP Maximizing objf;
Price ("corn")=2.50;
Solve FARMdyn USING LP Maximizing objf;

$ontext
#user model library stuff
Main topic Calculations
Featured item 1 Static
Featured item 2 Dynamic
Featured item 3
Featured item 4
Description
Model illustrating static, and dynamic calculation differences
$offtext
