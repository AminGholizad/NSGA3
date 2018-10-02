function options = dtgaOptions
%% options = nsdga3Options
%   geerate a set of variable used in the DTGA algorithm.
    options = baseOptions;
    options.Algorithm = 'DTGA';
    options.x = [];% Inputs vectors for dea
    options.y = [];% Outputs vectors for dea