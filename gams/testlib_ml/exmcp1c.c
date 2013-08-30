/*
  exmcp1c.c

  C implementation of the external functions for example MCP1
  in the file exmcp1.gms.

*/

#include <math.h>
#include "geheader.h"

#define FNAME "exmcp1.put"
#define N 14
static double Q[N][N];
static double X0[N];

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  /*
    Declare local arrays to hold the model data.
  */

  int  i, j, findex, dofnc, dodrv, neq, nvar, nz, rc=0;
  FILE *fp;
  char buf[128];

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

    /*  Test the sizes and return 2 if not OK */
    neq	= N;
    nvar = N;
    nz = N*N;
    if ( neq != icntr[I_Neq] || nvar != icntr[I_Nvar] ||  nz != icntr[I_Nz] ) {
      GElog ( icntr, "--- Model has the wrong size.");
      return 2;
    }


    fp = fopen (FNAME, "r");
    if (NULL == fp) {
      sprintf (buf, "--- Could not open data file %s for read", FNAME);
      GEstat (icntr, buf);
      GElog  (icntr, buf);
      return 2;
    }
    fscanf (fp, "%d", &i);
    if (i != neq || i != nvar) {
      GEstat (icntr, "--- Data file has the wrong size.");
      GElog  (icntr, "--- Data file has the wrong size.");
      return 2;
    }
    for (i = 0;  i < neq;  i++) {
      fscanf (fp, "%lf", &(X0[i]));
      for (j = 0;  j < nvar;  j++) {
	fscanf (fp, "%lf", &(Q[i][j]));
      }
    }
    fclose (fp);

#if defined(PRECISION_CHECK)
    /* as a quick check, we can compute the data exactly; this allows
     * us to check the loss in precision due to the data file being
     * written to and then read from the text file */
    for (i = 0;  i < neq;  i++) {
      X0[i] = (i+1.0) / neq;
      Q[i][i] = 1.0;
      for (j = i+1;  j < nvar;  j++) {
	Q[i][j] = pow(0.5, j-i);
	Q[j][i] = Q[i][j];
      }
    }
#endif

    return 0;
  } /* init mode */
  else if ( icntr[I_Mode] == DOTERM ) {
    /* Termination mode: Do nothing */
    return rc;
  }
  else if ( icntr[I_Mode] == DOEVAL ) {
    /* Function and Derivative Evaluation Mode */
    findex = icntr[I_Eqno];
    dofnc = icntr[I_Dofunc];
    dodrv = icntr[I_Dodrv];
    rc = 0;

    /*
     * Function index: make sure findex is in range
     */
    if (findex >= 1  && findex <= N) {
      i = findex - 1;
      if (dofnc) {
	/* Function value is needed */
	*f = 0;
	for (j = 0; j < N; j++)
	  *f += Q[i][j] * (x[j]-X0[j]);
	*f *= 2;
      }
      if ( dodrv ) {
	/*
	 * The vector of derivatives is needed. The derivative with respect
	 * to variable x(i) must be returned in d(i).
	 */
	for (j = 0; j < N; j++) {
	  d[j] = 2 * Q[i][j];
	}
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
    return 2;
  }
} /* gefunc */
