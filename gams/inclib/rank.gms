$if not setglobal debug $offlisting offinclude

$hidden   Created 4/03 (tfr)

$if not errorfree $exit

$hidden        Libinclude routine for sorting vectors:

$hidden        Usage:

$hidden        $libinclude rank v s r [p]

$hidden        Required arguments:

$hidden        	v(s)    Values to be sorted (input)
$hidden        	s       Set of identifiers to be sorted (input)
$hidden        	r(s)    Rank orders (integers between 1 and card(s)) (output)

$hidden        Optional argument:

$hidden        	p(*)    Percentiles (input and output)

$hidden  First invocation must be outside of a loop or if block.
$hidden
$hidden  Use a blank invocation (without an id) to initialize.
$hidden

$if not declared rank_tmp  parameter rank_tmp(*); alias (rank_u,*); set rank_p(*);

$if "%1"=="" $exit

$setargs v s r p

$if     settype %v% $abort "Error detected in SORT. First argument (%1) may not be a set."
$if not dimension 1 %v% $abort "Error in RANK. Item %v% is not one dimensional."

$if "%s%"=="" $abort "Error in RANK.  Second (set) and third (rank) arguments are required."
$if not settype %s% $abort "Error detected in SORT. Second argument (%s%) must be a set."
$if not dimension 1 %s% $abort "Error detected in RANK. Second argument (%s%) is not one dimensional."

$if "%r%"=="" $abort "Error in RANK.  Third (rank) parameter argument is required."
$if not partype %r% $abort "Error detected in RANK. Third argument (%r%) must be a parameter."
$if not dimension 1 %r% $abort "Error detected in RANK. Third argument (%r%) is not one dimensional."

$if "%p%"=="" $goto start

$if not partype %p% $abort "Error in RANK.  Percentile argument is not a single-dimensional set."
$if not dimension 1 %p% $abort "Error detected in RANK. Percentile argument (%p%) is not one dimensional."

$hidden        Determine centiles to be computed:
$onuni

$hidden        mapval=8 means EPS

rank_p(rank_u) = yes$((%p%(rank_u) ne 0) or (mapval(%p%(rank_u)) eq 8));
loop(rank_p,
  abort$(       (mapval(%p%(rank_p)) ne 8) and
        (%p%(rank_p) lt 1) or (%p%(rank_p)) gt 100)
        "Error in RANK.  Percentiles must be between 1 and 100.",%p%;
);
$offuni

$label start

*       Transfer data to the GDX file:

rank_tmp(%s%) = %v%(%s%) + eps;
execute_unload 'rank_data.gdx',rank_tmp;
rank_tmp(%s%) = 0;
$ifthen %gams.lo% == 2
execute 'gdxrank rank_data.gdx rank_output.gdx > %system.nullfile%';
$else
execute 'gdxrank rank_data.gdx rank_output.gdx';
$endif
execute_load 'rank_output.gdx',%r%=Rank_Tmp;

$if "%p%"=="" $exit

$hidden        	Additional code handles the percentiles:

$onuni
%p%(rank_p) = 1 + (card(%s%)-1)*%p%(rank_p)/100;
%p%(rank_p) = sum(%s%, (%v%(%s%) *    mod(%p%(rank_p),1) )$(%r%(%s%) eq  ceil(%p%(rank_p)))
                     + (%v%(%s%) * (1-mod(%p%(rank_p),1)))$(%r%(%s%) eq floor(%p%(rank_p))) );
rank_p(rank_u) = no;
$offuni
