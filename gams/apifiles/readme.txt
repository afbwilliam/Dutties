This document gives a short instruction how to compile and execute the examples
in the different language directories. The compile line is written down for a 
specific compiler, but it should be easy to do the same with another one. It is
assumed that <Path/To/GAMS> is the directory where GAMS has been installed, 
<language> denotes either C, C++, C#, Delphi, Fortran, Java, Python, or VB, and 
you are in <Path/To/GAMS>/apifiles/<language> when compiling the examples.

********************
********************
** C
********************
********************

****************
* xp_example1.c
****************
Compilation:
  cl xp_example1.c api/gdxcc.c -Iapi
Execution:
  xp_example1.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

****************
* xp_example2.c
****************
Compilation:
  cl xp_example2.c api/gdxcc.c api/optcc.c api/gamsxcc.c -Iapi
Execution:
  xp_example2.exe <Path/To/GAMS>


********************
********************
** C++
********************
********************

******************
* xp_example1.cpp
******************
There is a file xp_example1.vcproj which can be used to compile an execute this
example in Microsoft Visual Studio. Alternatively, you can compile and
execute at the command line.

Compilation:
  cl xp_example1.cpp api/gdxco.cpp ../C/api/gdxcc.c -Iapi -I../C/api
Execution:
  xp_example1.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

******************
* xp_example2.cpp
******************
There is a file xp_example2.vcproj which can be used to compile an execute this
example in Microsoft Visual Studio. Alternatively, you can compile and execute
at the command line.

Compilation:
  cl xp_example2.cpp api/gdxco.cpp ../C/api/gdxcc.c api/optco.cpp ../C/api/optcc.c
                     api/gamsxco.cpp ../C/api/gamsxcc.c -Iapi -I../C/api
Execution:
  xp_example2.exe <Path/To/GAMS>


********************
********************
** C#
********************
********************

There are several project (.csproj) and solution (.sln) files which can be used
to compile an execute the examples in Microsoft Visual Studio.
BendersDecomposition2StageSP, GMSCutstock, GMSWarehouse and TransportSeq are 
using the GAMS.net4 API while the other examples are using the low level gamsx,
gdx and opt API files.


********************
********************
** Delphi
********************
********************

******************
* xp_example1.dpr
******************
There is a file xp_example1.dof which can be used to compile an execute this
example in the Delphi IDE. Alternatively, you can compile and execute at the
command line. In this case xp_example1.cfg takes care about the required 
compiler flags.

Compilation:
  dcc32 xp_example1.dpr
Execution:
  xp_example1.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

********************
* xp_example1do.dpr
********************
There is a file xp_example1do.dof which can be used to compile an execute this
example in the Delphi IDE. Alternatively, you can compile and execute at the
command line. In this case xp_example1do.cfg takes care about the required 
compiler flags.

Compilation:
  dcc32 xp_example1do.dpr
Execution:
  xp_example1do.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1do.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

********************
* xp_example1dp.dpr
********************
There is a file xp_example1dp.dof which can be used to compile an execute this
example in the Delphi IDE. Alternatively, you can compile and execute at the
command line. In this case xp_example1dp.cfg takes care about the required 
compiler flags.

Compilation:
  dcc32 xp_example1dp.dpr
Execution:
  xp_example1dp.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1dp.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

******************
* xp_example2.dpr
******************
There is a file xp_example2.dof which can be used to compile an execute this
example in the Delphi IDE. Alternatively, you can compile and execute at the
command line. In this case xp_example2.cfg takes care about the required 
compiler flags.

Compilation:
  dcc32 xp_example2.dpr
Execution:
  xp_example2.exe <Path/To/GAMS>


********************
********************
** Fortran
********************
********************

The following examples use a lib file as a connection between the GAMS 
libraries and the Fortran client. For the first set of examples this lib file
is compiled from C source. It is also possible to create the lib file from 
Fortran source. You can find examples for ifort 32bit and 64bit below.

******************
* xp_example1.f90
******************
Compilation:
  ifort -c api/gdxf9def.f90
  cl -DAPIWRAP_LCASE_NODECOR -c api/gdxf9glu.c -I../C/api
  lib -out:gdxf90lib.lib gdxf9def.obj gdxf9glu.obj
  ifort -c api/gamsglobals_mod.f90 xp_example1.f90
  ifort -exe:xp_example1.exe gamsglobals_mod.obj xp_example1.obj gdxf90lib.lib
Execution:
  xp_example1.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}


******************
* xp_example2.f90
******************
Compilation:
  ifort -c api/gamsxf9def.f90 api/gdxf9def.f90 api/optf9def.f90
  cl -DAPIWRAP_LCASE_NODECOR -c api/gamsxf9glu.c api/gdxf9glu.c api/optf9glu.c -I../C/api
  lib -out:gamsxf90lib.lib gamsxf9def.obj gamsxf9glu.obj
  lib -out:gdxf90lib.lib gdxf9def.obj gdxf9glu.obj
  lib -out:optf90lib.lib optf9def.obj optf9glu.obj
  ifort -c api/gamsglobals_mod.f90 xp_example2.f90
  ifort -exe:xp_example2.exe gamsglobals_mod.obj example2.obj gamsxf90lib.lib 
        gdxf90lib.lib optf90lib.lib
Execution:
  xp_example2.exe <Path/To/GAMS>


*************************
* xp_example1ifort32.f90
*************************
Compilation:
  ifort -c api/gdxifort32deflib.f90
  lib /def:api/gdxifort32def.def gdxifort32deflib.obj
  ifort -c api/gamsglobals_mod.f90
  ifort -c api/gdxifort32def.f90
  ifort xp_example1ifort32.f90 gdxifort32def.obj gamsglobals_mod.obj gdxifort32def.lib -exe:xp_example1.exe
Execution:
  xp_example1.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

  
*************************
* xp_example1ifort64.f90
*************************
Compilation:
  ifort -c api/gdxifort64deflib.f90
  lib /def:api/gdxifort64def.def gdxifort64deflib.obj
  ifort -c api/gamsglobals_mod.f90
  ifort -c api/gdxifort64def.f90
  ifort xp_example1ifort64.f90 gdxifort64def.obj gamsglobals_mod.obj gdxifort64def.lib -exe:xp_example1.exe
Execution:
  xp_example1.exe <Path/To/GAMS>                      {This will write a GDX file}
  xp_example1.exe <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

  
********************
********************
** Java
********************
********************
GAMS Java API provides a Java programming interface to GAMS. There are two
different kinds of GAMS Java API, low level API and object oriented API. 
The low level API yields an access directly from a Java program to various GAMS
libraries (e.g. GDX, GMO, OPT, and so on). The object oriented API is built on
top of low level API and provides a more intuitive and convenient way to access
to GAMS software components from a Java program.

For the communication between Java program and GAMS we need Java Native 
Interface (JNI) libraries. These libraries are platform dependent and can be 
found in <Path/To/GAMS>/apifiles/Java/api directory (e.g. on Windows-based 
32-bit platform you can find the shared library to access GDX component at 
<Path/To/GAMS>/apifiles/Java/api/gdxjni.dll). In case you need to modify the 
JNI libraries for your needs, we also distribute the required C source code 
(e.g. <Path/To/GAMS>/apifiles/Java/C/gdxjni.c).

A Java program that uses GAMS Java API requires at least Java SE 5 to compile
and run.

**********************
* Object Oriented API
**********************
All objected oriented Java API classes are contained within one single jar file 
'GAMSJavaAPI.jar' with a namespace 'com.gams.api'. This file is located at
<Path/To/GAMS>/apifiles/Java/api/GAMSJavaAPI.jar. 
 
To compiling a Java program that uses objected oriented Java API, you need to 
add the jar file 'GAMSJavaAPI.jar' as well as its location into the Java build 
path (e.g. with -cp). 

A Java program that uses objected oriented Java API requires a number of GAMS 
shared libraries for establishing a connection with GAMS software components 
during the run time. These libraries can be found at <Path/To/GAMS> directory 
and <Path/To/GAMS>/apifiles/Java/api directory.

Before running a Java program that uses objected oriented Java API, you need to
set up your environment variable ('PATH' on Window-based platform, 
'DYLD_LIBRARY_PATH' on Mac-os family, or 'LD_LIBRARY_PATH' on other Unix-based 
platforms) properly. This envrionment variable must contain the GAMS system 
directory (<Path/To/GAMS> by default). When running a program, you need to set 
the Java library path to the directory that contains all required JNI libraries 
(<Path/To/GAMS>/apifiles/Java/api by default). 

More detailed documentation about this object oriented API can be found in 
<Path/To/GAMS>/docs/api/GAMS_java.pdf. 

*****************
 Transport1.java
*****************
Compilation:
On Unix-based platforms
   javac -cp api/GAMSJavaAPI.jar -d . Transport1.java
On Windows-based platforms
   javac -cp api\GAMSJavaAPI.jar -d . Transport1.java
  
Environment Setup:
On Window-based platforms
   set PATH=%PATH%;<Path/to/GAMS>
On Unix-based platforms using Bourne Shell
   export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:<Path/To/GAMS>
On Unix-based platforms using C Shell
   setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:<Path/To/GAMS>
On Mac OS family platforms, replace LD_LIBRARY_PATH by DYLD_LIBRARY_PATH.

Execution:
On Windows-based platforms
   java -cp api\GAMSJavaAPI.jar;. -Djava.library.path=<Path/To/GAMS>\apfiles\Java\api com.gams.examples.Transport1
On Unix-based platforms
   java -cp api/GAMSJavaAPI.jar:. -Djava.library.path=<Path/To/GAMS>/apfiles/Java/api com.gams.examples.Transport1

****************
* Low Level API
****************
The Java examples and low level API files are organized in different packages, 
each require a specific folder organization. 
******************
 xp_example1.java
******************
Compilation:
  javac -d . xp_example1.java api/gdx.java api/gamsglobals.java
Execution:
  java -cp . -Djava.library.path=api com.gams.xp_examples.xp_example1
       <Path/To/GAMS>                      {This will write a GDX file}
  java -cp . -Djava.library.path=api com.gams.xp_examples.xp_example1
       <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}
******************
 xp_example2.java
******************
Compilation:
  javac -d . xp_example2.java api/gdx.java api/opt.java api/gamsx.java api/gamsglobals.java
Execution:
  java -cp . -Djava.library.path=api com.gams.xp_examples.xp_example2 <Path/To/GAMS>

********************
********************
** Python
********************
********************

Like Java, Python requires an additional interface to access the GAMS
libraries (the C extension).  These interface files are part of this
distribution. Note that these files depend on a particular Python
version. In this case they were created with Python 2.7. If you are using
another version it might be necessary to recreate them.

In general, the C extension be created using distutils. The C source (e.g. 
apifiles/Python/api/gdxcc_wrap.c) and the setup settings (e.g. 
apifiles/Python/apix/gdxsetup.py) required by distutils can be found in the 
apifiles directories.

***********************
* Object Oriented API
***********************
The object oriented GAMS Python API is built on top of the different low level
component API's and provides convenient access to GAMS from within Python.
Examples using the API are located in 'apifiles/Python' while the API itself is
found in 'apifiles/Python/api'.
The GAMS Python API requires Python 2.7. The bitness of the Python version has
to be the same as the bitness of the GAMS system.

Installing the API and the required low level API's to Python site-packages:
  cd api && python setup.py install && cd ..

Using the API without installing:
  export PYTHONPATH=api  (on Windows: set PYTHONPATH=api)

Running transport1.py example:
  export LD_LIBRARY_PATH=<Path/To/GAMS>:$LD_LIBRARY_PATH (DYLD_LIBRARY_PATH on
                                                          OS X, not required on
                                                          Windows)
  python transport1.py

More detailed documentation about this object oriented API can be found in 
<Path/To/GAMS>/docs/api/GAMS_python.pdf. 

*****************
* xp_example1.py
*****************
Create C extension using distutils in case the distribution files don't work
with your version of Python:
  cd api && python gdxsetup.py install && cd ..
  OR
  cd api && python gdxsetup.py build --build-lib . && cd ..
  > Note that the 'install' command will try to copy files into your
    Python/lib/site-packages directory. In case you are not allowed to
    write there you should use 'build' instead. This will put the
    created files into a separate build directory which you could add
    to PYTHONPATH later. Moreover, you might have to delete the
    distribution files *.pyd (or *.so) in the subdirectory api.
  
Execution:
  export PYTHONPATH=api  (on Windows set PYTHONPATH=api)
  > Note that the previous command is only required if you have not used the
    'python ... install' option above.
  python xp_example1.py <Path/To/GAMS>                      {This will write a GDX file}
  python xp_example1.py <Path/To/GAMS> ../GAMS/trnsport.gdx {This will read a GDX file}

*****************
* xp_example2.py
*****************
Create C extension using distutils in case the distribution files don't work
with your version of Python:
  cd api && python gamsxsetup.py install && cd ..
  cd api && python gdxsetup.py   install && cd ..
  cd api && python optsetup.py   install && cd ..
  OR
  cd api && python gamsxsetup.py build --build-lib . && cd ..
  cd api && python gdxsetup.py   build --build-lib . && cd ..
  cd api && python optsetup.py   build --build-lib . && cd ..
  > Note that the 'install' command will try to copy files into your
    Python/lib/site-packages directory. In case you are not allowed to
    write there you should use 'build' instead. This will put the
    created files into a separate build directory which you could add
    to PYTHONPATH later. Moreover, you might have to delete the
    distribution files *.pyd (or *.so) in the subdirectory api.
      
Execution:
  export PYTHONPATH=api  (on Windows set PYTHONPATH=api)
  > Note that the previous command is only required if you have not used the
    'python ... install' option above.
  python xp_example2.py <Path/To/GAMS>
 
********************
********************
** VB
********************
********************

There are several Excel files using vba modules for calling GAMS from Excel. In
addition the are two examples for VB.net.

*****************
* xp_example1.vb
*****************
There is a file xp_example1.vbproj which can be used to compile an execute this
example in Microsoft Visual Studio.

*****************
* xp_example2.vb
*****************
There is a file xp_example2.vbproj which can be used to compile an execute this
example in Microsoft Visual Studio.