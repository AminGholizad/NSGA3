function o = polynomial_mutation(x, options)
%% o = polynomial_mutation(x, options)
%   Perform polynomial mutation and checks for boundiry limits.

    % Perform mutation on eact element of the selected parent.
    o = zeros(1,options.nVar);
    for i = 1 : options.nVar
        % Generate the corresponding child element.
        o(i) = x.vars(i) + genDelta(options);
        % Make sure that the generated element is within the decision
        % space.
        if options.limitRestriction
            while o(i) > options.upperLimit(i) || o(i) < options.lowerLimit(i)
                o(i) = x.vars(i) + genDelta(options);
            end
        else
            if o(i) > options.upperLimit(i)
                o(i) = options.upperLimit(i);
            elseif o(i) < options.lowerLimit(i)
                o(i) = options.lowerLimit(i);
            end
        end
    end

function d = genDelta(options)
    r = rand;
    if r < 0.5
        d = (2*r)^(1/(options.mum+1)) - 1;
    else
        d = 1 - (2*(1 - r))^(1/(options.mum+1));
    end