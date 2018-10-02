function options = Options(Algorithm)
%Options Chooses the right options based on the Algorithm name
    if     strcmp(Algorithm,'NSGAIII')
        options = nsga3Options;
    elseif strcmp(Algorithm,'NSDGAIII')
        options = nsdga3Options;
    elseif strcmp(Algorithm,'ThNSGAIII')
        options = Thnsga3Options;
    elseif strcmp(Algorithm,'ThNSDGAIII')
        options = Thnsdga3Options;
    elseif strcmp(Algorithm,'DTGA')
        options = dtgaOptions;
    end

