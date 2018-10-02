function [O1, O2]= simulated_binary_crossover(parents, options)
%% [O1, O2]= simulated_binary_crossover(parents, options)
%   perfroms SBX crossover and checks for boundiry limits.

    % Perform corssover for each decision variable in the chromosome.
    childs = zeros(2,options.nVar);
    for j = 1 : options.nVar
        bq = genBQ(options);
        % Generate the jth element of first child
        childs(1,j) = genCH1(bq,parents,j);
        % Generate the jth element of second child
        childs(2,j) = genCH2(bq,parents,j);
        % Make sure that the generated element is within the specified
        % decision space.
        if options.limitRestriction
            while childs(1,j) > options.upperLimit(j) || ...
                    childs(1,j) < options.lowerLimit(j) ||...
                    childs(2,j) > options.upperLimit(j) || ...
                    childs(2,j) < options.lowerLimit(j)
                bq = genBQ(options);
                childs(1,j) = genCH1(bq,parents,j);
                childs(2,j) = genCH2(bq,parents,j);
            end
        else
            if childs(1,j) > options.upperLimit(j)
                childs(1,j) = options.upperLimit(j);
            elseif childs(1,j) < options.lowerLimit(j)
                childs(1,j) = options.lowerLimit(j);
            end
            if childs(2,j) > options.upperLimit(j)
                childs(2,j) = options.upperLimit(j);
            elseif childs(2,j) < options.lowerLimit(j)
                childs(2,j) = options.lowerLimit(j);
            end
        end
    end
    O1 = childs(1,:);
    O2 = childs(2,:);
    
function bq = genBQ(options)
    u = rand;
    if u <= 0.5
        bq = (2*u)^(1/(options.mu+1));
    else
        bq = (1/(2*(1 - u)))^(1/(options.mu+1));
    end
function ch = genCH1(bq,parents,j)
    ch = 0.5*(((1 + bq)*parents(1).vars(j)) + (1 - bq)*parents(2).vars(j));
function ch = genCH2(bq,parents,j)
    ch = 0.5*(((1 - bq)*parents(1).vars(j)) + (1 + bq)*parents(2).vars(j));