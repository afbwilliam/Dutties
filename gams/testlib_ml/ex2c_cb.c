/*
 * ex2c_cb.c
 *
 * C implementation of the external functions for example 2
 * in the file ex2.gms.
 * Here, we use the callback capability for the messages.
 *
 */

#include <math.h>
#include "geheader.h"

static int N;
static double *x0 = NULL;
static double *Q  = NULL;

static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); msgcb(&mmode,&nchars,buf,nchars);} while (0)

GE_API int GE_CALLCONV
gefunc (int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  int i, j;
  FILE *fp;

  if (icntr[I_Mode] == DOINIT) {
    /*
     * Initialization Mode:
     * Write a "finger print" to the status file so errors in the DLL
     * can be detected more easily. This should be done before anything
     * can go wrong. Also write a line to the log just to show it.
     */
    MSGCB (LOGFILE | STAFILE,"");
    MSGCB (LOGFILE | STAFILE,"--- GEFUNC in ex2c_cb.c is being initialized.");

    /*  Test the equation count and return 2 if bogus */
    if (1 != icntr[I_Neq]) {
      MSGCB (LOGFILE | STAFILE,
	     "--- Model has the wrong number of external equations.");
      return 2;
    }
    if (icntr[I_Nvar] != icntr[I_Nz]) {
      MSGCB (LOGFILE | STAFILE,
	     "--- This external equations should be fully dense.");
      return 2;
    }
    N = icntr[I_Nvar] - 1;
    fp = fopen ("ex2.put", "r");
    if (NULL == fp) {
      MSGCB (LOGFILE | STAFILE,
	     "--- Could not open put file for read.");
      return 2;
    }
    fscanf (fp, "%d", &i);
    if (N != i) {
      MSGCB (LOGFILE | STAFILE,
	     "--- Inconsistent dimension found in put file.");
      return 2;
    }
    x0 = (double *) malloc(N * sizeof(double));
    Q  = (double *) malloc(N*N * sizeof(double));
    if (NULL == x0 || NULL == Q) {
      MSGCB (LOGFILE | STAFILE,
	     "--- Malloc failure: could not allocate space.");
      return 2;
    }

    /* these should probably be checked for i/o errors, but are not */
    for (i = 0;  i < N;  i++) {
      fscanf (fp, "%lf", x0+i);
      for (j = 0;  j < N;  j++) {
	fscanf (fp, "%lf", Q+(i*N + j));
      }
    }

    return 0;
  } /* initialization mode */
  else if ( icntr[I_Mode] == DOTERM ) {
    /* Termination mode: free allocated storage */

    if (NULL != x0) {
      free(x0);
      x0 = NULL;
    }
    if (NULL != Q) {
      free(Q);
      Q = NULL;
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

    if (icntr[I_Dofunc]) {
      /*
       * Function value is needed. Note that the linear term corresponding
       * to -Z must be included.
       */
      *f = -x[N];
      for (i = 0; i < N; i++)
	for (j = 0; j < N; j++)
	  *f += (x[i]-x0[i]) * Q[i*N+j] * (x[j]-x0[j]);
    } /* end func eval */

    if (icntr[I_Dodrv]) {
      /*
       * The vector of derivatives is needed. The derivative with respect
       * to variable x(i) must be returned in d(i). The derivatives of the
       * linear terms, here -Z, must be defined each time.
       */
      d[N] = -1.0;
      for (i = 0; i < N; i++) {
	d[i] = 0;
	for (j = 0; j < N; j++ ) {
	  d[i] = d[i] + Q[i*N+j] * (x[j]-x0[j]);
	}
	d[i] = d[i] * 2.0;
      }
    } /* end derivative eval */

    return 0;
  } /* Function and Derivative Evaluation Mode */
  else {
    MSGCB (STAFILE | LOGFILE, " ** Mode not defined.");
    return 2;
  }
} /* gefunc */
