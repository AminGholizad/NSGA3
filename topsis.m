function [c,I] = topsis( x,J,Jp,w )
%topsis uses PIS and NIS to rank the solutions
    nans = isnan(x(:,1));
    xN = x(~nans,:);
    if nargin == 1
        J = 1:size(xN,2);
        Jp = [];
        w = ones(size(xN));
    end
    if nargin == 2
        Jp = [];
        w = ones(size(xN));
    end
    if nargin == 3
        w = ones(size(xN));
    end
    r = xN./repmat(sum(xN.^2,1),size(xN,1),1);
    v = r.*w;
    Ap = [max(v(:,J),[],1),min(v(:,Jp),[],1)];
    An= [min(v(:,J),[],1),max(v(:,Jp),[],1)];
    Sp = sqrt(sum((r-repmat(Ap,size(r,1),1)).^2,2));
    Sn = sqrt(sum((r-repmat(An,size(r,1),1)).^2,2));
    c = Sn./(Sn+Sp);
    
    tmp = zeros(length(nans),1);
    l = 1;
    for k=1:length(nans)
        if nans(k)
           tmp(k) = -1;
        else
            tmp(k) = c(l);
            l = l + 1;
        end
    end
    c = tmp;
    [~,I] = sort(c,'descend');
    c(c==-1) = NaN;

