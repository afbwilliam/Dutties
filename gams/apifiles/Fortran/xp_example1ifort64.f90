MODULE exData
  USE gamsglobals
  IMPLICIT NONE
  CHARACTER(LEN=UEL_IDENT_LEN), DIMENSION(MAX_INDEX_DIM) :: Indx
  REAL(KIND=8), DIMENSION(val_max) :: Values
END MODULE exData

PROGRAM xp_example1
  USE gdxifort64def
  USE gamsglobals
  USE exData
  IMPLICIT NONE

  LOGICAL			 :: ok
  INTEGER(KIND=8)    :: PGX = 0
  INTEGER(KIND=4)    :: RC, ErrNr, VarNr, NrRecs, N, Dim, VarTyp, D, argc, iargc
  CHARACTER(LEN=255) :: Msg, Producer, Sysdir, VarName, gdxFname

  argc = iargc()
  
  IF ((argc /= 1) .AND. (argc /= 2)) THEN
    WRITE(*,*) '**** xp_Example1: incorrect number of parameters'
    STOP 1
  END IF

  CALL getarg(1, Sysdir)
  WRITE(*,*) 'xp_Example1 using GAMS system directory: ', Sysdir

  ok = gdxCreateD(PGX, Sysdir, Msg)

  IF (.NOT. ok) THEN
    WRITE(*,*) '**** Could not load GDX library'
    WRITE(*,*) '**** ', Msg
    STOP 1
  END IF

  RC = gdxGetDLLVersion(PGX, Msg)
  WRITE(*,*) 'Using GDX DLL version: ', Msg

  IF (1 == argc) THEN
!   Write demand data
    RC = gdxOpenWrite(PGX, './demanddata.gdx', 'example1', ErrNr)
    IF (ErrNr /= 0) CALL ReportIOError(ErrNr,'gdxOpenWrite')
    ok = 0 .ne. gdxDataWriteStrStart(PGX,'Demand','Demand data',1,DT_PAR ,0)
    IF (.NOT. ok) CALL ReportGDXError(PGX)
    CALL WriteData(PGX,'New-York',324D0)
    CALL WriteData(PGX,'Chicago',299D0)
    CALL WriteData(PGX,'Topeka',274D0)
    ok = 0 .ne. gdxDataWriteDone(PGX)
    IF (.NOT. ok) CALL ReportGDXError(PGX)
    WRITE(*,*) 'Demand data written by xp_example1'
  ELSE
!   Read variable X
    CALL getarg(2, gdxFname)
    RC = gdxOpenRead(PGX, gdxFname, ErrNr)
    IF (ErrNr /= 0) CALL ReportIOError(ErrNr,'gdxOpenRead')
    RC = gdxFileVersion(PGX,Msg,Producer)
    WRITE(*,*) 'GDX file written using version: ',Msg
    WRITE(*,*) 'GDX file written by: ',Producer

    ok = 0 .ne. gdxFindSymbol(PGX,'x',VarNr)
    IF (.NOT. ok) THEN
      WRITE(*,*) '**** Could not find variable X'
      STOP 1
    END IF

    RC = gdxSymbolInfo(PGX,VarNr,VarName,Dim,VarTyp)
    IF (Dim /= 2 .OR. DT_VAR /= VarTyp) THEN
      WRITE(*,*) '**** X is not a two dimensional variable: ',Dim,':',VarTyp
      STOP 1
    END IF

    ok = 0 .ne. gdxDataReadStrStart(PGX,VarNr,NrRecs)
    IF (.NOT. ok) CALL ReportGDXError(PGX)
    WRITE(*,*) 'Variable X has ',NrRecs,' records'
    DO WHILE (0 .ne. gdxDataReadStr(PGX,Indx,Values,N))
      IF (0D0 == Values(VAL_LEVEL)) CYCLE ! skip, level 0.0 is default
      DO D = 1,Dim 
		 IF (D /= DIM) THEN
	        WRITE(*,*) Indx(D) ,'.'
		 ELSE
	        WRITE(*,*) Indx(D)
		 END IF  
	  END DO
      write(*,*) ' = ', Values(VAL_LEVEL)
	END DO
    WRITE(*,*) 'All solution values shown'
    RC = gdxDataReadDone(PGX)
  END IF

  ErrNr = gdxClose(PGX)
  IF (ErrNr /= 0) CALL ReportIOError(ErrNr,'gdxClose')

  ok = gdxFree(PGX)
  IF (.NOT. ok) THEN
    WRITE(*,*) 'Problems unloading the GDX DLL'
    STOP 1
  END IF


CONTAINS
  SUBROUTINE ReportGDXError(PGX) 
    INTEGER(KIND=8), INTENT(IN) :: PGX
    CHARACTER(LEN=256) :: S
    WRITE (*,*) '**** Fatal GDX Error'
    RC = gdxErrorStr(PGX, gdxGetLastError(PGX), S)
    WRITE (*,*) '**** ', S
    STOP
  END SUBROUTINE ReportGDXError

  SUBROUTINE ReportIOError(N, msg)
    INTEGER(KIND=4), INTENT(IN) :: N
	CHARACTER(LEN=*), INTENT(IN) :: msg
    WRITE(*,*) '**** Fatal I/O Error = ', N, ' when calling ', msg
    STOP
  END SUBROUTINE ReportIOError

  SUBROUTINE WriteData(PGX, S, V)
    INTEGER(KIND=8), INTENT(IN) :: PGX
    CHARACTER(LEN=*), INTENT(IN) :: S
    REAL(KIND=8), INTENT(IN) :: V
    Indx(1) = S
    Values(VAL_LEVEL) = V
    RC = gdxDataWriteStr(PGX,Indx,Values)
  END SUBROUTINE WriteData


END PROGRAM xp_example1
