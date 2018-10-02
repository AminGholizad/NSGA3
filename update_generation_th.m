function S  = update_generation_th(R, options)
%update_generation_th Creates New Genration from Intermediate Generarion 

    %if this generation is less than or equal nPop the next generation will
    %be all of this generation
    if length(R)<=options.nPop
        S = R;
        return;
    end
    S = struct([]);
    for i = 1:length(options.Fronts)
        if length(S) + options.Fronts(i).frontPop < options.nPop
            %fill the next genration with this front
            S = [S R(options.Fronts(i).indexes)];
        elseif length(S) + options.Fronts(i).frontPop > options.nPop
            F = R(options.Fronts(i).indexes);
            %random sort the front
            F = F(randperm(length(F)));
            %fill the next generation to reach nPop
            S = [S F(1:options.nPop-length(S))];
        else 
            %fill the next genration with this front and return since this
            %fills next generation fully
            S = [S R(options.Fronts(i).indexes)];
            return;
        end
    end

