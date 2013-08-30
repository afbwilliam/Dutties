
*codes for html

$offlisting

*a table
*begin
$setglobal starttable    '<table>'
*end
$setglobal endtable    '</table> <p>&nbsp;&nbsp;</p> <p>&nbsp;&nbsp;</p>'

*a table row
*begin
$setglobal starttabrow      '<tr>'
*end
$setglobal endtabrow   '</tr>'
*blank one
$setglobal blankrow    '<tr> <td>&nbsp;&nbsp;</td></tr>'

$setglobal srow        '<tr><td align="left">'
$setglobal endsrow     '</td></tr>'

*a blank cell
$setglobal blankcell   '<td align="right"> </td>'

*element that is a label
*start centered
$setglobal lelementc    '<td align="centered">'
*start right justified
$setglobal lelementr    '<td align="right">'
*start left justified
$setglobal lelementl    '<td align="left">'
*endit
$setglobal lendelement  '</td>'

*element that is a number
*start right justified
$setglobal nelementr    '<td align="right">'
*start left justified
$setglobal nelementl    '<td align="left">'
*end it
$setglobal nendelement  '</td>'


*spaces in file
$setglobal spaces      '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
$setglobal aspace      '&nbsp;&nbsp;'
$setglobal space      '&nbsp;'

*font header 1
$setglobal h1          '<h1>'
$setglobal eh1         '</h1>'

*font header 2
$setglobal h2          '<h2>'
$setglobal eh2         '</h2>'

*a line in html file
*begin
$setglobal startline        '<p>'
*end
$setglobal endline       '</p>'

*a blankline
$setglobal blankline   '<p>&nbsp;&nbsp;</p>'

*a new page
$setglobal newpage     "<br clear=all style='page-break-before:always'>"


*do lists
$setglobal startlist         '<ul>'
$setglobal endlist           '</ul>'
$setglobal startlistentry    '<li>'
$setglobal endlistentry      '</li>'

*a hyperlink destination name between start and middle
*start
$setglobal startref    '<li><a href="#'
$setglobal startref1    '<a href="#'
$setglobal startref2    '<a href="'
*middle
$setglobal midref      '">'
*end
$setglobal endref      '</a></li>'
$setglobal endref1     '</a>'

*a hyperlink destination name goes in between
*begin
$setglobal startjump   '<a name='
*end
$setglobal endjump     '></a>'


$if not setglobal codetocsv $goto theendofcodes

$setglobal spaces      '      '
$setglobal aspace      ' '

$setglobal blankcell   '", '
$setglobal starttabrow      ' '
$setglobal endtabrow   ' '
$setglobal blankrow    ' '
$setglobal lelementr    '"'
$setglobal lelementl    '"'
$setglobal nelementr    ' '
$setglobal nelementl    ' '
$setglobal lendelement  '",'
$setglobal nendelement  ','
$setglobal srow        ' '
$setglobal endsrow     ' '

$setglobal h1          ' '
$setglobal eh1         ' '
$setglobal h2          ' '
$setglobal eh2         ' '

$setglobal startline        '" '
$setglobal endline       ' "'
$setglobal blankline   '" "'

$setglobal newpage     " "
$setglobal starttable    ' '
$setglobal endtable    ' '

*do lists
$setglobal startlist         ' '
$setglobal endlist           ' '
$setglobal startlistentry    ' '
$setglobal endlistentry      ' '

$setglobal startref    '"'
$setglobal startref1   '"'
$setglobal midref      ' '
$setglobal endref      '"'
$setglobal endref1     '"'

$setglobal startjump   '"'
$setglobal endjump     '"'

$label theendofcodes
