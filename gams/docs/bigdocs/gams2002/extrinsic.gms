$eolcom //

$set SLASH \
$if %system.filesys% == UNIX $set SLASH /

$FuncLibIn trilib testlib_ml%SLASH%tridclib  // Make the library available.
                                             // trilib is the internal name being created now.
                                             // tridclib is the external name.
                                             // With no path, GAMS will look for tridclib in
                                             // the GAMS system directory.

* Declare each of the functions that will be used.
* myCos, mySin and MyPi are names being declared now for use in this model.
* Cosine, Sine and Pi are the function names from the library.
* Note the use of the internal library name.

Function myCos /trilib.Cosine/
         mySin /trilib.Sine/
         myPi  /trilib.Pi/;

scalar i, grad, rad, intrinsic;

for (i=1 to 360,
    intrinsic = cos(i/180*pi);
    grad = mycos(i,1);
    abort$round(abs(intrinsic-grad),4) 'cos', i, intrinsic, grad;
    rad = mycos(i/180*pi);
    abort$round(abs(intrinsic-rad) ,4) 'cos', i, intrinsic, rad;);

variable x;
equation e;

e.. sqr(mysin(x)) + sqr(mycos(x)) =e= 1;
model m /e/;
x.lo = 0; x.l=3*mypi
solve m min x using nlp;
