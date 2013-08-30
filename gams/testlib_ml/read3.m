% read3.m
% This test reads the parameter fibo from the GDX file exr3.gdx
% and verifies that it is read as expected
% The GDX file contains the first 6 fibonacci numbers
% what we get back from readgdx is the data in i-j-val format
%
% In this simple test, we don't use the utilities full2sp or sp2full
% to convert the GDX input/output - that's for a separate test

resultfile='read3_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

% fibo_ijval is A stored in i-j-val format
fibo_ijval = [1 1 ; 2 1 ; 3 2 ; 4 3 ; 5 5 ; 6 8 ];

[f_ijval,uels] = readgdx('exr3.gdx', 'fibo');
if norm(fibo_ijval-f_ijval) > 0
  error('bad output from readgdx: parameter fibo');
end

magic = 525;
errCount = 0;
writegdx (resultfile, ...
          'parameter','magic',magic, ...
          'parameter','errCount',errCount);
