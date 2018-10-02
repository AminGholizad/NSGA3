function [output, options]= ndsort(x,options)
%% function output = ndsort(x, options)
%   This function sorts the current popultion based on non-domination. All the
%   individuals in the first front are given a rank of 1, the second front
%   individuals are assigned rank 2 and so on.

    N = length(x);
    % Initialize the front number to 1.
    front = 1;

    % There is nothing to this assignment, used only to manipulate easily in
    % MATLAB.
    F(front).indexes = [];
    individual = struct;

    %% Non-Dominated sort. 
    % The initialized population is sorted based on non-domination. The fast
    % sort algorithm [1] is described as below

    % • for each individual p in main population P do the following
    %   – Initialize Sp = []. This set would contain all the individuals that is
    %     being dominated by p.
    %   – Initialize np = 0. This would be the number of individuals that domi-
    %     nate p.
    %   – for each individual q in P
    %       * if p dominated q then
    %           · add q to the set Sp i.e. Sp = Sp U {q}
    %       * else if q dominates p then
    %           · increment the domination counter for p i.e. np = np + 1
    %   – if np = 0 i.e. no individuals dominate p then p belongs to the first
    %     front; Set rank of individual p to one i.e prank = 1. Update the first
    %     front set by adding p to front one i.e F1 = F1 U {p}
    % • This is carried out for all the individuals in main population P.
    % • Initialize the front counter to one. i = 1
    % • following is carried out while the ith front is nonempty i.e. Fi != []
    %   – Q = []. The set for storing the individuals for (i + 1)th front.
    %   – for each individual p in front Fi
    %       * for each individual q in Sp (Sp is the set of individuals
    %         dominated by p)
    %           · nq = nq-1, decrement the domination count for individual q.
    %           · if nq = 0 then none of the individuals in the subsequent
    %             fronts would dominate q. Hence set qrank = i + 1. Update
    %             the set Q with individual q i.e. Q = Q U q.
    %   – Increment the front counter by one.
    %   – Now the set Q is the next front and hence Fi = Q.

    for i = 1 : N
        % Number of individuals that dominate this individual
        individual(i).dominated = 0;
        % Individuals which this individual dominate
        individual(i).dominates = [];
        if x(i).isFeasable %xi is feasable
            for j = 1 : N
                if x(j).isFeasable % xj is feasabe
                    if options.dominatesFcn(x(i),x(j),options)
                        individual(i).dominates = [individual(i).dominates j];
                    elseif options.dominatesFcn(x(j),x(i),options)
                        individual(i).dominated = individual(i).dominated + 1;
                    end
                else % xj is not feasable then xi dominates xj
                    individual(i).dominates = [individual(i).dominates j];
                end
            end   
        else % xi is not feasable
            for j = 1 : N
                if x(j).isFeasable% xj is feasable then xi is dominated by xj
                    individual(i).dominated = individual(i).dominated + 1;
                else  % xj is not feasable
                        % Do nothing
                        continue;
                end
            end 
        end
        if individual(i).dominated == 0
            x(i).front = 1;
            F(front).indexes  = [F(front).indexes i];
        end
    end
    % Find the subsequent fronts
    while ~isempty(F(front).indexes)
        Q = [];
        for i = F(front).indexes
           if ~isempty(individual(i).dominates)
               for j = individual(i).dominates
                    individual(j).dominated = individual(j).dominated - 1;
                    if individual(j).dominated == 0
                        x(j).front = front + 1;
                        Q = [Q j];
                    end
                end
           end
        end
        F(front).frontPop = length(F(front).indexes);
        front =  front + 1;
        F(front).indexes = Q;
    end
    options.Fronts = F;
    output = x;