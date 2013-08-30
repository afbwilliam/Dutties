!     exmcp1f.f90
!     Fortran implementation of the external functions for example MCP2
!     in the file exmcp1.gms.
!
FUNCTION gefunc (icntr, x, f, dfdx, msgcb) RESULT (result)

  USE gehelper
  IMPLICIT NONE
  ! the DEC$ ATTRIBUTES directive must come after the function statement
  ! less preferred method: the /export option of the linker
  !DEC$ ATTRIBUTES DLLEXPORT :: gefunc
  !DEC$ ATTRIBUTES STDCALL, REFERENCE :: gefunc

  INTEGER, INTENT(IN OUT) :: icntr(*)
  REAL(8), INTENT(IN    ) :: x(*)
  REAL(8), INTENT(   OUT) :: f
  REAL(8), INTENT(   OUT) :: dfdx(*)
  EXTERNAL                :: msgcb		 ! not used in this example
  INTEGER                 :: result

  Integer ni
  parameter ( ni = 14 )
  integer i, j, findex, neq, nvar, nz
  integer luMat
  double precision Q(ni,ni), X0(ni)
  save Q, X0

  if ( icntr(I_Mode) .eq. 1 ) then

!    Initialization Mode:
!    Write a "finger print" to the status file so errors
!    in the external functions can be detected more easily.
!    This should be done before anything can go wrong.
!    Also write a line to the log just to show it.

	 call GEstat( Icntr, ' ')
     call GEstat( Icntr,'**** Using External Function in exmcp1f.f90.')
	 call GElog ( Icntr, '--- GEFUNC in exmcp1f.f90 is being initialized.')

!        Test the sizes and return 0 if OK

	 neq	= ni
	 nvar	= ni
	 nz	= ni*ni
	 IF ( neq .eq. Icntr(I_Neq) .and. nvar .eq. Icntr(I_Nvar) .and. nz  .eq. Icntr(I_Nz) ) then
	    result = 0
	 Else
	    call GElog ( Icntr, '--- Model has the wrong size.')
	    result = 2
	 endif

         luMat = 25
         open (luMat,file='exmcp1.put',status='old',err=1000)
         rewind (luMat)
         read (luMat,*,err=1100,end=1100) j

         if ( ni .ne. j ) then
            call GEStat (Icntr, '**** Data file has wrong matrix size')
            call GELog  (Icntr, '--- Data file has wrong matrix size')
            close (luMat)
            result = 2
            return
         endif

         do i = 1, ni
            read (luMat,*,err=1100,end=1100) X0(i)
            do j = 1, ni
               read (luMat,*,err=1100,end=1100) Q(i,j)
            enddo
         enddo

         close (luMat)
         result = 0
	 return

 1000    call GEStat ( Icntr, '**** Could not open data file.')
         call GElog  ( Icntr, '--- Could not open data file.')
         result = 2
         return

 1100    close (luMat)
         call GEStat ( Icntr, '**** Could not read data file.')
         call GElog  ( Icntr, '--- Could not read data file.')
         result = 2
         return

      elseif ( Icntr(I_Mode) .eq. 2 ) then

!        Termination mode: Do nothing
	 result = 0
	 Return

      elseif ( Icntr(I_Mode) .eq. 3 ) then

!        Function and Derivative Evaluation Mode

!        Function index: make sure findex is in range
         findex = Icntr(I_Eqno)

	 if ( findex .ge. 1 .and. findex .le. ni) then
            i = findex
	    if ( Icntr(I_Dofunc) .ne. 0 ) then
	       f = 0
	       do j = 1, ni
                  f = f + Q(i,j) * (x(j)-X0(j))
	       enddo
               f = f * 2.0D0
	    endif

	    if ( Icntr(I_Dodrv) .ne. 0 ) then
!              The vector of derivatives is needed.
!              The derivative with respect to variable x(i)
!              must be returned in dfdx(i).
	       do j = 1, ni
		  dfdx(j) = 2 * Q(i,j)
               enddo
	    endif
!           Everything was fine. Return result = 0.
	    result = 0

	 else
!           If findex is bogus: return result = 1.
	    Call GEstat( Icntr,' ** fIndex has an unexpected value.')
	    result = 2
	 endif
!        End of function evaluation mode

      else
	 Call GEstat( Icntr,' ** Mode has an unexpected value.')
	 result = 2
      endif

      Return
      End
