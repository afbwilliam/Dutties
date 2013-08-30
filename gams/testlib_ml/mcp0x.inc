$ontext

Contributor: Steve Dirkse, May 2004

The table below describes the rules as implemented in CMEX Rev 139,
and as tested in models mcp01*mcp04.

Legend:
bndL   x.lo <= x <= INF
bndU   -INF <= x <= x.up
bndF   -INF <= x <= INF
bndB   x.lo <= x <= x.up, x.lo < x.up
bndE   x.lo <= x <= x.up, x.lo = x.up

Here's what we have:

        =G=     =L=     =N=     =E=
bndL    OK      ERR     OK      OK
bndU    ERR     OK      OK      OK
bndE    OK      OK      OK      OK
bndB    OK      OK      OK      OK
bndF    OK      OK      OK      OK


Note that CMEX does not distinguish between the cases bndB and bndE
when it comes to deciding if the match makes sense.  This will make a
difference when .holdfixed=1 and when you have unmatched variables.

$offtext

$if not set TESTTOL $set TESTTOL 1e-6
scalar mchecks / 0 /;
$if not %MCPMCHECKS% == 0 mchecks = 1;
scalar nonstrict 'test cases of nonstrict complementarity'  / 0 /;
$if not %NONSTRICT% == 0 nonstrict = 1;

$eolcom //

maxexecerror = 1;  // instead of running with execerr=1
scalar failed / 0 /;
scalar xbar 'known solution' / 2 /;
scalar tol / %TESTTOL% /;
acronyms XUPP, XLOW, XBAS;

set v / xlo, xup, xs, xl, nRedef, xerr /;
set t 'tests with different bound combos' / t01 * t18 /;
set tt(t);

parameter p(t,*);
table p_e(t,*)
        xlo     xup     xs      xl    nRedef    xerr
t01     -INF    INF     XBAS    2
t02     -INF    3       XBAS    2
t03     -INF    2       XBAS    2
t04     -INF    1       XUPP    1       1
t05     -INF    -1      XUPP   -1       1
t06     -1      INF     XBAS    2
t07     1       INF     XBAS    2
t08     2       INF     XBAS    2
t09     3       INF     XLOW    3       1
t10     -1      3       XBAS    2
t11     1       3       XBAS    2
t12     2       3       XBAS    2
t13     1       2       XBAS    2
t14     2       2       XBAS    2
t15     -1      1       XUPP    1       1
t16     -1      -1      XUPP   -1       1
t17     3       4       XLOW    3       1
t18     4       4       XLOW    4       1
;
table p_g(t,*)
        xlo     xup     xs      xl    nRedef    xerr
t01     -INF    INF     XBAS    2
t02     -INF    3       XBAS    2               1
t03     -INF    2       XBAS    2               1
t04     -INF    1       XUPP    1       1       1
t05     -INF    -1      XUPP   -1       1       1
t06     -1      INF     XBAS    2
t07     1       INF     XBAS    2
t08     2       INF     XBAS    2
t09     3       INF     XLOW    3
t10     -1      3       XBAS    2
t11     1       3       XBAS    2
t12     2       3       XBAS    2
t13     1       2       XBAS    2
t14     2       2       XBAS    2
t15     -1      1       XUPP    1       1
t16     -1      -1      XUPP   -1       1
t17     3       4       XLOW    3
t18     4       4       XLOW    4
;
table p_l(t,*)
        xlo     xup     xs      xl    nRedef    xerr
t01     -INF    INF     XBAS    2
t02     -INF    3       XBAS    2
t03     -INF    2       XBAS    2
t04     -INF    1       XUPP    1
t05     -INF    -1      XUPP   -1
t06     -1      INF     XBAS    2                1
t07     1       INF     XBAS    2                1
t08     2       INF     XBAS    2                1
t09     3       INF     XLOW    3       1        1
t10     -1      3       XBAS    2
t11     1       3       XBAS    2
t12     2       3       XBAS    2
t13     1       2       XBAS    2
t14     2       2       XBAS    2
t15     -1      1       XUPP    1
t16     -1      -1      XUPP   -1
t17     3       4       XLOW    3       1
t18     4       4       XLOW    4       1
;
table p_n(t,*)
        xlo     xup     xs      xl    nRedef    xerr
t01     -INF    INF     XBAS    2
t02     -INF    3       XBAS    2
t03     -INF    2       XBAS    2
t04     -INF    1       XUPP    1
t05     -INF    -1      XUPP   -1
t06     -1      INF     XBAS    2
t07     1       INF     XBAS    2
t08     2       INF     XBAS    2
t09     3       INF     XLOW    3
t10     -1      3       XBAS    2
t11     1       3       XBAS    2
t12     2       3       XBAS    2
t13     1       2       XBAS    2
t14     2       2       XBAS    2
t15     -1      1       XUPP    1
t16     -1      -1      XUPP   -1
t17     3       4       XLOW    3
t18     4       4       XLOW    4
;

alias(u,*);
p('t01','xlo') = NA; // force it to choke if not reset
$if '%EQTYPE%' == '=E='  p(t,u) = p_e(t,u);
$if '%EQTYPE%' == '=G='  p(t,u) = p_g(t,u);
$if '%EQTYPE%' == '=L='  p(t,u) = p_l(t,u);
$if '%EQTYPE%' == '=N='  p(t,u) = p_n(t,u);
p(t,'fl') =  exp(p(t,'xl'));
p(t,'fm') =  p(t,'xl');

tt(t) = yes;
if {(0 eq nonstrict),
  tt(t)$[(p(t,'xlo') < p(t,'xup')) AND
         ((p(t,'xlo') eq xbar) OR (p(t,'xup') eq xbar))] = no;
};
$if set TESTCASE tt(t) = sameas('%TESTCASE%',t);
display tt;

variable x;

equation f;

f.. exp(x) %EQTYPE% exp(xbar);

model m / f.x /;

$if SOLVER minos option dnlp = minos;
scalar rhs;
loop {tt(t),
  x.l = 0;  x.m = 0;  f.l = 0;  f.m = 0;
  x.lo = p(t,'xlo');
  x.up = p(t,'xup');
  solve m using mcp;
  if {p(t,'xerr'),
    p(t,'errXerr') = 1$(execerror=0);
    display$p(t,'errXerr') 'failed: expected exec errors';
    p(t,'sstat') = m.solvestat;
    p(t,'mstat') = m.modelstat;
    p(t,'errStat') = abs(p(t,'sstat') - 12) + abs(p(t,'mstat')-14);
    display$p(t,'errStat') 'failed: wrong status codes';
    execerror = 0;
  else
    if {(f.up < INF),
      rhs = f.up;
    elseif (f.lo > -INF),
      rhs = f.lo;
    else
      rhs = 0;    // this for the =N= case
    };
    display rhs;
    if {(p(t,'xs') eq XLOW),
      p(t,'xm') = exp(p(t,'xl')) - rhs;
    elseif (p(t,'xs') eq XUPP),
      p(t,'xm') = exp(p(t,'xl')) - rhs;
    else
      p(t,'xm') = 0;
    };
    if {(rhs = 0),   // must be =N= case, correct for lost RHS
      p(t,'fl') = p(t,'fl') - exp(xbar);
      p(t,'xm') = p(t,'fl');
    };
    p(t,'sstat') = m.solvestat;
    p(t,'mstat') = m.modelstat;
    p(t,'errStat') = abs(p(t,'sstat') - 1) + abs(p(t,'mstat')-1);
    display$p(t,'errStat') 'failed: wrong status codes';
    p(t,'SnRedef') = m.numredef;
    p(t,'errRedef') = abs(p(t,'SnRedef') - p(t,'nRedef'));
    display$[p(t,'errRedef')] 'failed: bad m.numredef';
    p(t,'Sx.l') = x.l;
    p(t,'Sf.l') = f.l;
    p(t,'errXl')    = p(t,'xl') - p(t,'Sx.l');
    p(t,'errFl')    = p(t,'fl') - p(t,'Sf.l');
    display$(abs(p(t,'errXl')) > tol) 'failed: bad x.l';
    display$(abs(p(t,'errFl')) > tol) 'failed: bad f.l';
    p(t,'Sx.m') = x.m;
    p(t,'Sf.m') = f.m;
    p(t,'errXm') = p(t,'xm') - p(t,'Sx.m');
    p(t,'errFm') = p(t,'fm') - p(t,'Sf.m');
    if {mchecks,
      display$(abs(p(t,'errXm')) > tol) 'failed: bad x.m'
      display$(abs(p(t,'errFm')) > tol) 'failed: bad f.m'
    };
  }; // end if (xerr) .. else ..
};

display p;
set badxerr(t)
    badstat(t)
    badredef(t)
    badxl(t)
    badfl(t)
    badxm(t)
    badfm(t);
badxerr(tt)  = p(tt,'errXerr');
badstat(tt)  = p(tt,'errStat');
badredef(tt) = p(tt,'errRedef');
badxl(tt)    = abs(p(tt,'errXl')) > tol;
badfl(tt)    = abs(p(tt,'errFl')) > tol;
badxm(tt)    = abs(p(tt,'errXm')) > tol;
badfm(tt)    = abs(p(tt,'errFm')) > tol;

display badxerr,badstat,badredef,badxl,badfl,badxm,badfm;

abort$[card(badxerr) + card(badstat) + card(badredef) + card(badxl)
     + card(badfl)] 'There were failures, see the listing above';
abort$[mchecks and (card(badxm) + card(badfm))]
     'There were failures, see the listing above';
