function parents = random_selection(parent_chromosome)
%% parents = random_selection(parent_chromosome)
%   Select two deferent individual randomly
    N = length(parent_chromosome); 
% Select the first parent
    parent_1 = round(N*rand);
    if parent_1 < 1
        parent_1 = 1;
    end
% Select the second parent
    parent_2 = round(N*rand);
    if parent_2 < 1
        parent_2 = 1;
    end
% Make sure both the parents are not the same. 
    while isequal(parent_chromosome(parent_1),parent_chromosome(parent_2))
        parent_2 = round(N*rand);
        if parent_2 < 1
            parent_2 = 1;
        end
    end
% Get the chromosome information for each randomnly selected
% parents
    parents(1) = parent_chromosome(parent_1);
    parents(2) = parent_chromosome(parent_2);

