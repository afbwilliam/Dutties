public class gamsglobals
{
    public const int maxdim = 20;
    public const int str_len = 256;

    public const int val_level = 0;
    public const int val_marginal = 1;
    public const int val_lower = 2;
    public const int val_upper = 3;
    public const int val_scale = 4;
    public const int val_max = 5;

    public const int sv_und = 0;
    public const int sv_na = 1;
    public const int sv_pin = 2;
    public const int sv_min = 3;
    public const int sv_eps = 4;
    public const int sv_normal = 5;
    public const int sv_acronym = 6;
    public const int sv_max = 7;

    public const int dt_set = 0;
    public const int dt_par = 1;
    public const int dt_var = 2;
    public const int dt_equ = 3;
    public const int dt_alias = 4;
    public const int dt_max = 5;

    public const double sv_valund = 1.0E300;   // undefined
    public const double sv_valna = 2.0E300;   // not available/applicable
    public const double sv_valpin = 3.0E300;   // plus infinity
    public const double sv_valmin = 4.0E300;   // minus infinity
    public const double sv_valeps = 5.0E300;   // epsilon
    public const double sv_valacronym = 10.0E300;   // potential/real acronym
}