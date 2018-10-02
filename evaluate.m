function [fitnesses, constraintViolations, isFeasable] = evaluate(x, options)
%% [fitnesses, constraintViolations, isFeasable] = evaluate(x, options)
%   Decision variables are passed to the constraint and objective functions
%   and feasablity check is performed.

    [constraintViolations, isFeasable] = ...
            options.constraintFcn(x, options);
    if isFeasable
        % If this set of variables is feasable then calculate objective
        fitnesses = options.objectiveFcn(x, options);
    else
        % else put Not a Number in the fitness values
        fitnesses = NaN*ones(1,options.nObjective);
    end