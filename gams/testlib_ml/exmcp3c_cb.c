/*
 * exmcp3c_cb.c
 *
 * C implementation of the external functions for example MCP3
 * in the file exmcp3.gms.
 * Here, we use the callback capability for the messages.
 *
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include "geheader.h"

#define BUFLEN 256
static int  first = 1;
static int  gotScratchDir  = 0;
static int  scratchDirLen;
static char dataFile[BUFLEN+7];
static char scratchDir[BUFLEN];
static char msgBuf[2*BUFLEN];

#define FNAME "exmcp3.dat"
#define N 50                            /* maximum allowed */
#define MM(i,j) (M[(i)*nvar + (j)])

static int neq, nvar, nz;
static double *M = NULL;
static double *q = NULL;

static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); \
                             msgcb(&mmode,&nchars,buf,nchars);} while (0)

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  int  i, j, k, findex, dofnc, dodrv, rc=0;
  int nBytes;

  if ( icntr[I_Mode] == DOINIT ) {
    if (first) {
      /*
       * Initialization Mode:
       * Write a "finger print" to the status and log files so errors in the DLL
       * can be detected more easily. This should be done before anything
       * can go wrong.
       */
      MSGCB (STAFILE, "");
      MSGCB (STAFILE, "**** GEFUNC in exmcp3c_cb.c is being initialized.");
      MSGCB (LOGFILE, "--- GEFUNC in exmcp3c_cb.c is being initialized.");
      first = 0;
    }

    if (I_Scr == icntr[I_Smode]) {
      /* scratch directory requested */
      scratchDirLen = GEname (icntr, scratchDir, sizeof(scratchDir));
      if (scratchDirLen <= 0            /* failure or empty string */
          || scratchDirLen >= sizeof(scratchDir) /* truncation */
          ) {
        MSGCB (LOGFILE | STAFILE,
               "    GEFUNC: Unable to get the scratch directory");
        return 2;
      }
      else {
        sprintf (msgBuf, "    GEFUNC: scratch directory = %s", scratchDir);
        MSGCB (LOGFILE | STAFILE, msgBuf);
        gotScratchDir = 1;
      }
    }

    MSGCB (LOGFILE | STAFILE, "    GEFUNC: Past file reception");
    if ( ! gotScratchDir) {
      icntr[I_Getfil] = I_Scr;
      return 0;
    }
    MSGCB (LOGFILE | STAFILE, "    GEFUNC: Past gotScratchDir test");


    /*  Test the sizes and return 0 if OK */
    neq        = icntr[I_Neq];
    nvar = icntr[I_Nvar];
    nz = icntr[I_Nz];
    if (neq <= 0
         || nvar <= 0
         || nz <= 0) {
      MSGCB (LOGFILE | STAFILE, "--- Model has a bogus (nonpositive) size.");
      rc = 2;
    }
    else {
      FILE *fpData;

      sprintf (dataFile, "%s%s", scratchDir, FNAME);
      sprintf (msgBuf, "    GEFUNC: Data file = %s", dataFile);
      MSGCB (LOGFILE | STAFILE, msgBuf);
      fpData = fopen (dataFile, "r");
      if (NULL == fpData) {
        MSGCB (LOGFILE | STAFILE,
               "    GEFUNC: Could not open data file for read");
        return 2;
      }
      fscanf (fpData, "%d", &i);
      if (i != neq || i != nvar) {
        MSGCB (STAFILE | LOGFILE,
               "   GEFUNC: Data file has the wrong size.");
        fclose (fpData);
        return 2;
      }
      nBytes = sizeof(double)*neq*nvar;
      M = (double *) malloc (nBytes);
      if (NULL == M) {
        sprintf (msgBuf, "    GEFUNC: Malloc failure for M (%d bytes requested)",
                 nBytes);
        MSGCB (LOGFILE | STAFILE, msgBuf);
        fclose(fpData);
        return 2;
      }
      nBytes = sizeof(double)*neq;
      q = (double *) malloc (nBytes);
      if (NULL == q) {
        sprintf (msgBuf, "    GEFUNC: Malloc failure for q (%d bytes requested)",
                 nBytes);
        MSGCB (LOGFILE | STAFILE, msgBuf);
        free (M);
        M = NULL;
        fclose(fpData);
        return 2;
      }

      for (i = 0;  i < neq;  i++) {
        fscanf (fpData, "%lf", q+i);
      }
      k = neq;
      for (j = 0;  j < nvar;  j++) {
        for (i = 0;  i < neq;  i++) {
          fscanf (fpData, "%lf", &MM(i,j) );
          if (i != j && 0 != MM(i,j))
            k++;
        }
      }

      if (k != nz) {
        MSGCB (STAFILE | LOGFILE,
               "    GEFUNC: Data file has the wrong nonzero count.");
        free (M);
        M = NULL;
        free (q);
        q = NULL;
        fclose (fpData);
        return 2;
      }

      fclose (fpData);
    }

    return rc;
  }
  else if ( icntr[I_Mode] == DOTERM ) {
    if (M) {
      free (M);
      M = NULL;
    }
    if (q) {
      free (q);
      q = NULL;
    }
    return 0;
  }
  else if ( icntr[I_Mode] == DOEVAL ) {
    /* Function and Derivative Evaluation Mode */
    findex = icntr[I_Eqno];
    dofnc = icntr[I_Dofunc];
    dodrv = icntr[I_Dodrv];
    if ( neq != icntr[I_Neq] || nvar != icntr[I_Nvar] ||  nz != icntr[I_Nz] ) {
      MSGCB (STAFILE | LOGFILE, "    GEFUNC: Model has the wrong size.");
      return 2;
    }
    if (NULL == M || NULL == q) {
      MSGCB (STAFILE | LOGFILE, "    GEFUNC: DLL was not properly initialized.");
      return 2;
    }

    /*
     * Function index: make sure findex is in range
     */
    if (findex >= 1  && findex <= neq) {
      if (dofnc) {
        /* Function value is needed */
        *f = x[findex-1]*x[findex-1] - q[findex-1];
        for (j = 0;  j < nvar;  j++)
          *f +=  MM(findex-1,j) * x[j];
      }
      if (dodrv) {
        /*
         * The vector of derivatives is needed. The derivative with respect
         * to variable x(i) must be returned in d(i).
         */
        for (j = 0;  j < nvar;  j++) {
          d[j] = MM(findex-1,j);
        }
        d[findex-1] += 2*x[findex-1];
      }
    }
    else {
      /*
       * findex is out of range: return 2.
      */
      MSGCB (STAFILE | LOGFILE, "    GEFUNC: fIndex has unexpected value.");
      rc = 2;
    }
    return rc;
  }
  else {
    MSGCB (STAFILE | LOGFILE, "    GEFUNC: Mode not defined.");
    rc = 2;
  }

  return rc;
} /* gefunc */
