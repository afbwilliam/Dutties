% create 1-, 3- and 10-dim sets and write them to GDX

N = 50;
I = [ linspace(1,N,N) ]';
dim3 = zeros(N,N,N);
dim3([1,50],[1,50],[1,50]) = 1;
[i3,i2,i1] = ind2sub(size(dim3),find(dim3>0));
dim3index = [i1,i2,i3];
writegdx ('write2a.gdx', 'set','I',I, 'set','dim3',dim3index);

N = 3;
sindex = ones(2,10);
sindex(2,:) = N;
uels = cell(N,1);
uels(1) = {'first'};
% N.B.: we must include something for each cell, not just the ones
% associated with data.
uels(2) = {'not_used'};
uels(N) = {'last'};
writegdx ('write2b.gdx', 'set','s',sindex, uels);
