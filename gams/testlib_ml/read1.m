% read1.m
% This test reads the set I from the GDX file ex1_.gdx and verifies
% that it is read as expected
% The GDX file contains
% set I / 1 * 4 /;
% what we get back from readgdx is the index array for this set
%
% In this simple test, we don't use the utilities full2sp or sp2full
% to convert the GDX input/output - that's for a separate test

resultfile='read1_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

Aindex = [1 ; 2 ; 3 ; 4 ];
A      = [1 ; 1 ; 1 ; 1 ];

Iindex = readgdx('ex1_.gdx', 'I');
if norm(Iindex-Aindex) > 0
  error('bad output from readgdx');
end

I(Iindex,1) = 1;
if norm(I-A) > 0
  error('bad output from readgdx');
end

magic = 525;
errCount = 0;
writegdx (resultfile, ...
          'parameter','magic',magic, ...
          'parameter','errCount',errCount);
