function options = generate_refrence_points_uniform_random(options)
%% options.refs = generate_options.refs_uniform_random(options)
%   Generates reference points on the normalized hyperplain randomly.

    options.refs = zeros(options.nRef,options.nObjective);
    for j = 1:options.nRef
        s = 0;
        for k = 1:options.nObjective
            if k < options.nObjective
                options.refs(j,k) = (1-s)*(1-rand^(1/(options.nObjective-k)));
                s = s + options.refs(j,k);
            else
                options.refs(j,k) = 1 - s;
            end
        end
    end
    if options.refPlot
        if options.nObjective == 2
            figure;
            plot(options.refs(:,1),options.refs(:,2),'*b');
            title(options.title);
            xlabel(options.axisLabels(1));
            ylabel(options.axisLabels(2));
            grid on
        elseif options.nObjective == 3
            title(options.title);
            plot3(options.refs(:,1),options.refs(:,2),options.refs(:,3),'*b')
            title(options.title);
            xlabel(options.axisLabels(1));
            ylabel(options.axisLabels(2));
            grid on
            zlabel(options.axisLabels(3));
        end
        if options.export
            if ~exist(options.exportPath,'dir')
                mkdir(options.exportPath)
            end
            saveas(gcf,[options.exportPath, 'references(' strrep(datestr(datetime),':','-') ').fig'])
        end
    end