*Illustrate set arithmetic

set superset          /i1*i10/
    subset1(superset) /i1*i3,i7,i8/
    subset2(superset) / i2*i6,i9*i10/
    subset3(superset);

Subset3(superset) = Subset1(superset) + Subset2(superset);
display 'union 1',subset3;

Subset3(superset)=no; subset3(subset1)=yes; subset3(subset2)=yes;
display 'union 2',subset3;Subset3(superset)=no; subset3(subset1)=yes; subset3(subset2)=yes;

Subset3(superset) = Subset1(superset) * Subset2(superset);
display 'intersect 1',subset3;

Subset3(superset)=yes$(subset1(superset) and subset2(superset));
display 'intersect 2',subset3;

Subset3(superset) = not Subset1(superset);
display 'complement 1',subset3;

Subset3(superset)=yes; subset3(subset1)=no;
display 'complement 2',subset3;

Subset3(superset) = Subset1(superset) - Subset2(superset);
display 'difference 1',subset3;

subset3(subset1)=yes; subset3(subset2)=no;
display 'difference 2',subset3;


$ontext
#user model library stuff
Main topic Set
Featured item 1 Set artihmetic
Featured item 2 Union
Featured item 3 Difference
Featured item 4 Intersection
Description
Illustrate set arithmetic

$offtext
