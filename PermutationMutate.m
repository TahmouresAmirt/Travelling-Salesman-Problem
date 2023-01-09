function y = PermutationMutate(x)

    %m = randi([1 3]);
    pSwap = 0.3;
    pReversion = 0.45;
    pInsertion = 1 - pSwap - pReversion;
    m = RoulettWheelSelection([pSwap pReversion pInsertion]);
    switch m
        case 1
            y = DoSwap(x);
        case 2
            y = DoInsertion(x);
        case 3
            y = DoReversion(x);
    end 
end


function y = DoSwap(x)

        n = numel(x);
        i = randsample(n,2);
        i1 = i(1);
        i2 = i(2);
        
        y = x;
        y(i1) = x(i2);
        y(i2) = x(i1);
end
function y = DoReversion(x)
        
        n = numel(x);
        i = randsample(n,2);
        i1 = min(i(1),i(2));
        i2 = max(i(1),i(2));
        
        y = x;
        y (i1:i2) = x(i2:-1:i1);

end
function y = DoInsertion(x)
        
        n = numel(x);
        i = randsample(n,2);
        i1 = i(1);
        i2 = i(2);
        
        if i1<i2
            y = [x(1:i1-1) x(i1+1:i2) x(i1) x(i2+1:end)];
        else 
            y = [x(1:i2) x(i1) x(i2+1:i1-1) x(i1+1:end)];
        end

end