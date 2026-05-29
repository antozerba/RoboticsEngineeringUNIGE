clc
clear
close all

A = [1,0;0,2];
times = 0:0.1:1;

%% Symbolic functions
syms t real
f(t) = A * [t.^2;sin(t)];
fvalue = f(times);
fvalue_eval = [eval(fvalue{1})', eval(fvalue{2})'];
figure
plot(times,fvalue_eval)
xlabel('t')
ylabel('f(t)')
legend('f1','f2')

%% Derivatives
Dsin = diff(sin(t));

%% Integrals
primsin = int(sin(t), t);
isin = eval(int(sin(t), t, 0, pi/2));