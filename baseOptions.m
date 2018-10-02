function options = baseOptions
%% options = baseOptions
%   generate a set of base variable used in the NSGAIII algorithm varations.
    options.Algorithm = '';
    options.nPop = 0;% - Population size
    options.nGen = 0;% - Number of Generations
    options.nObjective = 0;% - Number of objective functions
    options.maxiObjs = [];% - Index of maximization objectives
    options.nConstraint = 0;% - Number of Constraint functions
    options.nVar = 0;% - Number of decision variables
    options.intVars = [];% - Array of integer Variables
    options.lowerLimit = [];% - Vector of manimum possible values for decision variables.
    options.upperLimit= [];% - Vector of maximum possible values for decision variables.
    options.limitRestriction = true;% if true use while loop if false use limits.
    
    options.crossoverRate = 1;% With this probability perform crossover
    options.mutationRate = 1/55;% With this probability perform  mutation
    options.mu = 20;% The distribution index for crossover operator
    options.mum = 20;% The distribution index for mutation operator
    options.scale = 0.5;% gaussian mutation parameter
    options.shrink = 0.75;% gaussian mutation parameter
    
    options.genRefFcn = @()[];% use this function to generate reference points
    options.dominatesFcn = @()[];% use this function to perform dominance
    options.selectionFcn = @random_selection;% use this function to perform seltcion
    options.crossoverFcn = @simulated_binary_crossover;% use this function to perform crossover
    options.mutationFcn = @gaussian_mutation;% use this function to perform mutation
    options.objectiveFcn = @objectives;% use this function to evaluate objectives
    options.constraintFcn = @constraints;% use this function to evaluate constraint
    
    options.feasablityRetry = 1;% number of retrys to find a feasable solution
    options.thisGen = 1;% this generation number
    options.converge = true;% plot convergance of objectives
    options.display = true;% display massages in the command window
    options.gens = true;% display passed generations
    options.genInterval = 1;% display passed generations interval
    options.feasablity = true;% dispaly feasable solutions precentage
    options.visualize = false;% plot solutions
    options.export = false;% export results as files
    options.exportPath = './results/';% path to the export folder
    options.refPlot = false;% plot references
    options.converge = false;% plot convergance
    options.axisLabels = {'','',''};% axis labels shown in figure
    options.title = {''};% figure title
    options.time = true;% display elapsed and remaining time
