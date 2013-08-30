% Read data using rgdx() with FORM=sparse and verify correctness

resultfile='rsparse_result.gdx';
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
if nnz(isSame - 1) ~= 0
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


% flags to try: compress = 'true';
%               uels

Iuels_sp = [ 1 ; 2 ; 3];
p1uels_sp = [ 2 ];
s0uels_sp = [ 1 ; 4 ];
s1uels_sp = [ 5 ; 6 ];
s2uels_sp = [ 7 ; 8 ];
s3uels_sp = [ 9 ; 10 ];
sxuels_sp = [ 11 ; 12 ];
s9uels_sp = [ 13 ; 14 ];


% flags to control the read are put into a structure, rFlag
% the output comes back in another structure, r
clear rFlags
rFlags.name = 'I';
% sparse is the default, it should not be required
% rFlags.form = 'sparse';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'I')
  error('expected name = "I"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(size(r.val)-[3,1]) ~= 0
  error('bad r.val size');
end
if nnz(Iuels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if nnz(isSame - 1) ~= 0
  error('bad r.uels');
end

rFlags.name = 'I';
% with compress = true the uels come back squeezed
rFlags.compress = 'true';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'I')
  error('expected name = "I"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(size(r.val)-[3,1]) ~= 0
  error('bad r.val size');
end
if nnz(Iuels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},{'1','2','3'});
if nnz(isSame - 1) ~= 0
  error('bad r.uels');
end


icell = cell(1,3);
% is there an easier way to do this next line?  This seems complicated.
[icell{1:3}] = deal(universe{1:3});
rFlags.name = 'p1';
rFlags = rmfield(rFlags, 'compress');
rFlags.uels{1} = icell;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'p1')
  error('expected name = "p1"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(p1uels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},icell);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end


% read s0
rFlags = rmfield(rFlags, 'uels');
rFlags.form = 'sparse';
rFlags.name = 's0';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'s0')
  error('expected name = "s0"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(s0uels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s1
rFlags.name = 's1';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'s1')
  error('expected name = "s1"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(s1uels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s2
rFlags.name = 's2';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'s2')
  error('expected name = "s2"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(s2uels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s3
rFlags.name = 's3';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'s3')
  error('expected name = "s3"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(s3uels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read sx
rFlags.name = 'sx';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'sx')
  error('expected name = "sx"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(sxuels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end

% read s9
rFlags.name = 's9';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'s9')
  error('expected name = "s9"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz(s9uels_sp - r.val) ~= 0
  error('bad r.val');
end
isSame = strcmp(r.uels{1},universe);
if norm(isSame - ones(size(isSame))) > 0
  error('bad r.uels');
end


% read ps10
% reading sparse we can read ps10 with no filters or compressing
rFlags.name = 'ps10';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps10')
  error('expected name = "ps10"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1024,10] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1024,10]');
end
tt = r.val;
tt([1:512],1) = tt([1:512],1) - 1;
tt([513:1024],1) = tt([513:1024],1) - 3;
tt(:,2) = tt(:,2) - 5;
tt(:,3) = tt(:,3) - 7;
tt(:,4) = tt(:,4) - 9;
tt(:,5) = tt(:,5) - 11;
tt(:,6) = tt(:,6) - 11;
tt(:,7) = tt(:,7) - 11;
tt(:,8) = tt(:,8) - 11;
tt(:,9) = tt(:,9) - 11;
tt(:,10)= tt(:,10)- 13;
check = zeros(1024,1);
for j = 1 : 1024
  check(j) = j - 1 ...
     - 512*tt(j,1) ...
     - 256*tt(j,2) ...
     - 128*tt(j,3) ...
     -  64*tt(j,4) ...
     -  32*tt(j,5) ...
     -  16*tt(j,6) ...
     -   8*tt(j,7) ...
     -   4*tt(j,8) ...
     -   2*tt(j,9) ...
     -   1*tt(j,10);
end
if nnz(check) ~= 0
  error('bad r.val: check should be all zero!');
end
% tt = r.val;

% now read ps 10 with filters
domain = cell(1,10);
domain{1} = {'1','0'};
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
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1024,10] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1024,10]');
end
if nnz(r.val - tt - 1) ~= 0
  error('bad r.val: not as expected');
end



% now read ps 10 compressed
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps10')
  error('expected name = "ps10"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1024,10] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1024,10]');
end
if nnz(r.val - tt - 1) ~= 0
  error('bad r.val: not as expected');
end

% read tiny with no filters or compression
rFlags.name = 'tiny';
rFlags = rmfield(rFlags, 'compress');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'tiny')
  error('expected name = "tiny"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1,10] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1,10]');
end
if nnz(r.val - [1, 6, 8, 10, 12, 12, 12, 12, 12, 14]) ~= 0
  error('bad r.val: not as expected');
end

% read tiny with uel filters
rFlags.uels = domain;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'tiny')
  error('expected name = "tiny"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1,10] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1,10]');
end
if nnz(r.val - [1, 2, 2, 2, 2, 2, 2, 2, 2, 2]) ~= 0
  error('bad r.val: not as expected');
end

rFlags.compress = 'true';
rFlags = rmfield(rFlags, 'uels');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'tiny')
  error('expected name = "tiny"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1,10] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1,10]');
end
if nnz(r.val - [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]) ~= 0
  error('bad r.val: not as expected');
end

% read ps4 unfiltered and uncompressed
rFlags.name = 'ps4';
rFlags = rmfield(rFlags, 'compress');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps4')
  error('expected name = "ps4"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([16,4] - size(r.val)) ~= 0
  error('expected size(r.val) to be [16,4]');
end
tt = r.val;
tt([1:8],1) = tt([1:8],1) - 1;
tt([9:16],1) = tt([9:16],1) - 3;
tt(:,2) = tt(:,2) - 5;
tt(:,3) = tt(:,3) - 7;
tt(:,4) = tt(:,4) - 9;
check = zeros(16,1);
for j = 1 : 16
  check(j) = j - 1 ...
     - 8*tt(j,1) ...
     - 4*tt(j,2) ...
     - 2*tt(j,3) ...
     - 1*tt(j,4);
end
if nnz(check) ~= 0
  error('bad r.val: check should be all zero!');
end
for j = 1 : 4
  isSame = strcmp(r.uels{j},universe);
  if nnz(isSame - 1) > 0
   error('bad r.uels{j}', j);
  end
end

d4 = cell(1,4);
d4{1} = {'1','0'};
d4{2} = {'zero','one'};
d4{3} = {'null', 'eins'};
d4{4} = {'aught', 'unity'};
rFlags.uels = d4;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps4')
  error('expected name = "ps4"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([16,4] - size(r.val)) ~= 0
  error('expected size(r.val) to be [16,4]');
end
if nnz(r.val - tt - 1) ~= 0
  error('bad r.val: not as expected');
end

% now read ps4 compressed
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'ps4')
  error('expected name = "ps4"');
end
if 1 ~= strcmp(r.type,'set')
  error('expected type = "set"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([16,4] - size(r.val)) ~= 0
  error('expected size(r.val) to be [16,4]');
end
if nnz(r.val - tt - 1) ~= 0
  error('bad r.val: not as expected');
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% start read tests for parameters
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% read a10, unfiltered and uncompressed
rFlags.name = 'a10';
rFlags = rmfield(rFlags, 'compress');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a10')
  error('expected name = "a10"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1023,11] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1023,11]');
end
if nnz(r.val(1,:) - [1, 5, 7, 9, 11, 11, 11, 11, 11, 13, 1]) ~= 0
  error('bad r.val(1,:): not as expected');
end
if nnz(r.val(1023,:) - [4, 6, 8, 10, 12, 12, 12, 12, 12, 14, 1022]) ~= 0
  error('bad r.val(1,:): not as expected');
end
check = zeros(1023, 1);
for j = 1 : 1023
  check(j) = -r.val(j,11);
  i = (r.val(j,1) - 4)/-3;
  check(j) = check(j) + i ...
    +   2 * (r.val(j,2)-5) ...
    +   4 * (r.val(j,3)-7) ...
    +   8 * (r.val(j,4)-9) ...
    +  16 * (r.val(j,5)-11) ...
    +  32 * (r.val(j,6)-11) ...
    +  64 * (r.val(j,7)-11) ...
    + 128 * (r.val(j,8)-11) ...
    + 256 * (r.val(j,9)-11) ...
    + 512 * (r.val(j,10)-13);
end
if nnz(check) ~= 0
  error('bad check of r.val');
end

% read a10, filtered
rFlags.name = 'a10';
rFlags.uels = domain;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a10')
  error('expected name = "a10"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1023,11] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1023,11]');
end
if nnz(r.val(1,:) - [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]) ~= 0
  error('bad r.val(1,:): not as expected');
end
if nnz(r.val(1023,:) - [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1022]) ~= 0
  error('bad r.val(1,:): not as expected');
end
check = zeros(1023, 1);
for j = 1 : 1023
  check(j) = -r.val(j,11);
  i = (r.val(j,1) - 2)/-1;
  check(j) = check(j) + i ...
    +   2 * (r.val(j,2)-1) ...
    +   4 * (r.val(j,3)-1) ...
    +   8 * (r.val(j,4)-1) ...
    +  16 * (r.val(j,5)-1) ...
    +  32 * (r.val(j,6)-1) ...
    +  64 * (r.val(j,7)-1) ...
    + 128 * (r.val(j,8)-1) ...
    + 256 * (r.val(j,9)-1) ...
    + 512 * (r.val(j,10)-1);
end
if nnz(check) ~= 0
  error('bad check of r.val');
end

% read a10, compressed
rFlags.name = 'a10';
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a10')
  error('expected name = "a10"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1023,11] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1023,11]');
end
if nnz(r.val(1,:) - [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]) ~= 0
  error('bad r.val(1,:): not as expected');
end
if nnz(r.val(1023,:) - [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1022]) ~= 0
  error('bad r.val(1,:): not as expected');
end
check = zeros(1023, 1);
for j = 1 : 1023
  check(j) = -r.val(j,11);
  i = (r.val(j,1) - 2)/-1;
  check(j) = check(j) + i ...
    +   2 * (r.val(j,2)-1) ...
    +   4 * (r.val(j,3)-1) ...
    +   8 * (r.val(j,4)-1) ...
    +  16 * (r.val(j,5)-1) ...
    +  32 * (r.val(j,6)-1) ...
    +  64 * (r.val(j,7)-1) ...
    + 128 * (r.val(j,8)-1) ...
    + 256 * (r.val(j,9)-1) ...
    + 512 * (r.val(j,10)-1);
end
if nnz(check) ~= 0
  error('bad check of r.val');
end


% read a4, unfiltered and uncompressed
rFlags.name = 'a4';
rFlags = rmfield(rFlags, 'compress');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a4')
  error('expected name = "a4"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([15,5] - size(r.val)) ~= 0
  error('expected size(r.val) to be [15,5]');
end
if nnz(r.val(1,:) - [1, 5, 7, 9, 1]) ~= 0
  error('bad r.val(1,:): not as expected');
end
if nnz(r.val(15,:) - [4, 6, 8, 10, 14]) ~= 0
  error('bad r.val(1,:): not as expected');
end
check = zeros(15, 1);
for j = 1 : 15
  check(j) = -r.val(j,5);
  i = (r.val(j,1) - 4)/-3;
  check(j) = check(j) + i ...
    +   2 * (r.val(j,2)-5) ...
    +   4 * (r.val(j,3)-7) ...
    +   8 * (r.val(j,4)-9);
end
if nnz(check) ~= 0
  error('bad check of r.val');
end

% read a4, filtered
rFlags.name = 'a4';
rFlags.uels = d4;
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a4')
  error('expected name = "a4"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([15,5] - size(r.val)) ~= 0
  error('expected size(r.val) to be [15,5]');
end
if nnz(r.val(1,:) - [1, 1, 1, 1, 1]) ~= 0
  error('bad r.val(1,:): not as expected');
end
if nnz(r.val(15,:) - [2, 2, 2, 2, 14]) ~= 0
  error('bad r.val(1,:): not as expected');
end
check = zeros(15, 1);
for j = 1 : 15
  check(j) = -r.val(j,5);
  i = (r.val(j,1) - 2)/-1;
  check(j) = check(j) + i ...
    +   2 * (r.val(j,2)-1) ...
    +   4 * (r.val(j,3)-1) ...
    +   8 * (r.val(j,4)-1);
end
if nnz(check) ~= 0
  error('bad check of r.val');
end

% read a4, compressed
rFlags.name = 'a4';
rFlags = rmfield(rFlags, 'uels');
rFlags.compress = 'true';
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'a4')
  error('expected name = "a4"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([15,5] - size(r.val)) ~= 0
  error('expected size(r.val) to be [15,5]');
end
if nnz(r.val(1,:) - [1, 1, 1, 1, 1]) ~= 0
  error('bad r.val(1,:): not as expected');
end
if nnz(r.val(15,:) - [2, 2, 2, 2, 14]) ~= 0
  error('bad r.val(1,:): not as expected');
end
check = zeros(15, 1);
for j = 1 : 15
  check(j) = -r.val(j,5);
  i = (r.val(j,1) - 2)/-1;
  check(j) = check(j) + i ...
    +   2 * (r.val(j,2)-1) ...
    +   4 * (r.val(j,3)-1) ...
    +   8 * (r.val(j,4)-1);
end
if nnz(check) ~= 0
  error('bad check of r.val');
end


% read atiny, unfiltered and uncompressed
rFlags.name = 'atiny';
rFlags = rmfield(rFlags, 'compress');
r = rgdx ('readbig.gdx', rFlags);
if 1 ~= strcmp(r.name,'atiny')
  error('expected name = "atiny"');
end
if 1 ~= strcmp(r.type,'parameter')
  error('expected type = "parameter"');
end
if 1 ~= strcmp(r.form,'sparse')
  error('expected form = "sparse"');
end
if nnz([1,11] - size(r.val)) ~= 0
  error('expected size(r.val) to be [1,11]');
end
if nnz(r.val(1,:) - [1, 6, 8, 10, 12, 12, 12, 12, 12, 14, 525]) ~= 0
  error('bad r.val(1,:): not as expected');
end

magic.name = 'magic';
magic.type = 'parameter';
magic.val  = 525;
errCount.name = 'errCount';
errCount.type = 'parameter';
errCount.val  = 0;
wgdx (resultfile, magic, errCount);

disp 'ALL SPARSE READ TESTS PASSED';
