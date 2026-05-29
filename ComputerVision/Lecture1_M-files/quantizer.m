t = [0:.1:2*pi]; % Times at which to sample the sine function
A=3;
sig = A*sin(t); % Original signal, a sine wave
figure,plot(t,sig,'*') %sampled values
partition = A*(-1:2/(11-1):1); % Length 11, to represent 12 intervals
codebook = A*(-1.2:2.4/11:1.2); % Length 12, one entry for each interval
[index,quants] = quantiz(sig,partition,codebook); % Quantize.
figure
plot(t,sig,'-',t,quants,'r-')
legend('Original signal','Quantized signal');
%axis([-.2 7 -1.2 1.2])