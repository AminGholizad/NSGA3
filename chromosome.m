function chromosomes = chromosome(options)
%chromosome Creates an empty chromosome structure array for preallocation
    if strcmp(options.Algorithm,'DTGA')
        chromosomes(options.nPop) = struct('vars',[],'fitnesses',[],...
                                       'constraintViolations',[],...
                                       'isFeasable',[]);
    elseif strncmp(options.Algorithm,'Th',2)% thnsdga thnsga
        chromosomes(options.nPop) = struct('vars',[],'fitnesses',[],...
                                       'fitnessesNorm',[],'pbi',[],...
                                       'd2',[],'constraintViolations',[],...
                                       'isFeasable',[],'front',[],...
                                       'cluster',[]);
    elseif strncmp(options.Algorithm,'NS',2)% nsdga3 nsga3
        chromosomes(options.nPop) = struct('vars',[],'fitnesses',[],...
                                       'fitnessesNorm',[],'constraintViolations'...
                                       ,[],'isFeasable',[],'front',[],...
                                       'dist',[],'distance',[],'reference',[]);
    end