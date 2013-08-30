% Read data using rgdx() with only .name field in input structure.

% This is a test to verify that rgdx read data in sparse format as
% as default format and .uels will be corresponding n dimensional
% cell array,

resultfile='r2_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

s = struct('name', 'K');
x = rgdx('read2.gdx', s)

xout = [1 3; 1 4; 2 3; 2 4];
uel = {{'i1' 'i2' 'j1' 'j2'}, {'i1' 'i2' 'j1' 'j2'}};

if (1~= strcmp(x.form, 'sparse') )
    error('bad format, sparse expected ');
end

if norm(x.val - xout) > 0
    error('bad x.val');
end

dim = size(x.val);
uelDim = size(x.uels);

if(dim(2) - uelDim(2) ~= 0)
    error('bad dimension of uel');
end

g = rgdx('read2.gdx');
globUEL = g.uels;

isSame = strcmp(x.uels{1}, globUEL);
if norm(isSame - ones(size(isSame))) > 0
  error('bad x.uels');
end

isSame = strcmp(x.uels{2}, globUEL);
if norm(isSame - ones(size(isSame))) > 0
  error('bad x.uels');
end

spar = struct('name', 'P');
xpar = rgdx('read2.gdx', spar);

p = [1 3 3; 1 4 4; 2 3 5; 2 4 6];

if(1 ~= strcmp(xpar.type, 'parameter'))
    error('bad xpar.type');
end

if norm(p - xpar.val) > 0
    error('bad xpar.val');
end

magic.name = 'magic';
magic.type = 'parameter';
magic.val  = 525;
errCount.name = 'errCount';
errCount.type = 'parameter';
errCount.val  = 0;
wgdx (resultfile, magic, errCount);

disp 'ALL TESTS FOR DEFAULT BEHAVIOUR PASSED';
