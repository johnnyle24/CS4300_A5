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

board2 = ...
     [0  ,   1  ,   0  ,   1;...
     1  ,   0 ,    0   ,  0;...
     0  ,   3 ,    1   ,  0;...
     0   ,  0   ,  2   ,  0;];
[score,trace] = CS4300_WW1(max_steps,'CS4300_MC_agent',board2);


results = zeros(250,2);

% for i = 1:100
%     i
%     if(i == 6)
%         disp('break');
%     end
%     b = boards(i).board
%     clear('CS4300_WW1');
%     clear('CS4300_MC_agent');
%     [score,trace] = CS4300_WW1(max_steps,'CS4300_MC_agent',b);
%     results(i,1) = score;
%     if(score < 0)
%         results(i,2) = 0;
%         disp('FAIL')
%     else
%         results(i,2) = 1;
%         disp('SUCCESS')
%     end
% end


disp('hello');




