function KB = CS4300_Initialize_KB()
% CS4300_Initialize_KB - initalizes KB with initial knowledge
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

KB(1).clauses = [-1]; %no pit in 1,1
KB(2).clauses = [-49]; %no wumpus in 1,1
KB(3).clauses = [-66]; %no gold in 1,1
kb_counter = 4;

KB(1).vars = [-1,-49,-66];
i = 1;
%Initialize KB for breezes and pits
for y = 1:3
    for x = 1:3
        c1 = CS4300_Get_Index(x,y,1,1);
        i = i + 1;
        c2_counter = 1;
        c2 = [];
        if(y+1 <= 4)
            c2(c2_counter) = CS4300_Get_Index(x,y+1,1,0);
            i = i + 1;
            c2_counter = c2_counter + 1;
        end
        if(y-1 > 0)
            c2(c2_counter) = CS4300_Get_Index(x,y-1,1,0);
            i = i + 1;
            c2_counter = c2_counter + 1;
        end
        if(x+1 <= 4)
            c2(c2_counter) = CS4300_Get_Index(x+1,y,1,0);
            i = i + 1;
            c2_counter = c2_counter + 1;
        end
        if(x-1 > 0)
            c2(c2_counter) = CS4300_Get_Index(x-1,y,1,0);
            i = i + 1;
            c2_counter = c2_counter + 1;
        end
        
        res = CS4300_Convert_Imply_To_CNF(c1,c2);
        
        for i = 1:length(res)
            KB(kb_counter).clauses = res(i).clauses;
            KB(1).vars = [KB(1).vars,res(i).clauses];
            KB(1).vars = unique(KB(1).vars);
            kb_counter = kb_counter + 1;
        end
    end
end

%Initialize KB for stenches and wumpus
for y = 1:4
    for x = 1:4
        c1 = CS4300_Get_Index(x,y,1,2);
        c2_counter = 1;
        c2 = [];
        if(y+1 <= 4)
            c2(c2_counter) = CS4300_Get_Index(x,y+1,1,3);
            c2_counter = c2_counter + 1;
            i = i + 1;
        end
        if(y-1 > 0)
            c2(c2_counter) = CS4300_Get_Index(x,y-1,1,3);
            c2_counter = c2_counter + 1;
            i = i + 1;
        end
        if(x+1 <= 4)
            c2(c2_counter) = CS4300_Get_Index(x+1,y,1,3);
            c2_counter = c2_counter + 1;
            i = i + 1;
        end
        if(x-1 > 0)
            c2(c2_counter) = CS4300_Get_Index(x-1,y,1,3);
            c2_counter = c2_counter + 1;
            i = i + 1;
        end
        
        res = CS4300_Convert_Imply_To_CNF(c1,c2);
        
        for i = 1:length(res)
            KB(kb_counter).clauses = res(i).clauses;
            kb_counter = kb_counter + 1;
            KB(1).vars = [KB(1).vars,res(i).clauses];
            KB(1).vars = unique(KB(1).vars);
        end
    end
end

        
end
