function [ val ] = dea( x,y )
%data envelopment analysis with CCR & BCC methods input and output oriented
    nans = isnan(x(:,1));
    xN = x(~nans,:);
    yN = y(~nans,:);
    n = size(xN,1);%DMU-j
    m = size(xN,2);%IN-i
    s = size(yN,2);%OUT-r
    fval = zeros(n,4);
    f13 = [1,-eps.*ones(1,s+m),zeros(1,n)];%[HETA0,Sr+,Si-,Lambdaj],1,s,m,n
    f24 = [1,+eps.*ones(1,s+m),zeros(1,n)];%[HETA0,Sr+,Si-,Lambdaj],1,s,m,n
    A = [];
    b = [];
    lb = [-inf;zeros(s+m+n,1)];
    ub = inf*ones(s+m+n+1,1);
    for j = 1:n
        y0 = yN(j,:);
        x0 = xN(j,:);
        st1i = zeros(m,1+s+m+n);
        st1o = zeros(m,1+s+m+n);
        Si = eye(m);
        for i = 1:m
            st1i(i,:) = [-x0(i), zeros(1,s),Si(i,:),xN(:,i).'];%-THETA0*x0+sum(Lambda*x)+Si=0
            st1o(i,:) = [0, zeros(1,s),Si(i,:),xN(:,i).'];%sum(Lambda*x)+Si=x0
        end
        st2i = zeros(s,1+s+m+n);
        st2o = zeros(s,1+s+m+n);
        Sr = eye(s);
        for r = 1:s
            st2i(r,:) = [0,Sr(r,:), zeros(1,m),yN(:,r).'];%sum(Lambda*y)+Sr=y0
            st2o(r,:) = [-y0(r),Sr(r,:), zeros(1,m),yN(:,r).'];%-THETA0*y0+sum(Lambda*y)+Sr=0
        end
        st3 = [zeros(1,1+s+m), ones(1,n)];%sum(Lambda) = 1;
        Aeq1 = [st1i;st2i];
        beq1 = [zeros(m,1);y0.'];
        Aeq2 = [st1o;st2o];
        beq2 = [x0.';zeros(s,1)];
        Aeq3 = [Aeq1;st3];
        beq3 = [beq1;1];
        Aeq4 = [Aeq2;st3];
        beq4 = [beq2;1];
%         opt = optimoptions(@linprog,'Display','off','Algorithm','interior-point');
        opt = optimoptions(@linprog,'Display','off');
        X0 = [];
        try
            [~,tmp] = linprog(f13,A,b,Aeq1,beq1,lb,ub,X0,opt);
            fval(j,1) = tmp;
        catch
            fval(j,1) = NaN;
        end
        try
            [~,tmp] = linprog(-f24,A,b,Aeq2,beq2,lb,ub,X0,opt);%notice the minus for maximazation
            fval(j,2) = tmp;
        catch
            fval(j,2) = NaN;
        end
        try
            [~,tmp] = linprog(f13,A,b,Aeq3,beq3,lb,ub,X0,opt);
            fval(j,3) = tmp;
        catch
            fval(j,3) = NaN;
        end
        try
            [~,tmp] = linprog(-f24,A,b,Aeq4,beq4,lb,ub,X0,opt);%notice the minus for maximazation
            fval(j,4) = tmp;
        catch 
            fval(j,4) = NaN;
        end
    end
    val = zeros(length(nans),4);
    l = 1;
    for k=1:length(nans)
        if nans(k)==1
           val(k,:) = NaN*ones(1,4);
        else
            val(k,:) = fval(l,:);
            l = l + 1;
        end
    end
end

