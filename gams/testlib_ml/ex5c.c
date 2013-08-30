/*
  ex5c.c

  C implementation of the external functions for example 5
  in the file ex5.gms.

*/

#include <math.h>
#include "geheader.h"

#define ni 4
#define BUFLEN 256

static double x0[ni], Q[ni][ni];
static int  first = 1;
static int  gotControlFile = 0;
static int  gotScratchDir  = 0;
static int  controlFileLen;
static int  scratchDirLen;
static char controlFile[BUFLEN];
static char dataFile[BUFLEN+7];
static char scratchDir[BUFLEN];

static char msgBuf[512];

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  /*
    Declare local arrays to hold the model data.
  */

  int  i, j, findex, dofnc, dodrv, neq, nvar, nz, rc=0;

  if ( icntr[I_Mode] == DOINIT ) {
    if (first) {
      /*
       * Initialization Mode:
       * Write a "finger print" to the status file so errors in the DLL
       * can be detected more easily. This should be done before anything
       * can go wrong. Also write a line to the log just to show it.
       */
      GEstat (icntr, " ");
      GEstat (icntr, "**** Using shared object based on ex5c.c.");
      GElog  (icntr, "--- GEFUNC in ex5c.c is being initialized.");
      first = 0;
    }

    if (I_Cntr == icntr[I_Smode]) {
      /* control file requested */
      controlFileLen = GEname (icntr, controlFile, sizeof(controlFile));
      if (controlFileLen <= 0	/* failure or empty string */
	  ||  controlFileLen >= sizeof(controlFile) /* truncation */
	  ) {
	GEstat (icntr, "**** Unable to get the control file");
	return 2;
      }
      else {
	sprintf (msgBuf, "**** GEFUNC: control file = %s", controlFile);
	GEstat (icntr, msgBuf);
	gotControlFile = 1;
      }
    }

    if (I_Scr == icntr[I_Smode]) {
      /* scratch directory requested */
      scratchDirLen = GEname (icntr, scratchDir, sizeof(scratchDir));
      if (scratchDirLen <= 0		/* failure or empty string */
	  || scratchDirLen >= sizeof(scratchDir) /* truncation */
	  ) {
	GEstat (icntr, "**** Unable to get the scratch directory");
	return 2;
      }
      else {
	sprintf (msgBuf, "**** GEFUNC: scratch directory = %s", scratchDir);
	GEstat (icntr, msgBuf);
	gotScratchDir = 1;
      }
    }

    GEstat (icntr, "**** Past file reception");
    if ( ! gotControlFile) {
      icntr[I_Getfil] = I_Cntr;
      return 0;
    }
    GEstat (icntr, "**** Past gotControlFile test");
    if ( ! gotScratchDir) {
      icntr[I_Getfil] = I_Scr;
      return 0;
    }
    GEstat (icntr, "**** Past gotScratchDir test");

    /* Now we have all the necessary file names and we can terminate
     * the initialization
     * Get and test the size and return 0 if OK
     */

    sprintf (dataFile, "%sabc.dat", scratchDir);
    sprintf (msgBuf, "**** GEFUNC: Data file = %s", dataFile);
    GEstat (icntr, msgBuf);

    {
      FILE *fpData = NULL;

      fpData = fopen (dataFile, "r");
      if (NULL != fpData) {
	fscanf (fpData, "%d", &j);
	fclose (fpData);
	if (j != ni) {
	  GEstat (icntr, "Data has unexpected size");
	  return 2;
	}
	else {
	  GEstat (icntr, "Data was as expected");
	}
      }
      else {
	GEstat (icntr, "Could not open data file for read");
	return 2;
      }
    }

    neq	= 1;
    nvar = ni+1;
    nz = ni+1;
    if ( neq != icntr[I_Neq] || nvar != icntr[I_Nvar] ||  nz != icntr[I_Nz] ) {
      GElog ( icntr, "--- Model has the wrong size.");
      rc = 2;
    }
    else {
      /*
	Define the model data using statements similar to those in GAMS.
	Note that any changes in the GAMS model must be changed here also,
	so syncronization can be a problem with this methodology.
      */
      for (i = 0; i < ni; i++) {
	x0[i]  = (i+1);
	for (j = 0; j < ni; j++)
	  Q[i][j] = pow(0.5,(double)abs(i-j));
      }
    }
	
    return rc;
  }
  else if ( icntr[I_Mode] == DOTERM ) {
    /*
      Termination mode: Do nothing
    */
    return rc;
  }
  else if ( icntr[I_Mode] == DOEVAL ) {
    /*
      Function and Derivative Evaluation Mode
    */

    findex = icntr[I_Eqno];
    dofnc = icntr[I_Dofunc];
    dodrv = icntr[I_Dodrv];

    /*
      Function index: there is only one so we do not have to test fIndex,
      but we do it just to show the principle.
    */
    if ( findex == 1 ) {
      if ( dofnc ) {
	/*
	  Function value is needed. Note that the linear term corresponding
	  to -Z must be included.
	*/
	*f = -x[ni];
	for (i = 0; i < ni; i++)
	  for (j = 0; j < ni; j++)
	    *f += (x[i]-x0[i]) * Q[i][j] * (x[j]-x0[j]);
      }
      /*
	The vector of derivatives is needed. The derivative with respect
	to variable x(i) must be returned in d(i). The derivatives of the
	linear terms, here -Z, must be defined each time.
      */
      if ( dodrv ) {
	d[ni] = -1.0;
	for (i = 0; i < ni; i++) {
	  d[i] = 0;
	  for (j = 0; j < ni; j++ )
	    d[i] = d[i] + Q[i][j] * ( x[j]-x0[j] );
	  d[i] = d[i] * 2.0;
	}
      }
    }
    else {
      /*
	If findex is different from 1, then something is wrong and we
	return 2.
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
	return rc;
  }
}
