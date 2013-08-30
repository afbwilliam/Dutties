$eolcom //
* Interface definition of external functions

* This is a library written in C
$setGlobal CLib    1
* API Prefix
$setGlobal PreU    TRI
* Library name stem
$setGlobal LibName tricclib
* Library version
$setGlobal LibVer  1
* API version
$setGlobal ApiVer  1
* Library Description
$setGlobal LibDesc Trigonometric functions Sine and Cosine, Constant Pi

* Descrioption of exported functions
set f(NAME,      // Function name
      CD,        // Continuous derivatives   (0:no, 1:yes)
      EQ,        // Use in eqation forbidden (0:no, 1:yes)
      AMIN,      // Minimum number of arguments
      AMAX,      // Maximum number of arguments
      ARG,       // Argument sequence number
      ARGNAME,   // Argument name
      ARGT)      // Argument Type
/
 SetTriMode.0.1.1.1. 1.mode.X          'Set mode globally, could still be overwritten by mode at (Co)Sine call'
 Cosine    .1.0.1.2.(1.X.E, 2.mode.X)  'Cosine: mode=0 (default) -> rad, mode=1 -> deg'
 Sine      .1.0.1.2.(1.X.E, 2.mode.X)  'Sine  : mode=0 (default) -> rad, mode=1 -> deg'
 Pi        .0.0.0.0. 0.X.E              Pi
/;

* List of functions which return 0 if the input is 0 (AMAX must be 1)
$onempty
Set ZeroRipple(NAME) /
    SetTriMode
/;
$offempty
