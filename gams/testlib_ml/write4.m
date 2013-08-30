% create 1-, 3- and 10-dim parameters and write them to GDX

N = 50;
uels = cell(N,1);
uels(1) = {'delaware'};
for i=2:N-1
    uels(i) = {sprintf('state%02d',i)};
end;
uels(N) = {'hawaii'};

dim1 = [ linspace(1,N,N) ; 4+linspace(1,N,N) ]';
dat3 = zeros(N,N,N);
dat3([1,50],[1,50],[1,50]) = 1;
[i3,i2,i1] = ind2sub(size(dat3),find(dat3>0));
v = (i1-1)*10000 + (i2-1)*100 + (i3-1);
dat3index = [i1,i2,i3,v];
writegdx ('write4a.gdx', ...
          'parameter', 'long_ugly_nameXXXX', dim1, ...
          'parameter', 'dat3', dat3index, ...
          uels);

sindex = ones(2,11);
sindex(2,:) = N;
sindex(1,11) = 1787;
sindex(2,11) = 1959;
writegdx ('write4b.gdx', 'p','statehood',sindex, uels);
