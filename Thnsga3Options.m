function options = Thnsga3Options
%% options = nsga3Options
%   geerate a set of variable used in the ThNSGAIII algorithm.
    options = baseOptions;
    options.Algorithm = 'ThNSGAIII';
	options.nRef = 0;% Number of reference points.
    options.theta = 0.1;% Penalty parameter of theta - dominance
    options.genRefFcn = @generate_refrence_points_uniform_random;% use this function to generate reference points
    options.dominatesFcn = @Dominates_th;% use this function to perform theta dominance