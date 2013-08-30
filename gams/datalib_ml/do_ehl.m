alpha = struct('lbs100',2.832,'lbs175',3.746,'lbs250',4.477);
lambda = struct(...
	'rpm500',struct('lbs100',6.057,'lbs175',1.978,'lbs250',0.9692),...
	'rpm2500',struct('lbs100',30.29,'lbs175',9.889,'lbs250',4.846),...
	'rpm5000',struct('lbs100',60.57,'lbs175',19.78,'lbs250',9.692));

close all hidden
k = seepress(alpha.lbs100,lambda.rpm500.lbs100);
close all hidden
k = seepress(alpha.lbs175,lambda.rpm2500.lbs175);
close all hidden
k = seepress(alpha.lbs250,lambda.rpm5000.lbs250);
