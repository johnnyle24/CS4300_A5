function [score, trace] = CS4300_A5_Driver()
% CS4300_A4b_Driver - given a board, runs the hybrid wumpus agent
% On input:
%     board: nxn int array
% On output:
%     score (int): agent score on game
%     trace (nx3 int array): trace of state
%       (i,1): x location
%       (i,2): y location
%       (i,3): action selected at time i
% Call:
%     [s,t] = CS4300_A4b_Driver(board);
% Author:
%     UU
%     Summer 2015
%

%           0: means empty cell
%           1: means a pit in cell
%           2: means gold (only) in cell
%           3: means Wumpus (only) in cell
%           4: means gold and Wumpus in cell
clear all;

clc;

load('A5_boards.mat');

max_steps = 100;
%{
board1 = [0,1,1,1;...
    0,1,1,1;...
    0,0,2,1;...
    0,0,1,1];



board2 = [0,0,0,1;...
    1,2,1,0;...
    0,0,0,0;...
    0,1,1,0];

board3 = [0,0,0,0;0,0,0,0;0,2,0,0;0,0,0,0]

board4 = [0,0,0,3;...
          0,0,0,0;...
          2,1,0,0;...
          0,0,0,0;];

scores = zeros(3,1);

%}


samples = 0;
results = zeros(250,2);

for i = 1:250
    i;
    b = boards(i).board;
    clear('CS4300_WW1');
    clear('CS4300_MC_agent');
    [score,trace] = CS4300_WW1(max_steps,'CS4300_MC_agent',b,samples);
    results(i,1) = score;
    if(score < 0)
        results(i,2) = 0;
    else
        results(i,2) = 1;
    end
end

samples = 50;
results1 = zeros(250,2);

for i = 1:250
    i;
    b = boards(i).board;
    clear('CS4300_WW1');
    clear('CS4300_MC_agent');
    [score,trace] = CS4300_WW1(max_steps,'CS4300_MC_agent',b,samples);
    results1(i,1) = score;
    if(score < 0)
        results1(i,2) = 0;
    else
        results1(i,2) = 1;
    end
end

samples = 100;
results2 = zeros(250,2);

for i = 1:250
    i;
    b = boards(i).board;
    clear('CS4300_WW1');
    clear('CS4300_MC_agent');
    [score,trace] = CS4300_WW1(max_steps,'CS4300_MC_agent',b,samples);
    results2(i,1) = score;
    if(score < 0)
        results2(i,2) = 0;
    else
        results2(i,2) = 1;
    end
end

samples = 250;
results3 = zeros(250,2);

for i = 1:250
    i;
    b = boards(i).board;
    clear('CS4300_WW1');
    clear('CS4300_MC_agent');
    [score,trace] = CS4300_WW1(max_steps,'CS4300_MC_agent',b,samples);
    results3(i,1) = score;
    if(score < 0)
        results3(i,2) = 0;
        %disp('FAIL')
    else
        results3(i,2) = 1;
        %disp('SUCCESS')
    end
end



mean_0 = mean(results(:,1));
sum_0 = sum(results(:,2));
mean_50 = mean(results1(:,1));
sum_50 = sum(results1(:, 2));
mean_100 = mean(results2(:,1));
sum_100 = sum(results2(:,2));
mean_250 = mean(results3(:,1));
sum_250 = sum(results3(:,2));

var_0 = var(results(:,1));
var_50 = var(results1(:,1));
var_100 = var(results2(:,1));
var_250 = var(results3(:,1));

CI_Results_0_1 = mean_0 - 1.96*sqrt(var_0/250);
CI_Results_0_2 = mean_0 + 1.96*sqrt(var_0/250);

CI_Results_50_1 = mean_50 - 1.96*sqrt(var_50/250);
CI_Results_50_2 = mean_50 + 1.96*sqrt(var_50/250);

CI_Results_100_1 = mean_100 - 1.96*sqrt(var_100/250);
CI_Results_100_2 = mean_100 + 1.96*sqrt(var_100/250);

CI_Results_250_1 = mean_250 - 1.96*sqrt(var_250/250);
CI_Results_250_2 = mean_250 + 1.96*sqrt(var_250/250);



disp('hello');




