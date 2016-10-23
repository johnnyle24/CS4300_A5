function action = CS4300_Hybrid_Wumpus_Agent(percept)
import java.util.Queue;
import java.util.LinkedList;
% CS4300_Hybrid_Wumpus_Agent - KB logic agent 
%    
% On input:
%     percept (1x5 Boolean vector): percept values
%      (1): Stench
%      (2): Breeze
%      (3): Glitters
%      (4): Bumped
%      (5): Screamed
% On output:
%     action (int): action selected by agent
%       FORWARD = 1;
%       ROTATE_RIGHT = 2;
%       ROTATE_LEFT = 3;
%       GRAB = 4;   
%       SHOOT = 5;  
%       CLIMB = 6;  
% Call:
%     a = CS4300_Example1([0,1,0,0,0]);
% Author:
%     T. Henderson
%     UU
%     Summer 2015
%

%Type
%0 Pits
%1 Breeze
%2 Stench
%3 Wumpus
%4 Gold

%Pits [1,16]
%Breeze [17,32]
%Stench [33,48]
%Wumpus [49,64]

FORWARD = 1;
ROTATE_RIGHT = 2;
ROTATE_LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

t = 0;

% plan = java.util.PriorityQueue;
% 
% plan.add({1, 0});
% 
% plan = (100, 1);

    persistent KB;
    persistent local_x;
    persistent shot;
    local_x = getGlobalx;
    persistent local_y;
    local_y = getGlobaly;

    persistent local_dir;
    local_dir = getGlobaldir;
    persistent visited;
    persistent board;
    persistent frontier;
    persistent plan;
    persistent succeed;

    persistent haveArrow;
 


if(isempty(KB))
    %Initially no pit and no wumpus in 1,1
    KB = CS4300_Initialize_KB();
    
    shot = 0;

    local_x = 1;
    
    local_y = 1;
    
    local_dir = 0;
    
    %0  not visited
    %1  visited
    %initially (1,1) visited
    visited = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
    
    %-1 dont know
    %0  safe/no pit or wumpus
    %1  not safe
    board = [-1,-1,-1,-1;-1,-1,-1,-1;-1,-1,-1,-1; 0,-1,-1,-1];
    
    %frontier:  neighbors of whats been visited
    %0  not on frontier
    %1  on frontier
    frontier = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
    
    plan = LinkedList();
    
    succeed = 0;
    
    haveArrow = 1;
    
end

if(shot == 0 && haveArrow == 0)
    shot = 1;
    
%     if(percept(5) == 1)
%         for x1 = 1:4
%             for y1 = 1:4
%                 sen(1).clauses = CS4300_Get_Index(y1,x1,-1,3);
%                 KB = CS4300_Tell(KB, sen); 
%                 sen(1).clauses = CS4300_Get_Index(y1,x1,-1,2);
%                 KB = CS4300_Tell(KB, sen); 
%             end
%         end
%     end
    
    if(percept(5) == 1)
        
        for x1 = 1:size(KB, 1)
            if(KB(x1).clauses < 48 && KB(x1).clauses > 33)
               KB(x1).clauses = KB(x1).clauses * -1; 
            end
        end
        
        if(local_dir == 0)
            for inc = 1:3
               if(local_x+inc <= 4)
    %                 sentence2(1).clauses = CS4300_Get_Index(local_x+inc, local_y, -1, 3);
    %                 KB = CS4300_Tell(KB, sentence2);
                    if(frontier(CS4300_conversion(local_y), local_x+inc) == 1)
                        board(CS4300_conversion(local_y), local_x+inc) = 0;
                    end
               end
            end
        end
        if(local_dir == 1)
            for inc = 1:3
               if(local_y+inc <= 4)
    %                sentence2(1).clauses = CS4300_Get_Index(local_x, local_y+inc, -1, 3);
    %                 KB = CS4300_Tell(KB, sentence2);
                    if(frontier(CS4300_conversion(local_y+inc), local_x) == 1)
                        board(CS4300_conversion(local_y+inc), local_x) = 0;
                    end
               end
            end
        end
        if(local_dir == 2)
            for inc = 1:3
               if(local_x-inc >= 0)
    %                sentence2(1).clauses = CS4300_Get_Index(local_x-inc, local_y, -1, 3);
    %                 KB = CS4300_Tell(KB, sentence2);
                    if(frontier(CS4300_conversion(local_y), local_x-inc) == 1)
                        board(CS4300_conversion(local_y), local_x-inc) = 0;
                    end
               end
            end
        end
        if(local_dir == 3)
            for inc = 1:3
               if(local_y-inc >= 0)
    %                sentence2(1).clauses = CS4300_Get_Index(local_x, local_y-inc, -1, 3);
    %                 KB = CS4300_Tell(KB, sentence2);
                    if(frontier(CS4300_conversion(local_y-inc), local_x) == 1)
                       board(CS4300_conversion(local_y-inc), local_x) = 0; 
                    end
               end
            end        
        end
    end
end

    
KB = CS4300_Tell(KB, CS4300_Make_Percept_Sentence(percept,local_x,local_y));

visited(CS4300_conversion(local_y), local_x) = 1;
frontier(CS4300_conversion(local_y),local_x) = 0;

frontier = CS4300_frontier(local_x,local_y,visited,frontier);

board = CS4300_safe(local_x,local_y,KB,board);

%On glitter

sentence1(1).clauses = CS4300_Get_Index(local_x,local_y,1,4);
if(CS4300_Ask(KB,sentence1) || percept(3) == 1)
   plan.add(GRAB);
   temp_plan = CS4300_Plan_Route([local_x, local_y, local_dir], [1,1,0], board);
   for temp_index = 1:length(temp_plan)
      plan.add(temp_plan(temp_index).p); 
   end
   plan.add(CLIMB);
end

found = 0;
random_index2 = 1;
%Go to safe square
if(plan.isEmpty()) % check to see if it is safe and if it is, navigates to it
    for i = 1:length(board)
        for j = 1:length(board)
            if(board(i, j) == 0)
                if(visited(i, j) == 0)
                    random3(random_index2).square = [i,j];
                    random_index2 = random_index2 + 1;
                    found = 1;
                end
            end
        end
    end
   
   if(found == 1)
       p = randi([1, random_index2-1]);
   
       tempy = random3(p).square(1);
       tempx = random3(p).square(2);
       
       tempyc = CS4300_conversion(tempy);
       temp_plan = CS4300_Plan_Route([local_x, local_y, local_dir], [tempx,tempyc,0], board);
       for temp_index = 1:length(temp_plan)
          plan.add(temp_plan(temp_index).p); 
       end
   end
   
end

random_index2 = 1;
%Make a safe square by shooting
if(plan.isEmpty() && haveArrow == 1)
    for i = 1:length(frontier)
        for j = 1:length(frontier)
            if(frontier(i, j) == 1)
                sentence1(1).clauses = CS4300_Get_Index(i, j, -1, 3);
                if(~CS4300_Ask(KB, sentence1))
                    random2(random_index2).square = [i,j];
                    random_index2 = random_index2 + 1;

                end
            end
        end
    end
    
    x = randi([1, random_index2-1])
    
    tempy1 = random2(x).square;
    tempy = tempy1(1);
    tempx = tempy1(2);
    
    tempyc = CS4300_conversion(tempy);
    temp_plan = CS4300_Plan_Shot([local_x, local_y, local_dir], [tempx,tempyc,0], board);
    
    if(temp_plan(1).p ~= -1)
        for temp_index = 1:length(temp_plan)
            plan.add(temp_plan(temp_index).p); 
        end
    end
    
    
    plan.add(SHOOT);

end

found = 0;

%Go to possibly safe square
if(plan.isEmpty())
    for i = 1:length(frontier)
        if(found == 1)
            break;
        end
        for j = 1:length(frontier)
            if(frontier(i, j) == 1)
                pit = CS4300_Get_Index(i,j,1,0);
                stench = CS4300_Get_Index(i,j,1,2);
                sentence(1).clauses = pit;
                sentence(2).clauses = stench;
                
                if(~CS4300_Ask(KB,sentence))
                    tempy = i;
                    tempx = j;
                    found = 1;
                    break;
                end
            end
        end
    end
   
   if(found == 1)
       tempyc = CS4300_conversion(tempy);
       temp_plan = CS4300_Plan_Route([local_x, local_y, local_dir], [tempx,tempyc,0], [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0]);
       for temp_index = 1:length(temp_plan)
          plan.add(temp_plan(temp_index).p); 
       end
   end
   
end

random_index = 1;
%go to random neigboring square
if(plan.isEmpty())
   for i = 1:length(frontier)
        for j = 1:length(frontier)
            if(frontier(i, j) == 1 && visited(i,j) == 0)
                random(random_index).square = [i,j];
                random_index = random_index + 1;
            end
        end
   end
    
   p = randi([1, random_index-1]);
   
   tempy = random(p).square(1);
   tempx = random(p).square(2);

   if(found == 1)
       tempyc = CS4300_conversion(tempy);
       temp_plan = CS4300_Plan_Route([local_x, local_y, local_dir], [tempx,tempyc,0], board);
       for temp_index = 1:length(temp_plan)
          plan.add(temp_plan(temp_index).p); 
       end
   end
   
end

action = plan.poll();

if(action == 5)
        
    haveArrow = 0;
end;




