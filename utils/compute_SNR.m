function [sigma_w, SNR_y, SNR_x_mmse,...
    SNR_xCNN1, SNR_xCNN2] = compute_SNR(L, rho, sigma_x, CNN_1, CNN_2)
%
% INPUT
%   N : length of signal
%   rho : sparsity level ( 0 < rho < 1 )
%   sigma_x : signal standard deviation (scalar)
%   CNN_1 : CNN denoiser number 1
%   CNN_2 : CNN denoiser number 2
% 
% OUTPUT
%   sigma_w : noise standard deviations
%   SNR_y : SNR of the noisy signal
%   SNR_x_mmse: SNR of the MMSE
%   SNR_xCNN1: SNR of the CNN denoiser number 1
%   SNR_xCNN2: SNR of the CNN denoiser number 2
%
% Notes
%  rho = 0.1 means that 10% of the signal is non-zero

%% Set parameters

Nr = 500;     % Number of realizations

min_sigma_w = 0.1;  % min noise std range
max_sigma_w = 2.0;  % max noise std range
num_sigmas_w = 20;  % number of noise std points in the range

%% Initialization

sigma_w = logspace(log10(min_sigma_w), log10(max_sigma_w), num_sigmas_w);

SNR_y_vals = nan(num_sigmas_w, Nr);
SNR_x_mmse_vals = nan(num_sigmas_w, Nr);
SNR1_x_hat_vals = nan(num_sigmas_w, Nr);
SNR2_x_hat_vals = nan(num_sigmas_w, Nr);

%% Computation

for i = 1:num_sigmas_w
    % loop over noise levels
    fprintf('progress = %0.0f/100 \n', i/num_sigmas_w*100);

    for j = 1:Nr
        % loop over realizations

        x = pos_sparse_signal(L, rho, sigma_x);
        y = x + sigma_w(i) * randn(L, 1);
        
        % signal estimation using denosing methods
        x_MMSE = MMSE_est(y, rho, sigma_x, sigma_w(i));
        x_hat_1 = CNN_1(y);
        x_hat_2 = CNN_2(y);
        
        SNR_y_vals(i, j) = SNR(y, x);
        SNR_x_mmse_vals(i, j) = SNR(x_MMSE, x);
        SNR1_x_hat_vals(i, j) = SNR(x_hat_1, x);
        SNR2_x_hat_vals(i, j) = SNR(x_hat_2, x);
        
    end
end

%% Average across realizations
SNR_y = mean(SNR_y_vals, [2]);
SNR_x_mmse = mean(SNR_x_mmse_vals, [2]);
SNR_xCNN1 = mean(SNR1_x_hat_vals, [2]);
SNR_xCNN2 = mean(SNR2_x_hat_vals, [2]);

