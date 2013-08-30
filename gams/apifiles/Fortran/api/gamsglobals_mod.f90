MODULE gamsglobals
!  INTEGER(KIND=4),PARAMETER :: MAX_INDEX_DIM = 10
!  INTEGER(KIND=4),PARAMETER :: UEL_IDENT_LEN = 31
  INTEGER(KIND=4),PARAMETER :: MAX_INDEX_DIM = 20
  INTEGER(KIND=4),PARAMETER :: UEL_IDENT_LEN = 63

  INTEGER(KIND=4),PARAMETER :: val_level    = 1
  INTEGER(KIND=4),PARAMETER :: val_marginal = 2
  INTEGER(KIND=4),PARAMETER :: val_lower    = 3
  INTEGER(KIND=4),PARAMETER :: val_upper    = 4
  INTEGER(KIND=4),PARAMETER :: val_scale    = 5
  INTEGER(KIND=4),PARAMETER :: val_max      = 5

  INTEGER(KIND=4),PARAMETER :: dt_set        = 0 ! gdxSyType
  INTEGER(KIND=4),PARAMETER :: dt_par        = 1
  INTEGER(KIND=4),PARAMETER :: dt_var        = 2
  INTEGER(KIND=4),PARAMETER :: dt_equ        = 3
  INTEGER(KIND=4),PARAMETER :: dt_alias      = 4
  INTEGER(KIND=4),PARAMETER :: dt_max        = 5

  INTEGER(KIND=4),PARAMETER :: sv_valund       = 0 ! gdxSpecValue
  INTEGER(KIND=4),PARAMETER :: sv_valna        = 1
  INTEGER(KIND=4),PARAMETER :: sv_valpin       = 2
  INTEGER(KIND=4),PARAMETER :: sv_valmin       = 3
  INTEGER(KIND=4),PARAMETER :: sv_valeps       = 4
  INTEGER(KIND=4),PARAMETER :: sv_normal       = 5
  INTEGER(KIND=4),PARAMETER :: sv_acronym      = 6
  INTEGER(KIND=4),PARAMETER :: sv_max          = 7

  REAL(KIND=8),PARAMETER :: valund     =  1.0D300  ! undefined
  REAL(KIND=8),PARAMETER :: valna      =  2.0D300  ! not available/applicable
  REAL(KIND=8),PARAMETER :: valpin     =  3.0D300  ! plus infinity
  REAL(KIND=8),PARAMETER :: valmin     =  4.0D300  ! minus infinity
  REAL(KIND=8),PARAMETER :: valeps     =  5.0D300  ! epsilon
  REAL(KIND=8),PARAMETER :: valacronym = 10.0D300  ! potential/real acronym
 
  REAL(KIND=8),PARAMETER :: RMACH1 = 2.2D-16
  !REAL(KIND=8),PARAMETER :: RMACH2 = 1.797693D308
  !REAL(KIND=8),PARAMETER :: RMACH3 = DBLE(-308)
  !REAL(KIND=8),PARAMETER :: RMACH4 = DBLE(308)
  !REAL(KIND=8),PARAMETER :: RMACH5 = DBLE(15)
  !REAL(KIND=8),PARAMETER :: RMACH6 = 2.225074D-308

  INTEGER(KIND=4),PARAMETER :: IMACH1 = 2
  INTEGER(KIND=4),PARAMETER :: IMACH2 = 4
  !INTEGER(KIND=4),PARAMETER :: IMACH3 = 2
  !INTEGER(KIND=4),PARAMETER :: IMACH4 = 8  
  
END MODULE gamsglobals
