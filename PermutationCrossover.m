 function [y1 y2] = PermutationCrossover(x1,x2)

    nVar = numel(x1);
    c = randi([1 nVar-1]);
    
    x11 = x1(1:c);
    x12 = x1(1+c:end);
    
    x21 = x2(1:c);
    x22 = x2(1+c:end);
    
    r1 = intersect(x11,x22);
    r2 = intersect(x21,x12);
    
    x11(ismember(x11,r1)) = r2;
    x21(ismember(x21,r2)) = r1;
    
    y1 = [x11 x22];
    y2 = [x21 x12];
    % Another Way of Permutation Crossover 
    %{ 
     nVar = numel(x1);
     c = randi([1 nVar-1]);
     
     y1 = [x1(1:c) x2(1+c:end);
     y2 = [x2(1:c) x1(1+c:end);
    
     R1 = find(ismember(x2(1+c:end),x1(1:c))+c;
     R2 = find(ismember(x1(1+c:end),x2(1:c))+c;
     
     for k=1:numel(R1)
         
            i = R1(k);
            j = R2(k);
            temp = y1(i);
            y1(i) = y2(i);
            y2(i) = temp;
            
     end
 %}    
 end
