% Read data using rgdx() with FORM=full and verify correctness

resultfile='rfull_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

universe = { '1', '2', '3', '0', 'zero', 'one', 'null', 'eins', ...
             'aught', 'unity', 'x0', 'x1', 'cero', 'uno'};

% with no parameter structure, rgdx just returns the universe of UELs
% from the GDX file
r = rgdx ('readbig.gdx');

if(iscell(r.uels) ~= 1)
  error('expected cell in r.uels');
end
isSame = strcmp(r.uels, universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end
if size(r.name) > 0
  error('bad r.name, none expected');
end
if size(r.type) > 0
  error('bad r.type, none expected');
end
if size(r.form) > 0
  error('bad r.form, none expected');
end
if size(r.val) > 0
  error('bad r.val, none expected');
end


% flags to control the read are put into a structure, rFlag
% the output comes back in another structure, r
clear rFlags
rFlags.name = 'I';
rFlags.form = 'full';
r = rgdx ('readbig.gdx', rFlags);

Ivals_ = [ 1 ; 1 ; 1 ; zeros(11,1) ];
p1vals_ = [ 0 ; 1 ; 0 ];

I_uels_ = { '1', '2', '3'};

if 1 ~= strcmp(r.name,'I')
  error('expected name = "I"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(Ivals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

icell = cell(1,3);
% is there an easier way to do this next line?  This seems complicated.
[icell{1:3}] = deal(r.uels{1}{1:3});

% now do a read over the domain I, since we have p1(I)
rFlags.name = 'p1';
% rFlags.uels = icell;
rFlags.uels{1} = icell;
r = rgdx ('readbig.gdx', rFlags);
if r.name ~= 'p1'
  error('expected name = "p1"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(p1vals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},I_uels_);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end


% read p1 with COMPRESS=true
p1valsCompress_ = [ 1 ];
p1uels_ = { '2' };
rFlags.name = 'p1';
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';

r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'p1')
  error('expected name = "p1"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(p1valsCompress_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},p1uels_);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end


% read s0
rFlags = rmfield(rFlags, 'compress');
rFlags.form = 'full';
rFlags.name = 's0';
r = rgdx ('readbig.gdx', rFlags);
s0vals_ = [ 1 ; 0 ; 0; 1 ; zeros(10,1) ];
if 1 ~= strcmp(r.name,'s0')
  error('expected name = "s0"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(s0vals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s1
rFlags.name = 's1';
r = rgdx ('readbig.gdx', rFlags);
s1vals_ = [ 0 ; 0 ; 0; 0 ; 1 ; 1 ; zeros(8,1) ];
if 1 ~= strcmp(r.name,'s1')
  error('expected name = "s1"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(s1vals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s2
rFlags.name = 's2';
r = rgdx ('readbig.gdx', rFlags);
s2vals_ = [ zeros(6,1) ; 1 ; 1 ; zeros(6,1) ];
if 1 ~= strcmp(r.name,'s2')
  error('expected name = "s2"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(s2vals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s3
rFlags.name = 's3';
r = rgdx ('readbig.gdx', rFlags);
s3vals_ = [ zeros(8,1) ; 1 ; 1 ; zeros(4,1) ];
if 1 ~= strcmp(r.name,'s3')
  error('expected name = "s3"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(s3vals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read sx
rFlags.name = 'sx';
r = rgdx ('readbig.gdx', rFlags);
sxvals_ = [ zeros(10,1) ; 1 ; 1 ; zeros(2,1) ];
if 1 ~= strcmp(r.name,'sx')
  error('expected name = "sx"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(sxvals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s6
% s6 is an alias for sx, but it should give the same result
rFlags.name = 's6';
r = rgdx ('readbig.gdx', rFlags);
s6vals_ = [ zeros(10,1) ; 1 ; 1 ; zeros(2,1) ];
if 1 ~= strcmp(r.name,'s6')
  error('expected name = "s6"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(s6vals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s9
rFlags.name = 's9';
r = rgdx ('readbig.gdx', rFlags);
s9vals_ = [ zeros(12,1) ; 1 ; 1 ];
if 1 ~= strcmp(r.name,'s9')
  error('expected name = "s9"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if norm(s9vals_- r.val) > 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end



% read ps10
% it is too big to read full over the universe 10-tuple
% but we can do it full using uel filters: this should have 2^10 elements
rFlags.name = 'ps10';
domain = cell(1,10);

domain{1} = {'0','1'};
domain{2} = {'zero','one'};
domain{3} = {'null', 'eins'};
domain{4} = {'aught', 'unity'};
domain{5} = {'x0', 'x1'};
domain{6} = {'x0', 'x1'};
domain{7} = {'x0', 'x1'};
domain{8} = {'x0', 'x1'};
domain{9} = {'x0', 'x1'};
domain{10} = {'cero', 'uno'};
rFlags.uels = domain;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps10')
  error('expected name = "ps10"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1024 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1024');
end
if nnz(r.val - 1) ~= 0
  error('bad r.val: should be all ones!');
end

% read ps10 compressed
% it is too big to read full over the universe 10-tuple
% but we can do it compressed: this should have 2^10 elements
rFlags.name = 'ps10';
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';

r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps10')
  error('expected name = "ps10"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1024 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1024');
end
if nnz(r.val - 1) ~= 0
  error('bad r.val: should be all ones!');
end


% read tiny
% do it full using uel filters: this should have just one nonzero
rFlags.name = 'tiny';
rFlags = rmfield(rFlags, 'compress');
rFlags.uels = domain;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'tiny')
  error('expected name = "tiny"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1024');
end
if nnz(r.val - 1) ~= 1023
  error('bad r.val: should be almost all zeros!');
end
if r.val(2,2,2,2,2,2,2,2,2,2) ~= 1
  error('bad r.val: one in the wrong spot');
end

% read tiny compressed
rFlags.name = 'tiny';
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';

r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'tiny')
  error('expected name = "tiny"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1');
end
if nnz(r.val - 1) ~= 0
  error('bad r.val: should be all ones!');
end


% read ps4
% it is small enough to read full over the universe 4-tuple
rFlags.name = 'ps4';
rFlags = rmfield(rFlags, 'compress');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps4')
  error('expected name = "ps4"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if nnz(size(r.val) - [14,14,14,14]) ~= 0
  error('bad size for r.val');
end
if nnz(r.val) ~= 16
  error('expected nnz(r.val) to be 16');
end
% so this thing is pretty sparse: density = 16 / 14^4
% knock out the expected 16 elements to get an empty set
r.val([1,4],[5,6],[7,8],[9,10]) = 0;
if nnz(r.val) ~= 0
  error('expected nnz(r.val) to be 0 after cleaning it out');
end
if nnz(size(r.uels) - [1,4]) ~= 0
  error('bad size for r.uels');
end
for j = 1 : 4
  isSame = strcmp(r.uels{j},universe);
  if nnz(isSame - 1) > 0
   error('bad r.uels{j}', j);
  end
end

% we could also read ps4 with uels or compressed, but we already
% tested that with ps10


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% start read tests for parameters
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read a10
% it is too big to read full over the universe 10-tuple
% but we can do it full using uel filters: this should have 2^10 nonzeros
rFlags.name = 'a10';
rFlags.uels = domain;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a10')
  error('expected name = "a10"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1023 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1023');
end
if r.val(2,1,1,1,1,1,1,1,1,1) ~= 1
  error('bad r.val in 2,ones');
end
if r.val(2,2,2,2,2,2,2,2,2,2) ~= 1023
  error('bad r.val in twos');
end

% read a10 compressed
rFlags.name = 'a10';
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';
if 1 ~= strcmp(r.name,'a10')
  error('expected name = "a10"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1023 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1024');
end
if r.val(2,1,1,1,1,1,1,1,1,1) ~= 1
  error('bad r.val in 2,ones');
end
if r.val(2,2,2,2,2,2,2,2,2,2) ~= 1023
  error('bad r.val in twos');
end

% read atiny
% do it full using uel filters: this should have just one nonzero
rFlags.name = 'atiny';
rFlags = rmfield(rFlags, 'compress');
rFlags.uels = domain;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'atiny')
  error('expected name = "atiny"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1');
end
if r.val(2,2,2,2,2,2,2,2,2,2) ~= 525
  error('bad r.val: unexpected value found');
end

% read atiny compressed
rFlags.name = 'atiny';
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';

r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'atiny')
  error('expected name = "atiny"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if 1 ~= nnz(r.val)
  error('expected nnz(r.val) to be 1024');
end
if nnz(r.val - 525) ~= 0
  error('bad r.val: should be all 525!');
end



% read a4
% it is small enough to read full over the universe 4-tuple
rFlags.name = 'a4';
rFlags = rmfield(rFlags, 'compress');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a4')
  error('expected name = "a4"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'full')
  error('expected form = "full"');
end
if nnz(size(r.val) - [14,14,14,14]) ~= 0
  error('bad size for r.val');
end
if nnz(r.val) ~= 15
  error('expected nnz(r.val) to be 15');
end
% so this thing is pretty sparse: density = 16 / 14^4
% knock out the expected 16 elements to get an empty set
r.val([1,4],[5,6],[7,8],[9,10]) = 0;
if nnz(r.val) ~= 0
  error('expected nnz(r.val) to be 0 after cleaning it out');
end
if nnz(size(r.uels) - [1,4]) ~= 0
  error('bad size for r.uels');
end
for j = 1 : 4
  isSame = strcmp(r.uels{j},universe);
  if nnz(isSame - 1) > 0
    error('bad r.uels{j}', j);
  end
end

magic.name = 'magic';
magic.type = 'parameter';
magic.val  = 525;
errCount.name = 'errCount';
errCount.type = 'parameter';
errCount.val  = 0;
wgdx (resultfile, magic, errCount);

disp 'ALL FULL READ TESTS PASSED';
