function options = nsga3Options
%% options = nsga3Options
%   generate a set of variable used in the NSGAIII algorithm.
    options = baseOptions;
    options.Algorithm = 'NSGAIII';
    options.nDivision = 0;% Number of Divitions in reference points
    options.genRefFcn = @generate_refrence_points_classic;% use this function to generate reference points
    options.dominatesFcn = @Dominates;% use this function to perform dominance
