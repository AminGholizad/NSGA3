function [St, options]= normalize_objective_th(St,options)
%% St = normalize_objective(St)
%   Normalize objectives of the population in order to find normalized
%   distacse from referece points  that areon the normmalized hyper plain.
%     options.Zmax = max(options.Zmax, max(vertcat(St.fitnesses)));
    options.Zmax = max(vertcat(St.fitnesses));
    L = find(vertcat(St.isFeasable),1,'last');
    % Each objective valueof St is then translated by subtracting objective fi
    % by zimin, so that the ideal point of translated St becomes a zero vector.
    for i = 1:L
        St(i).fitnessesNorm = (St(i).fitnesses - options.Zmin)./(options.Zmax - options.Zmin);
    end