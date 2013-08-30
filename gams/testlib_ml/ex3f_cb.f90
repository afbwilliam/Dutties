!     ex3f_cb.f90
!     Fortran implementation of the external functions for example 3
!     in the file ex3.gms.

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

!     Internal variables, initialized for Mode = 1 and used for Mode = 3.

      integer f2i(15), f2j(15)
      integer i, j, i1, findex, neq, nvar, nz
      save neq, nvar, nz, f2i, f2j

      if ( Icntr(I_Mode) .eq. 1 ) then
!        Initialization Mode.

         CALL msg2 (cbType, usrMem, msgcb, 3, ' ')
         CALL msg2 (cbType, usrMem, msgcb, 3, '**** Using External Function in er3f_cb.f90.')
!        Test if the sizes are as expected.
	 neq	= 21
	 nvar	= 33
	 nz	= 5*15 + 5*6
	 if (       neq .ne. Icntr(I_Neq) .or. nvar .ne. Icntr(I_Nvar) .or.  nz  .ne. Icntr(I_Nz)   ) then
	     CALL msg2 (cbType, usrMem, msgcb, 1, '--- Model has the wrong size.')
	     result = 2
	     close(25)
	     return
	 endif

!        Create a mapping from linear fIndex for the Maxdist equations
!        to the individual i and j indices

	 findex = 0
	 do i = 1, 6
	    do j = 1, 6
	       if ( i .lt. j ) then
		  findex = findex + 1
		  f2i(findex) = i
		  f2j(findex) = j
	       endif
	    enddo
	 enddo

         result = 0             ! everything is OK
	 return

      else if ( Icntr(I_Mode) .eq. 2 ) then
!        Termination mode: no cleanup required
	 result = 0             ! everything is OK
	 return

      else if ( Icntr(I_Mode) .eq. 3 ) then
!        Function and Derivative Evaluation Mode

	 findex = Icntr(I_Eqno)

	 if ( findex .le. 0 .or. findex .gt. 21 ) then
!           findex is outside the interval from 1 to 21:
!           something is wrong
            CALL msg2 (cbType, usrMem, msgcb, 3, ' ** fIndex has an unexpected value.')
	     result = 2            ! error in call

         else if (findex .le. 15) then
!
!  This is one of the Maxdist equations that in GAMS looks like
!  maxdist(i,j)$(ord(i) lt ord(j)).. sqr(x(i)-x(j))+sqr(y(i)-y(j)) =l= 1;
!  We must add an explicit slack and move the right hand side to the
!  left

	    i = f2i(findex)
	    j = f2j(findex)
	    if ( Icntr(I_Dofunc) .ne. 0 ) then
!             Function value is needed.

	       f = (x(i)-x(j))**2 + (x(6+i)-x(6+j))**2 + x(18+findex) - 1.d0
	    endif

	    if ( Icntr(I_Dodrv) .ne. 0 ) then
!              The vector of derivatives is needed.
!              The derivative w.r.t. x(i) must be returned in dfdx(i).
!              Only nonzero values have to be defined.
	       dfdx(i)	    = 2.d0*(x(i)-x(j))
	       dfdx(j)	    = -dfdx(i)
	       dfdx(6+i)	    = 2.d0*(x(6+i)-x(6+j))
	       dfdx(6+j)	    = -dfdx(6+i)
	       dfdx(18+findex) = 1.d0
	    endif

	    result = 0             ! everything is OK

	 else                   ! findex .le. 21
!
!  This was one of the Areadef equations that in GAMS looked
!  as follows:
!  areadef(i)..  area(i) =e= 0.5*(x(i)*y(i++1)-y(i)*x(i++1)) ;
!  We must remember to move the right hand side to the left.
!
	    i = findex - 15
	    if ( i .eq. 6 ) then
	       i1 = 1
	    else
	       i1 = i + 1
	    endif

	    if ( ICntr(I_Dofunc) .ne. 0 ) then
!              Function value is needed.
	       f = x(12+i) - 0.5d0 * (x(i)*x(6+i1)-x(6+i)*x(i1))
	    endif

	    if ( Icntr(I_Dodrv) .ne. 0 ) then
!              The vector of derivatives is needed.
!              The derivative w.r.t. x(i) must be returned in dfdx(i).
!              Only nonzero values have to be defined.
	       dfdx(12+i) = 1.d0
	       dfdx(i)    = -0.5d0*x(6+i1)
	       dfdx(i1)   = +0.5d0*x(6+i)
	       dfdx(6+i)  = +0.5d0*x(i1)
	       dfdx(6+i1) = -0.5d0*x(i)
	    endif

	    result = 0             ! everything is OK
	 endif

!        end evaluation mode
      else
!        Unknown Mode:
         CALL msg2 (cbType, usrMem, msgcb, 3, ' ** Unknown Mode value.')
         result = 2             ! error in call
      endif

      return
      end
