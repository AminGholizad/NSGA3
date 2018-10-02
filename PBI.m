function x = PBI( x, options )
%PBI is used for theta dominance
    for i = 1:length(x)
        pbi = zeros(1,options.nRef);
        D2 = zeros(1,options.nRef);
        for j = 1:options.nRef
            D2(j) = d2(x(i).fitnessesNorm,options.refs(j,:));
            pbi(j) = d1(x(i).fitnessesNorm,options.refs(j,:)) + ...
            options.theta*D2(j);
        end
        x(i).pbi = pbi;
        x(i).d2 = D2;
    end
    function d = d2(f,ref)
            d = norm(f-d1(f,ref)*(ref/norm(ref)));

            function d = d1(f,ref)
                d = norm(f*ref.')/norm(ref);

