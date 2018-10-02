function options = PerformScalarizing(z, options)
    zmax = options.Zmax;
    smin = options.Smin;
    for j = 1:options.nObjective
        w = GetScalarizingVector(options.nObjective, j);
        [sminj, ind] = min(max(z./repmat(w,length(z),1)));
        if sminj < smin(j)
            zmax(:,j) = z(ind,:);
            smin(j) = sminj;
        end
    end
    options.Zmax = zmax;
    options.Smin = smin;

function w = GetScalarizingVector(n, j)
    epsilon = 1e-10;
    w = epsilon*ones(1,n);
    w(j) = 1;