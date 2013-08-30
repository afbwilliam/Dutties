!     ex4xf_cb.f90
!     Alternative Fortran implementation of the external functions for
!     example 4 (DEA, parameter estimation) in the file ex4x.gms.
!     The special aspect of this implementation is that we tell the
!     solvers that some of the derivatives are constant and we declare
!     the derivate w.r.t cv to be constant = +1.


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


FUNCTION gefuncx (cbType, icntr, x, func, dfdx, msgcb, usrMem) RESULT (result)
  USE gehelper
  IMPLICIT NONE
  INTEGER, INTENT(IN    ) :: cbType
  INTEGER, INTENT(IN OUT) :: icntr(*)
  REAL(8), INTENT(IN    ) :: x(*)
  REAL(8), INTENT(   OUT) :: func
  REAL(8), INTENT(   OUT) :: dfdx(*)
  INTEGER, INTENT(IN OUT) :: usrMem
  EXTERNAL                :: msgcb
  INTEGER                 :: result

!     Internal variables, initialized in Mode 1 and used in Mode 3.

      integer maxDMU
      parameter (maxDMU=2000)
      integer nDMU
      double precision objval(maxDMU)
      double precision fudge
      save nDMU, objval, fudge

      double precision t, dtdh, t1, dt1dh, t2, dt2dh
      double precision h, cv, dfdh, dfdcv, f
      integer putUnit / 25 /
      integer i, ii

      if ( Icntr(I_Mode) .eq. 1 ) then
!        Initialization Mode. 

         CALL msg2 (cbType, usrMem, msgcb, 3, ' ')
         CALL msg2 (cbType, usrMem, msgcb, 3, '**** Using External Functions in ex4xf_cb.for.')

!        Test if the sizes are as expected.
         if (      1 .ne. Icntr(I_Neq) .or. 2 .ne. Icntr(I_Nvar) .or. 2 .ne. Icntr(I_Nz)   ) then
            CALL msg2 (cbType, usrMem, msgcb, 3, '**** Model has the wrong size.')
            result = 2
            return
         endif

!        Read the put file created by the GAMS model. We must do this as
!        the very first thing because it holds the size of the model.

         open (putUnit,file='ex4x.put',status='old',err=1000)
         rewind (putUnit)
         read (putUnit,*,err=1010) nDMU

         if (nDMU .gt. maxDMU) then
            CALL msg2 (cbType, usrMem, msgcb, 3, '****')
            CALL msg2 (cbType, usrMem, msgcb, 3, '**** Too many DMU''s for DLL')
            CALL msg2 (cbType, usrMem, msgcb, 3, '**** You must recompile with a larger maxDMU parameter.')
            CALL msg2 (cbType, usrMem, msgcb, 3, '****')
            result = 2
            close (putUnit)
            return
         endif

         read (putUnit,*,err=1010) fudge
         do i = 1, nDMU
            read (putUnit, *, err=1010) objval(i)
         end do
         close (putUnit)
!
!  Declare that one derivative is constant.
!
         Icntr(I_ConstDeriv) = 1
         result = 0             ! everything is OK
         return

 1000    result = 2
         CALL msg2 (cbType, usrMem, msgcb, 3, '****')
         CALL msg2 (cbType, usrMem, msgcb, 3, '**** Could not open data file')
         return
 1010    result = 2
         CALL msg2 (cbType, usrMem, msgcb, 3, '****')
         CALL msg2 (cbType, usrMem, msgcb, 3, '**** Error reading data file')
         close (putUnit)
         return


      else if ( Icntr(I_Mode) .eq. 4 ) then
!
!  Second setup call in which we must define the constant derivatives
!
         if (1 .ne. Icntr(I_Eqno)) then
            CALL msg2 (cbType, usrMem, msgcb, 3, ' ** Equation index has unexpected value.')
            result = 2          ! error in call
            return
         endif
!  The derivative w.r.t. cv = x(2) is constant with value 1.
         dfdx(2) = 1
         result = 0             ! everything is OK
         return
      else if ( Icntr(I_Mode) .eq. 2 ) then
!        Termination mode: no cleanup required
         result = 0             ! everything is OK
         return

      else if ( Icntr(I_Mode) .eq. 3 ) then
!        Function and Derivative Evaluation Mode

         if (1 .ne. Icntr(I_Eqno)) then
            CALL msg2 (cbType, usrMem, msgcb, 3, ' ** Equation index has unexpected value.')
            result = 2          ! error in call 
         endif

         h  = x(1)
         cv = x(2)

         if (h .le. 1e-20) then
            result = 1
!           bad point; return function eval error
            return
         endif

!        here, we mix the function and gradient computation
!        recall, function looks like -sum {nDMU, big_ugly(h)} + cv =e= 0
!        at the cost of some extra space (two vectors from 1..nDMU), we
!        could cut the time in half using the symmetry; we leave that
!        as an exercise

         f = cv
         dfdcv = 1.0
         dfdh  = 0.0

         do i = 1, nDMU
            t = fudge
            dtdh = 0.0
            do ii = 1, nDMU
               if (i .ne. ii) then
                  t1 = (objval(i)-objval(ii))/h
                  t1 = t1*t1
!                 save the 1/h term until later
                  dt1dh = t1
                  t1 = exp(-t1/2.0)
                  dt1dh = dt1dh*t1

                  t2 = (objval(i)+objval(ii)-2.0)/h
                  t2 = t2*t2
!                 save the 1/h term until later
                  dt2dh = t2
                  t2 = exp(-t2/2.0)
                  dt2dh = dt2dh*t2

                  t = t + t1 + t2
                  dtdh = dtdh + dt1dh + dt2dh
               endif
            enddo
            f = f - log(t)
            dfdh = dfdh - dtdh/t
         enddo

         f     = f    + nDMU*log(h)
!        don't forget our common 1/h term in dfdh!
         dfdh  = (dfdh + nDMU)/h

         if (ICntr(I_Dofunc) .ne. 0) then
!           Function value is needed.
            func = f
         endif
         if ( Icntr(I_Dodrv) .ne. 0 ) then
!           The vector of derivatives is needed.
            dfdx(1) = dfdh
            dfdx(2) = dfdcv
         endif

         result = 0             ! everything is OK

!        end evaluation mode
      else
!        Unknown Mode:
         CALL msg2 (cbType, usrMem, msgcb, 3, ' ** Unknown Mode value.')
         result = 2             ! error in call
      endif

      return
      end
