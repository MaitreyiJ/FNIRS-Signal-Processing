load 079JJ_rest+deep_breathing+hutt.nirs -mat

ch4=d(:,4);%data from channel 4 is the long distance channel which we are filtering  
ch5=d(:,5);%data from the channel 5 is another long distance channel, but we are currently not filtering that,if this algorithm is succesful,we will filter this channel too.
ch6=d(:,6);%this is the short distance channel which needs to be removed from the long distance channel
%plot of the raw data without any processing .
plot(t,ch4,'g');
hold on;
plot(t,ch5,'r');
plot(t,ch6,'m');
legend('desired long distance channel 2-2 ','desired long distance channel 2-3','short distance channel 2-4 ');
title('Raw data');
xlabel('time');
ylabel('intensity');

%the processing of the data starts here 
%the LMS Filter
noise=ch6;%noise is the short distance channel
desired = ch4;%signal from the long distance channel
noise=noise-mean(noise);
desired=desired-mean(desired);
%experimenting with different ordersof the filter 
coeffs1=0.01*rand(2,1);
coeffs2=0.01*rand(4,1);
coeffs3=0.01*rand(8,1);
coeffs4=0.01*rand(10,1);
% Set the step size for algorithm updating.
mu1=0.02;
mu2=0.08; 
mu3=1;
mu4=1.2;

%filtering the short distance from the long distance 
lms1 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs1);%filter order2 step size 0.02
[y1,e1] = lms1(noise,desired);

lms2 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs1);%filter order2 step size 0.08
[y2,e2] = lms2(noise,desired);

lms3 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs1);%filterorder2 step size 1
[y3,e3] = lms3(noise,desired);

lms4 = dsp.LMSFilter(2,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs1);%filterorder2 step size 1.2
[y4,e4] = lms4(noise,desired);

lms5 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs2);%filter order 4 step size 0.02
[y5,e5] = lms5(noise,desired);
lms6 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs2);%filter order 4 stepsize 0.08
[y6,e6] = lms6(noise,desired);
lms7 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs2);%filter order 4 stepsize 1
[y7,e7] = lms7(noise,desired);
lms8 = dsp.LMSFilter(4,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs2);%filter order 4 step size 1.2
[y8,e8] = lms8(noise,desired);

lms9 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs3);%filter order8  step size 0.02
[y9,e9] = lms9(noise,desired);
lms10 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs3);%filter order8 stepsize 0.08
[y10,e10] = lms10(noise,desired);
lms11 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs3);%filter order8 stepsize 1
[y11,e11] = lms11(noise,desired);
lms12 = dsp.LMSFilter(8,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs3);%filter order 8 step size 1.2
[y12,e12] = lms12(noise,desired);

lms13 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu1,'InitialConditions',coeffs4);%filter order10  step size 0.02
[y13,e13] = lms9(noise,desired);
lms14 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu2,'InitialConditions',coeffs4);%filter order10 stepsize 0.08
[y14,e14] = lms10(noise,desired);
lms15 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu3,'InitialConditions',coeffs4);%filter order10 stepsize 1
[y15,e15] = lms11(noise,desired);
lms16 = dsp.LMSFilter(10,'Method','Sign-Data LMS',...
   'StepSize',mu4,'InitialConditions',coeffs4);%filter order 10 step size 1.2
[y16,e16] = lms12(noise,desired);


%plotting the data 

grid on ;
%order2 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e1);%desired represents the long distance channel(raw data) and e1 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafrom long distance channel','filtered data-order2 step size 0.02');
grid on ;

subplot(2,2,2)
plot(t,desired,t,e2);%desired represents the long distance channel(raw data) and e2 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafrom  long distance channel','filtered data-order2 step size 0.08');
grid on ;

subplot(2,2,3)
plot(t,desired,t,e3);%desired represents the long distance channel(raw data) and e3 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdata fromlong distance  channel','filtered dataorder2 step size 1');
grid on ;

subplot(2,2,4)
plot(t,desired,t,e4);%desired represents the long distance channel(raw data) and e4 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('raw data from long distance channel','filtered dataorder2 step size 1.2');
grid on ;

%order8 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e5);%desired represents the long distance channel(raw data) and e5 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafrom  long distance channel','filtered data order4 step size 0.02');
grid on ;

subplot(2,2,2)
plot(t,desired,t,e6);%desired represents the long distance channel(raw data) and e6 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafrom long distance channel','filtered data order4 step size 0.08');
grid on ;

subplot(2,2,3)
plot(t,desired,t,e7);%desired represents the long distance channel(raw data) and e7 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdata from  long distance channel','filtered dataorder4 step size 1');
grid on ;

subplot(2,2,4)
plot(t,desired,t,e8);%desired represents the long distance channel(raw data) and e8 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('raw data from long distance channel','filtered dataorder4 step size 1.2');
grid on ;

%order 12 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e9);%desired represents the long distance channel(raw data) and e9 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafrom long distance channel','filtered data order8 step size 0.02');
grid on ;

subplot(2,2,2)
plot(t,desired,t,e10);%desired represents the long distance channel(raw data) and e10 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafromlongdustance  channel','filtereddataorder8 step size 0.08');
grid on ;

subplot(2,2,3)
plot(t,desired,t,e11);%desired represents the long distance channel(raw data) and e11 represents the processed data with the short distance filtered away.
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdata from long distance channel','filtered dataorder8 step size 1');
grid on ;

subplot(2,2,4)
plot(t,desired,t,e12);%desired represents the long distance channel(raw data) and e12 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('raw data from long distance channel','filtered dataorder8 step size 1.2');
grid on ;

%order 14 plots
figure;
subplot(2,2,1)
plot(t,desired,t,e13);%desired represents the long distance channel(raw data) and e13 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafrom long distance channel','filtered dataorder10 step size 0.02');
grid on ;

subplot(2,2,2)
plot(t,desired,t,e14);%desired represents the long distance channel(raw data) and e14 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdatafrom long distancechannel','filterd dataorder10 step size 0.08');
grid on ;

subplot(2,2,3)
plot(t,desired,t,e15);%desired represents the long distance channel(raw data) and e15 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('rawdata from long distancechannel','filtered dataorder10 step size 1');
grid on ;

subplot(2,2,4)
plot(t,desired,t,e16);%desired represents the long distance channel(raw data) and e16 represents the processed data with the short distance filtered away
title('The filtered output ');
xlabel('time');
ylabel('intensity');
legend('raw data from longdistance channel','filtered dataorder10 step size 1.2');























