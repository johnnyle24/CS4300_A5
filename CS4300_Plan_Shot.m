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


for i = 1:length(safe)
   for j = 1:length(safe)
       if(i == target(1) || j == target(2))
          if(safe(i, j) == 1 || safe(i, j) == -1)
              new_dist = abs(i-current(1)) + abs(j-current(2));
              if(new_dist <= distance)
                 distance = new_dist;
                 targetx = i;
                 targety = j;
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
if(goal_state(1) == initial_state(1) && goal_state(2) == initial_state(2))
    plantemp(j).p = -1;
    while(direction ~= initial_state(3))
       plantemp(j).p = 2;
       j = j + 1;
       initial_state(3) = initial_state(3) - 1;
       if(initial_state(3) < 0)
          initial_state(3) = 3; 
       end
    end
    return;
end

[sol,nod] = CS4300_Wumpus_A_star_safe(safe,initial_state,goal_state,'CS4300_A_star_Man',safe);

j = 1;

for i = 2:size(sol, 1)
   plantemp(j).p = sol(i,4); 
   j = j + 1;
end


end