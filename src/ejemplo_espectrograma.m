% Ejemplo de espectrograma en Matlab
% 
% Seniales y Sistemas - Curso 1 - FIUBA
% 
% Se recomienda ver el help de la funcion ejecutando 
%     help spectrogram

clc,clear all

% Generate a test signal, a 2 Vrms sine wave whose frequency is slowly modulated 
% around 3kHz, corrupted by white noise of exponentially decreasing magnitude 
% sampled at 10 kHz.
fs = 10e3;
N = 1e5;
amp = 2*sqrt(2);
noise_power = 0.01*fs/2;
time = (0:N-1)/fs;
mod = 1000*cos(2*pi*0.25*time); % moduladora (se suma en el argumento de carrier)
carrier = amp * sin(2*pi*3e3*time + mod);
noise = randn(size(time))*sqrt(noise_power);
noise = noise.*exp(-time/5);
x = carrier + 0*noise;

% Compute and plot the spectrogram
window = tukeywin(256); % ventana de Tukey de 256 muestras
figure
spectrogram(x, window, [], [], fs, 'yaxis')

%% Ploteo en tiempo y frecuencia de la ventana utilizada
plot(window)
title('Tukey window')
ylabel('Amplitude')
xlabel('Sample')
ylim([0, 1.1])

figure
A = fft(window,2048)/(length(window)/2.0);  % fft de 2048 puntos
freq = linspace(-0.5, 0.5, length(A));
response = 20*log10(abs(fftshift(A./max(abs(A)))));
plot(freq,response)
axis([-0.5, 0.5, -120, 0])
title('Frequency response of the Tukey window')
ylabel('Normalized magnitude [dB]')
xlabel('Normalized frequency [cycles per sample]');