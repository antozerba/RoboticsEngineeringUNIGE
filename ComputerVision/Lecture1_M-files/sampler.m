t = 0:.1:2*pi; % Times at which to sample the sine function
A=1;
f0=0.5;
sig = A*sin(2*pi*f0*t); % Original signal, a sine wave
figure,plot(t,sig) %its plot
figure,plot(t,sig,'*') %sampled values

%larger sampling period -> aliasing
t = 0:.5:2*pi; % Times at which to sample the sine function
sig = A*sin(2*pi*f0*t); % Original signal, a sine wave
figure,plot(t,sig,'-*') %its plot and sampled values

%even larger sampling period
t = 0:.8:2*pi; % Times at which to sample the sine function
sig = A*sin(2*pi*f0*t); % Original signal, a sine wave
figure,plot(t,sig,'-*') %its plot and sampled values
