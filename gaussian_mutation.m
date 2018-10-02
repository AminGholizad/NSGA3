function o = gaussian_mutation(x, options)
%% o = gaussian_mutation(x, options)
%	gaussian mutation more mutation at the beginning of the algorithm
%	compared with the end of the algorithm. this function also checks for
%	boundiry limits.

    % Perform mutation on eact element of the selected parent.
    scale = options.scale - options.shrink * options.scale * options.thisGen/options.nGen;
    scale = scale * (options.upperLimit - options.lowerLimit);
    o = zeros(1,options.nVar);
    for i = 1 : options.nVar
        % Generate the corresponding child element.
        o(i) = genM(x,i,scale);
        % Make sure that the generated element is within the decision
        % space.
        if options.limitRestriction
            while o(i) > options.upperLimit(i) || o(i) < options.lowerLimit(i)
                o(i) = genM(x,i,scale);
            end
        else
            if o(i) > options.upperLimit(i)
                o(i) = options.upperLimit(i);
            elseif o(i) < options.lowerLimit(i)
                o(i) = options.lowerLimit(i);
            end
        end
    end
    
function m = genM(x,i,scale)
    m = x.vars(i) + scale(i) * rand;