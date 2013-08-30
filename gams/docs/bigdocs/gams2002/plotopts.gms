*show many of the gnupltxy options
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* non terminal specific options
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* suppress (0,0) data pairs globally
$setglobal gp_supzero yes

* ranges for axis
$setglobal gp_yrange '100000:160000'
$setglobal gp_xrange '8000:68000'

* set label increments for x and y axis
*$setglobal gp_xinc 2
*$setglobal gp_yinc 25

* grid
*$setglobal gp_grid    'no'
$setglobal gp_grid    'yes'

* line type for grid,
* default is dotted for monochrome and gray for color
*$setglobal gp_gline '9';

* key location (names work only with 32bit version)
*$setglobal gp_key   'no'
*$setglobal gp_key   'bottom right'
*$setglobal gp_key   'bottom left'
*$setglobal gp_key   'top right'
$setglobal gp_key   'top left'
*$setglobal gp_key   'bottom right outside'
*$setglobal gp_key   '12,12'

* format of lines in graph
*$setglobal gp_style  'linespoints' !lines and points
$setglobal gp_style  'lines'
*$setglobal gp_style  'points'
*$setglobal gp_style  'dots'
*$setglobal gp_style  'boxes'

* border
*$setglobal gp_border 'no'
$setglobal gp_border 'yes'
$setglobal gp_borddim '3'
*$setglobal gp_borddim ''

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* terminal specific options for cgm, postscript, aifm, windows
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* orientation of graphics: 'landscape' or 'portrait'
* works for cgm, postscript
$setglobal gp_term0   'landscape'
*$setglobal gp_term0   'portrait'

* color scheme: 'monochrome' or 'color'
* works for aifm, cgm, postscript, windows
$setglobal gp_term1   'monochrome'
*$setglobal gp_term1   'color'

* line style: 'solid' or 'dashed'
* works for postscript
$setglobal gp_term2   'solid'

* text rotation of Y-axis label: 'rotate' or 'norotate'
* works for cgm, postscript
$setglobal gp_term3   'rotate'

* width of graphics, default = 432 = 6 inches = 15.24 cm
* works for cgm, postscript
$setglobal gp_term4   'width 432'

* line width
* works for cgm, postscript
*$setglobal gp_term5   'linewidth 1'

* font name
* works for aifm, cgm, postscript, windows
$setglobal gp_term6   '"Times Roman"'

* font size
* works for aifm, cgm, postscript, windows
$setglobal gp_term7   '10'

$ontext
#user model library stuff
Main topic  Output
Featured item 1 Graphics
Featured item 2 GNUPLTXY.gms
Featured item 3
Featured item 4
Description
Illustrates many of the gnupltxy options

$offtext
