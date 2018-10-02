function [solutions,options] = Thnsga3(options)
%% [solutions,options] = Thnsga3(options)
    
    %% Initialize
    % Generate refrence points
    if options.display
        disp('Generating Reference Points...');
    end
    options = options.genRefFcn(options);
    if options.display
        disp('Done!');
    end
    % Initialize Ideal Points
    options.Zmin = inf(1,options.nObjective);
    options.Zmax = zeros(1,options.nObjective);
    % Initialize the population
    if options.display
        disp('Initializing Population...');
    end
    P = initialize_variables(options);
    % Update Ideal Point
    options = UpdateIdealPoint(P,options);
    %% Start the evolution process
    if options.display
        disp('Done!');
        disp('Starting The Evolution Process...');
    end
    startTime = clock;
    for i = 1 : options.nGen
        options.thisGen = i;
        % Make Offspring Population
        Q = genetic_operator(P, options);
        %Update Ideal Point
        options = UpdateIdealPoint(Q,options);
        R = [P, Q];
        % Normalize
        [R , options]= normalize_objective_th(R,options);
        % Clustering
        R = PBI(R,options);
        [R, options] = clustering(R,options);
        % Theta Non Dominated Sort
        [R, options]= ndsort(R,options);
        % Make New Generation
        P = update_generation_th(R, options);
        % Plot convergance of the objectives
        if options.converge
            converge(i,:) = options.Zmin;
            converge(i,options.maxiObjs) = MaximizationFcn(converge(i,options.maxiObjs),false);
%             for j = 1:options.nObjective
%                 subplot(options.nObjective,1,j)
%                 plot(1:i,converge(:,j));
%             end
%             axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0  1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%             text(0.5, 0.98,options.Algorithm,'FontSize',11,'FontWeight','Bold','HorizontalAlignment','center')
%             drawnow;
        end
        % Display numbe of generations that has passed and time if choosed
        % to do.
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
    solutions = rmfield(P,{'pbi';'d2';'fitnessesNorm'});
    for i = 1:options.nPop
        solutions(i).fitnesses(options.maxiObjs) = MaximizationFcn(solutions(i).fitnesses(options.maxiObjs),false);
    end
    Datetime = datestr(datetime,'yyyy-mm-dd HH-MM');
    if options.converge && options.export
        if ~exist(options.exportPath,'dir')
            mkdir(options.exportPath)
        end
        plot(1:options.nGen,converge);
        saveas(gcf,[options.exportPath, options.Algorithm, 'Convergance(' Datetime ').fig'])
        saveas(gcf,[options.exportPath, options.Algorithm, 'Convergance(' Datetime ').png'])
    end
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