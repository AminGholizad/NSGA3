function S  = update_generation(P, options)
%% S  = update_generation(P, options)
    S = struct([]);
    [P, ro] = associate(P,options);
    for i = 1 : length(options.Fronts)
        if length(S) + options.Fronts(i).frontPop > options.nPop
            LastFront = P(options.Fronts(i).indexes);
            break;
        end
        S = [S P(options.Fronts(i).indexes)];
    end
    while true
        [~, minro] = min(ro);
        AssocitedFromLastFront = find(vertcat(LastFront.reference) == minro);
        if ~any(AssocitedFromLastFront)
            ro(minro) = inf;
            continue;
        end
        if ro(minro) == 0
            AssocitedLastFrontDist = vertcat(LastFront(AssocitedFromLastFront).dist);
            [~, new_member_ind] = min(AssocitedLastFrontDist(:,minro));
        else
            new_member_ind = randi(length(AssocitedFromLastFront));
        end
        new_member_ind = AssocitedFromLastFront(new_member_ind);
        S = [S LastFront(new_member_ind)];
        LastFront(new_member_ind)=[];
        ro(minro)=ro(minro)+1;
        if length(S) >= options.nPop
            break;
        end
    end