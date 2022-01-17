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

CNN1_name = 'CNN_structure3_paper.mat';
CNN2_name = 'CCNN_structure3_paper.mat';

% load the CNN
CNN1 = load(CNN1_name).H;
CNN2 = load(CNN2_name).H;

% Plot CNN filters
filters_plot(CNN1);
filters_plot(CNN2);

%% Denoising example
rng(0)

% Signal generation
L = 300;        % signal length
rho = 0.1;      % sparsity level
sigma_x = 10.0;	% half-Gaussian standard deviation

% CNN denoisers
fun_CNN1 = @(y) Run_CNN(CNN1, y);
fun_CNN2 = @(y) Run_CNN(CNN2, y);

% SNR computation
[sigma_w_, SNR_y, SNR_x_mmse, SNR_xCNN1, SNR_xCNN2] = compute_SNR(L, rho, sigma_x, fun_CNN1, fun_CNN2);

% plotting
figure(3)
semilogx(sigma_w_, SNR_x_mmse, 'r.-');
hold on;
semilogx(sigma_w_, SNR_xCNN2, 'm.-');
semilogx(sigma_w_, SNR_xCNN1, 'b.-');
semilogx(sigma_w_, SNR_y, 'k--');
fill([0.5, 0.5, 1.5, 1.5], [0, 40, 40, 0], 'blue', 'FaceAlpha', 0.1, 'LineStyle','none');
hold off;
legend('MMSE', 'CCNN', 'CNN', 'Noisy');
xlabel('\sigma_w')
ylabel('SNR')
set(gca, 'xtick', [0.1 0.2 0.5 1 1.5 2.0 4])
xlim([min(sigma_w_) max(sigma_w_)])

% print -dpdf -bestfit figures/SNR_plot_CNN
