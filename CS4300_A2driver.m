function [results, numberOfSteps, numberOfStates] = CS4300_A2driver(numBoards)
% CS4300_A2driver - runs the simulation for testing
% On input:
%     numBoards (int): number of boards to generate
% On output:
%     Prints:
%       The results of the simulation
%       The number of steps the agent took to reach the end
%       The number of states the A* algorithm generated
% Call:
%     [results, numberOfSteps, numberOfStates] = CS4300_A2driver(0.2)
% Author:
%     Trung Le and Johnny Le
%     UU
%     08/30/2016 Fall 2016
%


count = 0;
% Keeps tracks of results, 1 means successfully found gold, 2 means dead
results = zeros(numBoards,1);
% Keeps track of number of steps to goal
numberOfSteps = zeros(numBoards,1);
% Keeps track of total number of states generated
numberOfStates = zeros(numBoards,1);
for p = 1:numBoards

    [board, gold_loc] = CS4300_generate_board(0.2);

    x_val = CS4300_conversion(gold_loc(1));
    
    gold_location = zeros(1,2);
    gold_location(1) = gold_loc(2);
    gold_location(2) = x_val;
    
    V = zeros(numBoards,1);    
    [sol, nod] = CS4300_Wumpus_A_star1([0,0,0,0;0,0,0,0;0,2,0,0;0,0,0,0],[1,1,0],[2,2,0],'CS4300_A_star_Man',2);
    s = size(sol);
    end_location = s(1);
    end_x = sol(end_location,1);
    end_y = sol(end_location,2);
    
    numberOfSteps(p) = s(1);
    
    s = size(nod);
    numberOfStates(p) = s(2);
    
    if(end_x == gold_location(1) && end_y == gold_location(2))
        results(p) = 1;
    else
        results(p) = 0;
    end
end

results;
meanResults = mean(results);
meanNumberOfSteps = mean(numberOfSteps);
meanNumberOfStates = mean(numberOfStates);

varResults = var(results);
varNumberOfSteps = var(numberOfSteps);
varNumberOfStates = var(numberOfStates);

CI_Results_1 = meanResults - 1.96*sqrt(varResults/numBoards);
CI_Results_2 = meanResults + 1.96*sqrt(varResults/numBoards);

CI_NumSteps_1 = meanNumberOfSteps - 1.96*sqrt(varNumberOfSteps/numBoards);
CI_NumSteps_2 = meanNumberOfSteps + 1.96*sqrt(varNumberOfSteps/numBoards);

CI_NumState_1 = meanNumberOfStates - 1.96*sqrt(varNumberOfStates/numBoards);
CI_NumState_2 = meanNumberOfStates + 1.96*sqrt(varNumberOfStates/numBoards);

%figure

%subplot(3,1,1)
%bar(results)
%xlabel('Current Run')
%ylabel('Success')
%title('Success Rate')

%subplot(3,1,2)
%bar(numberOfSteps)
%xlabel('Current Run')
%ylabel('Number of Steps')
%title('Steps Per Run')

%subplot(3,1,3)
%bar(numberOfStates)
%xlabel('Current Run')
%ylabel('Number of States')
%title('States Per Run')

    