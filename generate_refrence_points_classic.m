function options = generate_refrence_points_classic(options)
%% refrence_points = generate_refrence_points_classic(options)
%   Generates reference points on the normalized hyperplain using classic method.
    options.refs = GetFixedRowSumIntegerMatrix(options.nObjective, options.nDivision) / options.nDivision;
    options.nRef = length(options.refs);
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

function A = GetFixedRowSumIntegerMatrix(M, RowSum)

    if M < 1
        error('M cannot be less than 1.');
    end
    
    if floor(M) ~= M
        error('M must be an integer.');
    end
    
    if M == 1
        A = RowSum;
        return;
    end

    A = [];
    for i = 0:RowSum
        B = GetFixedRowSumIntegerMatrix(M - 1, RowSum - i);
        A = [A; i*ones(size(B,1),1) B];
    end
