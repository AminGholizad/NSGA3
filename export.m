function export(solutions, Datetime, options)
            T = struct2table(solutions);
        if ~exist(options.exportPath,'dir')
            mkdir(options.exportPath)
        end
        writetable(T,[options.exportPath, options.Algorithm,...
        'Solutions(' Datetime ').csv'],'Delimiter',',','QuoteStrings',true);
end

