/*
 * exmcp4c_cb.c
 *
 * C implementation of the external functions for example MCP4
 * in the file exmcp4.gms.
 * Here, we use the callback capability for the messages.
 *
 */

#include <math.h>
#include "geheader.h"

#define NJ  10
#define NJC 6
#define NI  2
#define NR  2

static char msgbuf[128];

static double p = .2;
static double alpha = .7;
static double A[NI][NJ] = {
  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,
  3,  3,  2,  2,  1,  1,  1, .5,  1, .5
};
static double B[NI][NJ] = {
  1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 4.0, 3.0, 1.5, 1.5,
  2.7, 2.7, 1.8, 1.8,  .9,  .9,  .9,  .4, 2.0, 1.5
};
static double C[NR][NJ] = {
  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
   .5, 1.5, 1.5,  .5,  .5, 1.5, 1.5,  .5,  .5, 1.5
};
static double w[NR] = {
  0.8,
  0.8
};

static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); msgcb(&mmode,&nchars,buf,nchars);} while (0)

static int neq, nvar, nz;

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  int  i, j, r, findex, dofnc, dodrv, rc=0;

  if ( icntr[I_Mode] == DOINIT ) {
    /*
     * Initialization Mode:
     * Write a "finger print" to the status and log files so errors in the DLL
     * can be detected more easily. This should be done before anything
     * can go wrong.
     */

    MSGCB (STAFILE, "");
    MSGCB (STAFILE, "**** GEFUNC in exmcp4c_cb.c is being initialized.");
    MSGCB (LOGFILE, "--- GEFUNC in exmcp4c_cb.c is being initialized.");

    /*  Test the sizes and return 0 if OK */
    neq	= NJ+NR;
    nvar = NJ+NI+NR;
    nz = NJC*NJC + NJ*(NI+NR)
      + NR*NJ;
    if ( neq != icntr[I_Neq] || nvar != icntr[I_Nvar] ||  nz != icntr[I_Nz] ) {
      MSGCB (LOGFILE, "--- Model has the wrong size.");
      sprintf (msgbuf, "Equation count: received %4d,   expected %4d",
	       icntr[I_Neq], neq);
      MSGCB (LOGFILE, msgbuf);
      sprintf (msgbuf, "Variable count: received %4d,   expected %4d",
	       icntr[I_Nvar], nvar);
      MSGCB (LOGFILE, msgbuf);
      sprintf (msgbuf, " Nonzero count: received %4d,   expected %4d",
	       icntr[I_Nz], nz);
      MSGCB (LOGFILE, msgbuf);
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
    if (findex <= 0 || findex > neq) {
      /* findex is out of range: return 2. */
      MSGCB (STAFILE | LOGFILE, " ** fIndex has unexpected value.");
      sprintf (msgbuf, " ** fIndex is %d:  expected in [1,%d]",
	       findex, neq);
      MSGCB (STAFILE | LOGFILE, msgbuf);
      rc = 2;
    } /* bad findex */
    else if (findex <= NJ) {
      if (dofnc) {
	if      (1 == findex) {
	  *f = - p
	    * pow(x[0] + 2.5*x[1],p-1)
	    * pow(2.5*x[2] + x[3],p)
	    * pow(2*x[4] + 3*x[5],p);
	}
	else if (2 == findex) {
	  *f = - p * 2.5
	    * pow(x[0] + 2.5*x[1],p-1)
	    * pow(2.5*x[2] + x[3],p)
	    * pow(2*x[4] + 3*x[5],p);
	}
	else if (3 == findex) {
	  *f = -p * 2.5
	    * pow(x[0] + 2.5*x[1],p)
	    * pow(2.5*x[2] + x[3],p-1)
	    * pow(2*x[4] + 3*x[5],p);
	}
	else if (4 == findex) {
	  *f = - p
	    * pow(x[0] + 2.5*x[1],p)
	    * pow(2.5*x[2] + x[3],p-1)
	    * pow(2*x[4] + 3*x[5],p);
	}
	else if (5 == findex) {
	  *f = -p * 2.0
	    * pow(x[0] + 2.5*x[1],p)
	    * pow(2.5*x[2] + x[3],p)
	    * pow(2*x[4] + 3*x[5],p-1);
	}
	else if (6 == findex) {
	  *f = -p * 3.0
	    * pow(x[0] + 2.5*x[1],p)
	    * pow(2.5*x[2] + x[3],p)
	    * pow(2*x[4] + 3*x[5],p-1);
	}
	else {
	  *f = 0;
	}
	/* Function value is needed */
	j = findex - 1;
	for (i = 0;  i < NI;  i++) {
	  *f += x[NJ+i] * (A[i][j]-alpha*B[i][j]);
	}
	for (r = 0;  r < NR;  r++) {
	  *f += x[NJ+NI+r] * C[r][j];
	}
      }
      if ( dodrv ) {
	if      (1 == findex) {
	  d[0] = -p * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 1.0 * pow(x[0] + 2.5*x[1],p-2);
	  d[1] = -p * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 2.5 * pow(x[0] + 2.5*x[1],p-2);
	  d[2] = -p * pow(x[0] + 2.5*x[1],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 2.5 * pow(2.5*x[2] + x[3],p-1);
	  d[3] = -p * pow(x[0] + 2.5*x[1],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 1.0 * pow(2.5*x[2] + x[3],p-1);
	  d[4] = - p * pow(x[0] + 2.5*x[1],p-1) * pow(2.5*x[2] + x[3],p)
	    * p * 2.0 * pow(2*x[4] + 3*x[5],p-1);
	  d[5] = - p * pow(x[0] + 2.5*x[1],p-1) * pow(2.5*x[2] + x[3],p)
	    * p * 3.0 * pow(2*x[4] + 3*x[5],p-1);
	}
	else if (2 == findex) {
	  d[0] = - p * 2.5 * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 1.0 * pow(x[0] + 2.5*x[1],p-2);
	  d[1] = - p * 2.5 * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 2.5 * pow(x[0] + 2.5*x[1],p-2);
	  d[2] = - p * 2.5 * pow(x[0] + 2.5*x[1],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 2.5 * pow(2.5*x[2] + x[3],p-1);
	  d[3] = - p * 2.5 * pow(x[0] + 2.5*x[1],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 1.0 * pow(2.5*x[2] + x[3],p-1);
	  d[4] = - p * 2.5 * pow(x[0] + 2.5*x[1],p-1) * pow(2.5*x[2] + x[3],p)
	    * p * 2.0 * pow(2*x[4] + 3*x[5],p-1);
	  d[5] = - p * 2.5 * pow(x[0] + 2.5*x[1],p-1) * pow(2.5*x[2] + x[3],p)
	    * p * 3.0 * pow(2*x[4] + 3*x[5],p-1);
	}
	else if (3 == findex) {
	  d[0] = -2.5 * p * pow(2.5*x[2] + x[3],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 1.0 * pow(x[0] + 2.5*x[1],p-1);
	  d[1] = -2.5 * p * pow(2.5*x[2] + x[3],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 2.5 * pow(x[0] + 2.5*x[1],p-1);
	  d[2] = -2.5 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 2.5 * pow(2.5*x[2] + x[3],p-2);
	  d[3] = -2.5 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 1.0 * pow(2.5*x[2] + x[3],p-2);
	  d[4] = -2.5 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2.5*x[2] + x[3],p-1)
	    * p * 2.0 * pow(2*x[4] + 3*x[5],p-1);
	  d[5] = -2.5 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2.5*x[2] + x[3],p-1)
	    * p * 3.0 * pow(2*x[4] + 3*x[5],p-1);
	}
	else if (4 == findex) {
	  d[0] = -1.0 * p * pow(2.5*x[2] + x[3],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 1.0 * pow(x[0] + 2.5*x[1],p-1);
	  d[1] = -1.0 * p * pow(2.5*x[2] + x[3],p-1) * pow(2*x[4] + 3*x[5],p)
	    * p * 2.5 * pow(x[0] + 2.5*x[1],p-1);
	  d[2] = -1.0 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 2.5 * pow(2.5*x[2] + x[3],p-2);
	  d[3] = -1.0 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2*x[4] + 3*x[5],p)
	    * (p-1) * 1.0 * pow(2.5*x[2] + x[3],p-2);
	  d[4] = -1.0 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2.5*x[2] + x[3],p-1)
	    * p * 2.0 * pow(2*x[4] + 3*x[5],p-1);
	  d[5] = -1.0 * p *  pow(x[0] + 2.5*x[1],p)  * pow(2.5*x[2] + x[3],p-1)
	    * p * 3.0 * pow(2*x[4] + 3*x[5],p-1);
	}
	else if (5 == findex) {
	  d[0] = -2.0 * p * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 1.0 * pow(x[0] + 2.5*x[1],p-1);
	  d[1] = -2.0 * p * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 2.5 * pow(x[0] + 2.5*x[1],p-1);
	  d[2] = -2.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 2.5 * pow(2.5*x[2] + x[3],p-1);
	  d[3] = -2.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 1.0 * pow(2.5*x[2] + x[3],p-1);
	  d[4] = -2.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2.5*x[2] + x[3],p)
	    * (p-1) * 2.0 * pow(2*x[4] + 3*x[5],p-2);
	  d[5] = -2.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2.5*x[2] + x[3],p)
	    * (p-1) * 3.0 * pow(2*x[4] + 3*x[5],p-2);
	}
	else if (6 == findex) {
	  d[0] = -3.0 * p * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 1.0 * pow(x[0] + 2.5*x[1],p-1);
	  d[1] = -3.0 * p * pow(2.5*x[2] + x[3],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 2.5 * pow(x[0] + 2.5*x[1],p-1);
	  d[2] = -3.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 2.5 * pow(2.5*x[2] + x[3],p-1);
	  d[3] = -3.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2*x[4] + 3*x[5],p-1)
	    * p * 1.0 * pow(2.5*x[2] + x[3],p-1);
	  d[4] = -3.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2.5*x[2] + x[3],p)
	    * (p-1) * 2.0 * pow(2*x[4] + 3*x[5],p-2);
	  d[5] = -3.0 * p * pow(x[0] + 2.5*x[1],p) * pow(2.5*x[2] + x[3],p)
	    * (p-1) * 3.0 * pow(2*x[4] + 3*x[5],p-2);
	}
	j = findex - 1;
	for (i = 0; i < NI; i++) {
	  d[NJ+i] = A[i][j] - alpha*B[i][j];
	}
	for (r = 0;  r < NR;  r++) {
	  d[NJ+NI+r] = C[r][j];
	}
      }
    } /* findex <= NJ */
    else {
      r = findex - 1 - NJ;
      if (dofnc) {
	*f = w[r];
	for (j = 0;  j < NJ;  j++) {
	  *f -= C[r][j]*x[j];
	}
      }
      if (dodrv) {
	for (j = 0;  j < NJ;  j++) {
	  d[j] = -C[r][j];
	}
      }
    }
    return rc;
  }
  else {
    MSGCB (STAFILE | LOGFILE, " ** Mode not defined.");
    rc = 2;
  }

  return rc;
} /* gefunc */




