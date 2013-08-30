$ontext
   Copies UNStatistics.gdx to a compressed format for version 6,
   creates a new directory called "newdir" in the project directory
   and places the new copy there. Note that, if required, all GDX files
   can be compressed and stored into the new directory using
   '$call gdxcopy -v6c *.gdx newdir'.

   Source for GDX file:
      United Nations - Demographic Yearbook, Historical supplement. New York, 1999
$offtext

$ifi %system.platform% == AIX $exit No V6 GDX exists for this platform
$ifi %system.platform% == BGP $exit No V6 GDX exists for this platform
$ifi %system.platform% == DEX $exit No V6 GDX exists for this platform
$ifi %system.platform% == DII $exit No V6 GDX exists for this platform
$ifi %system.platform% == SOX $exit No V6 GDX exists for this platform

$call gdxcopy -v6c UNStatistics.gdx newdir
