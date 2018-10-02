function  [Rt,options]  = clustering(Rt,options)
%clustering clusters population with respect to reference points
    clusters = cell(options.nRef,1);
    for i = 1:length(Rt)
        [~,k] = min(Rt(i).d2);
        clusters{k,:} = [clusters{k,:} i];
        Rt(i).cluster = k;
    end
    options.clusters = clusters;