% write one dimensional set first with uels and then without uels

s1.name = 'iWithUels';
s1.type = 'set';
s1.val = [1; 2; 3];
s1.form = 'sparse';
s1.uels = {'i1', 'i2', 'i3'};

s2 = s1;
s2.name = 'iWoUels';
s2 = rmfield(s2, 'uels');

wgdx('writeset', s1, s2);
