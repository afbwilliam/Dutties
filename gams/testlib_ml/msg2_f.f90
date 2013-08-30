SUBROUTINE msg (msgcb, mode, msgbuf)
  IMPLICIT NONE

  EXTERNAL :: msgcb
  !DEC$ ATTRIBUTES STDCALL, REFERENCE :: msgcb
  INTEGER, INTENT(IN) ::  mode
  CHARACTER(LEN=*), INTENT(IN) :: msgbuf

  INTEGER :: nChars
  INTEGER, EXTERNAL :: charCount

  nChars = charCount (msgbuf)
  CALL msgcb (mode, nChars, msgbuf)

  RETURN
END SUBROUTINE msg


SUBROUTINE msg2 (cbType, usrMem, msgcb, mode, msgbuf)
  IMPLICIT NONE
  INTEGER, INTENT(IN) :: cbType
  INTEGER, INTENT(IN OUT) :: usrMem
  ! EXTERNAL :: usrMem, msgcb
  EXTERNAL :: msgcb
  !DEC$ ATTRIBUTES STDCALL, REFERENCE :: msgcb
  INTEGER, INTENT(IN) ::  mode
  CHARACTER(LEN=*), INTENT(IN) :: msgbuf

  INTEGER :: nChars
  INTEGER, EXTERNAL :: charCount

  nChars = charCount (msgbuf)


  IF (cbType == 1) THEN
     CALL msgcb (mode, nChars, msgbuf)
  ELSE IF (cbType == 2) THEN
     CALL msgcb (usrMem, mode, nChars, msgbuf)
  END IF

  RETURN
END SUBROUTINE msg2


! charCount returns "length" of string str without trailing blanks
FUNCTION charCount (str) RESULT (result)
  IMPLICIT NONE
  INTEGER :: result
  CHARACTER(LEN=*), INTENT(IN) :: str

  INTEGER :: i
  CHARACTER :: c

  DO i = len(str),1,-1
     c = str(i:i)
     IF (c /= ' ') THEN
        result = i
        RETURN
     END IF
  END DO

  result = 0                    ! all blanks
END FUNCTION charCount
