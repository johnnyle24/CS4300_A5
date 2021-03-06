function plantemp = CS4300_Plan_Shot(current,target,safe)
%Given x, y return the stench index
%Pits [1,16]
%Breeze [17,32]
%Stench [33,48]
%Wumpus [49,65]
%Gold [66, 81]

%Type
%0 Pits
%1 Breeze
%2 Stench
%3 Wumpus
%4 Gold

initial_state = zeros(1,3);
initial_state(1) = current(1);
initial_state(2) = current(2);
initial_state(3) = current(3);

distance = length(safe);

targetx = current(1);
targety = current(2);


for i = 1:4
   for j = 1:4
       if(4-i+1 == target(2) || j == target(1))
          if(safe(i, j) == 1)
%           if(safe(i, j) == 1 || safe(i, j) == -1)
              new_dist = abs(j-current(1)) + abs(4-i+1-current(2));
              if(new_dist <= distance)
                 distance = new_dist;
                 targetx = j;
                 targety = 4-i+1;
              end
          end
       end
   end
end



direction = 0;

if(targetx < target(1))
    direction = 0;
end
if(targetx > target(1))
    direction = 2;
end
if(targety < target(2))
    direction = 1;
end
if(targety > target(2))
    direction = 3;
end

goal_state = zeros(1,3);
goal_state(1) = targetx;
goal_state(2) = targety;
goal_state(3) = direction;

% FORWARD = 1;
% ROTATE_RIGHT = 2;
% ROTATE_LEFT = 3;
% GRAB = 4;
% SHOOT = 5;
% CLIMB = 6;
j = 1;
[sol,nod] = CS4300_Wumpus_A_star_safe(safe,initial_state,goal_state,'CS4300_A_star_Man',safe);
if(~isempty(sol))
    plantemp = [sol(2:end,4)];
    j = size(sol, 1);
end

if(goal_state(1) == initial_state(1) || goal_state(2) == initial_state(2))
    
    if(initial_state(3) < direction)    
        difference_left = abs(initial_state(3) - direction);
        different_right = abs(initial_state(3) - direction+4);
    else
        difference_left = abs(initial_state(3) - direction+4);
        different_right = abs(initial_state(3) - direction);
    end
    
    if(difference_left < different_right)
        turn = 3;
        turning = 1;
    else
        turn = 2;
        turning = -1;
    end
    
    while(direction ~= initial_state(3))
       plantemp(j) = turn;
       j = j + 1;
       
       
       initial_state(3) = initial_state(3) + turning;
       if(initial_state(3) < 0)
          initial_state(3) = 3;
       elseif(initial_state(3) > 3)
           inital_state(3) = 0;
       end
    end 
end



% j = 1;

% for i = 2:size(sol, 1)
%    plantemp(j).p = sol(i,4); 
%    j = j + 1;
% end


plantemp(j) = 5;


end