function [pits,Wumpus] = CS4300_WP_estimates(breezes,stench,num_trials)
% CS4300_WP_estimates - estimate pit and Wumpus likelihoods
% On input:
%   breezes (4x4 Boolean array): presence of breeze percept at cell
%   -1: no knowledge
%   0: no breeze detected
% 1: breeze detected
%   stench (4x4 Boolean array): presence of stench in cell
%       -1: no knowledge
%       0: no stench detected
%       1: stench detected
%   num_trials (int): number of trials to run (subset will be OK)
% On output:
%   pits (4x4 [0,1] array): likelihood of pit in cell
%   Wumpus (4x4 [0 to 1] array): likelihood of Wumpus in cell
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


benchmark = num_trials * 0.5;
valid = 0; % number valid

pits = zeros(4, 4);
Wumpus = zeros(4, 4);

trials = 0; % total trials

for i = 1:num_trials
    %Generate board   
    board = CS4300_gen_board(0.2)
    
    %Check if board matches stench and wumpus requirements
    if(CS4300_check_board(breezes, stench, board) == 1)
        for x = 1:size(board, 1)
            for y = 1:size(board, 1)
                if(board(x, y) == 1)
                   pits(x,y) = pits(x, y) + 1; 
                end
                
                if(board(x, y) == 3)
                   Wumpus(x, y) = Wumpus(x, y) + 1; 
                end
            end
        end
        valid = valid + 1;
    end
    
    if(i == benchmark)
        trials = 1;
    end
    
    if(trials ~= 0 && valid < benchmark)
        num_trials = num_trials + 1;
    end
    
    if(num_trials == (benchmark*4))
        break;
    end
    
    
end

    for x1 = 1:4
        for y1 = 1:4
            
            pits(x1, y1) = pits(x1, y1) / valid;
            
            Wumpus(x1, y1) = Wumpus(x1, y1) / valid;
            
        end
        
    end

end
    
    

    
    
    
    