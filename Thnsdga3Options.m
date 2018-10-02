function options = Thnsdga3Options
%% options = nsdga3Options
%   geerate a set of variable used in the ThNSDGAIII algorithm.
    options = Thnsga3Options;
    options.Algorithm = 'ThNSDGAIII';
    options.x = [];% Inputs vectors for dea
    options.y = [];% Outputs vectors for dea
    options.deamse = 1e-3;% mean squared error for dea in abs(dea^2 - 1) < e