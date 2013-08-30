!     exmcp4f_cb.f90
!     Fortran implementation of the external functions for example MCP4
!     in the file exmcp4.gms.
!     Here, we use the callback capability for the messages.
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
  INTEGER, INTENT(IN OUT) :: usrMem
  INTEGER                 :: result
  INTEGER, EXTERNAL       :: gefuncx
     
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
  INTEGER, INTENT(IN OUT) :: usrMem
  EXTERNAL                :: msgcb
  INTEGER                 :: result

      INTEGER NJ, NJC, NI, NR
      PARAMETER (NJ = 10, NJC = 6, NI = 2, NR = 2)
      REAL*8 p, alpha
      PARAMETER (p = .2d0, alpha = .7d0)
      REAL*8 A(NI,NJ), B(NI,NJ), C(NR,NJ), w(NR)
      SAVE   A       , B,        C,        w
      DATA A / 2.0, 3.0, 2.0, 3.0, 4 * 2.0, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 0.5, 2.0, 1.0, 2.0, 0.5 /
      DATA B / 1.5, 2.7d0, 1.5, 2.7d0, 1.5, 1.8d0, 1.5, 1.8d0, 1.5, 0.9d0, 1.5, 0.9d0, 4.0, 0.9d0, 3.0, 0.4d0, 1.5, 2.0, 1.5, 1.5 /
      DATA C / 1.0, 0.5, 1.0, 1.5, 1.0, 1.5, 1.0, 0.5, 1.0, 0.5, 1.0, 1.5, 1.0, 1.5, 1.0, 0.5, 1.0, 0.5, 1.0, 1.5 /
      DATA w / 0.8d0, 0.8d0 /

      CHARACTER*255 msgBuf
      INTEGER findex
      LOGICAL dofnc, dodrv
      INTEGER i, j, r
      INTEGER neq, nvar, nz
      SAVE    neq, nvar, nz

      IF (icntr(I_Mode) .eq. 1) THEN
!        Initialization Mode:
!        Write a "finger print" to the status file so errors
!        in the external functions can be detected more easily.
!        This should be done before anything can go wrong.
!        Also write a line to the log just to show it.

	 CALL msg2 (cbType, usrMem, msgcb, 2, ' ')
	 CALL msg2 (cbType, usrMem, msgcb, 2, '**** GEFUNC in exmcp4f_cb.f90 is being initialized.')
	 CALL msg2 (cbType, usrMem, msgcb, 1, '--- GEFUNC in exmcp4f_cb.f90 is being initialized.')

!        Test the sizes and return 0 if OK

	 neq   = NJ + NR;
	 nvar  = NJ + NI + NR;
	 nz    = NJC*NJC + NJ*(NI+NR) + NR*NJ;

         IF (neq .NE. icntr(I_Neq) .OR. nvar .NE. icntr(I_Nvar) .OR. nz .NE. icntr(I_Nz) ) THEN
            CALL msg2 (cbType, usrMem, msgcb, 3, '--- Model has the wrong size.')
            WRITE (msgBuf, 1000) icntr(I_Neq), neq
	    CALL msg2 (cbType, usrMem, msgcb, 3, msgBuf)
            WRITE (msgBuf, 1010) icntr(I_Nvar), nvar
	    CALL msg2 (cbType, usrMem, msgcb, 3, msgBuf)
            WRITE (msgBuf, 1020) icntr(I_Nz), nz
	    CALL msg2 (cbType, usrMem, msgcb, 3, msgBuf)

 1000       FORMAT ('Equation count: received', i8, '  expected', i8)
 1010       FORMAT ('Variable count: received', i8, '  expected', i8)
 1020       FORMAT (' Nonzero count: received', i8, '  expected', i8)
	    result = 2
	    RETURN
         ELSE
	    result = 0
         ENDIF

      ELSE IF (icntr(I_Mode) .EQ. 2) THEN

!        Termination mode: Do nothing

	 result = 0
	 RETURN

      ELSE IF (icntr(I_Mode) .EQ. 3) THEN

!        function and derivative evaluation mode

         findex = icntr(I_Eqno)
         dofnc  =(icntr(I_Dofunc) .NE. 0)
         dodrv  =(icntr(I_Dodrv)  .NE. 0)
         result = 0

!        make sure findex is in range
	 IF ( findex .LT. 1 .OR. findex .GT. neq) THEN
	    CALL msg2 (cbType, usrMem, msgcb, 3,' ** fIndex has an unexpected value.')
            WRITE (msgBuf, 1030) findex, neq
	    CALL msg2 (cbType, usrMem, msgcb, 3, msgBuf)
	    result = 2
 1030       FORMAT (' ** fIndex is', i8, ':  expected in [1,',i8,']')
         ELSE IF (fIndex .LE. NJ) THEN
            IF (dofnc) THEN 
               IF      (1 .EQ. fIndex) THEN
                  f = - p * (x(1) + 2.5*x(2))**(p-1) * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**p
               ELSE IF (2 .EQ. fIndex) THEN
                  f = - p * 2.5 * (x(1) + 2.5*x(2))**(p-1) * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**p
               ELSE IF (3 .EQ. fIndex) THEN
                  f = -p * 2.5 * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**(p-1) * (2*x(5) + 3*x(6))**p
               ELSE IF (4 .EQ. fIndex) THEN
                  f = - p * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**(p-1) * (2*x(5) + 3*x(6))**p
               ELSE IF (5 .EQ. fIndex) THEN
                  f = -p * 2.0 * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**(p-1)
               ELSE IF (6 .EQ. fIndex) THEN
                  f = -p * 3.0 * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**(p-1)
               ELSE
                  f = 0
               ENDIF
               j = findex
               DO i = 1, NI
                  f = f + (A(i,j) - alpha*B(i,j)) * x(NJ+i)
               END DO
               DO r = 1, NR
                  f = f + C(r,j) * x(NJ+NI+r)
               END DO
            ENDIF               ! if (dofnc)
            IF (dodrv) THEN
               IF      (1 .EQ. fIndex) THEN
                  dfdx(1) = -p * (2.5*x(3) +x(4))**p * (2*x(5) + 3*x(6))**p * (p-1) * 1.0 * (x(1) + 2.5*x(2))**(p-2)
                  dfdx(2) = -p * (2.5*x(3) +x(4))**p * (2*x(5) + 3*x(6))**p * (p-1) * 2.5 * (x(1) + 2.5*x(2))**(p-2)
                  dfdx(3) = -p * (x(1) + 2.5*x(2))**(p-1) * (2*x(5) + 3*x(6))**p * p * 2.5 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(4) = -p * (x(1) + 2.5*x(2))**(p-1) * (2*x(5) + 3*x(6))**p * p * 1.0 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(5) = -p * (x(1) + 2.5*x(2))**(p-1) * (2.5*x(3) + x(4))**p * p * 2.0 * (2*x(5) + 3*x(6))**(p-1)
                  dfdx(6) = -p * (x(1) + 2.5*x(2))**(p-1) * (2.5*x(3) + x(4))**p * p * 3.0 * (2*x(5) + 3*x(6))**(p-1)
               ELSE IF (2 .EQ. fIndex) THEN
                  dfdx(1) = - p * 2.5 * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**p * (p-1) * 1.0 * (x(1) + 2.5*x(2))**(p-2)
                  dfdx(2) = - p * 2.5 * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**p * (p-1) * 2.5 * (x(1) + 2.5*x(2))**(p-2)
                  dfdx(3) = - p * 2.5 * (x(1) + 2.5*x(2))**(p-1) * (2*x(5) + 3*x(6))**p * p * 2.5 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(4) = - p * 2.5 * (x(1) + 2.5*x(2))**(p-1) * (2*x(5) + 3*x(6))**p * p * 1.0 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(5) = - p * 2.5 * (x(1) + 2.5*x(2))**(p-1) * (2.5*x(3) + x(4))**p * p * 2.0 * (2*x(5) + 3*x(6))**(p-1)
                  dfdx(6) = - p * 2.5 * (x(1) + 2.5*x(2))**(p-1) * (2.5*x(3) + x(4))**p * p * 3.0 * (2*x(5) + 3*x(6))**(p-1)
               ELSE IF (3 .EQ. fIndex) THEN
                  dfdx(1) = -2.5 * p * (2.5*x(3) + x(4))**(p-1) * (2*x(5) + 3*x(6))**p * p * 1.0 *  (x(1) + 2.5*x(2))**(p-1)
                  dfdx(2) = -2.5 * p * (2.5*x(3) + x(4))**(p-1) * (2*x(5) + 3*x(6))**p * p * 2.5 * (x(1) + 2.5*x(2))**(p-1)
                  dfdx(3) = -2.5 * p * (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**p * (p-1) * 2.5 * (2.5*x(3) + x(4))**(p-2)
                  dfdx(4) = -2.5 * p *  (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**p * (p-1) * 1.0 * (2.5*x(3) + x(4))**(p-2)
                  dfdx(5) = -2.5 * p *  (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**(p-1) * p * 2.0 * (2*x(5) + 3*x(6))**(p-1)
                  dfdx(6) = -2.5 * p *  (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**(p-1) * p * 3.0 * (2*x(5) + 3*x(6))**(p-1)
               ELSE IF (4 .EQ. fIndex) THEN
                  dfdx(1) = -1.0 * p * (2.5*x(3) + x(4))**(p-1) * (2*x(5) + 3*x(6))**p * p * 1.0 * (x(1) + 2.5*x(2))**(p-1)
                  dfdx(2) = -1.0 * p * (2.5*x(3) + x(4))**(p-1) * (2*x(5) + 3*x(6))**p * p * 2.5 * (x(1) + 2.5*x(2))**(p-1)
                  dfdx(3) = -1.0 * p *  (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**p * (p-1) * 2.5 * (2.5*x(3) + x(4))**(p-2)
                  dfdx(4) = -1.0 * p *  (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**p * (p-1) * 1.0 * (2.5*x(3) + x(4))**(p-2)
                  dfdx(5) = -1.0 * p *  (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**(p-1) * p * 2.0 * (2*x(5) + 3*x(6))**(p-1)
                  dfdx(6) = -1.0 * p *  (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**(p-1) * p * 3.0 * (2*x(5) + 3*x(6))**(p-1)
               ELSE IF (5 .EQ. fIndex) THEN
                  dfdx(1) = -2.0 * p * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**(p-1) * p * 1.0 * (x(1) + 2.5*x(2))**(p-1)
                  dfdx(2) = -2.0 * p * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**(p-1) * p * 2.5 * (x(1) + 2.5*x(2))**(p-1)
                  dfdx(3) = -2.0 * p * (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**(p-1) * p * 2.5 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(4) = -2.0 * p * (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**(p-1) * p * 1.0 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(5) = -2.0 * p * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**p * (p-1) * 2.0 * (2*x(5) + 3*x(6))**(p-2)
                  dfdx(6) = -2.0 * p * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**p * (p-1) * 3.0 * (2*x(5) + 3*x(6))**(p-2)
               ELSE IF (6 .EQ. fIndex) THEN
                  dfdx(1) = -3.0 * p * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**(p-1) * p * 1.0 * (x(1) + 2.5*x(2))**(p-1)
                  dfdx(2) = -3.0 * p * (2.5*x(3) + x(4))**p * (2*x(5) + 3*x(6))**(p-1) * p * 2.5 * (x(1) + 2.5*x(2))**(p-1)
                  dfdx(3) = -3.0 * p * (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**(p-1) * p * 2.5 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(4) = -3.0 * p * (x(1) + 2.5*x(2))**p * (2*x(5) + 3*x(6))**(p-1) * p * 1.0 * (2.5*x(3) + x(4))**(p-1)
                  dfdx(5) = -3.0 * p * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**p * (p-1) * 2.0 * (2*x(5) + 3*x(6))**(p-2)
                  dfdx(6) = -3.0 * p * (x(1) + 2.5*x(2))**p * (2.5*x(3) + x(4))**p * (p-1) * 3.0 * (2*x(5) + 3*x(6))**(p-2)
               ENDIF
               j = findex
               DO i = 1, NI
                  dfdx(NJ+i) = (A(i,j) - alpha*B(i,j))
               END DO
               DO r = 1, NR
                  dfdx(NJ+NI+r) = C(r,j)
               END DO
            ENDIF               ! if (dodrv) 
         ELSE
            r = fIndex - NJ
            IF (dofnc) THEN
               f = w(r)
               DO j = 1, NJ
                  f = f - C(r,j)*x(j)
               END DO
            ENDIF
            IF (dodrv) THEN
               DO j = 1, NJ
                  dfdx(j) = -C(r,j)
               END DO
            ENDIF
         ENDIF                  ! different findex values

!        End of function evaluation mode

      ELSE

	 CALL msg2 (cbType, usrMem, msgcb, 3,' ** Mode has an unexpected value.')
	 result = 2

      ENDIF

      RETURN
      END
