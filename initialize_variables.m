function O = initialize_variables(options)
%% function O = initialize_variables(options) 
%   This function initializes the chromosomes. Each chromosome has the
%   following at this stage
%       * set of decision variables
%       * constraint function values
%       * feasablty of the chromosomes
%       * objective function values

%% Initialize each chromosome
% For each chromosome perform the following (nPop is the population size)
    O = chromosome(options);
    for i = 1 : options.nPop
        % Initialize the decision variables based on the minimum and maximum
        % possible values. A random number is picked between the minimum
        % and maximum possible values for the each decision variable.
        for j = 1:options.feasablityRetry
        % retry until a feasable solution is generated or retry limit is reached
            O(i).vars = unifrnd(options.lowerLimit,options.upperLimit,[1,options.nVar]);
            O(i).vars(options.intVars) = floor(O(i).vars(options.intVars));
            % The function evaluate takes one chromosome at a time, infact
            % only the decision variables are passed to the function which are
            % processed and returns the value for the objective functions. These
            % values are now stored at the fitnesses and constraintViolation and 
            % isFeasable fields of chromosome.
            [O(i).fitnesses, O(i).constraintViolations, O(i).isFeasable] = ...
                evaluate(O(i).vars,options);
            if O(i).isFeasable
                break
            end
        end
    end
    for i = 1:options.nPop
        O(i).fitnesses(options.maxiObjs) = MaximizationFcn(O(i).fitnesses(options.maxiObjs));
    end
