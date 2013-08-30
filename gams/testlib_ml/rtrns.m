% read transport data from GDX and verify it's correct

resultfile='rtrns_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

[I,uels] = readgdx ('trnsport.gdx','I');
J        = readgdx ('trnsport.gdx','J');
a        = readgdx ('trnsport.gdx','a');
b        = readgdx ('trnsport.gdx','b');
d        = readgdx ('trnsport.gdx','d');
f        = readgdx ('trnsport.gdx','f');
c        = readgdx ('trnsport.gdx','c');

N = 5;
if size(uels) ~= [N,1]
  error('bad size for uels');
end

d_ = [   0         0    2.5000    1.7000    1.8000 ; ...
         0         0    2.5000    1.8000    1.4000 ];

f_ = [ 90 ];

c_ = [   0         0    0.2250    0.1530    0.1620 ; ...
         0         0    0.2250    0.1620    0.1260 ];

I_ = [   1         1    0         0         0      ]';

J_ = [   0         0    1         1         1      ]';


dmat = sp2full(d,'par');
fmat = sp2full(f,'par');
cmat = sp2full(c,'par');
Imat = sp2full(I,'set',5);
Jmat = sp2full(J,'set');

if norm(d_-dmat) > 1e-14
  error('bad parameter d');
end
if norm(f_-fmat) > 1e-14
  error('bad parameter f');
end
if norm(c_-cmat) > 1e-14
  error('bad parameter c');
end
if norm(I_-Imat) > 0
  error('bad set I');
end
if norm(J_-Jmat) > 0
  error('bad set J');
end

magic = 525;
errCount = 0;
writegdx (resultfile, ...
          'parameter','magic',magic, ...
          'parameter','errCount',errCount);
