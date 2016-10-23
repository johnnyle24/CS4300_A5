function [solution,nodes] = CS4300_Wumpus_A_star1(board,initial_state,goal_state,h_name,option)
% CS4300_Wumpus_A_star1 - A* algorithm for Wumpus world
% On input:
%       board (4x4 int array): Wumpus board layout
%           0: means empty cell
%           1: means a pit in cell
%           2: means gold (only) in cell
%           3: means Wumpus (only) in cell
%           4: means gold and Wumpus in cell
%       initial_state (1x3 vector): x,y,dir state
%       goal_state (1x3 vector): x,y,dir state
%       h_name (string): name of heuristic function
%       option (int): picks insertion strategy for equal cost states
%           1: insert state before equal or greater than states
%           2: insert after equal or less than states
% On output:
%       solution (nx4 array): solution sequence of state and the action
%       nodes (search tree data structure): search tree
%           (i).parent (int): index of node’s parent
%           (i).level (int): level of node in search tree
%           (i).state (1x3 vector): [x,y,dir] state represented by node
%           (i).action (int): action along edge from parent to node
%           (i).g (int): path length from root to node
%           (i).h (float): heuristic value (estimate from node to goal)
%           (i).cost (float): g + h (called f value in text)
%           (i).children (1xk vector): list of node’s children
% Call:
%[so,no] = CS4300_Wumpus_A_star1([0,0,0,0;0,0,0,1;0,2,1,3;0,0,0,0],...
%           [1,1,0],[2,2,1],’CS4300_A_star_Man’,1)
% so =
%   1 1 0 0
%   2 1 0 1
%   2 1 1 3
%   2 2 1 1
%
% no = 1x9 struct array with fields:
%   parent
%   level
%   state
%   action
%   cost
%   g
%   h
%   children
% Author:
%   Trung Le and Johnny Le
%   UU
%   Fall 2016

% Flags: 1 = alive, 2 = found gold, 3 = dead (found pit/Wumpus)
flag = 1;

% Nodes already explored
explored = zeros(1,64);

% Nodes discovered but yet to be explored
% Frontier keeps track of the index of node, lower indexes in the frontier
% array means the node associated is cheaper than higher indexes
% 0 indicates an empty index
frontier = zeros(1,128);

% Identifies a state with a unique index
 state_list = containers.Map(1, initial_state);
% state_list = zeros(64,1);

% Mapping from index to index where first argument is current node and
% second argument is most efficient parent node
cameFrom = containers.Map(1, 0);

% When a new node is discovered, append it to the state_list at current
% index and add it and its parent node to cameFrom
currentIndex = 1;

% Array of path length, each index identifies a state
g = zeros(1,64);

% Array of costs, each index identifies a state and the value at the index
% is the cost
f = zeros(1,64);

% Instantiate base case at root node

% Initial path length is zero
g(1) = 0;

% Initial cost is the heuristic
cost = g(1) + CS4300_A_star_Man(initial_state, goal_state);

f(1) = cost;

exploredIndex = 1;

nodes(1).parent = 0;
nodes(1).level = 0;
nodes(1).state = initial_state;
nodes(1).action = 0;
nodes(1).cost = g(1);
nodes(1).children = zeros(1,3);

frontier(64) = 1;

startIndex = 64;

if(option == 1)
 
    while(~isempty(frontier) && flag == 1)
        % Iterate through frontier, get the index I associated with the
        % lowest cost value
        % The first non zero index is guaranteed to be the cheapest
        
        pitWumpus = 0;
        
        for i = 1:128
            if(frontier(i) ~= 0)
                % Get node index to explore from frontier 
                currentNode_index = frontier(i);
                % Get state from state list using node index 
                currentState = state_list(currentNode_index); 

                % Set frontier at index to 0 meaning it is not unexplored
                frontier(i) = 0;
                
                % Add node index to explored meaning it has already been
                % explored
                explored(exploredIndex) = currentNode_index;
                exploredIndex = exploredIndex + 1;
                
                % Check what is on current state
                y_val = CS4300_conversion(currentState(2));
                % Current location contains pit
                if(board(y_val,currentState(1)) == 1)
                    pitWumpus = 1;
                    break;
                end

                % Current location contains gold
                if(board(y_val,currentState(1)) == 2)
                    flag = 2;
                    solution = CS4300_Traceback(currentNode_index, currentState, cameFrom, state_list, nodes);
                end

                % Current location contains wumpus
                if(board(y_val,currentState(1)) == 3)
                    pitWumpus = 1;
                    break;
                end

                % Current location contains wumpus/gold
                if(board(y_val,currentState(1)) == 4)
                    flag = 3;
                    solution = CS4300_Traceback(currentNode_index, currentState, cameFrom, state_list, nodes);
                    break;
                end
                
                break;
            end
        end
        

        
        if(flag == 1 && pitWumpus == 0)
            found = 0;

            % Get children from current state
            children = CS4300_explore(currentState); 

            child_index_list = [0,0,0];

            % Check if child exists in state list BEGIN
            child = zeros(1,3);
           
            for indices = 1:3
                child(1) = children(indices, 1);
                child(2) = children(indices, 2);
                child(3) = children(indices, 3);
                
                if(child(1) ~= 0 && child(2) ~= 0)
                    for check = 1:currentIndex
                       state_to_check = state_list(check);

                       if(child(1) == state_to_check(1) && child(2) == state_to_check(2) && child(3) == state_to_check(3))
                           found = 1;
                       end
                    end
                    % If state not yet in state list
                    if(found ~= 1)
                        % Increment current index, child index is at current index
                        currentIndex = currentIndex + 1;
                        child_index = currentIndex;
                        % Add state to state list at correct index
                        state_list(child_index) = child; 
                        % Child length is length of parent + 1
                        child_length = g(currentNode_index) + 1;
                        % Add child length at correct index
                        g(child_index) = child_length;
                        % Compute child cost and add at correct index
                        f(child_index) = g(child_index) + CS4300_A_star_Man(child, goal_state); 

                        child_index_list(indices) = child_index;
                        cameFrom(child_index) = currentNode_index;
                        % Add information about new discovered node to node
                        % data structure
                        nodes(currentIndex).parent = currentNode_index;
                        nodes(currentIndex).level = g(child_index);
                        nodes(currentIndex).state = child;
                        nodes(currentIndex).action = children(indices, 4);
                        nodes(currentIndex).cost = f(child_index);
                        nodes(child_index).children = zeros(1,3);
                    end 
                end 
            end

                    
            % Check END

            % Compare the costs of the children and add the child index
            % corresponding to the lowest cost



            for iteration = 1:3
                if(child_index_list(1) == 0)
                    if(child_index_list(2) == 0)
                        min_child_index = child_index_list(3);
                        previous_child_index = child_index_list(3);
                        child_index_list(3) = 0;
                    else
                        min_child_index = child_index_list(2);
                        previous_child_index = child_index_list(2);
                        child_index_list(2) = 0;
                    end
                else
                    min_child_index = child_index_list(1);
                    previous_child_index = child_index_list(1);
                    child_index_list(1) = 0;
                end


                %for child_index_2 = 2:3
                    %if (child_index_list(child_index_2) ~= 0 && f(child_index_list(child_index_2)) < f(min_child_index))

                        % Sets the previous child_index to no longer be 0 if a new
                        % min was found
                        %child_index_list(child_index_2 - 1) = previous_child_index; 
                        %min_child_index = child_index_list(child_index_2);
                        %previous_child_index = child_index_list(child_index_2);
                        %child_index_list(child_index_2) = 0;
                    %end
                %end

                if(frontier(startIndex) == 0)      
                    for frontierIndices = 1:128
                        if(frontier(frontierIndices) ~= 0)
                            startIndex = frontierIndices;
                            break;
                        end 
                    end
                    if(frontier(startIndex) == 0)
                        startIndex = 64;
                    end
                end

                if(min_child_index ~= 0)
                    finished = 0;
                    
                    % Add child to children nodes
                    nodes(currentNode_index).children(iteration) = min_child_index;
                    while(finished == 0)
                        
                        if(frontier(startIndex) ~= 0)
                           
                            if(f(min_child_index) <= f(frontier(startIndex)))
                                temp = frontier(startIndex);

                                frontier(startIndex) = min_child_index; 

                                min_child_index = temp;    
                            end 
                            
                            startIndex = startIndex + 1;   
                        else
                            frontier(startIndex) = min_child_index;
                            finished = 1;
                            startIndex = startIndex + 1;
                        end
                        %frontierIndex = frontierIndex + 1;
                        %frontier(frontierIndex) = min_child_index;
                    end  
                    
                end
            end 
        end 

    end
else
    while(~isempty(frontier) && flag == 1)
        % Iterate through frontier, get the index I associated with the
        % lowest cost value
        % The first non zero index is guaranteed to be the cheapest
        
        for i = 1:128
            if(frontier(i) ~= 0)
                % Get node index to explore from frontier 
                currentNode_index = frontier(i);
                % Get state from state list using node index 
                currentState = state_list(currentNode_index); 

                % Set frontier at index to 0 meaning it is not unexplored
                frontier(i) = 0;
                % Add node index to explored meaning it has already been
                % explored
                explored(exploredIndex) = currentNode_index;
                exploredIndex = exploredIndex + 1;
                break;
            end
        end
        
        % Check what is on current state
        y_val = CS4300_conversion(currentState(2));
        % Current location contains pit
        if(board(y_val,currentState(1)) == 1)
            flag = 3;
            solution = CS4300_Traceback(currentNode_index, currentState, cameFrom, state_list, nodes);
        end
        
        % Current location contains gold
        if(board(y_val,currentState(1)) == 2)
            flag = 2;
            solution = CS4300_Traceback(currentNode_index, currentState, cameFrom, state_list, nodes);
        end
        
        % Current location contains wumpus
        if(board(y_val,currentState(1)) == 3)
            flag = 3;
            solution = CS4300_Traceback(currentNode_index, currentState, cameFrom, state_list, nodes);
        end

        % Current location contains wumpus/gold
        if(board(y_val,currentState(1)) == 4)
            flag = 3;
            solution = CS4300_Traceback(currentNode_index, currentState, cameFrom, state_list, nodes);
        end
        
        if(flag == 1)
            found = 0;

            % Get children from current state
            children = CS4300_explore(currentState); 

            child_index_list = [0,0,0];

            % Check if child exists in state list BEGIN
            child = zeros(1,3);
           
            for indices = 1:3
                child(1) = children(indices, 1);
                child(2) = children(indices, 2);
                child(3) = children(indices, 3);
                
                if(child(1) ~= 0 && child(2) ~= 0)
                    for check = 1:currentIndex
                       state_to_check = state_list(check);

                       if(child(1) == state_to_check(1) && child(2) == state_to_check(2) && child(3) == state_to_check(3))
                           found = 1;
                       end
                    end
                    % If state not yet in state list
                    if(found ~= 1)
                        % Increment current index, child index is at current index
                        currentIndex = currentIndex + 1;
                        child_index = currentIndex;
                        % Add state to state list at correct index
                        state_list(child_index) = child; 
                        % Child length is length of parent + 1
                        child_length = g(currentNode_index) + 1;
                        % Add child length at correct index
                        g(child_index) = child_length;
                        % Compute child cost and add at correct index
                        f(child_index) = g(child_index) + CS4300_A_star_Man(child, goal_state); 

                        child_index_list(indices) = child_index;
                        cameFrom(child_index) = currentNode_index;
                        % Add information about new discovered node to node
                        % data structure
                        nodes(currentIndex).parent = currentNode_index;
                        nodes(currentIndex).level = g(child_index);
                        nodes(currentIndex).state = child;
                        nodes(currentIndex).action = children(indices, 4);
                        nodes(currentIndex).cost = f(child_index);
                        nodes(child_index).children = zeros(1,3);
                    end 
                end 
            end

                    
            % Check END

            % Compare the costs of the children and add the child index
            % corresponding to the lowest cost



            for iteration = 1:3
                if(child_index_list(1) == 0)
                    if(child_index_list(2) == 0)
                        min_child_index = child_index_list(3);
                        previous_child_index = child_index_list(3);
                        child_index_list(3) = 0;
                    else
                        min_child_index = child_index_list(2);
                        previous_child_index = child_index_list(2);
                        child_index_list(2) = 0;
                    end
                else
                    min_child_index = child_index_list(1);
                    previous_child_index = child_index_list(1);
                    child_index_list(1) = 0;
                end


                %for child_index_2 = 2:3
                    %if (child_index_list(child_index_2) ~= 0 && f(child_index_list(child_index_2)) < f(min_child_index))

                        % Sets the previous child_index to no longer be 0 if a new
                        % min was found
                        %child_index_list(child_index_2 - 1) = previous_child_index; 
                        %min_child_index = child_index_list(child_index_2);
                        %previous_child_index = child_index_list(child_index_2);
                        %child_index_list(child_index_2) = 0;
                    %end
                %end

                if(frontier(startIndex) == 0)      
                    for frontierIndices = 128:1
                        if(frontier(frontierIndices) ~= 0)
                            startIndex = frontierIndices;
                            break;
                        end 
                    end
                    if(frontier(startIndex) == 0)
                        startIndex = 64;
                    end
                end

                if(min_child_index ~= 0)
                    finished = 0;
                    
                    % Add child to children nodes
                    nodes(currentNode_index).children(iteration) = min_child_index;
                    while(finished == 0)
                        
                        if(frontier(startIndex) ~= 0)
                            
                            if(f(min_child_index) >= f(frontier(startIndex)))
                                temp = frontier(startIndex);

                                frontier(startIndex) = min_child_index; 

                                min_child_index = temp;    
                            end 
                            
                            startIndex = startIndex - 1;   
                        else
                            frontier(startIndex) = min_child_index;
                            finished = 1;
                            startIndex = startIndex - 1;
                        end
                        %frontierIndex = frontierIndex + 1;
                        %frontier(frontierIndex) = min_child_index;
                    end  
                    
                end
            end 
        end 

    end
end






