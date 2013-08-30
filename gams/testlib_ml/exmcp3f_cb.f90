!  exmcp3f_cb.f90
!  Fortran implementation of the external functions for example MCP3
!  in the file exmcp3.gms.
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
      parameter ( ni = 50 )
      integer i, j, k, findex, neq, nvar, nz
      double precision q(ni), M(ni,ni)
      save q, M, neq, nvar, nz
      character*255 scrdir
      logical gotscr
      integer scrlen
      save scrlen, gotscr, scrdir
      logical first
      save    first
      data    first / .true. /
      integer kdat /99/
      character*10 fname /'exmcp3.dat'/
      character*265 dataFile
      integer dataFileLen
      character*64 buf

      if ( icntr(I_Mode) .eq. 1 ) then
         if (first) then
!
!  Initialization Mode:
!  Write a "finger print" to the status file so errors in the external
!  functions can be detected more easily. This should be done before
!  anything can go wrong. Also write a line to the log just to show it.
!
            CALL msg2 (cbType, usrMem, msgcb, 2, ' ')
            CALL msg2 (cbType, usrMem, msgcb, 2, '**** GEFUNC in exmcp3f_cb.for is being initialized.')
            CALL msg2 (cbType, usrMem, msgcb, 1, '--- GEFUNC in exmcp3f_cb.for is being initialized.')
            first = .false.
         endif

         if ( Icntr(I_Smode) .eq. I_scr  ) then
            call GENAME (Icntr, Scrlen, Scrdir)
            CALL msg2 (cbType, usrMem, msgcb, 2, '--- GEFUNC: Scratch directory = '//Scrdir(1:Scrlen))
            gotscr = .true.
         endif
         CALL msg2 (cbType, usrMem, msgcb, 2, '--- Past file reception.')
         if ( .not. gotscr ) then
            Icntr(I_Getfil) = I_scr
            result = 0
            return
         endif
         CALL msg2 (cbType, usrMem, msgcb, 3, '--- Past gotscr test.')

!
!  Now we have the data file name and we can terminate the initialization.
!  Test the sizes and return 0 if OK
!
         dataFile = Scrdir(1:Scrlen) // fname
         dataFileLen = Scrlen + len(fname)
         CALL msg2 (cbType, usrMem, msgcb, 3, '--- Data file: '//dataFile(1:dataFileLen))
         open (kdat, file=dataFile, status='OLD', err=1000)
         read (kdat, *) neq
         nvar = neq
         if (neq .gt. ni) then
            CALL msg2 (cbType, usrMem, msgcb, 3, '--- The model is too large.')
            close (kdat)
            result = 2
            return
         endif
         read (kdat, *) (q(i),i=1,neq)
         read (kdat, *) ((M(i,j),i=1,neq),j=1,nvar)
         close (kdat)

!        Count the total number of Jacobian elements:

         nz = neq
         do i=1,neq
            do j=1,nvar
               if (j.ne.i .and. M(i,j).ne.0.0) nz = nz + 1
            end do
         end do

         IF ( neq .eq. Icntr(I_Neq) .and. nvar .eq. Icntr(I_Nvar) .and. nz  .eq. Icntr(I_Nz) ) then
            result = 0
         Else
            CALL msg2 (cbType, usrMem, msgcb, 3, '--- Model has the wrong size.')
            result = 2
            Return
         endif
         return

 1000    continue
         write (buf, '(''--- Could not open data file '', A)') fname
         CALL msg2 (cbType, usrMem, msgcb, 3, buf)
         result = 2
         return

      elseif ( Icntr(I_Mode) .eq. 2 ) then
!
!  Termination mode: Do nothing
!
         result = 0
         Return

      elseif ( Icntr(I_Mode) .eq. 3 ) then
!
!  Function and Derivative Evaluation Mode
!
!  Function index: make sure findex is in range
!
         findex = Icntr(I_Eqno)

         if ( findex .ge. 1 .and. findex .le. neq) then
            if ( Icntr(I_Dofunc) .ne. 0 ) then
!
!  Function value is needed.
!
               f = x(findex) * x(findex) - q(findex)
               do j = 1, nvar
                  f = f + M(findex,j) * x(j)
               enddo
            endif

            if ( Icntr(I_Dodrv) .ne. 0 ) then
!
!  The vector of derivatives is needed. The derivative with respect
!  to variable x(i) must be returned in dfdx(i). The derivatives of the
!  linear terms, here -Z, must be defined each time.
!
               do j = 1, nvar
                  dfdx(j) = M(findex,j)
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
