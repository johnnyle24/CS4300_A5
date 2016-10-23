function [scores,traces] = CS4300_WW32(max_steps,f_name)
% CS4300_WW3 - Wumpus World 3 (hybrid agent) simulator
% On input:
%     max_steps (int): maximum number of simulation steps
%     f_name (string): name of agent function
% On output:
%     score (int): agent score on game
%     trace (nx3 int array): trace of state
%       (i,1): x location
%       (i,2): y location
%       (i,3): action selected at time i
% Call:
%     [s,t] = CS4300_WW3(50,'CS4300_hybrid_agent');
% Author:
%     T. Henderson
%     UU
%     Summer 2015
%

traces = [];

agent.x = 1;
agent.y = 1;
agent.alive = 1;  
agent.gold = 0;  % grabbed gold in same room
agent.dir = 0;  % facing right
agent.succeed = 0;  % has gold and climbed out
agent.climbed = 0; % climbed out

clear(f_name);

board1 = [0,0,0,3;...
    0,0,0,0;...
    2,1,0,0;...
    0,0,0,0];
[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board1);
scores1(1).board = board1;
scores1(1).score = score;
scores1(1).trace = trace;
scores1(1).shc = shot_count;
scores1(1).scc = scream_count;

clear(f_name);

[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board1);
scores1(2).board = board1;
scores1(2).score = score;
scores1(2).trace = trace;
scores1(2).shc = shot_count;
scores1(2).scc = scream_count;


clear(f_name);

[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board1);
scores1(3).board = board1;
scores1(3).score = score;
scores1(3).trace = trace;
scores1(3).shc = shot_count;
scores1(3).scc = scream_count;


clear(f_name);

board2 = [0,0,0,1;...
    3,2,1,0;...
    0,0,0,0;...
    0,0,1,0];
[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board2);
scores2(1).board = board2;
scores2(1).score = score;
scores2(1).trace = trace;
scores2(1).shc = shot_count;
scores2(1).scc = scream_count;


clear(f_name);

[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board2);
scores2(2).board = board2;
scores2(2).score = score;
scores2(2).trace = trace;
scores2(2).shc = shot_count;
scores2(2).scc = scream_count;



clear(f_name);

[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board2);
scores2(3).board = board2;
scores2(3).score = score;
scores2(3).trace = trace;
scores2(3).shc = shot_count;
scores2(3).scc = scream_count;


clear(f_name);

board3 = [0,0,0,0;...
    0,0,0,0;...
    3,2,0,0;...
    0,1,0,0];
[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board3);
scores3(1).board = board3;
scores3(1).score = score;
scores3(1).trace = trace;
scores3(1).shc = shot_count;
scores3(1).scc = scream_count;


clear(f_name);

[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board3);
scores3(2).board = board3;
scores3(2).score = score;
scores3(2).trace = trace;
scores3(2).shc = shot_count;
scores3(2).scc = scream_count;



clear(f_name);

[score,trace,shot_count,scream_count] = CS4300_WW1(max_steps,f_name,board3);
scores3(3).board = board3;
scores3(3).score = score;
scores3(3).trace = trace;
scores3(3).shc = shot_count;
scores3(3).scc = scream_count;

disp('done');

