%--------------------------------------------------------------------------
% This code is developed by Vivek Kumar Singh, PhD. It is requested to cite
% the paper mentioned below, if you are using this code.
%
% P. Jain and R.B. Pachori, GCI identification from voiced speech using the 
% eigen value decomposition of Hankel matrix, in: 2013 8th International 
% Symposium on Image and Signal Processing and Analysis (ISPA), IEEE, 2013,
% pp. 371–376.
%--------------------------------------------------------------------------

clc
clearvars
close all

%% Synthetic multicomponent signal
Fs = 500;  % Sampling rate of the signal
t = 0:1/Fs:1;   % Sampling instances of the signal
Ni = 4; % Number of components in the signal

N = length(t);
A = [0.93 0.77 0.58 0.2];
f = [10 12 35 55];
phi = [0 pi/3 pi/2 -pi];
sig_comps = zeros(N,Ni);
for i = 1:Ni
    sig_comps(:,i) = A(i)*sin(2*pi*f(i)*t + phi(i));
end
signal = sum(sig_comps,2);
SNR = 5;    % Set SNR = inf for analysis of the clean signal
signal = awgn(signal,SNR);  % Adding SNR dB AWGN to the signal

%% Decomposition of signal using EVDHM method
Ns = 4; % Number of significant eigenvalue pairs to be considered
flag = 1;   % Flag for printing significant eigenvalue pairs
comps = EVDHM(signal,Ns,flag);

%% Plotting signal, signal components, and decomposed components
figure;
subplot(5,1,1)
plot(t,signal,'b','LineWidth',1);
title('Signal')
for i = 1:Ni
    subplot(5,1,i+1)
    plot(t,sig_comps(:,i),'Color',[0.5 0.5 0.5],'LineWidth',1);
    hold on
    plot(t,comps(:,i),'b-.','LineWidth',1);
    if i == 2
        ylabel('Amplitude')
    elseif i == 4
        xlabel('Time (s)')
    end
    ttl = "Signal component " + num2str(i);
    title(ttl)
end
legend('True','Decomposed')
