load 079JJ_rest+deep_breathing+hutt.nirs -mat
%loading of NIRS Data from file.
%data from right hemisphere
ch7=d(:,7);%data from short-distance channel 3-1
ch9=d(:,9);%data from long-distance channel 3-3
figure,plot(t,ch9,'g');
hold on;
plot(t,ch7,'r');
legend('desired long distance channel 1-1 ','short distance channel 1-3 ');
title('Raw data-Intensity');
xlabel('time');
ylabel('intensity');

%pre processing steps
dod = hmrIntensity2OD( d );%conversion to optical density.
SD = enPruneChannels(d,SD,ones(size(t)),[0  100000000],5,[0  45],0);%prunning channels 
[tIncAuto,tIncChAuto] = hmrMotionArtifactByChannel(dod,t,SD,ones(size(t)),1,1,10,100);%motion artifact detection 
p=0.99; 
dodSpline = hmrMotionCorrectSpline(dod, t, SD, tIncChAuto, p);%Spline Interpolation.
%obtaining the optical density data after pre processing
chdod9=dodSpline(:,9);
%the LMS Filter
noise=chdod7;
desired=chdod9;
%experimenting with different ordersof the filter 
coeffs1=0.01*rand(2,1);
coeffs2=0.01*rand(4,1);
coeffs3=0.01*rand(8,1);
coeffs4=0.01*rand(10,1);
% Set the step size for algorithm updating.
mu1=0.01;
mu2=0.02; 
mu3=0.04;
mu4=0.08;
%filtering the short distance from the long distance 
lms1 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs1);%filter order2 step size 0.02
e1 =step (lms1,noise,desired);
lms2 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs1);%filter order2 step size 0.08
e2 =step (lms2,noise,desired);
lms3 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs1);%filterorder2 step size 1
e3 =step (lms3,noise,desired);
lms4 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs1);%filterorder2 step size 1.2
e4 =step (lms4,noise,desired);
lms5 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs2);%filter order 4 step size 0.02
e5 =step (lms5,noise,desired);
lms6 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs2);%filter order 4 stepsize 0.08
e6 =step (lms6,noise,desired);
lms7 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs2);%filter order 4 stepsize 1
e7 =step (lms7,noise,desired);
lms8 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs2);%filter order 4 step size 1.2
e8 =step (lms8,noise,desired);
lms9 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs3);%filter order8  step size 0.02
e9 =step (lms9,noise,desired);
lms10 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs3);%filter order8 stepsize 0.08
e10 =step (lms10,noise,desired);
lms11 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs3);%filter order8 stepsize 1
e11 =step (lms11,noise,desired);
lms12 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs3);%filter order 8 step size 1.2
e12 =step (lms12,noise,desired);
lms13 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs4);%filter order10  step size 0.02
e13 =step (lms13,noise,desired);
lms14 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs4);%filter order10 stepsize 0.08
e14 =step (lms14,noise,desired);
lms15 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs4);%filter order10 stepsize 1
e15 =step (lms15,noise,desired);
lms16 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs4);%filter order 10 step size 1.2
e16 =step (lms16,noise,desired);

%plotting the data
grid on ;
%order2 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e1);%desired represents the long distance channel(raw data) and e1 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('OD');
legend('longdistancechannel','order2step size0.02');
grid on ;
subplot(2,2,2)
plot(t,desired,t,e2);%desired represents the long distance channel(raw data) and e2 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order2stepsize0.08');
grid on ;
subplot(2,2,3)
plot(t,desired,t,e3);%desired represents the long distance channel(raw data) and e3 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('OD');
legend('longdistancechannel','filtereddataorder2stepsize1');
grid on ;
subplot(2,2,4)
plot(t,desired,t,e4);%desired represents the long distance channel(raw data) and e4 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('OD');
legend('longdistancechannel','order2stepsize1.2');
grid on ;
%order8 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e5);%desired represents the long distance channel(raw data) and e5 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order4stepsize0.02');
grid on ;
subplot(2,2,2)
plot(t,desired,t,e6);%desired represents the long distance channel(raw data) and e6 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order4stepsize0.08');
grid on ;
subplot(2,2,3)
plot(t,desired,t,e7);%desired represents the long distance channel(raw data) and e7 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order4stepsize1');
grid on ;
subplot(2,2,4)
plot(t,desired,t,e8);%desired represents the long distance channel(raw data) and e8 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order4stepsize1.2');
grid on ;
%order 12 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e9);%desired represents the long distance channel(raw data) and e9 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('long distance channel','order8 step size 0.02');
grid on ;
subplot(2,2,2)
plot(t,desired,t,e10);%desired represents the long distance channel(raw data) and e10 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order8stepsize0.08');
grid on ;
subplot(2,2,3)
plot(t,desired,t,e11);%desired represents the long distance channel(raw data) and e11 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order8stepsize1');
grid on ;
subplot(2,2,4)
plot(t,desired,t,e12);%desired represents the long distance channel(raw data) and e12 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order8stepsize1.2');
grid on ;
%order 14 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e13);%desired represents the long distance channel(raw data) and e13 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order10stepsize0.02');
grid on ;
subplot(2,2,2)
plot(t,desired,t,e14);%desired represents the long distance channel(raw data) and e14 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order10stepsize0.08');
grid on ;
subplot(2,2,3)
plot(t,desired,t,e15);%desired represents the long distance channel(raw data) and e15 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order10stepsize1');
grid on ;
subplot(2,2,4)
plot(t,desired,t,e16);%desired represents the long distance channel(raw data) and e16 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('od');
legend('longdistancechannel','order10 step size 1.2');


%after processing   Band Pass filter 

filteredData = hmrBandpassFilt(e15,t,0.01,2);%e15 is the output of the adaptive filter

%overwriting the processed output in the second channel of dodSpline
dodSpline( :,9)=filterdData;
%converting to concentration stored in variable dc ,after processing.
dc=hmrOD2Conc(dodSpline,SD,[6 6]);
%concentration before any processing stored in variable dcOld
dcOLD = hmrOD2Conc( dod, SD,[6 6] );
%extracting the concentration data from channel 5,after processing
dc9=dc( :,9);
figure,plot(dc9);%ploting concentration data from channel 5 after processing.
%Extracting old concentration data from channel 5 before processing
dcCH9ONLY=dcOLD( :,9);
hold on;
%plotting concentration data from channel5 after processing 
plot(dcCH9ONLY);
legend('afterprocessingconc','beforeprocessingconc');
title('Concentration data');
%plotting the optical density data before and after processing
dod9Old=dod( :,9);
dod9New=filteredData;
figure,plot(t,dod9Old);
hold on 
plot(t,dod9New);
legend('OD before processing','OD after processing');
xlabel('time');
ylabel('Optical Density ');
title('Optical Density');




