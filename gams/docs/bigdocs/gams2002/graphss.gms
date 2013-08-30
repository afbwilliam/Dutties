*Graphing with Excel

set allels /X               X values
            Newline1        Data for line 1
            NewLine2        Data for line 2
            Title           A graph of 2 GAMS generated lines
            XAXIS           Whatever the X axis label
            YAXIS           Whatever the X axis label /
    points /i1*i6/;
table mydata(points,allels) data to graph
          x        NewLine1        NewLine2
i1        1          1
i2        4          3
i3        7          4
i4        8          5
i5        12         8
i6        14         9                ;
mydata(points,"Newline2")=mydata(points,"x")+mydata(points,"Newline1");

execute_unload 'tograph.gdx' allels, mydata;
execute 'gdxxrw tograph.gdx trace=3 o=gdxxrwss.xls par=mydata rng=mygraph!a1:d7';
execute 'gdxxrw tograph.gdx trace=3 o=gdxxrwss.xls set=allels rng=mygraph!a10 rdim=1';



$ontext
#user model library stuff
Main topic  Output
Featured item 1  Graphics
Featured item 2  Spreadsheet
Featured item 3  GDXXRW
Featured item 4  Execute_Unload
Description
Graphing with Excel
$offtext
