function visualize(solutions, Datetime, options)
    if options.nObjective <=3
        tf = false;
        flags = vertcat(solutions(:).isFeasable);
        feasable = vertcat(solutions(flags).fitnesses);
        x = vertcat(solutions(~flags).vars);
        l = length(flags(flags == 0));
        infeasable = zeros(l,options.nObjective);
        for i = 1:length(flags(flags == 0))
            infeasable(i,:) = options.objectiveFcn(x(i,:), options);
        end
        if options.nObjective == 2
            figure
            if ~isempty(feasable)
                tf = true;
                plot(feasable(:,1),feasable(:,2),'*g','DisplayName','feasable');
            end
            if ~isempty(infeasable)
                if tf
                    hold on
                end
                plot(infeasable(:,1),infeasable(:,2),'*r','DisplayName','infeasable');
                if tf
                    hold off
                end
            end
            xlabel(options.axisLabels(1));
            ylabel(options.axisLabels(2));
            if ~strcmp(options.title,'')
                title(options.title);
            else
                title(options.Algorithm);
            end
            grid on
            legend('show')
        elseif options.nObjective ==3
            figure
            if ~isempty(feasable)
                tf = true;
                plot3(feasable(:,1),feasable(:,2),feasable(:,3),'*g','DisplayName','feasable');
            end
            if ~isempty(infeasable)
                if tf
                    hold on
                end
                plot3(infeasable(:,1),infeasable(:,2),infeasable(:,3),'*r','DisplayName','infeasable');
                if tf
                    hold off
                end
            end
            xlabel(options.axisLabels(1));
            ylabel(options.axisLabels(2));
            zlabel(options.axisLabels(3));
            if ~strcmp(options.title,'')
                title(options.title);
            else
                title(options.Algorithm);
            end
            grid on
            legend('show','Location','Best')
        end
        if options.export
            if ~exist(options.exportPath,'dir')
                mkdir(options.exportPath)
            end
            saveas(gcf,[options.exportPath, options.Algorithm, 'Solutions(' Datetime ').fig'])
            saveas(gcf,[options.exportPath, options.Algorithm, 'Solutions(' Datetime ').png'])
        end
    end

end

