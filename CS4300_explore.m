function children = CS4300_explore(parent)

% CS4300_A_star_Man - A function to explore all of the parent node's
%                     children
% On input:
%       parent              (1x3 vector): x,y,dir
% On output:
%       children            (3 1x4 vectors): (x,y,dir,action) x 3
% Call:
%       children = CS_4300_explore([1,1,0]);
%       children = [[2,1,0,1],[1,1,3,2],[1,1,1,3]]
% value = 2
%
% Author:
%   Trung Le and Johnny Le 
%   UU
%   Fall 2016

% Rotate right: 2
rotate_right = zeros(1, 4);
rotate_right(1) = parent(1);
rotate_right(2) = parent(2);

if(parent(3) == 0)
    rotate_right(3) = 3;
else
    rotate_right(3) = parent(3) - 1;
end

rotate_right(4) = 2;

% Rotate left: 3
rotate_left = zeros(1, 4);
rotate_left(1) = parent(1);
rotate_left(2) = parent(2);

if(parent(3) == 3)
    rotate_left(3) = 0;
else
    rotate_left(3) = parent(3) + 1;
end

rotate_left(4) = 3;

go_forward = zeros(1,4);

switch parent(3)
    % Facing east
    case 0
        if(parent(1) ~= 4)
            go_forward(1) = parent(1) + 1;
            go_forward(2) = parent(2);
            go_forward(3) = parent(3);
            go_forward(4) = 1;
        else
            %Do not add state
        end   
    % Facing north
    case 1
        if(parent(2) ~= 4)
            go_forward(1) = parent(1);
            go_forward(2) = parent(2) + 1;
            go_forward(3) = parent(3);
            go_forward(4) = 1;            
        end      
    % Facing west
    case 2
        if(parent(1) ~= 1)
            go_forward(1) = parent(1) - 1;
            go_forward(2) = parent(2);
            go_forward(3) = parent(3);
            go_forward(4) = 1;            
        end
    % Facing south
    otherwise
        if(parent(2) ~= 1)
            go_forward(1) = parent(1);
            go_forward(2) = parent(2) - 1;
            go_forward(3) = parent(3);
            go_forward(4) = 1;  
        end
end





children = [go_forward; rotate_right; rotate_left];












