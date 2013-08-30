/*
  er3c_cb.c

  C implementation of the external functions for error example 3
  in the file er3.gms.
  Here, we use the callback capability for the messages.
  Look for **ERROR** to find the error and compare with the message in
  the *.lst file.

 */

#include "geheader.h"

/* these sizes could be made dynamic if you wanted
 * to allow general N-gons instead of hexagons */
#define N       6
#define NMAP    (N*(N-1))/2
#define NEQ     21
#define NVAR    33
#define NZ      (5*15 + 5*6)

#if ! defined(SQR)
# define SQR(X) ((X)*(X))
#endif

static int f2i[NMAP];
static int f2j[NMAP];
static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); msgcb(&mmode,&nchars,buf,nchars);} while (0)

GE_API int GE_CALLCONV
gefunc (int *icntr, double *x_in, double *f, double *d, msgcb_t msgcb)
{
  int findex, i, j;

  if (icntr[I_Mode] == DOINIT) {
    MSGCB (LOGFILE | STAFILE,"");
    MSGCB (LOGFILE | STAFILE,"--- GEFUNC in er3c_cb.c is being initialized.");

    /*  Test the equation count and return 2 if bogus */
    if (NEQ != icntr[I_Neq]
        || NVAR != icntr[I_Nvar]
        || NZ != icntr[I_Nz]) {
      MSGCB (LOGFILE | STAFILE, "--- Model has the wrong size.");
      return 2;
    }

    /* these should probably be checked for i/o errors, but are not */
    for (findex = 0, i = 0;  i < N;  i++) {
      for (j = i+1;  j < N;  j++) {
        f2i[findex] = i;
        f2j[findex] = j;
        findex++;
      }
    }

    return 0;
  } /* initialization mode */
  else if ( icntr[I_Mode] == DOTERM ) {
    /* nothing to do in this external module */
    return 0;
  } /* termination mode */
  else if ( icntr[I_Mode] == DOEVAL ) {
    double  *x,  *y,  *area,  *slack;
    double *dx, *dy, *darea, *dslack;

    /*
     * x[j=0..N)          = x_in[j]
     * y[j=0..N)          = x_in[j+N]
     * area[j=0..N)       = x_in[j+2*N]
     * slack[j=0..NMAP)   = x_in[j+3*N]
     * and similarly for dx, dy, darea, dslack
     */

    /* first set up the variable mapping */
    x       = x_in;
    y       = x_in+N;
    area    = x_in+2*N;
    slack   = x_in+3*N;

    findex = icntr[I_Eqno] - 1;
    if (findex < 0 || findex >= NMAP + N) { /* bogus findex */
      MSGCB (STAFILE | LOGFILE," ** Eqno has unexpected value.");
      return 2;
    }
    else if (findex < NMAP) {           /* maxdist equation */
      i = f2i[findex];
      j = f2j[findex];

      if (icntr[I_Dofunc]) {
        *f = SQR(x[i]-x[j]) + SQR(y[i]-y[j])
          + slack[findex] - 1;
      }
      if (icntr[I_Dodrv]) {
        /* The derivative w.r.t. x(i) must be returned in d(i).
         * Only nonzero values have to be defined. */

        dx       = d;
        dy       = d+N;
        dslack   = d+3*N;

        dx[i]          = 2 * (x[i]-x[j]);
        dx[j]          = -dx[i];
        dy[i]          = 2 * (y[i]-y[j]);
        dy[j]          = -dy[i];
        dslack[findex] = 1;
      }
    } /* maxdist equation */
    else {                              /* areadef equation */
      int iplus;

      i = findex - NMAP;
      iplus = (i + 1) % N;
      if (icntr[I_Dofunc]) {
        *f = area[i]
          - 0.5 * (x[i]*y[iplus] - y[i]*x[iplus]);
      }
      if (icntr[I_Dodrv]) {
        /* The derivative w.r.t. x(i) must be returned in d(i).
         * Only nonzero values have to be defined. */

        dx       = d;
        dy       = d+N;
        darea    = d+2*N;

        darea[i]  = 1;
/* **ERROR** The following derivative should be defined but we have
             removed the line. Note that the error messages may appear
             strange. The value of d(i) could be inherited from the
             previous equation that defined d(i).
        dx[i]     = -.5 * y[iplus];                              */
        dx[iplus] =  .5 * y[i];
        dy[i]     =  .5 * x[iplus];
        dy[iplus] = -.5 * x[i];
/* **ERROR** An extra derivative is being defined:
             This cannot be seen found because the interface only
             transfers derivatives that are consistent with the
             sparsety pattern defined in GAMS.                   */
        dy[iplus+1] = -.5 * x[i];
      }
    } /* areadef equation */

    return 0;
  } /* function and derivative evaluation mode */
  else {                                /* unexpected mode value */
    MSGCB (STAFILE | LOGFILE, " ** Mode not defined.");
    return 2;
  }
} /* gefunc */
