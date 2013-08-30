/*
  er2c_cb.c

  C implementation of the external functions for error example 2
  in the file er2.gms.
  Here, we use the callback capability for the messages.
  Look for **ERROR** to find the error and compare with the message in
  the *.lst file.

*/

#include <math.h>
#include "geheader.h"

#define ni 4

static double x0[ni], q[ni][ni];

static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); msgcb(&mmode,&nchars,buf,nchars);} while (0)

GE_API int GE_CALLCONV
gefunc( int *icntr, double *x, double *f, double *d, msgcb_t msgcb)
{
  /*
    Declare local arrays to hold the model data.
  */

  int  i, j, findex, dofnc, dodrv, neq, nvar, nz, rc=0;

  if ( icntr[I_Mode] == DOINIT ) {
    /*
      Initialization Mode:
      Write a "finger print" to the status file so errors in the DLL
      can be detected more easily. This should be done before anything
      can go wrong. Also write a line to the log just to show it.
    */

    MSGCB (LOGFILE | STAFILE,"");
    MSGCB (LOGFILE | STAFILE,"--- GEFUNC in er2c_cb.c is being initialized.");

    /*  Test the sizes and return 0 if OK */
    neq = 1;
    nvar = ni+1;
    nz = ni+1;
    if ( neq != icntr[I_Neq] || nvar != icntr[I_Nvar] ||  nz != icntr[I_Nz] ) {
      MSGCB (LOGFILE,"--- Model has the wrong size.");
      rc = 2;
    }
    else {
      /*
        Define the model data using statements similar to those in GAMS.
        Note that any changes in the GAMS model must be changed here also,
        so syncronization can be a problem with this methodology.
      */
      for (i = 0; i < ni; i++) {
        x0[i]  = (i+1);  /* ??? */
        for (j = 0; j < ni; j++)
          q[i][j] = pow(0.5,(double)abs(i-j));
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
            *f += (x[i]-x0[i]) * q[i][j] * (x[j]-x0[j]);
      }
      /*
        The vector of derivatives is needed. The derivative with respect
        to variable x(i) must be returned in d(i). The derivatives of the
        linear terms, here -Z, must be defined each time.
      */
      if ( dodrv ) {
        for (i = 0; i < ni; i++) {
          d[i] = 0;
          for (j = 0; j < ni; j++ )
            d[i] = d[i] + q[i][j] * ( x[j]-x0[j] );
          d[i] = d[i] * 2.0;
        }
/* **ERROR**
     The constant derivative has wrong index: 0 instead of ni: */
        d[0] = -1.0;
      }
    }
    else {
      /*
        If findex is different from 1, then something is wrong and we
        return 2.
      */
      MSGCB (STAFILE | LOGFILE," ** fIndex has unexpected value.");
      rc = 2;
    }
    return rc;
  }
  else {
    MSGCB (STAFILE | LOGFILE," ** Mode not defined.");
    rc = 2;
    return rc;
  }
}
