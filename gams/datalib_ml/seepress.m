function k = seepress(alpha,lambda)
gamso.output = 'std';
gamso.form = 'full';
gamso.compress = 'true';
gamso.input = 'exec';
alp = struct();
alp.name = 'alpha';
alp.val = alpha;
alp.form = 'full';
alp.dim = 0;

lm = struct();
lm.name = 'lambda';
lm.val = lambda;
lm.form = 'full';
lm.dim = 0;

[pressure,gap,k,xa,delx] = gams('ehl_kost', alp, lm);

figure(1)
plot (xa + delx*[0:length(pressure)], [0; pressure])
title('lubricant pressure')

figure(2)
plot (xa + delx*([1:length(gap)]-0.5), gap)
title('lubricant thickness')
hold on;
plot (0,0);
hold off;
pause,
return;
