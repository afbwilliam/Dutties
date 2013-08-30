!  ex1xf.f90
!  Fortran implementation of the external functions for example 1x
!  in the file ex1x.gms.
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

  ! Declare local arrays to hold the model data.
  ! Remember to declare them SAVE so they remain available in
  ! later calls.
  INTEGER, PARAMETER :: NI = 20, NEQ = 1, NVAR = NI+1, NZ = NI+1
  REAL(8), SAVE :: x0(NI), Q(NI,NI)
  INTEGER :: i, j

  
  if ( icntr(I_Mode) .eq. 1 ) then
!
!  Initialization Mode:
!  Write a "finger print" to the status file so errors in the external
!  functions can be detected more easily. This should be done before
!  anything can go wrong. Also write a line to the log just to show it.
!
         call GEstat( Icntr, ' ')
         call GEstat( Icntr,'**** Using External Function in ex1xf.f90.')
         call GElog ( Icntr, '--- GEFUNC in ex1xf.f90 is being initialized.')
!
!  Test the sizes and return 0 if OK
!
        
         IF ( neq .eq. Icntr(I_Neq) .and. nvar .eq. Icntr(I_Nvar) .and. nz  .eq. Icntr(I_Nz) ) then
            result = 0
         Else
            CALL GElog ( Icntr, '--- Model has the wrong size.')
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
!
!  EXTRA:
!  Define capabilities:
!  * We can return constant derivatives and there is 1 such derivative
!  * We can return Hessian times Vector
!
         Icntr(I_ConstDeriv) = 1
         ICntr(I_HVprod) = 1
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
      elseif ( Icntr(I_Mode) .eq. 4 ) then
!
!  Return the constant derivatives and ignore the varying ones (and
!  any that do not belong to the sparsety pattern).
!
         if ( Icntr(I_Eqno) .eq. 1 ) then
            dfdx(ni+1) = -1.d0  ! 1 constant derivative with value -1.
            result = 0
         else
!
!  If findex is different from 1, then something is wrong and we
!  return result = 1.
!
            Call GEstat( Icntr,' ** fIndex has an unexpected value.')
            result = 2
         endif
      elseif ( Icntr(I_mode) .eq. 5 ) then
!
!  Return the dfdx = Hessian * V = 2 * Q * V where V is stored at the end
!  of X. The code assumes that dfdx is initialized as zero.
!
         if ( Icntr(I_Eqno) .eq. 1 ) then
            do i = 1, ni
               do j = 1, ni
                  dfdx(i) = dfdx(i) + Q(i,j) * x(ni+1+j)
               enddo
               dfdx(i) = dfdx(i) * 2.d0
            enddo
            result = 0
         else
!
!  If findex is different from 1, then something is wrong and we
!  return result = 1.
!
            Call GEstat( Icntr,' ** fIndex has an unexpected value.')
            result = 2
         endif
      else
         Call GEstat( Icntr,' ** Mode has an unexpected value.')
         result = 2
      endif

      Return
      End
