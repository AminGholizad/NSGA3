function [S, ro] = associate(S, options)
%% [S, ro] = associate(S, refs, options)
%   This function associates each individual to a reference point
%   the distance between each individual and reference point is calculated
%   and  then each individual is associated to a reference point that has
%   minimum distance from it.
    ro = zeros(options.nRef,1);
    for i=1:length(S)
        if S(i).isFeasable
            dist = zeros(1,options.nRef);
            for j=1:options.nRef
                w = (options.refs(j,:)/norm(options.refs(j,:))).';
                z = (S(i).fitnessesNorm).';
                dist(j) = norm(z - w'*z*w);
            end
            S(i).dist = dist;
            [S(i).distance, ind] = min(dist);
            S(i).reference = ind;
            ro(ind) = ro(ind) + 1;
        else
            S(i).dist = NaN;
            S(i).distance = NaN;
            S(i).reference = NaN;
        end
    end