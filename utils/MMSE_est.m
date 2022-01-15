function x_MMSE = MMSE_est(y, rho, sigma_x, sigma_n)

    sigma_n_2 = sigma_n.^2;
    sigma_x_2 = sigma_x.^2;

    mu_bar = sigma_x_2 / (sigma_n_2 + sigma_x_2) * y;
    sigma_bar_2 = (sigma_n_2 * sigma_x_2) / (sigma_n_2 + sigma_x_2);

    C_int = n_pdf(y, 0, sqrt(sigma_n_2 + sigma_x_2)); 
    C = (1 - rho) ./ (2 * rho * C_int);

    U = inf;
    L = 0.0;

    G1 = n_cdf(U - mu_bar, 0, sqrt(sigma_bar_2)) - n_cdf(L - mu_bar, 0, sqrt(sigma_bar_2));
    G2 = sigma_bar_2 * (n_pdf(L - mu_bar, 0, sigma_bar_2) - n_pdf(U - mu_bar, 0, sqrt(sigma_bar_2)));

    num = mu_bar .* G1 + G2;
    dom = C .* n_pdf(y, 0, sqrt(sigma_n_2)) + G1;

    x_MMSE = num ./ dom;

end


function y = n_pdf(x, mu, sigma)
    y = exp(-0.5 * ((x - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
end

function y = n_cdf(x, mu, sigma)
    y = 0.5 * erfc(-(x - mu)./(sqrt(2) * sigma));
end
