function snr = SNR(xhat, x)
% snr = SNR(xhat, x)

signalPow = mean(x.^2);
noisePow = mean((xhat - x).^2);
snr = 10 * log10(signalPow / noisePow);

