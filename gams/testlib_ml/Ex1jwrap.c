/*
 * ex1jwrap.c
 *
 * C wrapper for the Java implementation
 * of the external functions for example 1 in the file ex1.gms.
 *
 * This uses the Java Native Interface (JNI) to access a Java
 * implementation of the GAMS external equations.
 * The Java code also calls back to the C wrapper to
 * write messages during its run.
 */

#include <stdio.h>
#include <string.h>
#include <jni.h>
#include "Ex1j.h"

#include "geheader.h"

static JavaVM *jvm = NULL;	/* denotes a Java VM */
static JNIEnv *env;		/* pointer to native method interface */
#ifndef JNI_VERSION_1_2
static JDK1_1InitArgs vm_args;	/* JDK 1.1 VM initialization arguments */
#endif
static jclass cls;
static jobject eeObj;
static jint jrc;
static jmethodID constructorID, initID, funcEvalID, gradEvalID;
static jdoubleArray jx;
static jdoubleArray jf;
static jdoubleArray jg;
static jthrowable jexcept;

static void *mmsgcb;
static void *musrmem;
static int  mcbtype;
static int nchars;
static int mmode;
/* use the do-while loop so the macro acts like one statement */
#define MSGCB(mode,buf) do { mmode = mode; nchars=strlen(buf); mcbtype==1? ((msgcb_t) mmsgcb)(&mmode,&nchars,buf,nchars): ((msgcb2_t)mmsgcb)(musrmem, &mmode,&nchars,buf,nchars);} while (0)

JNIEXPORT void JNICALL
Java_Ex1j_msgCB (JNIEnv *env, jobject obj, jint mode, jstring msg)
{
  const char *str = (*env)->GetStringUTFChars (env, msg, NULL);

  MSGCB(mode, str);
  (*env)->ReleaseStringUTFChars (env, msg, str);
  return;
}

static JNINativeMethod jnatives = {
  "msgCB",
  "(ILjava/lang/String;)V",
  &Java_Ex1j_msgCB
};

GE_API int GE_CALLCONV
gefunc (int *icntr, double *x, double *f, double *g, msgcb_t msgcb)
{
  return gefuncX(1, icntr, x, f, g, msgcb, NULL);
}

GE_API int GE_CALLCONV
gefunc2 (int *icntr, double *x, double *f, double *g, msgcb2_t msgcb, void *usrmem)
{
  return gefuncX(2, icntr, x, f, g, msgcb, usrmem);
}

int gefuncX (int cbtype, int *icntr, double *x, double *f, double *g, void *msgcb, void *usrmem)
{
  int i, j;

  mmsgcb = msgcb;
  musrmem = usrmem;
  mcbtype = cbtype;
  if ( icntr[I_Mode] == DOINIT ) {
    /* Initialization Mode:
     *  1. start the Java Virtual Machine
     *  4. register our callback wrapper as a native method for Java
     *  2. get all the method pointers we will need to call
     *  3. initialize an object of the class
     *  5. allocate Java arrays for x, f, and g
     */

#ifdef JNI_VERSION_1_2
    JavaVMInitArgs vm_args;
    JavaVMOption options[1];
    MSGCB(LOGFILE | STAFILE, "");
    MSGCB(LOGFILE | STAFILE, "--- GEFUNC in ex1jwrap.c is being initialized.");
    vm_args.version = JNI_VERSION_1_2; /* New in 1.1.2: VM version */
    JNI_GetDefaultJavaVMInitArgs (&vm_args);
    options[0].optionString = "-Djava.class.path=.";
    vm_args.options = options;
    vm_args.nOptions = 1;
    /* MSGCB(LOGFILE | STAFILE, "DEBUG: Creating JavaVM"); */
    jrc = JNI_CreateJavaVM (&jvm, (void**)&env, &vm_args);
#else
    MSGCB(LOGFILE | STAFILE, "");
    MSGCB(LOGFILE | STAFILE, "--- GEFUNC in ex1jwrap.c is being initialized.");
    vm_args.version = JNI_VERSION_1_1; /* New in 1.1.2: VM version */
    JNI_GetDefaultJavaVMInitArgs (&vm_args);
    vm_args.classpath = ".";
    /* MSGCB(LOGFILE | STAFILE, "DEBUG: Creating JavaVM"); */
    jrc = JNI_CreateJavaVM (&jvm, &env, &vm_args);
#endif /* JNI_VERSION_1_2 */

    if (0 != jrc) {
      MSGCB(LOGFILE | STAFILE, "Could not create JavaVM");
      return 2;
    }
    cls = (*env)->FindClass (env, "Ex1j");
    if (NULL == cls) {
      MSGCB(LOGFILE | STAFILE, "Could not load class Ex1j");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }

    jrc = (*env)->RegisterNatives (env, cls, &jnatives, 1);

    if (0 != jrc) {
      MSGCB(LOGFILE | STAFILE, "Could not register native methods");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }

    constructorID = (*env)->GetMethodID (env, cls, "<init>", "()V");
    if (NULL == constructorID) {
      MSGCB(LOGFILE | STAFILE, "Could not get constructor method ID");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }
    initID = (*env)->GetMethodID (env, cls, "init", "(IIIII)I");
    if (NULL == initID) {
      MSGCB(LOGFILE | STAFILE, "Could not get init method ID");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }
    funcEvalID = (*env)->GetMethodID (env, cls, "funcEval", "(I[D[D)I");
    if (NULL == funcEvalID) {
      MSGCB(LOGFILE | STAFILE, "Could not get funcEval method ID");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }
    gradEvalID = (*env)->GetMethodID (env, cls, "gradEval", "(I[D[D)I");
    if (NULL == gradEvalID) {
      MSGCB(LOGFILE | STAFILE, "Could not get gradEval method ID");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }

    /* All methods present and accounted for;
     * now create an object instance to work with */

    eeObj = (*env)->NewObject (env, cls, constructorID);
    if (NULL == eeObj) {
      MSGCB(LOGFILE | STAFILE, "Could not instantiate class object");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }
    /* object constructors can throw exceptions */
    jexcept = (*env)->ExceptionOccurred (env);
    if (NULL != (*env)->ExceptionOccurred (env)) {
      MSGCB(LOGFILE | STAFILE,
	    "Exception occurred while instantiating object");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }

    jrc = (*env)->CallIntMethod (env, eeObj, initID,
				 icntr[I_Neq], icntr[I_Nvar], icntr[I_Nz],
				 LOGFILE, STAFILE);

    jexcept = (*env)->ExceptionOccurred (env);
    if (jexcept != (*env)->ExceptionOccurred (env)) {
      MSGCB(LOGFILE | STAFILE, "Exception occurred while initializing object");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }

    jx = (*env)->NewDoubleArray (env, icntr[I_Nvar]);
    jf = (*env)->NewDoubleArray (env, 1);
    jg = (*env)->NewDoubleArray (env, icntr[I_Nvar]);

    if (NULL == jx
	|| NULL == jf
	|| NULL == jg) {
      MSGCB(LOGFILE | STAFILE, "Could not allocate Java arrays x, f & g");
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
      return 2;
    }

    return 0;
  }
  else if ( icntr[I_Mode] == DOTERM ) {
    /* Termination mode:
     *  1. NULLify method pointers
     *  2. terminate the JVM if it exists
     */
    constructorID = initID = funcEvalID = gradEvalID = NULL;

    /* MSGCB(LOGFILE | STAFILE, "DEBUG: Destroying JavaVM"); */
    if (NULL != jvm) {
      (*jvm)->DestroyJavaVM(jvm);
      jvm = NULL;
    }

    return 0;
  } /* mode = DOTERM */
  else if ( icntr[I_Mode] == DOEVAL ) {
    /* Function and Derivative Evaluation Mode */

    (*env)->SetDoubleArrayRegion (env, jx, 0, icntr[I_Nvar], x);
    if (icntr[I_Dofunc]) {
      jrc = (*env)->CallIntMethod (env, eeObj, funcEvalID,
				   icntr[I_Eqno], jx, jf);
      if (0 != jrc) {
	return 2;
      }
      (*env)->GetDoubleArrayRegion (env, jf, 0, 1, f);
    }
    if (icntr[I_Dodrv]) {
      jrc = (*env)->CallIntMethod (env, eeObj, gradEvalID,
				   icntr[I_Eqno], jx, jg);
      if (0 != jrc) {
	return 2;
      }
      (*env)->GetDoubleArrayRegion (env, jg, 0, icntr[I_Nvar], g);
    }

    return 0;
  } /* mode = DOEVAL */
  else {
    MSGCB(LOGFILE | STAFILE, " ** Mode not defined.");
    return 2;
  } /* mode is undefined */
} /* gefunc */
