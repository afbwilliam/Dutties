% read5.m
% This test reads scalars containing special values
% from the GDX file exr5.gdx and verifies
% that they are read as expected
% See the file genr5.gms for the expected content

resultfile='read5_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

gdxFileName='exr5.gdx';

veps = readgdx(gdxFileName, 'valeps');
vinf = readgdx(gdxFileName, 'valinf');
vpi  = readgdx(gdxFileName, 'valpi');

if (veps ~= 0)
  error('cannot read eps correctly');
end
% the inf check allows two values for backwards compatibility
% the old readgdx() returned 1e20, the new rgdx() returns inf
if ((vinf ~= 1e20) && (vinf ~= inf))
  error('cannot read inf correctly');
end
if (vpi ~= pi)
  error('cannot read pi correctly');
end

magic = 525;
errCount = 0;
writegdx (resultfile, ...
          'parameter','magic',magic, ...
          'parameter','errCount',errCount);
