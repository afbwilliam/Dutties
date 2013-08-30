! ex2f_cb.f90
! Fortran implementation of the external functions for example 2
! in the file ex2.gms.

FUNCTION gefunc (icntr, x, f, dfdx, msgcb) RESULT (result)
  IMPLICIT NONE
  ! the DEC$ ATTRIBUTES directive must come after the function statement
  ! less preferred method: the /export option of the linker
  !DEC$ ATTRIBUTES DLLEXPORT :: gefunc
  !DEC$ ATTRIBUTES STDCALL, REFERENCE :: gefunc

  INTEGER, INTENT(IN OUT) :: icntr(*)
  REAL(8), INTENT(IN    ) :: x(*)
  REAL(8), INTENT(   OUT) :: f
  REAL(8), INTENT(   OUT) :: dfdx(*)
  EXTERNAL                :: msgcb
  INTEGER                 :: result
  INTEGER                 :: usrMem
  INTEGER, EXTERNAL       :: gefuncx

  result = gefuncx (1, icntr, x, f, dfdx, msgcb, usrMem)
END FUNCTION gefunc


FUNCTION gefunc2 (icntr, x, f, dfdx, msgcb, usrMem) RESULT (result)
  IMPLICIT NONE
  ! the DEC$ ATTRIBUTES directive must come after the function statement
  ! less preferred method: the /export option of the linker
  !DEC$ ATTRIBUTES DLLEXPORT :: gefunc2
  !DEC$ ATTRIBUTES STDCALL, REFERENCE :: gefunc2

  INTEGER, INTENT(IN OUT) :: icntr(*)
  REAL(8), INTENT(IN    ) :: x(*)
  REAL(8), INTENT(   OUT) :: f
  REAL(8), INTENT(   OUT) :: dfdx(*)
  EXTERNAL                :: msgcb
  INTEGER                 :: result
  INTEGER, EXTERNAL       :: gefuncx
  EXTERNAL                :: usrMem
     
  result = gefuncx (2, icntr, x, f, dfdx, msgcb, usrMem)
END FUNCTION gefunc2


FUNCTION gefuncx (cbType, icntr, x, f, dfdx, msgcb, usrMem) RESULT (result)
  USE gehelper
  IMPLICIT NONE
  INTEGER, INTENT(IN    ) :: cbType
  INTEGER, INTENT(IN OUT) :: icntr(*)
  REAL(8), INTENT(IN    ) :: x(*)
  REAL(8), INTENT(   OUT) :: f
  REAL(8), INTENT(   OUT) :: dfdx(*)
  EXTERNAL                :: msgcb, usrMem
  INTEGER                 :: result

  ! Declare local arrays to hold the model data.
  ! Remember to declare them SAVE so they remain available in
  ! later calls.
  INTEGER, PARAMETER :: MAXI = 10
  REAL(8), SAVE :: x0(MAXI), Q(MAXI,MAXI)
  INTEGER, SAVE :: ni, neq, nvar, nz
  INTEGER :: i, j

  IF (icntr(I_Mode) == DOINIT) THEN
     ! Initialization Mode:
     ! Write a "finger print" to the status file so errors in the DLL
     ! for example a wrong DLL can be detected more easily.
     CALL msg2 (cbType, usrMem, msgcb, 3, ' ')
     CALL msg2 (cbType, usrMem, msgcb, 3, '**** Using External Function in ex2f_cb.f90.')

     ! Read the put file created by the GAMS model. We must do this as
     ! the very first thing because it holds the size of the model.
     OPEN(25,file='ex2.put',status='old',err=1000)
     REWIND(25)
     READ(25,*,err=1010) ni

     IF (ni > MAXI) THEN
        CALL msg2 (cbType, usrMem, msgcb, 3, '****')
        CALL msg2 (cbType, usrMem, msgcb, 3, '**** Card(I) too large for DLL')
        CALL msg2 (cbType, usrMem, msgcb, 3, &
             '**** You must recompile with a larger Maxi value.' )
        CALL msg2 (cbType, usrMem, msgcb, 3, '****')
        result = 2
        CLOSE(25)
        RETURN
     END IF

     ! Check the model size compared to the information passed from GAMS
     neq  = 1
     nvar = ni+1
     nz   = ni+1
     IF (neq == icntr(I_Neq) .and. nvar == icntr(I_Nvar) .and. &
          nz == icntr(I_Nz)) THEN
        result = 0
     ELSE
        CALL msg2 (cbType, usrMem, msgcb, 1, '--- Model has the wrong size.')
        result = 2
        RETURN
     END IF

     ! The size was OK. Now read the target and covariance data:

     DO i = 1, ni
        READ(25,*,err=1010) x0(i)
        DO j = 1, ni
           READ(25,*,err=1010) Q(i,j)
        END DO
     END DO
     CLOSE(25)
     RETURN

1000 CONTINUE
     result = 2
     CALL msg2 (cbType, usrMem, msgcb, 3, '****')
     CALL msg2 (cbType, usrMem, msgcb, 3, '**** Could not open data file')
     return
1010 CONTINUE
     result = 2
     CALL msg2 (cbType, usrMem, msgcb, 3, '****')
     CALL msg2 (cbType, usrMem, msgcb, 3, '**** Error reading data file')
     CLOSE(25)
     RETURN

  ELSE IF (icntr(I_Mode) == DOTERM) THEN
     ! Termination mode: Do nothing in this example
     result = 0
     RETURN

  ELSE IF (icntr(I_Mode) == DOEVAL) THEN
     ! Function and Derivative Evaluation Mode

     ! Function index: there is only one so we do not have to test it
     ! but we do it here just to show how
     IF (icntr(I_Eqno) == 1) THEN
        IF (icntr(I_Dofunc) /= 0) THEN
           ! Function value is needed. Note that the linear term corresponding
           ! to -Z must be included.
           f = -x(ni+1)
           DO i = 1, ni
              DO j = 1, ni
                 f = f + (x(i)-x0(i)) * Q(i,j) * (x(j)-x0(j))
              END DO
           END DO
        END IF

        IF (icntr(I_Dodrv) /= 0) THEN
           ! The vector of derivatives is needed. The derivative with respect
           ! to variable x(i) must be returned in dfdx(i). The derivatives of the
           ! linear terms, here -Z, must be defined each time.
           dfdx(ni+1) = -1.d0
           DO i = 1, ni
              dfdx(i) = 0.d0
              DO j = 1, ni
                 dfdx(i) = dfdx(i) + Q(i,j) * (x(j)-x0(j))
              END DO
              dfdx(i) = dfdx(i) * 2.d0
           END DO
        END IF

        ! Everything was fine. Return GEFUNC = 0.
        result = 0

     ELSE
        ! If findex <> 1, then something is wrong and we return 2
        CALL msg2 (cbType, usrMem, msgcb, 3, ' ** fIndex has an unexpected value.')
        result = 2
     END IF
     ! End of function evaluation mode

  ELSE
     CALL msg2 (cbType, usrMem, msgcb, 3, ' ** Mode has an unexpected value.')
     result = 2
  END IF

  RETURN
END FUNCTION gefuncx
