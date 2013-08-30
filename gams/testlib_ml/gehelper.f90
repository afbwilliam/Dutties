!  include file for GAMS external function interface

!  Utility routines for writing to the status and log files.
!
!  The strings that are passed back to GAMS are stored in part of the
!  control vector, icntr. The packing convention is as follows:
!
!  icntr(26) points to the first position in icntr available as a
!	     a buffer. It is defined by the Solver/GAMS and it should
!	     not be changed
!  icntr(1)  Holds the length of icntr. All space from icntr(26) to
!	     icntr(1) is available for the buffer.
!  icntr(27) holds the number of integer positions in icntr already
!	     in use. It is always zero when GEFUNC is called and is
!	     accumulated in these routines. The first free position
!	     in the buffer is therefore always icntr(26)+icntr(27)+1.
!
!  Records are stored in the buffer with a two-integer header record
!  followed by the characters packed into integers. The first integer
!  in the header holds the number of characters in the following
!  string. The second integer is used to tell where the string should
!  go: 1 means the Status file and 2 means the Log file. Other value
!  can later be used to indicate other distinations.
!  The strings themselves are converted to integer*1 packed 4 to
!  one integer*4 position using the Fortran inline function Ichar.
!  (See subroutine GESTOR).
!
!  To avoid problems with mixing Fortran and C, strings should not
!  contain any null characters or new-line characters. And because
!  the string may be shifted a few characters right it should also
!  not contain tab characters. Each string is interpreted as one
!  output line.
!
!  If there is insufficient space in the buffer then the last part
!  is silently ignored. The header records reflect what is actually
!  stored and not what we would have like to store.
!
!  icntr(28) is used to turn debugging on. If icntr(28) is nonzero
!	     then it is used as a Fortran file unit and a file with
!	     the name debugext.txt is opened and all communication
!	     via GESTAT and GELOG is written to this file. The file
!	     is flushed continuously to avoid losing the last
!	     interesting part.
!

MODULE gehelper
  IMPLICIT NONE
  LOGICAL, PRIVATE :: debugOpened = .FALSE.
  INTEGER, PRIVATE :: debugUnit = 0
  PRIVATE :: openDebug

  INTEGER, PARAMETER :: I_Length = 1
  INTEGER, PARAMETER :: I_Neq    = 2
  INTEGER, PARAMETER :: I_Nvar   = 3
  INTEGER, PARAMETER :: I_Nz     = 4
  INTEGER, PARAMETER :: I_Mode   = 5
  INTEGER, PARAMETER :: I_Eqno   = 6
  INTEGER, PARAMETER :: I_Dofunc = 7
  INTEGER, PARAMETER :: I_Dodrv  = 8
  INTEGER, PARAMETER :: I_Newpt  = 9
  INTEGER, PARAMETER :: I_Debug  = 28

  ! Added by ADrud for communication of various directory or file names:
  ! Set Cntr(I_Getfil) to a value from the list I_Scr, I_Wrk, I_Sys
  ! to request a directory (including the trailing / or \), or
  ! to a value from the list I_Cntr, ... to get a complete file name.
  ! Cntr(I_Getfile) must be set to one of the request values during
  ! setup call. GEFUNC will then be called again with the same value
  ! (I_Scr, I_Wrk etc.) and the file or directory name can then be
  ! extracted from the communication buffer using the subroutine GENAME.
  INTEGER, PARAMETER :: I_Getfil = 10
  INTEGER, PARAMETER :: I_Smode  = 13
  INTEGER, PARAMETER :: I_Scr    = 11     ! Value used to request the scratch directory
  INTEGER, PARAMETER :: I_Wrk    = 12     ! Value used to request the working directory
  INTEGER, PARAMETER :: I_Sys    = 13     ! Value used to request the systems directory
  INTEGER, PARAMETER :: I_Cntr   = 14     ! Value used to request the control file

  ! Added for extra capability
  INTEGER, PARAMETER :: I_ConstDeriv = 14   ! The user can return number of constant
                                            ! derivatives
  INTEGER, PARAMETER :: I_HVprod     = 15   ! 1 indicates that the user can return
                                            ! Hessian time vector
  ! gefunc calling modes - possible values for icntr(I_Mode)
  INTEGER, PARAMETER :: DOINIT       = 1
  INTEGER, PARAMETER :: DOTERM       = 2
  INTEGER, PARAMETER :: DOEVAL       = 3
  INTEGER, PARAMETER :: DOCONSTDERIV = 4
  INTEGER, PARAMETER :: DOHVPROD     = 5


CONTAINS

  SUBROUTINE openDebug(du)
    INTEGER, INTENT(IN) :: du ! unit number to use for debug file
    IF (.not. debugOpened) THEN
       debugUnit = du
       OPEN (debugUnit,file='debugext.txt',status='unknown')
       debugOpened = .true.
    END IF
  END SUBROUTINE openDebug

  SUBROUTINE gestat (icntr, line)
    INTEGER, INTENT(IN OUT) :: icntr(*)
    CHARACTER(LEN=*), INTENT(IN) :: line

    INTEGER :: length, len1, start

    ! If in debug mode, write the string to debugext.txt
    IF (icntr(28) /= 0) THEN
       CALL openDebug(icntr(28))
       WRITE (debugUnit,"(A6,A)") 'Stat: ', line
       ! Missing -- how do we flush the buffers?
       ! call flush(debugUnit)
    END IF

    start  = icntr(26) + icntr(27)
    length = (icntr(1)-start-1)*4    !  Length in bytes after fixed part

    IF (length <= 8) RETURN          ! Not enough space for anything
    len1 = min(256, len(line))       ! Max line length = 256
    IF ((len1+3)/4 + 1 .gt. length) THEN  ! check for overflow, trunc if required
       len1 = (length - 1)*4
    END IF
    CALL gestor (icntr(start+2), len1, line)
    icntr(start) = len1	       ! Length of string
    icntr(start+1) = 1	       ! Goes to status file
    icntr(27) = icntr(27) + 2 + (len1+3)/4  ! Number of ints stored

    RETURN
  END SUBROUTINE gestat

  SUBROUTINE gelog (icntr, line)
    INTEGER, INTENT(IN OUT) :: icntr(*)
    CHARACTER(LEN=*), INTENT(IN) :: line

    INTEGER :: length, len1, start

    ! If in debug mode, write the string to debugext.txt
    IF (icntr(28) /= 0) THEN
       CALL openDebug(icntr(28))
       WRITE (debugUnit,"(A6,A)") ' Log: ', line
       ! Missing -- how do we flush the buffers?
       ! call flush(debugUnit)
    END IF

    start  = icntr(26) + icntr(27)
    length = (icntr(1)-start-1)*4    !  Length in bytes after fixed part

    IF (length <= 8) RETURN          ! Not enough space for anything
    len1 = min(256, len(line))       ! Max line length = 256
    IF ((len1+3)/4 + 1 .gt. length) THEN  ! check for overflow, trunc if required
       len1 = (length - 1)*4
    END IF
    CALL gestor (icntr(start+2), len1, line)
    icntr(start) = len1	       ! Length of string.
    icntr(start+1) = 2	       ! Goes to Log file
    icntr(27) = icntr(27) + 2 + (Len1+3)/4  ! Number of ints stored

    RETURN
  END SUBROUTINE gelog

  SUBROUTINE gename (icntr, len1, name)
    ! Utility routine for extracting file or directory names from GAMS
    ! icntr(I_Getfil) must be set to a value in the first call to request
    ! a file name. In the next call, icntr(I_SMode) will be set to the
    ! request value, and the file name is stored in icntr from
    ! index = icntr(11) (measured in integer*4 elements)
    ! with length = icntr(12) (measured in characters).
    ! The name can be extracted with subroutine GENAME.
    ! If additional directory or file names are needed,
    ! Inctr(I_Getfil) can be set again and the next call will have
    ! icntr(I_SMode) set to this value and the next name can be extracted
    ! with another call to GENAME. The name process continues until
    ! icntr(I_Getfil) is not set any more.

    ! Extracts the name of a file or directory packed into icntr.

    INTEGER, INTENT(IN OUT) :: icntr(*)
    INTEGER, INTENT(OUT) :: len1
    CHARACTER(LEN=255), INTENT(OUT) :: name
    INTEGER :: start

    name = ' '
    len1  = icntr(12)
    start = icntr(11)

    CALL geextr (icntr(start), len1, name)

    RETURN
  END SUBROUTINE gename

END MODULE gehelper

SUBROUTINE gestor (icntr, len1, line)
  ! Convert the string to integer*1 and pack it into icntr
  ! Notice that the compiler may give a warning since the first
  ! argument, icntr, has changed type from the caller to here.
  ! This is intentional and is not an error!

  INTEGER(KIND=1), INTENT(IN OUT) :: icntr(*)
  INTEGER, INTENT(IN) :: len1
  CHARACTER(LEN=*), INTENT(IN) :: line
  INTEGER :: i

  DO i = 1, len1
     icntr(i) = ichar(line(i:i))
  END DO

  RETURN
END SUBROUTINE gestor

SUBROUTINE geextr (icntr, len1, name)
  ! Convert the content of icntr packed as integer*1 to a string using
  ! the Fortran char() function.
  ! Notice that the compiler may give a warning since the first
  ! argument, icntr, has changed type from the caller to here.
  ! This is intentional and is not an error!
  INTEGER(KIND=1), INTENT(IN OUT) :: icntr(*)
  INTEGER, INTENT(IN) :: len1
  CHARACTER(LEN=255), INTENT(OUT) :: name
  INTEGER :: i

  DO i = 1, len1
     name(i:i) = char(icntr(i))
  END DO

  RETURN
END SUBROUTINE geextr
