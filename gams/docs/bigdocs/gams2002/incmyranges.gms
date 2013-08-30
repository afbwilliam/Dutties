set resource,
    process,
    rnglim;
$gdxin passtorange.gdx
$Load resource process rnglim
$include "%filename%"
execute_unload 'passtorange.gdx',OBJTRNG,
                               AVAILABLERNG,
                               PRODUCTIONRNG,
                               PROFITRNG;
