function model = CreateModel()
    
    x = [42 9 60 47 70 70 64 3 6 32 53 66 41 82 72 97 53 32 10 61]';
    y = [78 42 9 26 15 28 44 53 46 88 52 95 64 96 24 68 29 67 70 6]';
    
    n = numel(x);
    pos = [x y];
    
    d = zeros(n);

    for i = 1:n
       for j = 1:n
        d(i,j) = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2); 
       end
    end
    %d =  pdist2(pos,pos);
    model.n = n ;
    model.x = x ;
    model.y = y ;
    model.d = d ;
    
end