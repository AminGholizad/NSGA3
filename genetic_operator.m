function childs = genetic_operator(parent_chromosome, options)
%% function childs  = genetic_operator(parent_chromosome, options)
%	This function is utilized to produce offsprings from parent chromosomes.
%	The genetic operators corssover and mutation which are carried out with
%	slight modifications from the original design.

    i = 1;
    j = 1;
    childs = chromosome(options);
    while i <= options.nPop
        flagX = false;
        flagM = false;
        % select parents
        parents = options.selectionFcn(parent_chromosome);
        % perform crossover
        if rand <= options.crossoverRate
            flagX = true;
            [childs(i).vars,childs(i+1).vars] = options.crossoverFcn(parents,options);
        end
        % perform mutation
        if rand <= options.mutationRate
            flagM = true;
            if flagX% mutate crossovered childs if they exist
                childs(i).vars = options.mutationFcn(childs(i),options);
                childs(i+1).vars = options.mutationFcn(childs(i+1),options);
            else% mutate parents
                childs(i).vars = options.mutationFcn(parents(1),options);
                childs(i+1).vars = options.mutationFcn(parents(2),options);
            end
        end
        if flagM || flagX% if new childs are generated evaluate them
            childs(i).vars(options.intVars) = floor(childs(i).vars(options.intVars));
            childs(i+1).vars(options.intVars) = floor(childs(i+1).vars(options.intVars));

            [childs(i).fitnesses, childs(i).constraintViolations, ...
            childs(i).isFeasable] = evaluate(childs(i).vars, options);

            [childs(i+1).fitnesses, childs(i+1).constraintViolations,...
            childs(i+1).isFeasable] = evaluate(childs(i+1).vars, options);
            if childs(i).isFeasable && childs(i+1).isFeasable% keep childs if they are feasable
                i = i + 2;
                j = 1;
            elseif j <= options.feasablityRetry% retry if childs are not feasable
                j = j + 1;
            else% pass if retry limit is reached
                i = i + 2;
            end
        end
    end
    for i = 1:2:options.nPop
        childs(i).fitnesses(options.maxiObjs) = MaximizationFcn(childs(i).fitnesses(options.maxiObjs));
        childs(i+1).fitnesses(options.maxiObjs) = MaximizationFcn(childs(i+1).fitnesses(options.maxiObjs));
    end
