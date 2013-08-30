! This program performs the following steps:
!    1. Generate a gdx file with demand data
!    2. Calls GAMS to solve a simple transportation model
!       (The GAMS model writes the solution to a gdx file)
!    3. The solution is read from the gdx file

MODULE exData
  USE gamsglobals
  IMPLICIT NONE
  CHARACTER(LEN=UEL_IDENT_LEN), DIMENSION(MAX_INDEX_DIM) :: Indx
  REAL(KIND=8), DIMENSION(val_max) :: Values
  INTEGER(KIND=8)    :: PGDX = 0
  INTEGER(KIND=8)    :: PGAX = 0
  INTEGER(KIND=8)    :: POPT = 0
END MODULE exData

PROGRAM xp_example2
  USE gamsxf9def
  USE gdxf9def
  USE optf9def
  USE gamsglobals
  USE exData
  IMPLICIT NONE
  
  LOGICAL			 :: ok
  INTEGER(KIND=4)    :: iargc
  INTEGER(KIND=4)    :: status
  CHARACTER(LEN=255) :: Msg, Sysdir

  IF (iargc() /= 1) THEN
    WRITE(*,*) '**** xp_Example2: incorrect number of parameters'
    CALL gdxExit(1)
  END IF

  CALL getarg(1, Sysdir)
  WRITE(*,*) 'Loading objects from GAMS system directory: ', Sysdir
  
! Create objects
  ok = gamsxCreateD(PGAX, Sysdir, Msg)
  IF (.NOT. ok) THEN
    WRITE(*,*) '**** Could not load GDX library'
    WRITE(*,*) '**** ', Msg
    CALL gdxExit(1)
  END IF

  ok = gdxCreateD(PGDX, Sysdir, Msg)
  IF (.NOT. ok) THEN
    WRITE(*,*) '**** Could not load GDX library'
    WRITE(*,*) '**** ', Msg
    CALL gdxExit(1)
  END IF

  ok = optCreateD(POPT, Sysdir, Msg)
  IF (.NOT. ok) THEN
    WRITE(*,*) '**** Could not load GDX library'
    WRITE(*,*) '**** ', Msg
    CALL gdxExit(1)
  END IF

  status = WriteModelData('demanddata.gdx')
  IF (status /= 0) THEN
    WRITE(*,*) 'Model data not written'
    CALL TERMINATE
  END IF

  status = CallGams(sysdir)
  IF (status /= 0) THEN
    WRITE(*,*) 'Call to GAMS failed'
    CALL TERMINATE
  END IF

  status = ReadSolutionData('results.gdx')
  IF (status /= 0) THEN
    WRITE(*,*) 'Could not read solution back'
    CALL TERMINATE
  END IF

CONTAINS
  INTEGER (KIND=4) FUNCTION WriteModelData(fngdxfile)
    USE exData
    CHARACTER(LEN=*) :: fngdxfile
    INTEGER(KIND=4)  :: tmp, status
  
    tmp = gdxOpenWrite(PGDX, fngdxfile, 'xp_Example2', status)
    IF (status /= 0) THEN
      CALL gdxerror(status, 'gdxOpenWrite')
    END IF

    status = gdxDataWriteStrStart(PGDX, 'Demand', 'Demand Data', 1, DT_PAR, 0)
    IF (status == 0) THEN
      CALL gdxerror(gdxGetLastError(PGDX), 'gdxDataWriteStrStart')
    END IF

!   Initalize some GDX data structure */
    Indx(1) = 'New-York'
    Values(VAL_LEVEL) = 324.0
    status = gdxDataWriteStr(PGDX, Indx, Values)
    Indx(1) = 'Chicago'
    Values(VAL_LEVEL) = 299.0
    status = gdxDataWriteStr(PGDX, Indx, Values)
    Indx(1) = 'Topeka'
    Values(VAL_LEVEL) = 274.0
    status = gdxDataWriteStr(PGDX, Indx, Values)

    status = gdxDataWriteDone(PGDX)
    IF (status == 0) THEN
      CALL gdxerror(gdxGetLastError(PGDX), 'gdxDataWriteDone')
    END IF

    status = gdxClose(PGDX)
    IF (status /= 0) THEN
      CALL gdxerror(gdxGetLastError(PGDX), 'gdxClose')
    END IF

    WriteModelData = 0
  END FUNCTION
 
  INTEGER (KIND=4) FUNCTION CallGams(sysdir)
    USE exData
    CHARACTER(LEN=*)   :: sysdir
    CHARACTER(LEN=255) :: deffile, msg
    INTEGER(KIND=4)    :: status, i, itype
    
    deffile = TRIM(sysdir) // '/optgams.def'
    status = optReadDefinition(POPT,deffile)
    IF (status /= 0) THEN
      DO i=1,optMessageCount(POPT)
        CALL optGetMessage(POPT, i, msg, itype)
        WRITE(*,*) msg
      END DO
      CallGams = 1
      RETURN
    END IF
    
    CALL optSetStrStr(POPT, 'SysDir',    sysDir)
    CALL optSetStrStr(POPT, 'Input',     '../GAMS/model2.gms')
    CALL optSetIntStr(POPT, 'LogOption', 3)    
    
    status = gamsxRunExecDLL(PGAX, POPT, sysdir, 1, msg)
    IF (status /= 0) THEN
      WRITE(*,*) 'Could not execute RunExecDLL:', msg
      CallGams = 1
      RETURN
    END IF

    CallGams = 0
  END FUNCTION
 


  INTEGER (KIND=4) FUNCTION ReadSolutionData(fngdxfile)
    USE exData
    CHARACTER(LEN=*)   :: fngdxfile
    CHARACTER(LEN=255) :: msg, VarName
    INTEGER(KIND=4)  :: status, tmp, VarNr, NrRecs, FDim, dim, VarType, D

    tmp = gdxOpenRead(PGDX, fngdxfile, status)
    IF (status /= 0) THEN
      CALL gdxerror(status, 'gdxOpenRead')
    END IF

    VarName = 'result'
    status = gdxFindSymbol(PGDX, VarName, VarNr)
    IF (status == 0) THEN
      WRITE(*,*) 'Could not find variable >',VarName,'<'
      CALL gdxExit(1)
    END IF

    status = gdxSymbolInfo(PGDX, VarNr, VarName, dim, VarType)
    IF (Dim /= 2 .OR. DT_VAR /= VarType) THEN
      WRITE(*,*) '**** X is not a two dimensional variable: ',Dim,':',VarType
      CALL gdxExit(1)
    END IF

    status = gdxDataReadStrStart(PGDX,VarNr,NrRecs)
    IF (status == 0) THEN
      CALL gdxerror(gdxGetLastError(PGDX), 'gdxDataReadStrStart')
    END IF
    DO WHILE (0 .ne. gdxDataReadStr(PGDX,Indx,Values,FDim))
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
    
    status = gdxDataReadDone(PGDX)
    status = gdxGetLastError(PGDX)
    IF (status /= 0) THEN
      CALL gdxerror(status, 'GDX')
    END IF

    status = gdxClose(PGDX)
    IF (status /= 0) THEN
      CALL gdxerror(gdxGetLastError(PGDX), 'gdxClose')
    END IF

    ReadSolutionData = 0
  END FUNCTION
 
  SUBROUTINE gdxerror(i, s)
    INTEGER(KIND=4)    :: i,rc
    CHARACTER(LEN=*)   :: s
    CHARACTER(LEN=255) :: Msg
    rc = gdxErrorStr(PGDX, i, msg)
    WRITE(*,*) s, ' failed: ',msg
    CALL gdxExit(1)
  END SUBROUTINE
 
  SUBROUTINE TERMINATE
    LOGICAL :: brc
    brc = optFree(POPT)
    brc = gdxFree(PGDX)
    brc = gamsxFree(PGAX)
    CALL gdxExit(status)
  END SUBROUTINE
END PROGRAM xp_example2
