function [x_hat, z, g, v] = Run_CNN(CNN, y)
% x_hat = Run_CNN(CNN, x)
%
% INPUT
%   CNN : CNN filters
%   y : input signal 
%
% OUTPUT
%   x_hat : output of CNN
%
%   [x_hat, z, g, v] = Run_CNN(CNN, x) this returns:
%       z : intermediate convolutions
%       g : layer output signal prior to relu
%       v : layer output signal (no relu at final layer)
%
%   z, g, v are cell arrays

    h = CNN;
    dpt = length(h);
    z = cell(1, dpt);
    g = cell(1, dpt);
    v = cell(1, dpt-1);
    
    % first layer
    z{1} = first_conv1d_layer(h{1}, y);
    g{1} = z{1};
    v{1} = relu_layer(g{1});
    
    % hidden layers
    for i = 2:dpt-1
        [z{i}, g{i}] = conv1d_layer(v{i-1}, h{i});
        v{i} = relu_layer(g{i});
    end
    
    % final layers
    [z{dpt}, g{dpt}] = final_conv1d_layer(v{dpt-1}, h{dpt});
    
    % CNN output is output of final layer
    x_hat = g{dpt}{1};
    
end

function y = relu_layer(x)
% x and y are cell arrays    
    y = x;
    for i = 1:numel(y)
        y{i} = relu(y{i});
    end
end

function y = relu(x)
% Relu
% Input: x - (N, Cin, Lin) 
    
    y = x;
    x_idx = (x <= 0);
    y(x_idx) = 0.0;

end

function y = conv1d(x, h)
    % 'Same' Convolution
    % Input: x - (L, 1) 
    % Output: y - (L, 1)
    % h: (k, 1)
    y = conv(x, h(end:-1:1), 'same');
end

function z = first_conv1d_layer(h, x)
    
    [Nout, Nin] = size(h);
    z = cell(Nout, Nin);
    for i = 1:Nout
        z{i, 1} = conv1d(x, h{i, 1});
    end

end

function [z, g] = conv1d_layer(x, h)

    [Nout, Nin] = size(h);
    z = cell(Nout, Nin);
    g = cell(Nout, 1);
    for i = 1:Nout
        g{i} = 0.0;
        for j = 1:Nin
            z{i, j} = conv1d(x{j}, h{i, j});
            g{i} = g{i} + z{i, j};
        end        
    end

end

function [z, g] = final_conv1d_layer(x, h)
    
    [Nout, Nin] = size(h);
    z = cell(Nout, Nin);
    g = cell(1, 1);
    g{1} = 0;
    for j = 1:Nin
        z{1, j} = conv1d(x{j}, h{1, j});
        g{1} = g{1} + z{1, j};
    end
    
end


