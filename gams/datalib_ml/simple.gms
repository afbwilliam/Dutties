$title  Examples for plotting routines via MATLAB

$set matout "'matsol.gdx', a, t, j, sys "
set sys /'%system.title%'/;
set t /1990*2030/, j /a,b,c,d/;

parameter a(t,j);
a("1990",j) = 1;
loop(t,  a(t+1,j) = a(t,j) * (1 + 0.04 * uniform(0.2,1.8)); );

parameter year(*); year(t) = 1989 + ord(t);

* Omit some data in the middle of the graph:

a(t,j)$((year(t) gt 1995)*(year(t) le 2002)) = NA;

execute_unload %matout%;
