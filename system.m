% MATLAB program for DSB-SC and DSB with carrier analysis

clear all;
close all;

% Parameters
fs = 256e3;           % Sampling frequency (Hz)
t = 0:1/fs:0.001;    % Time vector (1 ms duration)
fm = 4e3;            % Message frequency (4 kHz)
fc = 64e3;           % Carrier frequency (64 kHz)
Am = 1;              % Message amplitude
Ac = 1;              % Carrier amplitude for DSB-SC

% Message signal
m = Am * cos(2*pi*fm*t);

% Carrier signal
c = Ac * cos(2*pi*fc*t);

% Part a) DSB-SC waveform
s_dsbsc = m .* c;    % DSB-SC signal (modulation)

% Frequency domain calculation
N = length(t);
f = (-fs/2:fs/N:fs/2-fs/N);  % Frequency vector
S_dsbsc = fftshift(fft(s_dsbsc)/N);

% Part a) Plots
figure(1);
subplot(2,1,1);
plot(t*1000, s_dsbsc);
title('DSB-SC Signal - Time Domain');
xlabel('Time (ms)'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(f/1000, abs(S_dsbsc));
title('DSB-SC Signal - Frequency Domain');
xlabel('Frequency (kHz)'); ylabel('Magnitude');
xlim([-80 80]);
grid on;

% Part b) DSB with carrier
% Calculate power in sidebands
P_sidebands = mean(s_dsbsc.^2);  % Total power in both sidebands

% Case 1: Carrier power = 50% of sideband power
Ac1 = sqrt(0.5 * P_sidebands * 2);  % Carrier amplitude (P = Ac^2/2)
s_case1 = s_dsbsc + Ac1*c;
S_case1 = fftshift(fft(s_case1)/N);

% Case 2: Carrier power = 3 times sideband power
Ac2 = sqrt(3 * P_sidebands * 2);
s_case2 = s_dsbsc + Ac2*c;
S_case2 = fftshift(fft(s_case2)/N);

% Case 3: Carrier power = 4 times sideband power
Ac3 = sqrt(4 * P_sidebands * 2);
s_case3 = s_dsbsc + Ac3*c;
S_case3 = fftshift(fft(s_case3)/N);

% Part b) Plots
figure(2);
subplot(3,2,1);
plot(t*1000, s_case1);
title('Case 1: P_c = 0.5*P_s - Time');
xlabel('Time (ms)'); ylabel('Amplitude');
grid on;

subplot(3,2,2);
plot(f/1000, abs(S_case1));
title('Case 1: P_c = 0.5*P_s - Freq');
xlabel('Frequency (kHz)'); ylabel('Magnitude');
xlim([-80 80]);
grid on;

subplot(3,2,3);
plot(t*1000, s_case2);
title('Case 2: P_c = 3*P_s - Time');
xlabel('Time (ms)'); ylabel('Amplitude');
grid on;

subplot(3,2,4);
plot(f/1000, abs(S_case2));
title('Case 2: P_c = 3*P_s - Freq');
xlabel('Frequency (kHz)'); ylabel('Magnitude');
xlim([-80 80]);
grid on;

subplot(3,2,5);
plot(t*1000, s_case3);
title('Case 3: P_c = 4*P_s - Time');
xlabel('Time (ms)'); ylabel('Amplitude');
grid on;

subplot(3,2,6);
plot(f/1000, abs(S_case3));
title('Case 3: P_c = 4*P_s - Freq');
xlabel('Frequency (kHz)'); ylabel('Magnitude');
xlim([-80 80]);
grid on;

% Part c) DSB-SC signal multiplied by carrier again (demodulation attempt)
s_demod = s_dsbsc .* c;
S_demod = fftshift(fft(s_demod)/N);

figure(3);
subplot(2,1,1);
plot(t*1000, s_demod);
title('DSB-SC Multiplied by Carrier - Time Domain');
xlabel('Time (ms)'); ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(f/1000, abs(S_demod));
title('DSB-SC Multiplied by Carrier - Frequency Domain');
xlabel('Frequency (kHz)'); ylabel('Magnitude');
xlim([-150 150]);
grid on;
