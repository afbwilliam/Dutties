file toadd /addit.txt/;
put toadd
$onput
this will be added to a file
$offput
putclose;

file toadd2 /sets.gms/;
put toadd2
$onput
*this will be added to a file
set it /i1*i3/;
$offput
putclose;

file myput ;
put myput ;
set i /a1*a5/;
scalar random;
*write stuff to different files
        loop(i,
          random = uniformint(0,100);
          put_utility 'shell' / 'echo ' random:0:0 ' > ' i.tl:0;
        );

*Put data in several gdx files then reloads it

       file fx2;
        put fx2;
        set ij / 2005*2007 /;

*put out the data to multiple GDX files

      loop(ij,
          put_utility 'gdxout' / 'data' ij.tl:0;
          random = uniform(0,1);
          execute_unload random;
        );

*Load the data from multiple GDX files

      loop(ij,
          put_utility 'gdxin' / 'data' ij.tl:0 ;
          execute_load random; display random;
        );



        file dummy; dummy.pw=2000; put dummy;

*here I execute some commands with waiting

        put_utility 'exec'  / 'gams sets' /
                    'shell' / 'dir *.gms'    ;

*here I execute some commands without waiting
         put_utility 'exec.async'  / 'gams sets' /
                     'shell' / 'dir *.gms'    ;

*here I enter a clickable link

      put_utility             'click' / 'sets.html' ;


*here I vary where the put file output goes

        loop(i,
            put_utility 'ren' / i.tl:0 '.output'  ;
            put "output to file " i.tl:0 " with suffix output " /;
            );

*here i put messages in the LOG and LST files

      put_utility 'msg'  / 'message to lst file' /
                    'log'  / 'message to log file' /
                    'msglog'  / 'message to log and lst file' ;

putclose;

*here i put some text in the put file

  file junk;
        put junk;
        put_utility 'inc'  / 'addit.txt' ;
        put_utility 'inc'  / 'sets.gms' ;



