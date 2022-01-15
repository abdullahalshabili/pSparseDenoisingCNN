%% Demo: Positive sparse signal denoising using CNNs
%
% Reference: 
% 'Positive sparse signal denoising: What does a CNN learn?'
% Abdullah H. Al-Shabili, and Ivan Selesnick
% New York University, Department of Electrical and Computer Engineering
% January 2022

%% Load functions

clc
clear all
close all

addpath('CNNs')
addpath('utils')

myrmse = @(x, xhat) mean((xhat - x).^2); % RMSE function

%% loading CNNs

% Select a CNN
%   CCNN: constrained CNN
%   structure: structure number i
%   paper/supp: where the CNN is mentioned: paper or supplementary material

% CNN_name = 'CNN_structure1_paper.mat';
% CNN_name = 'CNN_structure2_paper.mat';
% CNN_name = 'CNN_structure3_paper.mat';
CNN_name = 'CCNN_structure3_paper.mat';
% CNN_name = 'CCNN_structure1_supp.mat';
% CNN_name = 'CCNN_structure2_supp.mat';

% load the CNN
CNN = load(CNN_name).H;     % load CNN filters
filters_plot(CNN);          % Plot CNN filters

%% Denoising example
rng(0)

% Signal generation
L = 200;                            % signal length
rho = 0.1;                          % sparsity level
sigma_x = 10.0;                     % half-Gaussian standard deviation
x = pos_sparse_signal(L, rho, sigma_x);

sigma_w = 1.0;                      % noise standard deviation
y = x + sigma_w * randn(size(x));   % Noisy signal

% Denoising using CNN
x_hat = Run_CNN(CNN, y);

figure(2)
clf
subplot(2, 1, 1)
stem(x, 'k.')
title('Clean signal')
subplot(2, 1, 2)
stem(y, 'b.')
title(sprintf('Noisy signal. RSME = %.3f; SNR = %.3f dB', myrmse(x, y), SNR(y, x)))
print -dpdf figures/Noisy

figure(3)
clf
subplot(2, 1, 1)
stem(y, 'k.')
title('Noisy signal')
subplot(2, 1, 2)
stem(x_hat, 'b.')
title(sprintf('Denoised Signal. RSME = %.3f; SNR = %.2f dB',...
        myrmse(x, x_hat), SNR(x_hat, x)))
print -dpdf figures/Denoising
