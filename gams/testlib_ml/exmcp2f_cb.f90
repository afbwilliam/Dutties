!  exmcp2f_cb.f90
!  Fortran implementation of the external functions for example MCP2
!  in the file exmcp2.gms.
!  Here, we use the callback capability for the messages.
!
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

      Integer ni
      parameter ( ni = 8 )
      integer i, j, findex, neq, nvar, nz

      if ( icntr(I_Mode) .eq. 1 ) then
!
!  Initialization Mode:
!  Write a "finger print" to the status file so errors in the external
!  functions can be detected more easily. This should be done before
!  anything can go wrong. Also write a line to the log just to show it.
!
	 CALL msg2 (cbType, usrMem, msgcb, 2, ' ')
	 CALL msg2 (cbType, usrMem, msgcb, 2, '**** GEFUNC in exmcp2f_cb.f90 is being initialized.')
	 CALL msg2 (cbType, usrMem, msgcb, 1, '--- GEFUNC in exmcp2f_cb.f90 is being initialized.')
!
!  Test the sizes and return 0 if OK
!
	 neq	= ni
	 nvar	= ni
	 nz	= ni*ni
	 IF ( neq .eq. Icntr(I_Neq) .and. nvar .eq. Icntr(I_Nvar) .and. nz  .eq. Icntr(I_Nz) ) then
	    result = 0
	 Else
	    CALL msg2 (cbType, usrMem, msgcb, 3, '--- Model has the wrong size.')
	    result = 2
	    Return
	 endif
!        no data initialization necessary
	 return
      elseif ( Icntr(I_Mode) .eq. 2 ) then
!
!  Termination mode: Do nothing
!
	 result = 0
	 Return
      Elseif ( Icntr(I_Mode) .eq. 3 ) then
!
!  Function and Derivative Evaluation Mode
!
!  Function index: make sure findex is in range
!
         findex = Icntr(I_Eqno)

	 if ( findex .ge. 1 .and. findex .le. ni) then
	    if ( Icntr(I_Dofunc) .ne. 0 ) then
!
!  Function value is needed. Note that the linear term corresponding
!  to -Z must be included.
!
	       f = x(findex) * x(findex) - 1
	       do j = 1, ni
                  f = f + 0.1 * j * x(j)
	       enddo
	    endif

	    if ( Icntr(I_Dodrv) .ne. 0 ) then
!
!  The vector of derivatives is needed. The derivative with respect
!  to variable x(i) must be returned in dfdx(i). The derivatives of the
!  linear terms, here -Z, must be defined each time.
! 
	       do j = 1, ni
		  dfdx(j) = 0.1 * j
               enddo
               dfdx(findex) = dfdx(findex) + 2.d0 * x(findex)
	    endif
!
!  Everything was fine. Return result = 0.
!
	    result = 0
	 else
!
!  If findex is bogus: return result = 1.
!
     CALL msg2 (cbType, usrMem, msgcb, 3, ' ** fIndex has an unexpected value.')
	    result = 2
	 endif
!
!  End of function evaluation mode
!
      else
	 CALL msg2 (cbType, usrMem, msgcb, 3, ' ** Mode has an unexpected value.')
	 result = 2
      endif

      Return
      End
