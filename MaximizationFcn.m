function y = MaximizationFcn(x,flag)
%MaximizationFcn coverts maximization to minimization and vise versa
    if nargin <2
        flag = true;
    end
    if flag % convert
        y = -x;
    else % convert back
        y = -x;
    end
end