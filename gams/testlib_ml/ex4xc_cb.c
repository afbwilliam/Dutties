/*
 * ex4xc_cb.c
 *
 * C implementation of the external functions for example 4
 * (DEA, parameter estimation) in the file ex4x.gms.
 * Here, we use the callback capability for the messages.
 * The special aspect of this implementation is that we tell the
 * solvers that some of the derivatives are constant and we declare
 * the derivate w.r.t cv to be constant = +1.
 *
 */

#include <math.h>
#include "geheader.h"

static int nDMU;
static double *objval = NULL;
static double fudge = 0.0;

static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); msgcb(&mmode,&nchars,buf,nchars);} while (0)

GE_API int GE_CALLCONV
gefunc (int *icntr, double *x, double *func, double *d, msgcb_t msgcb)
{
  int i, ii, scanCount;
  FILE *fp;
#if defined(SOME_DEBUG_STUFF)
  char msgBuf[256];
#endif
  double t,  dtdh;
  double t1, dt1dh;
  double t2, dt2dh;
  double h, cv, dfdh, dfdcv, f;

  if (icntr[I_Mode] == DOINIT) {
    /*
     * Initialization Mode:
     * Write a "finger print" to the status file so errors in the DLL
     * can be detected more easily. This should be done before anything
     * can go wrong. Also write a line to the log just to show it.
     */
    MSGCB (LOGFILE | STAFILE,"");
    MSGCB (LOGFILE | STAFILE,"--- GEFUNC in ex4xc_cb.c is being initialized.");

    /*  Test the equation count and return 2 if bogus */
    if (1 != icntr[I_Neq]) {
      MSGCB (LOGFILE | STAFILE,
             "--- Model has the wrong number of external equations.");
      return 2;
    }
    if (2 != icntr[I_Nz]) {
      MSGCB (LOGFILE | STAFILE,
             "--- The external equation should be fully dense.");
      return 2;
    }
    if (2 != icntr[I_Nvar]) {
      MSGCB (LOGFILE | STAFILE,
             "--- The external equation should have 2 variables.");
      return 2;
    }
    fp = fopen ("ex4x.put", "r");
    if (NULL == fp) {
      MSGCB (LOGFILE | STAFILE,
             "--- Could not open put file for read.");
      return 2;
    }
    scanCount = fscanf (fp, "%d", &nDMU);
    if (1 != scanCount) {
      MSGCB (LOGFILE | STAFILE,
             "--- Error reading DMU count from put file.");
      return 2;
    }
    if (nDMU <= 0) {
      MSGCB (LOGFILE | STAFILE,
             "--- Non-positive DMU count found in put file.");
      return 2;
    }
    scanCount = fscanf (fp, "%lf", &fudge);
    if (1 != scanCount) {
      MSGCB (LOGFILE | STAFILE,
             "--- Error reading fudge factor from put file.");
      return 2;
    }
    if (fudge < 0) {
      MSGCB (LOGFILE | STAFILE,
             "--- Negative fudge factor found in put file.");
      return 2;
    }

    objval = (double *) malloc(nDMU * sizeof(double));
    if (NULL == objval) {
      MSGCB (LOGFILE | STAFILE,
             "--- Malloc failure: could not allocate space.");
      return 2;
    }

    /* these should probably be checked for i/o errors, but are not */
    for (i = 0;  i < nDMU;  i++) {
      scanCount = fscanf (fp, "%lf", objval+i);
      if (1 != scanCount) {
        MSGCB (LOGFILE | STAFILE,
               "--- Error reading put file.");
        free (objval);
        objval = NULL;
        fclose (fp);
        return 2;
      }
    }

    /* Define number of constant derivatives    */
    icntr[I_ConstDeriv] = 1;
    fclose (fp);
    return 0;
  } /* initialization mode */
  else if ( icntr[I_Mode] == DOCONSTDERIV ) {
    /* Define values of the nonzero constant derivatives    */
    if (icntr[I_Eqno] != 1) {
      MSGCB (STAFILE | LOGFILE," ** Eqno has unexpected value.");
      return 2;
    }
      d[1] = 1.0;
    return 0;
  }
  else if ( icntr[I_Mode] == DOTERM ) {
    /* Termination mode: free allocated storage */

    if (NULL != objval) {
      free(objval);
      objval = NULL;
    }

    return 0;
  } /* termination mode */
  else if ( icntr[I_Mode] == DOEVAL ) {
    /*
     * Function index: there is only one equation here,
     * but we check the equation number just to show the principle.
     */
    if (icntr[I_Eqno] != 1) {
      MSGCB (STAFILE | LOGFILE," ** Eqno has unexpected value.");
      return 2;
    }

    /* get our values from the array passed in, just to be neat */
    h = x[0];
    cv = x[1];

    if (h <= 0) {
      /* won't eval at this point */
      return 1;
    }

    /* here, we mix the function and gradient computation
     * recall, function looks like -sum {nDMU, big_ugly(h)} + cv =e= 0
     * at the cost of some extra space (two vectors from 1..nDMU), we
     * could cut the time in half using the symmetry; we leave that
     * as an exercise */

    f = cv;
    dfdcv = 1.0;
    dfdh  = 0;

    for (i = 0;  i < nDMU;  i++) {
      t = fudge;
      dtdh = 0;
      for (ii = 0;  ii < nDMU;  ii++) {
        if (i == ii)
          continue;

        t1 = (objval[i]-objval[ii])/h;
        t1 *= t1;
        /* dt1dh = t1 / h;
         * save the division by h until the end; its a common term! */
        dt1dh = t1;
        t1 = exp(-t1/2);
        dt1dh *= t1;

        t2 = (objval[i]+objval[ii]-2)/h;
        t2 *= t2;
        /* dt2dh = t2 / h;
         * save the division by h until the end; its a common term! */
        dt2dh = t2;
        t2 = exp(-t2/2);
        dt2dh *= t2;

        t += t1 + t2;
        dtdh += dt1dh + dt2dh;          /* we won't forget our 1/h term! */
      }
      f -= log(t);
      dfdh -= dtdh/t;
    }

    dfdh /= h;
    f +=  nDMU*log(h);
    dfdh += nDMU / h;

#if defined(SOME_DEBUG_STUFF)
    sprintf (msgBuf, "              dh = %g, dcv = %g, f = %f",
             dfdh, dfdcv, f);
    MSGCB (STAFILE | LOGFILE, msgBuf);
#endif

    if (icntr[I_Dofunc]) {
      *func = f;
    }
    if (icntr[I_Dodrv]) {
      d[0] = dfdh;
      d[1] = dfdcv;
    }
    return 0;
  } /* Function and Derivative Evaluation Mode */
  else {
    MSGCB (STAFILE | LOGFILE, " ** Mode not defined.");
    return 2;
  }
} /* gefunc */
