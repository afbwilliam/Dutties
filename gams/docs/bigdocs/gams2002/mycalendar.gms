*illustrates calendar functions

scalar todaydate    Gregorian date and time of start of GAMS job
       now          Gregorian current date + time
       year         Year of job,
       month        Month of job,
       day          Day of job,
       hour         Hour of job,
       minute       Minute of job,
       second       Second of job,
       dow          Day of week of job
       leap         Leap year status oof job
       date         Reverse data of this year, month and date
       time         Percent of day;
todaydate  = jstart;
now    = jnow;
year   = gyear(todaydate);
month  = gmonth (todaydate);
day    = gday   (todaydate);
hour   = ghour(todaydate);
minute = gminute(todaydate);
second = gsecond(todaydate);
dow    = gdow (todaydate);
leap   = gleap(todaydate);
display todaydate,now, year, month, day, hour, minute, second, dow, leap;

date  = jdate(year,month,day);
time  = jtime(hour,minute,second);
display date,time;

scalar plus200days;
todaydate  = jstart+200;
year   = gyear(todaydate);
month  = gmonth (todaydate);
day    = gday   (todaydate);
display todaydate,year, month, day;


$ontext
#user model library stuff
Main topic Calculations
Featured item 1 Calendar functions
Featured item 2 Gyear
Featured item 3 Gday
Featured item 4 Gmonth
Description
Illustrates calendar functions
$offtext
