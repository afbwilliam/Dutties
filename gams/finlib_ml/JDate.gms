$TITLE  Using GAMS time/date functions

* JDate.gms: Using GAMS time/date functions.
* Consiglio, Nielsen and Zenios.
* PRACTICAL FINANCIAL OPTIMIZATION: A Library of GAMS Models, Section 4.2.1
* Last modified: Apr 2008.

PARAMETER BaseDate Initializes the current date;

* Base date is January 1, 2000.

BaseDate = JDATE(2000, 01, 01);

DISPLAY BaseDate;

SET Time /Q1_01, Q2_01, Q3_01, Q4_01, Spring02, Fall03,
          2003, 2005, 2010, 2015, 2020, 2030/;

ALIAS(Time, t);

TABLE TimeInfo(t, *) Dates for each Time set item
                Year  Month Day
    Q1_01       2001   01    01
    Q2_01       2001   03    01
    Q3_01       2001   06    01
    Q4_01       2001   09    01
    Spring02    2002   01    01
    Fall03      2003   09    01
     2003       2003   01    01
     2005       2005   01    01
     2010       2010   01    01
     2015       2015   01    01
     2020       2020   01    01
     2030       2030   01    01;

* Average days per year over the horizon

PARAMETER DPY Average days per year;

DPY = (JDATE(2030,01,01) - JDATE(2000,01,01)) / 30;

DISPLAY DPY;

* Calculate tau times counted from the base date:

PARAMETER tau(t) Time Tau;
 tau(t) = (JDATE( TimeInfo(t, "Year"),
                  TimeInfo(t, "Month"),
                  TimeInfo(t, "Day"))  - BaseDate) / DPY;
DISPLAY tau;