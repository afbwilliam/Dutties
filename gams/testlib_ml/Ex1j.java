import java.util.*;

public class Ex1j {
  // in this example, NI is fixed at 4, but it could be generalized
  // to become an input argument
  private static final int NI = 4;
  private static int LOGFILE;
  private static int STAFILE;
  private int MRows;
  private int NCols;
  private int NZ;
  private double[][] Q;
  private double[] x0;

  public native void msgCB (int mode, String msg);
  // We load the native code for the callback via RegisterCallback instead
  //  static {
  //    System.loadLibrary("msgcb");
  //  }

  public Ex1j ()
  {
    MRows = 1;
    NCols = NI + 1;
    NZ    = NI + 1;
    return;
  }

  public int init (int m, int n, int nz, int logfile, int stafile)
  {
    msgCB (logfile | stafile,
	   "--- " + this.getClass().getName()
	   + "init: class initializer called");
    msgCB (logfile | stafile,
	   "---      Args: m:"  + m + "  n:" + n + "  nz:" + nz
	   + "  logfile:" + logfile + "  stafile:" + stafile);
    if (m != MRows || n != NCols || nz != NZ) {
      return 2;			// error
    }
    LOGFILE = logfile;
    STAFILE = stafile;
    Q  = new double[NI][NI];
    x0 = new double[NI];
    for (int i = 0;  i < NI;  i++) {
      x0[i] = i+1;
      for (int j = 0;  j < NI;  j++) {
	Q[i][j] = Math.pow (0.5,Math.abs(i-j) );
      }
    }

    return 0;			// OK
  }// init

  public int funcEval (int fIndex, double[] x, double [] f)
  {
    /* Function index test:
     * there is only one external function so we do not have to test fIndex,
     * but we do it just to show the principle.
     */
    if (fIndex != 1) {
      return 2;			// error
    }
    double tmp = -x[NI];
    for (int i = 0;  i < NI;  i++) {
      for (int j = 0;  j < NI;  j++) {
	tmp += (x[i]-x0[i]) * Q[i][j] * (x[j]-x0[j]);
      }
    }

    f[0] = tmp;
    return 0;			// OK
  } // funcEval

  public int gradEval (int fIndex, double[] x, double[] g)
  {
    if (fIndex != 1) {
      return 2;			// error
    }

    /*
     * The vector of derivatives is needed. The derivative with respect
     * to variable x(i) must be returned in d(i). The derivatives of the
     * linear terms, here -Z, must be defined each time.
     */
    g[NI] = -1;
    for (int i = 0;  i < NI;  i++) {
      g[i] = 0;
      for (int j = 0;  j < NI;  j++) {
	g[i] += Q[i][j] * (x[j]-x0[j]);
      }
      g[i] *= 2;
    }
    return 0;			// OK
  } // gradEval

  public int getMRows () {  return MRows;  }
  public int getNCols () {  return NCols;  }
  public int getNZ    () {  return NZ;     }

  public static void main (String args[])
  {
    Ex1j ext = new Ex1j();
    int m  = 1;
    int n  = 5;
    int nz = 5;
    int rc;
    double[] f = new double[1];
    double[] g = new double[ext.NCols];
    double[] x = new double[ext.NCols];

    System.out.println ("External Equations test for " +
			ext.getClass().getName());
    rc = ext.init (m, n, nz, 1, 2);
    System.out.println ("init returns " + rc);
    for (int i = 0;  i < NI;  i++) {
      x[i] = i+1 + Math.sqrt(2)/2;
    }
    // x[NI] = Math.PI;
    x[NI] = 0;
    rc = ext.funcEval (1, x, f);
    System.out.println ("funcEval returns " + rc + " and " + f[0]);
    rc = ext.gradEval (1, x, g);
    System.out.println ("gradEval returns " + rc + " and:");
    for (int j = 0;  j < ext.NCols;  j++) {
      System.out.println (g[j]);
    }

    return;
  } // main

}// Ex1j
