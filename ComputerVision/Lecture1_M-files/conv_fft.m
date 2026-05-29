% ==========================
% SIGNAL
% ==========================

w = 101;                     % Lunghezza del segnale (numero di campioni)
a = zeros(1,w);               % Inizializza un vettore di zeri di lunghezza w
a(ceil(w/2)+(-5:5)) = 1;     % Crea un "impulso rettangolare" centrato:
                              % 11 valori consecutivi (da -5 a +5) a 1, nel centro del vettore
figure, plot(a), axis([1,w,-1,2])  
                              % Visualizza il segnale a come grafico 2D
                              % 'axis' imposta i limiti: X da 1 a w, Y da -1 a 2

b = a;                        % Copia del segnale a in b (usata per convoluzione)

% ==========================
% CONVOLUTION
% ==========================

c = conv(a,b);                % Convoluzione del segnale a con b
c = c(ceil(length(c)/2) + (-floor(w/2):floor(w/2)));  
                              % Taglia il risultato della convoluzione per mantenerlo della stessa lunghezza di w
                              % 'ceil(length(c)/2)' centra il risultato
figure, plot(c), axis([1,w,-1,12])  
                              % Visualizza il segnale convoluto c
                              % Limiti Y più alti per vedere l'amplificazione

% ==========================
% FFT
% ==========================

A = fftshift(fft(a));         % Trasforma il segnale a nel dominio della frequenza (FFT)
                              % fftshift centra lo zero della frequenza al centro del vettore
B = fftshift(fft(b));         % Stessa cosa per il segnale b

% ==========================
% COMPARISON
% ==========================

figure, plot(abs(A)), axis([1,w,-1,12])  
                              % Visualizza lo spettro in ampiezza di A (modulo della FFT di a)

figure, plot(abs(A.*B)), axis([1,w,-1,140])  
                              % Visualizza la moltiplicazione degli spettri A*B
                              % Teoricamente corrisponde alla FFT della convoluzione nel dominio del tempo

hold on  
plot(abs(fftshift(fft(c))),'r--'), axis([1,w,-1,140])  
                              % Sovrappone la FFT del segnale convoluto c (in rosso tratteggiato)
                              % Serve a confrontare la convoluzione nel tempo con la moltiplicazione nello spettro
