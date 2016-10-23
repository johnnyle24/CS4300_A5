function value = CS4300_A_star_Man(initial_state,goal_state)

% CS4300_A_star_Man - A heuristic function using the Manhattan Distance
% On input:
%       initial_location    (1x3 vector): x,y,dir
%       goal_location       (1x3 vector): x,y,dir
% On output:
%       value               (integer): Mnimum Manhattan Distance between
%                           initial location and goal location  
% Call:
% value = CS4300_A_star_Man([1,1],[2,2])
% value = 2
%
% Author:
%   Trung Le and Johnny Le 
%   UU
%   Fall 2016

delta_x = abs(goal_state(1) - initial_state(1));
delta_y = abs(goal_state(2) - initial_state(2));

value = delta_x + delta_y;