function [solutions,options] = dtga(options)
%% [solutions,options] = dtga4(options)

    %% Initialize the population
    if options.display
        disp('Initializing Population...');
    end
    P = initialize_variables(options);
    %% Start the evolution process
    if options.display
        disp('Done!');
        disp('Starting The Evolution Process...');
    end
    % record starting time in order to measure elapsed and remainin time
    startTime = clock;
    for i = 1 : options.nGen
        options.thisGen = i;
        Q = genetic_operator(P, options);
        R = [P,Q];
        reshaped = reshape([R.fitnesses],options.nObjective,[]).';
        deas = dea(reshaped(:,options.x),reshaped(:,options.y));
        [~,Ind] = topsis(deas);
        Rsorted = R(Ind);
        P = Rsorted(1:options.nPop);
        % Display numbe of generations that has passed and time if choosed to
        % do.
        if options.display
            clc
            if options.gens
                if ~mod(options.thisGen, options.genInterval)
                    g = i;
                    fprintf('%d/%d generations completed\n',g,options.nGen);
                    if options.feasablity
                        fprintf('%g%% of the generation is feasable\n',sum([P.isFeasable])/options.nPop*100);
                    end
                elseif exist('g','var')
                    fprintf('%d/%d generations completed\n',g,options.nGen);
                end
            end
            if options.time
                currentTime = clock;
                elapsedTime = etime(currentTime,startTime);
                estimatedRemainingTime = (options.nGen - options.thisGen)*(elapsedTime/options.thisGen);
                fprintf('elapsed time: %s\n',datestr(elapsedTime/(24*60*60),'HH:MM:SS'));
                fprintf('estimated remianing time: %s\n',datestr(estimatedRemainingTime/(24*60*60),'HH:MM:SS'));
            end
        end
    end
    %% Result
    reshaped = reshape([P.fitnesses],options.nObjective,[]).';
    deas = dea(reshaped(:,options.x),reshaped(:,options.y));
    [c,Ind] = topsis(deas);
    for i = 1:options.nPop
        P(i).deas = deas(i,:);
        P(i).topsis = c(i);
    end
    solutions = P(Ind);
    for i = 1:options.nPop
        solutions(i).fitnesses(options.maxiObjs) = MaximizationFcn(solutions(i).fitnesses(options.maxiObjs),false);
    end
    Datetime = datestr(datetime,'yyyy-mm-dd HH-MM');
    %% Visualize
    % The following is used to visualize the result if objective space
    % dimension is visualizable.
    if options.visualize
        visualize(solutions, Datetime, options)
    end
    %% Export
    if options.export
        export(solutions, Datetime, options)
    end