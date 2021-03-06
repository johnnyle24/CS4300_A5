function valid = CS4300_check_board(breezes,stench,board)
% CS4300_check_board : checks for a valid board based on known percepts
% On input:
%   breezes (4x4 Boolean array): presence of breeze percept at cell
%   -1: no knowledge
%   0: no breeze detected
% 1: breeze detected
%   stench (4x4 Boolean array): presence of stench in cell
%       -1: no knowledge
%       0: no stench detected
%       1: stench detected
%   board (4x4 Boolean array): a board to be checked for validity
% On output:
%   valid: boolean stating validity of board
% Call:
%   breezes = -ones(4,4);
%   breezes(4,1) = 1;
%   stench = -ones(4,4);
%   stench(4,1) = 0;
%   [pts,Wumpus] = CS4300_WP_estimates(breezes,stench,10000)
%   pts =
%   0.2021 0.1967 0.1956 0.1953
%   0.1972 0.1999 0.2016 0.1980
%   0.5527 0.1969 0.1989 0.2119
%   0 0.5552 0.1948 0.1839
%
%   Wumpus =
%   0.0806 0.0800 0.0827 0.0720
%   0.0780 0.0738 0.0723 0.0717
%   0 0.0845 0.0685 0.0803
%   0 0 0.0741 0.0812
% Author:
% Johnny Le and Trung Le
% UU
% Fall 2016
%

valid = 0;

    %check for pits and wumpi
    for i = 1:4
        % i = rows/y
        for j = 1:4
            %j = columns/x
            
            if(breezes(i, j) == 1)
                
                foundPits = 0;
                
                % Check all neighbors to see if a pit is there
                %check right
                if(j+1 <= 4)
                    if(board(i, j+1) == 1)
                        foundPits = 1;
                    end
                end
                %check above
                if(i+1 <= 4)
                    if(board(i+1, j) == 1)
                        foundPits = 1;
                    end
                end
                %check below
                if(i-1 > 0)
                    if(board(i-1, j) == 1)
                        foundPits = 1;
                    end
                end
                %check left
                if(j-1 > 0)
                    if(board(i, j-1) == 1)
                        foundPits = 1;
                    end
                end
                
                
                if(foundPits == 0)
                    valid = 0;
                    return;
                end
               
                
            end
            
            %Do checking for no pits in neighboring square
            if(breezes(i, j) == 0)
                if(j+1 <= 4)
                    if(board(i, j+1) == 1)
                        valid = 0;
                        return;
                    end
                end
                %check above
                if(i+1 <= 4)
                    if(board(i+1, j) == 1)
                        valid = 0;
                        return;
                    end
                end
                %check below
                if(i-1 > 0)
                    if(board(i-1, j) == 1)
                        valid = 0;
                        return;
                    end
                end
                %check left
                if(j-1 > 0)
                    if(board(i, j-1) == 1)
                        valid = 0;
                        return;
                    end
                end
                
            end
            
            if(stench(i, j) == 1)
                
                foundWumpus = 0;
                
                % Check all neighbors to see if a wumpus is there
                %check right
                if(j+1 <= 4)
                    if(board(i, j+1) == 3 || board(i, j+1) == 4)
                        foundWumpus = 1;
                    end
                end
                %check above
                if(i+1 <= 4)
                    if(board(i+1, j) == 3 || board(i+1, j) == 4)
                        foundWumpus = 1;
                    end
                end
                %check below
                if(i-1 > 0)
                    if(board(i-1, j) == 3 || board(i-1, j) == 4)
                        foundWumpus = 1;
                    end
                end
                %check left
                if(j-1 > 0)
                    if(board(i, j-1) == 3 || board(i, j-1) == 4)
                        foundWumpus = 1;
                    end
                end
                
                
                if(foundWumpus == 0)
                    valid = 0;
                    return;
                end
                
            end
            
            
            if(stench(i, j) == 0)
                % Check all neighbors to see if a wumpus is there
                % check right
                if(j+1 <= 4)
                    if(board(i, j+1) == 3 || board(i, j+1) == 4)
                       valid = 0;
                       return;
                    end
                end
                % check above
                if(i+1 <= 4)
                    if(board(i+1, j) == 3 || board(i+1, j) == 4)
                       valid = 0;
                       return;
                    end
                end
                % check below
                if(i-1 > 0)
                    if(board(i-1, j) == 3 || board(i-1, j) == 4)
                       valid = 0;
                       return;
                    end
                end
                %check left
                if(j-1 > 0)
                    if(board(i, j-1) == 3 || board(i, j-1) == 4)
                       valid = 0;
                       return;
                    end
                end 
            end
            
            if(breezes(i, j) == 1 || breezes(i, j) == 0)
                if(board(i, j) == 1 || board(i, j) == 3 || board(i, j) == 4)
                    valid = 0;
                    return;
                end
            end
            
       
        end 
    end
    
%     for i1 = 1:4
%         for j1 = 1:4
%             
%             if(stench(i1, j1) == 1)
%                 
%                 foundStench = 0;
%                 
%                 % Check all neighbors to see if a wumpus is there
%                 %check right
%                 if(j1+1 <= 4)
%                     if(board(i1, j1+1) == 3)
%                         foundStench = 1;
%                     end
%                 end
%                 %check above
%                 if(i1+1 <= 4)
%                     if(board(i1+1, j1) == 3)
%                         foundStench = 1;
%                     end
%                 end
%                 %check below
%                 if(i1-1 > 0)
%                     if(board(i1-1, j1) == 3)
%                         foundStench = 1;
%                     end
%                 end
%                 %check left
%                 if(j1-1 > 0)
%                     if(board(i1, j1-1) == 3)
%                         foundStench = 1;
%                     end
%                 end
%                 
%                 
%                 if(foundStench == 0)
%                     valid = 0;
%                     return;
%                 end
%                 
%             end
%             
%             %check for no pits in neighboring squares
%             if(stench(i1, j1) == 0)
%                 
%             end
%             
%         end
%         
%     end
    
    
    
    valid = 1;
    
    

end


