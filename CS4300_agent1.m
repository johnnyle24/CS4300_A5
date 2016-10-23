function action = CS4300_agent(percept)
% CS4300_agent - simple agent example
%    
% On input:
%     percept (1x5 Boolean vector): percept values
%      (1): Stench
%      (2): Pit
%      (3): Glitters
%      (4): Bumped
%      (5): Screamed
% On output:
%     action (int): action selected by agent
%       FORWARD = 1;
%       ROTATE_RIGHT = 2;
%       ROTATE_LEFT = 3;
%       GRAB = 4;   -- NOT USED
%       SHOOT = 5;  -- NOT USED
%       CLIMB = 6;  -- NOT USED
% Call:
%     a = CS4300_Example1([0,1,0,0,0]);
% Author:
%     T. Henderson
%     UU
%     Summer 2015
%

persistent state

FORWARD = 1;
ROTATE_RIGHT = 2;
ROTATE_LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

if isempty(state)
    state = 0;
end

x = randi([0, 2]);

switch x
    case 0
        action = FORWARD;
        state = 1;
    case 1
        action = ROTATE_RIGHT;
        state = 2;
    case 2
        action = ROTATE_LEFT;
        state = 3;
        
end
