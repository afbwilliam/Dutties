% read2.m
% This test reads some sets from the GDX file ex2.gdx and verifies
% that they are read as expected
% See the file genr2.gms for the expected content
%
% In this simple test, we don't use the utilities full2sp or sp2full
% to convert the GDX input/output - that's for a seperate test

resultfile='read2_result.gdx';
if exist(resultfile,'file') delete(resultfile) ; end

i_index = [1 ; 2 ];
i_      = [1 ; 1 ];
iindex = readgdx('ex2.gdx', 'i');
if norm(i_index-iindex) > 0
  error('bad output for i from readgdx');
end
i(iindex,1) = 1;
if norm(i_-i) > 0
  error('bad output for i from readgdx');
end

k_index = [3 ; 4 ];
k_      = [0; 0; 1 ; 1 ];
kindex = readgdx('ex2.gdx', 'k');
if norm(k_index-kindex) > 0
  error('bad output for k from readgdx');
end
k(kindex,1) = 1;
if norm(k_-k) > 0
  error('bad output for k from readgdx');
end

emptee_index = zeros(0,3);
empteeindex = readgdx('ex2.gdx', 'emptee');
if norm(emptee_index-empteeindex) > 0
  error('bad output for emptee from readgdx');
end
% not clear how to interpret an empty index space
% but this must be addressed

iiiii_      = ones(2,2,2,2,2);
[i1,i2,i3,i4,i5] = ind2sub(size(iiiii_),find(iiiii_>0));
% do this in reverse order because
% Matlab stores matrices columnwise (left-most index moves fastest)
% but GAMS stores matrices rowwise (right-most index moves fastest)
iiiii_index = [i5,i4,i3,i2,i1];
iiiiiindex = readgdx('ex2.gdx', 'iiiii');
if norm(iiiii_index-iiiiiindex) > 0
  error('bad output for iiiii from readgdx - bad index');
end

% skip converting the index info from readgdx into the matrix iiiii,
% this is really the job of sp2full

% index space of I union K is 1..4
kikikikiki_ = zeros(4,4,4,4,4,4,4,4,4,4);
% construct kikikikiki_ in reverse or transposed order - see comment
% above about rowwise vs. columnwise storage
kikikikiki_([3:4],[1:2],[3:4],[1:2],[3:4],[1:2],[3:4],[1:2],[3:4],[1:2]) = 1;
[k5,i5,k4,i4,k3,i3,k2,i2,k1,i1] = ...
   ind2sub(size(kikikikiki_),find(kikikikiki_>0));
ikikikikik_index = [i1,k1,i2,k2,i3,k3,i4,k4,i5,k5];
ikikikikikindex = readgdx('ex2.gdx', 'ikikikikik');
if norm(ikikikikik_index-ikikikikikindex) > 0
  error('bad output for ikikikikik from readgdx - bad index info');
end

magic = 525;
errCount = 0;
writegdx (resultfile, ...
          'parameter','magic',magic, ...
          'parameter','errCount',errCount);
