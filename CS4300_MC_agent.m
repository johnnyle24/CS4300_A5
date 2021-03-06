function action = CS4300_MC_agent(percept,num_trials)
% CS4300_MC_agent - Monte Carlo agent with a few informal rules
% On input:
%     percept (1x5 Boolean vector): percept from Wumpus world
%       (1): stench
%       (2): breeze
%       (3): glitter
%       (4): bump
%       (5): scream
% On output:
%     action (int): action to take
%       1: FORWARD
%       2: RIGHT
%       3: LEFT
%       4: GRAB
%       5: SHOOT
%       6: CLIMB
% Call:
%     a = CS4300_MC_agent(percept);
% Author:
%     T. Henderson
%     UU
%     Fall 2016
%

FORWARD = 1;
RIGHT = 2;
LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

persistent safe pits Wumpus board have_gold have_arrow plan
persistent agent frontier visited t breezes stenches

if isempty(agent)
    t = 0;
    agent.x = 1;
    agent.y = 1;
    agent.dir = 0;
    safe = -ones(4,4);
    pits = -ones(4,4);
    Wumpus = -ones(4,4);
    board = -ones(4,4);
    visited = zeros(4,4);
    frontier = zeros(4,4);
    breezes = -ones(4,4);
    stenches = -ones(4,4);
    safe(4,1) = 1;
    pits(4,1) = 0;
    Wumpus(4,1) = 0;
    board(4,1) = 0;
    visited(4,1) = 1;
    frontier(3,1) = 1;
    frontier(4,2)  = 1;
    have_gold = 0;
    have_arrow = 1;
    [pits, Wumpus] = CS4300_WP_estimates(breezes, stenches, num_trials);
end

visited(4-agent.y+1,agent.x) = 1;

if have_gold==1&&~isempty(plan)
    action = plan(1);
    plan = plan(2:end);
    return
end

if percept(1)==1
    stenches(CS4300_conversion(agent.y), agent.x) = 1;
else
    stenches(CS4300_conversion(agent.y), agent.x) = 0;
end

if percept(2)==1
    breezes(CS4300_conversion(agent.y), agent.x) = 1;
else
    breezes(CS4300_conversion(agent.y), agent.x) = 0;
end

if percept(1)==0 && percept(2)==0
    safe = CS4300_safety(agent.x, agent.y, safe, 1);
    board = CS4300_safety(agent.x, agent.y, board, 0);
end

if(frontier(CS4300_conversion(agent.y), agent.x) == 1)
    frontier(CS4300_conversion(agent.y), agent.x) = 0;
    
    frontier = CS4300_frontier(agent.x, agent.y, visited, frontier);
    
    board(CS4300_conversion(agent.y), agent.x) = 0;
    safe(CS4300_conversion(agent.y), agent.x) = 1;
    [pits, Wumpus] = CS4300_WP_estimates(breezes, stenches, num_trials);
end


if percept(3)==1
    plan = [GRAB];
    have_gold = 1;
    [so,no] = CS4300_Wumpus_A_star_safe(abs(board),...
        [agent.x,agent.y,agent.dir],...
        [1,1,0],'CS4300_A_star_Man', abs(board));
    plan = [plan;so(2:end,4)];
    plan = [plan;CLIMB];
end

if percept(5)==1
    stenches = zeros(4, 4);
    
    [pits, Wumpus] = CS4300_WP_estimates(breezes, stenches, num_trials);
    
    
end

if isempty(plan)
    [cand_rows,cand_cols] = find(frontier==1&safe==1&visited==0);
    if ~isempty(cand_rows)
        cand_x = cand_cols;
        cand_y = 4 - cand_rows + 1;
        [so,no] = CS4300_Wumpus_A_star_safe(abs(board),...
            [agent.x,agent.y,agent.dir],...
            [cand_x(1),cand_y(1),0],'CS4300_A_star_Man', abs(board));
        plan = [so(2:end,4)];
    end
end

stench_check = find(stenches==1);

% No Wumpus shot yet
if (have_arrow==1 && isempty(plan) && ~isempty(stench_check))
%     plan = CS4300_Plan_Shot(agent,Wumpus,visited,safe,board);

    
%     x = mod(wumpusIndices(1), 4);
%     y = floor(wumpusIndices(1) / 4) + 1;

    [cand_rows,cand_cols] = find(frontier==1);
    
    max = 0;
    
    finalx = cand_cols(1);
    
    finaly = cand_rows(1);
    
    max = Wumpus(finaly, finalx);
    
    for i = 1:size(cand_rows, 1)
        r = cand_rows(i);
        c = cand_cols(i);
        
        temp_wumpus = Wumpus(r,c);
        
        if(temp_wumpus > max)
           max = temp_wumpus;
           
           finalx = c;
           finaly = r;
        end

    end
    
    
    

    plan = CS4300_Plan_Shot([agent.x, agent.y, agent.dir],[finalx,4 - finaly + 1, 0],safe);
end

% Take a risk
if isempty(plan)
    %determine safest cell 
    
    [cand_rows,cand_cols] = find(frontier==1);
    
    min = 1;
    
    finalx = cand_cols(1);
    
    finaly = cand_rows(1);
    
    for i = 1:size(cand_rows, 1)
        r = cand_rows(i);
        c = cand_cols(i);
        
        prob_average = (Wumpus(r,c)+pits(r,c)) / 2;
        
        if(prob_average < min)
           min = prob_average;
           
           finalx = c;
           finaly = r;
        end

    end
    
    
%     cand_x = cand_cols;
%     cand_y = 4 - cand_rows + 1;

    temp_board = board;
    temp_board(finaly,finalx) = 0;
    [so,no] = CS4300_Wumpus_A_star_safe(abs(temp_board),...
        [agent.x,agent.y,agent.dir],...
        [finalx,4 - finaly + 1,0],'CS4300_A_star_Man', abs(temp_board));
    plan = [so(2:end,4)];
end

action = plan(1);
plan = plan(2:end);

% Update agent's idea of state
agent = CS4300_agent_update(agent,action);


%visited(4-agent.y+1,agent.x) = 1;

if action==SHOOT
    have_arrow = 0;
end

tch = 0;
tl = 0;
jl = 0;