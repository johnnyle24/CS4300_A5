function [solution] = CS4300_Traceback(currentState_index, currentState, cameFrom, state_list, nodes)
%{ CS4300_Traceback - returns the solution
% On input:
%       currentState_index (int): number of boards to generate
%       currentState (3x1 int)
%       cameFrom (map(int x int))
%       state_list (map(int x 3x1 int)) 
%       nodes
% On output:
%     [solution]: the actions the agent took to get to current state
% Call:
%     solution = CS4300_Traceback(5, [3,3,1], cameFrom, state_list, nodes);
% Author:
%     Trung Le and Johnny Le
%     UU
%     08/30/2016 Fall 2016
%


parentIndex = cameFrom(currentState_index);

count = 0;

while(parentIndex ~= 0)
    parentIndex = cameFrom(parentIndex);
    count = count + 1;
end

parentIndex = cameFrom(currentState_index);
state = currentState;
count = count + 1;
solution = zeros(count, 4);
index = count;
parentIndex = currentState_index;

while(parentIndex ~= 0 && index ~= 0)
    solution(index,1) = state(1);
    solution(index,2) = state(2);
    solution(index,3) = state(3);
    solution(index,4) = nodes(parentIndex).action;
    index = index - 1;
    
    parentIndex = cameFrom(parentIndex);
    if(parentIndex ~= 0)
        state = state_list(parentIndex);  
    end
    
  
end

    
