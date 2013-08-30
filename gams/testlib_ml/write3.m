% create a 1-dim parameter and write it to GDX

N = 3;
c = [ linspace(1,N,N) ; 2*linspace(1,N,N) ]';
writegdx ('exw3.gdx','parameter','c',c);

uels = cell(N,1);
uels(1) = {'athos'};
uels(2) = {'porthos'};
uels(3) = {'aramis'};
writegdx ('exw3_lab.gdx','parameter','d',c,uels);
