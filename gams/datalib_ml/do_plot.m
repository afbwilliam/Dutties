gamso.output = 'std';
gamso.form = 'full';
gamso.compress = true;
[a,xlabels,legendset,titlestr] = gams('simple');
figure(1)

% Plot out the four lines contained in a; format using the third argument
plot(a,'+-');

% only put labels on x axis at 5 year intervals
xtick = 1:5:length(xlabels{1});
xlabels{1} = xlabels{1}(xtick);
set(gca,'XTick',xtick);
set(gca,'XTickLabel',xlabels{1});

% Add title, labels to axes
title(titlestr{1});
xlabel('Year -- time step annual');
ylabel('Value');

% Add a legend, letting MATLAB choose positioning
legend(legendset{1},0);

% match axes to data, add grid lines to plot
axis tight
grid

