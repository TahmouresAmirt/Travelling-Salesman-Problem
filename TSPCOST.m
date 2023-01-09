function z = TSPCOST(sol,model)

    n = model.n;
    d = model.d;
    global NFE;
    if isempty(NFE)
       NFE = 0; 
    end
    NFE = NFE + 1;
    if isempty(sol)
       return; 
    end
    
    sol = [sol sol(1)];
    z = 0;
    for i = 1:numel(sol)-1
    z = z + d(sol(i),sol(i+1));
    end
    
end