function [solutions,options] = runGA( options )
%runGA Chooses which algorithm to use to solve the problem
    if strcmp(options.Algorithm,'NSGAIII')
        [solutions,options] = nsga3(options);
    elseif strcmp(options.Algorithm,'NSDGAIII')
        [solutions,options] = nsdga3(options);
    elseif strcmp(options.Algorithm,'ThNSGAIII')
        [solutions,options] = Thnsga3(options);
    elseif strcmp(options.Algorithm,'ThNSDGAIII')
        [solutions,options] = Thnsdga3(options);
    elseif strcmp(options.Algorithm,'DTGA')
        [solutions,options] = dtga(options);
    end

