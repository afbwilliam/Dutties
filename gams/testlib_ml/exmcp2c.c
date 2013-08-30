/*
  exmcp2c.c

  C implementation of the external functions for example MCP2
  in the file exmcp1.gms.

*/

#include <math.h>
#include "geheader.h"

#define N 8

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  /*
    Declare local arrays to hold the model data.
  */

  int  j, findex, dofnc, dodrv, neq, nvar, nz, rc=0;

  if ( icntr[I_Mode] == DOINIT ) {
    /*
      Initialization Mode:
      Write a "finger print" to the status file so errors in the DLL
      can be detected more easily. This should be done before anything
      can go wrong. Also write a line to the log just to show it.
    */

    GEstat( icntr, " ");
    GEstat( icntr, "**** Using shared object based on exmcp1c.c.");
    GElog ( icntr, "--- GEFUNC in exmcp1c.c is being initialized.");

    /*  Test the sizes and return 0 if OK */
    neq	= N;
    nvar = N;
    nz = N*N;
    if ( neq != icntr[I_Neq] || nvar != icntr[I_Nvar] ||  nz != icntr[I_Nz] ) {
      GElog ( icntr, "--- Model has the wrong size.");
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
      GEstat( icntr," ** fIndex has unexpected value.");
      rc = 2;
    }
    return rc;
  }
  else {
    GElog( icntr," ** Mode not defined.");
    GEstat( icntr," ** Mode not defined.");
    rc = 2;
  }

  return rc;
} /* gefunc */
