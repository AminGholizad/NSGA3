function S  = update_generation2(P, options)
%% S  = update_generation(P, frontPop, options)
%   This function replaces the chromosomes based on rank and distance from
%   reference points. Initially until the population size is reached each
%   front is added one by one until addition of a complete front which
%   results in exceeding the population size. At this point the chromosomes
%   in that front is added subsequently to the population based on distance
%   from reference pionts using niche counting
    S = struct([]);
    for i = 1 : length(options.Fronts);
        % Check to see if the population is filled if all the individuals with
        % rank i is added to the population. 
        if length(S) + options.Fronts(i).frontPop < options.nPop
            % There is stil some space so add all the individuals with rank i into the population.
            S = [S P(options.Fronts(i).indexes)];
        elseif length(S) + options.Fronts(i).frontPop > options.nPop
            % If there is more then normalize St and associate its members to 
            % refrence points and niche count them.
            [~, roS] = associate(S,options);
            % Get information about the individuals in the last rank.
            remaining = options.nPop - length(S);
            Fl = P(options.Fronts(i).indexes);
            % Normalize Fl and associate its members to refrence points and niche count them.
            [AFl, roFl] = associate(Fl,options);
            % If this field has no reference points associated
            % with its individuals choose from it randomly.
            if all(roFl == 0) 
                S = [S Fl(randi(length(Fl),1,remaining))];
                return;
            end
            % Start filling individuals into the population using Niche-Preserving
            % until the population is filled.
            for j = 1 : remaining
                while 1
                    % Find reference points with minimum associated members in
                    % St.
                    refInd = find(roS == min(roS));
                    % If there is more than one minimum choose one randomly.
                    Lmin = length(refInd);
                    if  Lmin > 1
                        refInd = refInd(randi(Lmin));
                    end
                    if roFl(refInd) > 0
                        % Find member with minimum distance to the minimum
                        % associated reference.
                        AFlrank = find([AFl.reference] == refInd);
                        [~,x] = min([AFl(AFlrank).distance]);
                        % Make sure it does not add more than once.
                        AFl(AFlrank(x)).distance = NaN;
                        AFl(AFlrank(x)).reference = NaN;
                        roFl(refInd) = roFl(refInd) - 1;
                        % Add it to the population and add to niche count.
                        S = [S Fl(AFlrank(x))];
                        roS(refInd) = roS(refInd) + 1;
                        remaining  = remaining - 1;
                        break;
                    else
                        % This field does not have any individual associated to
                        % this reference point so make sure algorithm does not
                        % repeat it self selecting this reference point again.
                        roS(refInd) = inf;
                        % If all reference points are excluded then choose from
                        % it randomly.
                        if all(roS == inf)
                            if remaining > 0
                                S = [S Fl(randi(length(Fl),1,remaining))];
                                return;
                            end
                        end
                    end
                end
            end
            return;
        else
            % Add all the individuals with rank i into the population. after
            % this population will be filled.
            S = [S P(options.Fronts(i).indexes)];
            return;
        end
    end