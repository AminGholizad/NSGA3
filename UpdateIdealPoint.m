function [options] = UpdateIdealPoint( P, options )
%UpdateIdealPoint sets infimum piont so far
    x = vertcat(P.fitnesses);
    options.Zmin = min(options.Zmin, min(x));

