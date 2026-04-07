clc; clear; close all;
%% CEMIL KIVANÇ CANKURT-24 December 2025
%% PARAMETERS
fs = 1000;          % Sampling frequency (Hz)
N = 1000;           % Number of samples
t = (0:N-1)/fs;     % Time vector

%% =========================
%% PART 1: DFT BIN MATCHING
%% =========================

f1 = 50;    % exact bin
f2 = 50.5;  % leakage case

x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);

X1 = fft(x1);
X2 = fft(x2);

f = (0:N-1)*(fs/N);

figure('Name','PART 1 - Leakage')

subplot(2,1,1)
stem(f, abs(X1)/N, 'filled')
xlim([0 150])
title('f = 50 Hz (Leakage yok)')
xlabel('Frekans (Hz)')
ylabel('|X(f)|')
grid on

subplot(2,1,2)
stem(f, abs(X2)/N, 'filled')
xlim([0 150])
title('f = 50.5 Hz (Leakage var)')
xlabel('Frekans (Hz)')
ylabel('|X(f)|')
grid on


%% =========================
%% PART 2: WINDOW EFFECT
%% =========================

T = 1;
t = 0:1/fs:T-1/fs;
f0 = 47; % leakage case

x = sin(2*pi*f0*t);

% Window functions
w_rect = ones(length(x),1);
w_hann = hann(length(x));
w_hamm = hamming(length(x));
w_black = blackman(length(x));

windows = {w_rect, w_hann, w_hamm, w_black};
w_names = {'Rectangular','Hann','Hamming','Blackman'};

N = length(x);
Nfft = 8*N; % zero padding
f_fft = (0:Nfft/2-1)*(fs/Nfft);

figure('Name','PART 2 - Window Effects')

for k = 1:length(windows)

    w = windows{k};
    xw = x(:).*w;

    % Gain correction
    U = sum(w)/N;

    % FFT
    Xw = fft(xw, Nfft)/N;
    Xw = Xw(1:Nfft/2);

    % Magnitude
    mag = abs(Xw)/U;
    mag_db = 20*log10(mag + eps);

    % Linear plot
    subplot(4,2,2*(k-1)+1)
    plot(f_fft, mag, 'LineWidth',1)
    xlim([0 200])
    grid on
    title([w_names{k} ' - Linear'])
    xlabel('Frekans (Hz)')
    ylabel('|X(f)|')

    % dB plot
    subplot(4,2,2*(k-1)+2)
    plot(f_fft, mag_db, 'LineWidth',1)
    xlim([f0-100 f0+100])
    ylim([-120 10])
    grid on
    title([w_names{k} ' - dB'])
    xlabel('Frekans (Hz)')
    ylabel('|X(f)| (dB)')

end


%% =========================
%% PART 3: WINDOW COMPARISON
%% =========================

figure('Name','PART 3 - Window Comparison')
hold on
grid on

for k = 1:length(windows)

    w = windows{k};
    xw = x(:).*w;

    U = sum(w)/N;

    Xw = fft(xw, Nfft)/N;
    Xw = Xw(1:Nfft/2);

    mag_db = 20*log10(abs(Xw)/U + eps);

    plot(f_fft, mag_db, 'LineWidth',1.2, 'DisplayName', w_names{k})

end

xlim([f0-60 f0+60])
ylim([-120 10])

xlabel('Frekans (Hz)')
ylabel('Magnitude (dB)')
title('Window Fonksiyonlarının Leakage Durumunda Davranışı')

legend('Location','best')
hold off