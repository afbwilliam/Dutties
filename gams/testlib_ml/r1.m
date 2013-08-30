% Test rgdx() on only one argument

% This is a test to verify that when no 2nd argument (i.e. no input
% structure) is passed, rgdx returns the global UEL list

resultfile='r1_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

uel = {'i1', 'i2', 'j1', 'j2', 'j3'};

x = rgdx('read1.gdx');

if(iscell(x.uels) ~= 1)
    error('expected cell');
end

isSame = strcmp(x.uels, uel);
if norm(isSame - ones(size(isSame))) >0
    error('bad x.uels');
end


if size(x.name) > 0
    error('bad x.name, none expected');
end

if size(x.type) > 0
    error('bad x.type, none expected');
end

if size(x.form) > 0
    error('bad x.form, none expected');
end

if size(x.val) > 0
    error('bad x.val, none expected');
end

magic.name = 'magic';
magic.type = 'parameter';
magic.val  = 525;
errCount.name = 'errCount';
errCount.type = 'parameter';
errCount.val  = 0;
wgdx (resultfile, magic, errCount);

disp 'ALL TESTS FOR GLOBAL UEL PASSED';


