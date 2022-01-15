function x = pos_sparse_signal(N, rho, sigma_x)
% x = pos_sparse_signal(L, rho, sigma_x)
% Generates a postive sparse signal following a Bernoulli-Half
% Gaussian sparse prior
% INPUT
%    L: signal length
%    rho: sparsity level
%    sigma_x: half-Gaussian standard deviation
% OUTPUT
%    x: positive sparse signal

nonz = ceil(rho * N);
x = zeros(N, 1);
k = randperm(N);
x(k(1:nonz)) = sigma_x * abs(randn(nonz, 1));
