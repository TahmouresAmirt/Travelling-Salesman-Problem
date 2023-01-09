clc;
clear;
close all;
%% Problem Definition
global NFE ;
NFE = 0;
model = CreateModel();
%model.w(20,15) = 0;
%model.w(15,20) = 0;
CostFunction = @(sol)TSPCOST(sol,model);

%% GA Parameters

nVar = model.n ;
nPop = 50;
Varsize = [1 nVar];
MaxIt = 100;

pc = 0.8;
pm = 0.3;

nc = 2*round(pc*nPop/2);
nm = round(pm*nPop);

beta = 0.5;


TournamentSize = 3 ;

ANSWER = questdlg('Please Select Parents Selection Method','NOTE','RoulettWheel',...
    'Tournament','Random','RoulettWheel');
pause(0.01);
UseRoulett = strcmp(ANSWER,'RoulettWheel');
UseTournament = strcmp(ANSWER,'Tournament');
UseRandom = strcmp(ANSWER,'Random');

%% Initialization 

empty_Indvidul.Position = [];
empty_Indvidul.Cost = [];

pop = repmat(empty_Indvidul,nPop,1);

for i=1:nPop
    pop(i).Position = CreateRandomSolution(model);
    pop(i).Cost = CostFunction(pop(i).Position);
end

Costs = [pop.Cost]';
[Costs, sortorder] =sort(Costs);
pop = pop(sortorder);
BestSol = repmat(empty_Indvidul,MaxIt,1);
WorstSol = repmat(empty_Indvidul,MaxIt,1);
BestSol(1) = pop(1) ;
WorstCost = pop(end).Cost;

% Array to hold number of NFEl

nfe = zeros(MaxIt,1);
%% Main Loop
for i = 1:MaxIt
            
            % Calculate Selection Probabilits
            p = exp(-beta*Costs/WorstCost);
            p = p/sum(p);
            
            popc = repmat(empty_Indvidul,nc/2,2);
            for k = 1:nc/2
                
               % Select Parents With RoulettWheel 
               if UseRoulett
                i1 = RoulettWheelSelection(p);
                i2 = RoulettWheelSelection(p);
               end
                % Select Parents With Random Selection
                if UseRandom
                i1 = randi([1 nPop],1);
                i2 = randi([1 nPop],1);
                end
                % Select Parents With Tournament
                if UseTournament
                i1 = TournamentSelection(pop,TournamentSize);
                i2 = TournamentSelection(pop,TournamentSize);
                end
                p1 = pop(i1);
                p2 = pop(i2);
                % Apply Crossover
                [popc(k,1).Position popc(k,2).Position] = PermutationCrossover(p1.Position, p2.Position);
                popc(k,1).Cost = CostFunction(popc(k,1).Position);
                popc(k,2).Cost = CostFunction(popc(k,2).Position);
            end
            
            popc = reshape(popc,[],1);
           % Apply Mutation
           popm = repmat(empty_Indvidul,nm,1);
           for m = 1 : nm
          i1 = randi([1,nPop],1);
             popm(m).Position = PermutationMutate(pop(i1).Position);
             popm(m).Cost = CostFunction(popm(m).Position);
           end
           
           % Merg
           pop = [pop
                 popc
                 popm];
            % sorting
            Costs = [pop.Cost]';  
            [Costs sortorder] = sort(Costs);
            pop = pop(sortorder);
            % Truncate
            pop = pop(1:nPop);
            Costs = Costs(1:nPop);
            BestSol(i) = pop(1);
            WorstSol(i) = pop(end);
            WorstCost = max(WorstSol(i).Cost,WorstCost);
            nfe(i) = NFE;
            
          disp(['In The Iteration:  ' num2str(i) '   Best sol in this It is: ' num2str(BestSol(i).Cost)...
              '   Number of NFE: ' num2str(nfe(i))]); 
          figure(1);
         
         PlotLocations(BestSol(i).Position,model);
         pause(0.3);
end

%% Plot Results
BestCosts = [BestSol.Cost];
WorstCosts = [WorstSol.Cost];

figure(2);
plot(nfe,BestCosts,'LineWidth',2);
xlabel('NFE');
ylabel('Best Costs');









