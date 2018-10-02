function [St,options]  = normalize_objective(St,options)
%% St = normalize_objective(St)
%   Normalize objectives of the population in order to find normalized
%   distacse from referece points  that areon the normmalized hyper plain.
    fp = vertcat(St.fitnesses) - repmat(options.Zmin, length(St), 1);
    options = PerformScalarizing(fp, options);
    a = FindHyperplaneIntercepts(options.Zmax);
    L = find(vertcat(St.isFeasable),1,'last');
    for i = 1:L
        St(i).fitnessesNorm = fp(i,:)./a;
    end
    
function a = FindHyperplaneIntercepts(zmax)

    w = ones(1, size(zmax,2))/zmax;
    
    a = (1./w);