function new_safe = CS4300_safety(x, y, safe, option)
% CS4300_new_frontier - initalizes KB with initial knowledge
% On input:
%     percept (1x5 Boolean vector): percept values
%      (1): Stench
%      (2): Breeze
%      (3): Glitters
%      (4): Bumped
%      (5): Screamed
% Call:
%     KB = CS4300_Initialize_KB();
% Author:
%     Trung Le and Johnny Le
%     UU
%     Summer 2015
%
%   Pits [1,16]
%   Breeze [17,32]
%   Stench [33,48]
%   Wumpus [49,65]
%   Gold [66, 81]

%   Type
%   0 Pits
%   1 Breeze
%   2 Stench
%   3 Wumpus
%   4 Gold

new_safe = safe;

    %Initialize KB for breezes and pits

    if(y+1 <= 4)
        new_safe(CS4300_conversion(y+1), x) = option;
    end
    if(y-1 > 0)
        new_safe(CS4300_conversion(y-1), x) = option;
    end
    if(x+1 <= 4)
        new_safe(CS4300_conversion(y),x+1) = option;
    end
    if(x-1 > 0)
        new_safe(CS4300_conversion(y), x-1) = option;
    end

end