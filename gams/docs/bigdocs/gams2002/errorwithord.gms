*$ontext
        set a        a couple of the elements /r2,r3/;
        set b mor eelements /r1*r10/;
        scalar count counter /0/;
          loop(b$(ord(b) gt 3),count=count+1);
        display count;
*$offtext

        set a1a        a couple of the elements /s1*s10/;
        set a1b more elements /s3,s1/;
          loop(a1b$(ord(a1b) gt 3),count=count+1);
        display count;
