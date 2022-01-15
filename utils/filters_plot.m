function filters_plot(model)
    %% Parameters
    h = model;
    c1 = length(model{1});
    c2 = length(model{3});
    
    LineWidth = 1.0; MarkerSize = 2.0; FontSize = 15; 
    colors = ['r', 'b', 'k'];
    ylim_eps = 0.05;
    
    fig_r = max([c1, c2]);
    fig_c = 2 + c1;

    figure()
    clf
    for i=1:c1
        subplot(fig_r, fig_c, i + (i-1)*(fig_c-1));
        h_temp = h{1}{i,1};
        K = (length(h_temp) - 1)/2; xK = -K:K;
        stem(xK, h_temp, colors(1), 'filled',...
            'LineWidth', LineWidth, 'MarkerSize', MarkerSize);
        title(strcat('$h^{(1)}_{', num2str(i), '1}$'),...
            'Interpreter','latex','FontSize',FontSize);
        ylim([min(h_temp)-ylim_eps max(h_temp)+ylim_eps])
    end

    for i=1:c1
        for j=1:c2
            subplot(fig_r, fig_c, i+1 + (j-1)*fig_c);
            h_temp = h{2}{j,i};
            K = (length(h_temp) - 1)/2; xK = -K:K;
            stem(xK, h_temp,  colors(2), 'filled',...
                'LineWidth', LineWidth, 'MarkerSize', MarkerSize);
            title(strcat('$h^{(2)}_{', num2str(j), num2str(i), '}$'),...
                'Interpreter','latex','FontSize',FontSize);
        ylim([min(h_temp)-ylim_eps max(h_temp)+ylim_eps])

        end
    end

    for j=1:c2
        subplot(fig_r, fig_c, j*fig_c);
        h_temp = h{3}{1,j};
        K = (length(h_temp) - 1)/2; xK = -K:K;
        stem(xK, h_temp,  colors(3), 'filled',...
            'LineWidth', LineWidth, 'MarkerSize', MarkerSize);
        title(strcat('$h^{(3)}_{1', num2str(j), '}$'),...
            'Interpreter', 'latex','FontSize',FontSize);
        ylim([min(h_temp)-ylim_eps max(h_temp)+ylim_eps])
    end
    
end