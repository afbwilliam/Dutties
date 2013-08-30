/*
 * exmcp2c_cb.c
 *
 * C implementation of the external functions for example MCP2
 * in the file exmcp2.gms.
 * Here, we use the callback capability for the messages.
 *
 */

#include <math.h>
#include "geheader.h"

#define N 8

static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); \
                             msgcb(&mmode,&nchars,buf,nchars);} while (0)

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  int  j, findex, dofnc, dodrv, neq, nvar, nz, rc=0;

  if ( icntr[I_Mode] == DOINIT ) {
    /*
     * Initialization Mode:
     * Write a "finger print" to the status and log files so errors in the DLL
     * can be detected more easily. This should be done before anything
     * can go wrong.
     */

    MSGCB (STAFILE, "");
    MSGCB (STAFILE, "**** GEFUNC in exmcp2c_cb.c is being initialized.");
    MSGCB (LOGFILE, "--- GEFUNC in exmcp2c_cb.c is being initialized.");

    /*  Test the sizes and return 0 if OK */
    neq	= N;
    nvar = N;
    nz = N*N;
    if ( neq != icntr[I_Neq] || nvar != icntr[I_Nvar] ||  nz != icntr[I_Nz] ) {
      MSGCB (LOGFILE, "--- Model has the wrong size.");
      rc = 2;
    }
    else {
      /* no initialization necessary */
    }

    return rc;
  }
  else if ( icntr[I_Mode] == DOTERM ) {
    /* Termination mode: Do nothing */
    return rc;
  }
  else if ( icntr[I_Mode] == DOEVAL ) {
    /* Function and Derivative Evaluation Mode */
    findex = icntr[I_Eqno];
    dofnc = icntr[I_Dofunc];
    dodrv = icntr[I_Dodrv];

    /*
     * Function index: make sure findex is in range
     */
    if (findex >= 1  && findex <= N) {
      if (dofnc) {
	/* Function value is needed */
	*f = x[findex-1]*x[findex-1] - 1;
	for (j = 0; j < N; j++)
	  *f +=  .1 * (j+1) * x[j];
      }
      if ( dodrv ) {
	/*
	 * The vector of derivatives is needed. The derivative with respect
	 * to variable x(i) must be returned in d(i).
	 */
	for (j = 0; j < N; j++) {
	  d[j] = .1 * (j+1);
	}
	d[findex-1] += 2*x[findex-1];
      }
    }
    else {
      /*
       * findex is out of range: return 2.
      */
      MSGCB (STAFILE | LOGFILE, " ** fIndex has unexpected value.");
      rc = 2;
    }
    return rc;
  }
  else {
    MSGCB (STAFILE | LOGFILE, " ** Mode not defined.");
    rc = 2;
  }

  return rc;
} /* gefunc */
