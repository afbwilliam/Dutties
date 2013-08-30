!  ex5f.f90
!  Fortran implementation of the external functions for example 5
!  in the file ex5.gms.
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

      Logical First
      Save    First
      Data    First / .true. /
!
!  Assign space for the file names
! 
      character*255 Scrdir, Cntfil, Datfil
      Integer	    Scrlen, Cntlen
      Logical	    Gotscr, Gotcnt
      Save	    Scrdir, Cntfil
      Save	    Scrlen, Cntlen
      Save	    Gotscr, Gotcnt
      Data	    Gotscr / .false. /, Gotcnt / .false. /


!  Declare local arrays to hold the model data.
!  Remember to declare them SAVE so they remain available in
!  later calls.
!
      Integer ni, nread
      parameter ( ni = 4 )
      Real*8 x0(ni), Q(ni,ni)
      SAVE   x0, Q
      integer i, j, neq, nvar, nz

      if ( icntr(I_Mode) .eq. 1 ) then
!
!  Initialization Mode:
!  Write a "finger print" to the status file so errors in the external
!  functions can be detected more easily. This should be done before
!  anything can go wrong. Also write a line to the log just to show it.
!
	 if ( First ) then
	    First = .false.
	     call GEstat( Icntr, ' ')
         call GEstat( Icntr,'**** Using External Function in ex5f.f90.')
         call GElog ( Icntr, '--- GEFUNC in ex5f.f90 is being initialized.')
	 endif
!
!  Check if this is a call that defines the control file (requested in
!  another call)
!
	 if ( icntr(I_Smode) .eq. I_cntr ) then
	    call GENAME( Icntr, Cntlen, Cntfil )
	    call GEstat( Icntr, '--- GEFUNC: Control file = '//Cntfil(1:Cntlen))
	    gotcnt = .true.
	 endif
!
!  Check if this is a call that defines the scratch directory (requested in
!  another call)
!
	 if ( Icntr(I_Smode) .eq. I_scr  ) then
	    call GENAME( Icntr, Scrlen, Scrdir )
	    call GEstat( Icntr, '--- GEFUNC: Scratch directory = '//Scrdir(1:Scrlen))
	    gotscr = .true.
	 endif
!
!  If we do not have the necessary files yet, ask for them
!
	 call GEstat( Icntr,'--- Past file reception.')
	 if ( .not. gotcnt ) then
	    Icntr(I_Getfil) = I_cntr
	    result = 0
	    return
	 endif
	 call GEstat( Icntr,'--- Past gotcnt test.')
	 if ( .not. gotscr ) then
	    Icntr(I_Getfil) = I_scr
	    result = 0
	    return
	 endif
	 call GEstat( Icntr,'--- Past gotscr test.')
!
!  Now we have all necessary files and we can terminate the
!  initialization.
!  Test the sizes and return 0 if OK
!
	 call GEstat( Icntr,'--- Data file = ' // Scrdir(1:scrlen) // 'abc.dat' )
	 datfil = Scrdir(1:scrlen) // 'abc.dat'
	 open(20, file=datfil )
	 read(20,*) nread
	 close(20)
	 if ( nread .ne. ni ) then
	    call GElog ( Icntr, '--- Data has unexpected size.')
	    result = 2
	    Return
	 else
	    call GEstat( Icntr,'--- Data was as expected.')
	 endif
	 neq	= 1
	 nvar	= ni+1
	 nz	= ni+1
	 IF ( neq .eq. Icntr(I_Neq) .and. nvar .eq. Icntr(I_Nvar) .and. nz .eq. Icntr(I_Nz) ) then
	    result = 0
	 Else
	    call GElog ( Icntr, '--- Model has the wrong size.')
	    result = 2
	    Return
	 endif
!
!  Define the model data using statements similar to those in GAMS.
!  Note that any changes in the GAMS model must be changed here also,
!  so syncronization can be a problem with this methodology.
!
	 do i = 1, ni
	    x0(i) = i
	    do j = 1, ni
	       Q(i,j) = 0.5d0 ** dabs(dfloat(i-j))
	    enddo
	 enddo
	 Return
      Elseif ( Icntr(I_Mode) .eq. 2 ) then
!
!  Termination mode: Do nothing
!
	 result = 0
	 Return
      Elseif ( Icntr(I_Mode) .eq. 3 ) then
!
!  Function and Derivative Evaluation Mode
!
!  Function index: there is only one so we do not have to test it
!  but we do it just to show the principle.
!
	 if ( Icntr(I_Eqno) .eq. 1 ) then
	    if ( Icntr(I_Dofunc) .ne. 0 ) then
!
!  Function value is needed. Note that the linear term corresponding
!  to -Z must be included.
!
	       f = -x(ni+1)
	       do i = 1, ni
		  do j = 1, ni
		     f = f + (x(i)-x0(i)) * Q(i,j) * (x(j)-x0(j))
		  enddo
	       enddo
	    endif
!
!  The vector of derivatives is needed. The derivative with respect
!  to variable x(i) must be returned in dfdx(i). The derivatives of the
!  linear terms, here -Z, must be defined each time.
!
	    if ( Icntr(I_Dodrv) .ne. 0 ) then
	       dfdx(ni+1) = -1.d0
	       do i = 1, ni
		  dfdx(i) = 0.d0
		  do j = 1, ni
		     dfdx(i) = dfdx(i) + Q(i,j) * ( x(j)-x0(j) )
		  enddo
		  dfdx(i) = dfdx(i) * 2.d0
	       enddo
	    endif
!
!  Everything was fine. Return result = 0.
!
	    result = 0
	 else
!
!  If findex is different from 1, then something is wrong and we
!  return result = 1.
!
	    Call GEstat( Icntr,' ** fIndex has an unexpected value.')
	    result = 2
	 endif
!
!  End of function evaluation mode
!
      else
	 Call GEstat( Icntr,' ** Mode has an unexpected value.')
	 result = 2
      endif

      Return
      End
