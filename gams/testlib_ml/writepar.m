% write a two-dimensional parameter

s2.name = 'test2';
s2.type = 'parameter';
s2.val = [1 2 5; 2 1 4; 2 2 6; 3 1 5; 3 2 7; 4 1 6; 4 2 8];
s2.uels = {{'1', '2', '3', '4'},{'j1', 'j2'}};
s2.form = 'sparse';

wgdx('writepar', s2);
