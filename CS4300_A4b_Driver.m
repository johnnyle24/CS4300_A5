function [score, trace] = CS4300_A4b_Driver()
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

max_steps = 100;
board1 = [0,1,1,1;...
    0,1,1,1;...
    0,0,2,1;...
    0,0,1,1];



board2 = [0,0,0,1;...
    3,2,1,0;...
    1,0,0,0;...
    0,1,1,0];

board3 = [0,0,0,0;0,0,0,0;0,0,0,0;0,2,0,0];

scores = zeros(3,1);

[score,trace] = CS4300_WW1(max_steps,'CS4300_Hybrid_Wumpus_Agent',board1);





scores

