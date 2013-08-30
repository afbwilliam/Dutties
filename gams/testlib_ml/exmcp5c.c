/*
 * exmcp5c.c
 *
 * C implementation of the external functions for example MCP5
 * in the file exmcp5.gms.
 * Here, we use the callback capability for the messages.
 *
 */

#include <stdio.h>
#include <math.h>
#include "geheader.h"

#define NI 5
#define NC 3

static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); \
                             msgcb(&mmode,&nchars,buf,nchars);} while (0)

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  int i, c;                     /* equation indices */
  int j, doFunc, doDeriv, neq, nvar, nz, rc=0;
  double u, v, X, t, *uvec;
  char msg[256];

  neq = NI+NC;
  if (DOINIT == icntr[I_Mode]) {
    /*
     * Initialization Mode:
     * Write a "finger print" to the status and log files so errors in the DLL
     * can be detected more easily. This should be done before anything
     * can go wrong.
     */

    MSGCB (STAFILE, "");
    MSGCB (STAFILE, "**** GEFUNC in exmcp5c.c is being initialized.");
    MSGCB (LOGFILE, "--- GEFUNC in exmcp5c.c is being initialized.");

    /*  Test the sizes and return 0 if OK */
    nvar = 2*NI+NC;
    nz = 2*NI + NC*(1 + NI);
    if (neq != icntr[I_Neq] || nvar != icntr[I_Nvar] || nz != icntr[I_Nz]) {
      MSGCB (LOGFILE, "--- Model has the wrong size.");
      rc = 2;
    }
    else {
      /* no initialization necessary */
    }

    return rc;
  }
  else if (DOTERM == icntr[I_Mode]) {
    /* Termination mode: Do nothing */
    return rc;
  }
  else if (DOEVAL == icntr[I_Mode]) {
    /* Function and Derivative Evaluation Mode */
    i = icntr[I_Eqno] - 1;      /* make it 0-based */
    doFunc = icntr[I_Dofunc];
    doDeriv = icntr[I_Dodrv];

    if (i < 0 || i >= neq) {
      /* out of range: return 2 */
      sprintf (msg, " ** equation index has unexpected value: got %d,"
               " should be in [1,%d]", icntr[I_Eqno], neq);
      MSGCB (STAFILE | LOGFILE, msg);
      return 2;
    }
    if (i < NI) {
      /* row of ev: ev(i) = exp(v(i)) - u(i) */
      u = x[i];
      v = x[NI+i];
      t = exp(v);
      if (doFunc) {
        *f = t - u;
      }
      if (doDeriv) {
        d[i] = -1;
        d[NI+i] = t;
      }
    }
    else {
      /* row of ex(c) = X(c)**1.75 - 0.2*sum{i, u(i)} */
      c = i - NI;
      X = x[2*NI+c];
      uvec = x;
      t = log(X);
      if (doFunc) {
        *f = 0;
        for (j = 0;  j < NI;  j++)
          *f += uvec[j];
        *f = exp(1.75*t) - 0.2 * (*f);
      }
      if (doDeriv) {
        for (j = 0;  j < NI;  j++)
          d[j] = -0.2;
        d[2*NI+c] = 1.75 * exp(0.75*t);
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
