% create a 1-dim set and write it to GDX

N = 4;
I = [ linspace(1,N,N) ]';
writegdx ('ex1.gdx','set','I',I);

uels = cell(N,1);
uels(1) = {'one'};
uels(2) = {'two'};
uels(3) = {'three'};
uels(4) = {'four'};
writegdx ('ex1_lab.gdx','set','I',I,uels);
